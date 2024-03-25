// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
/* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */

#include "mlx5_core.h"
#include "mlx5_irq.h"
#include "pci_irq.h"

static void cpu_put(struct mlx5_irq_pool *pool, int cpu)
{
	pool->irqs_per_cpu[cpu]--;
}

static void cpu_get(struct mlx5_irq_pool *pool, int cpu)
{
	pool->irqs_per_cpu[cpu]++;
}

/* Gets the least loaded CPU. e.g.: the CPU with least IRQs bound to it */
static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
				const struct cpumask *req_mask)
{
	int best_cpu = -1;
	int cpu;

	for_each_cpu_and(cpu, req_mask, cpu_online_mask) {
		/* CPU has zero IRQs on it. No need to search any more CPUs. */
		if (!pool->irqs_per_cpu[cpu]) {
			best_cpu = cpu;
			break;
		}
		if (best_cpu < 0)
			best_cpu = cpu;
		if (pool->irqs_per_cpu[cpu] < pool->irqs_per_cpu[best_cpu])
			best_cpu = cpu;
	}
	if (best_cpu == -1) {
		/* There isn't online CPUs in req_mask */
		mlx5_core_err(pool->dev, "NO online CPUs in req_mask (%*pbl)\n",
			      cpumask_pr_args(req_mask));
		best_cpu = cpumask_first(cpu_online_mask);
	}
	pool->irqs_per_cpu[best_cpu]++;
	return best_cpu;
}

/* Creating an IRQ from irq_pool */
static struct mlx5_irq *
irq_pool_request_irq(struct mlx5_irq_pool *pool, const struct cpumask *req_mask)
{
	cpumask_var_t auto_mask;
	struct mlx5_irq *irq;
	u32 irq_index;
	int err;

	if (!zalloc_cpumask_var(&auto_mask, GFP_KERNEL))
		return ERR_PTR(-ENOMEM);
	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
	if (err) {
		if (err == -EBUSY)
			err = -EUSERS;
		return ERR_PTR(err);
	}
	if (pool->irqs_per_cpu) {
		if (cpumask_weight(req_mask) > 1)
			/* if req_mask contain more then one CPU, set the least loadad CPU
			 * of req_mask
			 */
			cpumask_set_cpu(cpu_get_least_loaded(pool, req_mask), auto_mask);
		else
			cpu_get(pool, cpumask_first(req_mask));
	}
	irq = mlx5_irq_alloc(pool, irq_index, cpumask_empty(auto_mask) ? req_mask : auto_mask);
	free_cpumask_var(auto_mask);
	return irq;
}

/* Looking for the IRQ with the smallest refcount that fits req_mask.
 * If pool is sf_comp_pool, then we are looking for an IRQ with any of the
 * requested CPUs in req_mask.
 * for example: req_mask = 0xf, irq0_mask = 0x10, irq1_mask = 0x1. irq0_mask
 * isn't subset of req_mask, so we will skip it. irq1_mask is subset of req_mask,
 * we don't skip it.
 * If pool is sf_ctrl_pool, then all IRQs have the same mask, so any IRQ will
 * fit. And since mask is subset of itself, we will pass the first if bellow.
 */
static struct mlx5_irq *
irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req_mask)
{
	int start = pool->xa_num_irqs.min;
	int end = pool->xa_num_irqs.max;
	struct mlx5_irq *irq = NULL;
	struct mlx5_irq *iter;
	int irq_refcount = 0;
	unsigned long index;

	lockdep_assert_held(&pool->lock);
	xa_for_each_range(&pool->irqs, index, iter, start, end) {
		struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
		int iter_refcount = mlx5_irq_read_locked(iter);

		if (!cpumask_subset(iter_mask, req_mask))
			/* skip IRQs with a mask which is not subset of req_mask */
			continue;
		if (iter_refcount < pool->min_threshold)
			/* If we found an IRQ with less than min_thres, return it */
			return iter;
		if (!irq || iter_refcount < irq_refcount) {
			/* In case we won't find an IRQ with less than min_thres,
			 * keep a pointer to the least used IRQ
			 */
			irq_refcount = iter_refcount;
			irq = iter;
		}
	}
	return irq;
}

/**
 * mlx5_irq_affinity_request - request an IRQ according to the given mask.
 * @pool: IRQ pool to request from.
 * @req_mask: cpumask requested for this IRQ.
 *
 * This function returns a pointer to IRQ, or ERR_PTR in case of error.
 */
struct mlx5_irq *
mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, const struct cpumask *req_mask)
{
	struct mlx5_irq *least_loaded_irq, *new_irq;

	mutex_lock(&pool->lock);
	least_loaded_irq = irq_pool_find_least_loaded(pool, req_mask);
	if (least_loaded_irq &&
	    mlx5_irq_read_locked(least_loaded_irq) < pool->min_threshold)
		goto out;
	/* We didn't find an IRQ with less than min_thres, try to allocate a new IRQ */
	new_irq = irq_pool_request_irq(pool, req_mask);
	if (IS_ERR(new_irq)) {
		if (!least_loaded_irq) {
			/* We failed to create an IRQ and we didn't find an IRQ */
			mlx5_core_err(pool->dev, "Didn't find a matching IRQ. err = %ld\n",
				      PTR_ERR(new_irq));
			mutex_unlock(&pool->lock);
			return new_irq;
		}
		/* We failed to create a new IRQ for the requested affinity,
		 * sharing existing IRQ.
		 */
		goto out;
	}
	least_loaded_irq = new_irq;
	goto unlock;
out:
	mlx5_irq_get_locked(least_loaded_irq);
	if (mlx5_irq_read_locked(least_loaded_irq) > pool->max_threshold)
		mlx5_core_dbg(pool->dev, "IRQ %u overloaded, pool_name: %s, %u EQs on this irq\n",
			      pci_irq_vector(pool->dev->pdev,
					     mlx5_irq_get_index(least_loaded_irq)), pool->name,
			      mlx5_irq_read_locked(least_loaded_irq) / MLX5_EQ_REFS_PER_IRQ);
unlock:
	mutex_unlock(&pool->lock);
	return least_loaded_irq;
}

void mlx5_irq_affinity_irqs_release(struct mlx5_core_dev *dev, struct mlx5_irq **irqs,
				    int num_irqs)
{
	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
	int i;

	for (i = 0; i < num_irqs; i++) {
		int cpu = cpumask_first(mlx5_irq_get_affinity_mask(irqs[i]));

		synchronize_irq(pci_irq_vector(pool->dev->pdev,
					       mlx5_irq_get_index(irqs[i])));
		if (mlx5_irq_put(irqs[i]))
			if (pool->irqs_per_cpu)
				cpu_put(pool, cpu);
	}
}

/**
 * mlx5_irq_affinity_irqs_request_auto - request one or more IRQs for mlx5 device.
 * @dev: mlx5 device that is requesting the IRQs.
 * @nirqs: number of IRQs to request.
 * @irqs: an output array of IRQs pointers.
 *
 * Each IRQ is bounded to at most 1 CPU.
 * This function is requesting IRQs according to the default assignment.
 * The default assignment policy is:
 * - in each iteration, request the least loaded IRQ which is not bound to any
 *   CPU of the previous IRQs requested.
 *
 * This function returns the number of IRQs requested, (which might be smaller than
 * @nirqs), if successful, or a negative error code in case of an error.
 */
int mlx5_irq_affinity_irqs_request_auto(struct mlx5_core_dev *dev, int nirqs,
					struct mlx5_irq **irqs)
{
	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
	cpumask_var_t req_mask;
	struct mlx5_irq *irq;
	int i = 0;

	if (!zalloc_cpumask_var(&req_mask, GFP_KERNEL))
		return -ENOMEM;
	cpumask_copy(req_mask, cpu_online_mask);
	for (i = 0; i < nirqs; i++) {
		if (mlx5_irq_pool_is_sf_pool(pool))
			irq = mlx5_irq_affinity_request(pool, req_mask);
		else
			/* In case SF pool doesn't exists, fallback to the PF IRQs.
			 * The PF IRQs are already allocated and binded to CPU
			 * at this point. Hence, only an index is needed.
			 */
			irq = mlx5_irq_request(dev, i, NULL);
		if (IS_ERR(irq))
			break;
		irqs[i] = irq;
		cpumask_clear_cpu(cpumask_first(mlx5_irq_get_affinity_mask(irq)), req_mask);
		mlx5_core_dbg(dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
			      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
			      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
			      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
	}
	free_cpumask_var(req_mask);
	if (!i)
		return PTR_ERR(irq);
	return i;
}
