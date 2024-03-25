/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
/* Copyright (c) 2019 Mellanox Technologies. */

#ifndef __MLX5_ECPF_H__
#define __MLX5_ECPF_H__

#include <linux/mlx5/driver.h>
#include "mlx5_core.h"

enum {
	MLX5_ECPU_BIT_NUM = 23,
};

bool mlx5_read_embedded_cpu(struct mlx5_core_dev *dev);
int mlx5_ec_init(struct mlx5_core_dev *dev);
void mlx5_ec_cleanup(struct mlx5_core_dev *dev);

int mlx5_cmd_host_pf_enable_hca(struct mlx5_core_dev *dev);
int mlx5_cmd_host_pf_disable_hca(struct mlx5_core_dev *dev);
void mlx5_smartnic_sysfs_init(struct net_device *dev);
void mlx5_smartnic_sysfs_cleanup(struct net_device *dev);

int mlx5_regex_sysfs_init(struct mlx5_core_dev *dev);
void mlx5_regex_sysfs_cleanup(struct mlx5_core_dev *dev);

#endif /* __MLX5_ECPF_H__ */
