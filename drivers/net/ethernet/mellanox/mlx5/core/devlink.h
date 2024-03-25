/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
/* Copyright (c) 2019, Mellanox Technologies */

#ifndef __MLX5_DEVLINK_H__
#define __MLX5_DEVLINK_H__

#include <net/devlink.h>

enum mlx5_devlink_resource_id {
	MLX5_DL_RES_MAX_LOCAL_SFS = 1,
	MLX5_DL_RES_MAX_EXTERNAL_SFS,

	__MLX5_ID_RES_MAX,
	MLX5_ID_RES_MAX = __MLX5_ID_RES_MAX - 1,
};

enum mlx5_devlink_param_id {
	MLX5_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
	MLX5_DEVLINK_PARAM_ID_FLOW_STEERING_MODE,
	MLX5_DEVLINK_PARAM_ID_ESW_LARGE_GROUP_NUM,
	MLX5_DEVLINK_PARAM_ID_CT_ACTION_ON_NAT_CONNS,
	MLX5_DEVLINK_PARAM_ID_CT_MAX_OFFLOADED_CONNS,
	MLX5_DEVLINK_PARAM_ID_ESW_PET_INSERT,
	MLX5_DEVLINK_PARAM_ID_ESW_PORT_METADATA,
	MLX5_DEVLINK_PARAM_ID_ESW_MULTIPORT,
	MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES,
	MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE,
};

struct mlx5_trap_ctx {
	int id;
	int action;
};

struct mlx5_devlink_trap {
	struct mlx5_trap_ctx trap;
	void *item;
	struct list_head list;
};

struct mlx5_devlink_trap_event_ctx {
	struct mlx5_trap_ctx *trap;
	int err;
};

struct mlx5_core_dev;
void mlx5_devlink_trap_report(struct mlx5_core_dev *dev, int trap_id, struct sk_buff *skb,
			      struct devlink_port *dl_port);
int mlx5_devlink_trap_get_num_active(struct mlx5_core_dev *dev);
int mlx5_devlink_traps_get_action(struct mlx5_core_dev *dev, int trap_id,
				  enum devlink_trap_action *action);
int mlx5_devlink_traps_register(struct devlink *devlink);
void mlx5_devlink_traps_unregister(struct devlink *devlink);

struct devlink *mlx5_devlink_alloc(struct device *dev);
void mlx5_devlink_free(struct devlink *devlink);
int mlx5_devlink_params_register(struct devlink *devlink);
void mlx5_devlink_params_unregister(struct devlink *devlink);
int
mlx5_devlink_ct_action_on_nat_conns_set(struct devlink *devlink, u32 id,
					struct devlink_param_gset_ctx *ctx);
int
mlx5_devlink_ct_action_on_nat_conns_get(struct devlink *devlink, u32 id,
					struct devlink_param_gset_ctx *ctx);

int
mlx5_devlink_ct_labels_mapping_set(struct devlink *devlink, u32 id,
				   struct devlink_param_gset_ctx *ctx);
int
mlx5_devlink_ct_labels_mapping_get(struct devlink *devlink, u32 id,
				   struct devlink_param_gset_ctx *ctx);
#endif /* __MLX5_DEVLINK_H__ */
