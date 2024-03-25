// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
// // Copyright (c) 2021 Mellanox Technologies.

#include "aso.h"
#include "ipsec_aso.h"

static int mlx5e_aso_send_ipsec_aso(struct mlx5e_priv *priv, u32 ipsec_obj_id,
				    struct mlx5e_aso_ctrl_param *param,
				    u32 *hard_cnt, u32 *soft_cnt,
				    u8 *event_arm, u32 *mode_param)
{
	struct mlx5e_aso *aso = priv->ipsec->aso;
	struct mlx5e_asosq *sq = &aso->sq;
	struct mlx5_wq_cyc *wq = &sq->wq;
	struct mlx5e_aso_wqe *aso_wqe;
	u16 pi, contig_wqebbs_room;
	int err = 0;

	memset(aso->ctx, 0, aso->size);

	pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
	contig_wqebbs_room = mlx5_wq_cyc_get_contig_wqebbs(wq, pi);

	if (unlikely(contig_wqebbs_room < MLX5E_ASO_WQEBBS)) {
		mlx5e_fill_asosq_frag_edge(sq, wq, pi, contig_wqebbs_room);
		pi = mlx5_wq_cyc_ctr2ix(wq, sq->pc);
	}

	aso_wqe = mlx5_wq_cyc_get_wqe(wq, pi);

	/* read enable always set */
	mlx5e_build_aso_wqe(aso, sq,
			    DIV_ROUND_UP(sizeof(*aso_wqe), MLX5_SEND_WQE_DS),
			    &aso_wqe->ctrl, &aso_wqe->aso_ctrl, ipsec_obj_id,
			    MLX5_ACCESS_ASO_OPC_MOD_IPSEC, param);

	sq->db.aso_wqe[pi].opcode = MLX5_OPCODE_ACCESS_ASO;
	sq->db.aso_wqe[pi].with_data = false;
	sq->pc += MLX5E_ASO_WQEBBS;
	sq->doorbell_cseg = &aso_wqe->ctrl;

	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);

	/* Ensure doorbell is written on uar_page before poll_cq */
	WRITE_ONCE(sq->doorbell_cseg, NULL);

	err = mlx5e_poll_aso_cq(&sq->cq);
	if (err)
		return err;

	if (hard_cnt)
		*hard_cnt = MLX5_GET(ipsec_aso, aso->ctx, remove_flow_pkt_cnt);
	if (soft_cnt)
		*soft_cnt = MLX5_GET(ipsec_aso, aso->ctx, remove_flow_soft_lft);

	if (event_arm) {
		*event_arm = 0;
		if (MLX5_GET(ipsec_aso, aso->ctx, esn_event_arm))
			*event_arm |= MLX5_ASO_ESN_ARM;
		if (MLX5_GET(ipsec_aso, aso->ctx, soft_lft_arm))
			*event_arm |= MLX5_ASO_SOFT_ARM;
		if (MLX5_GET(ipsec_aso, aso->ctx, hard_lft_arm))
			*event_arm |= MLX5_ASO_HARD_ARM;
		if (MLX5_GET(ipsec_aso, aso->ctx, remove_flow_enable))
			*event_arm |= MLX5_ASO_REMOVE_FLOW_ENABLE;
	}

	if (mode_param)
		*mode_param = MLX5_GET(ipsec_aso, aso->ctx, mode_parameter);

	return err;
}

#define UPPER32_MASK GENMASK_ULL(63, 32)

int mlx5e_ipsec_aso_query(struct mlx5e_priv *priv, u32 obj_id,
			  u32 *hard_cnt, u32 *soft_cnt,
			  u8 *event_arm, u32 *mode_param)
{
	return mlx5e_aso_send_ipsec_aso(priv, obj_id, NULL, hard_cnt, soft_cnt,
					event_arm, mode_param);
}

int mlx5e_ipsec_aso_set(struct mlx5e_priv *priv, u32 obj_id, u8 flags,
			u32 comparator, u32 *hard_cnt, u32 *soft_cnt,
			u8 *event_arm, u32 *mode_param)
{
	struct mlx5e_aso_ctrl_param param = {};
	int err = 0;

	if (!flags)
		return -EINVAL;

	param.data_mask_mode = ASO_DATA_MASK_MODE_BITWISE_64BIT;
	param.condition_0_operand = ALWAYS_TRUE;
	param.condition_1_operand = ALWAYS_TRUE;

	if (flags & ARM_ESN_EVENT) {
		param.data_offset = MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET;
		param.bitwise_data = BIT(22) << 32;
		param.data_mask = param.bitwise_data;
		return mlx5e_aso_send_ipsec_aso(priv, obj_id, &param, NULL, NULL, NULL, NULL);
	}

	if (flags & SET_SOFT) {
		param.data_offset = MLX5_IPSEC_ASO_REMOVE_FLOW_SOFT_LFT_OFFSET;
		param.bitwise_data = (u64)(comparator) << 32;
		param.data_mask = UPPER32_MASK;
		err = mlx5e_aso_send_ipsec_aso(priv, obj_id, &param, hard_cnt, soft_cnt,
					       NULL, NULL);
		if (flags == SET_SOFT)
			return err;
	}

	/* For ASO_WQE big Endian format,
	 * ARM_SOFT is BIT(25 + 32)
	 * SET COUNTER BIT 31 is BIT(31)
	 */
	param.data_offset = MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET;

	if (flags & SET_CNT_BIT31)
		param.bitwise_data = IPSEC_SW_LIMIT;
	if (flags & ARM_SOFT)
		param.bitwise_data |= BIT(25 + 32);
	if (flags & CLEAR_SOFT)
		param.bitwise_data &= ~(BIT(25 + 32));

	param.data_mask = param.bitwise_data;
	return mlx5e_aso_send_ipsec_aso(priv, obj_id, &param, hard_cnt, soft_cnt, NULL, NULL);
}
