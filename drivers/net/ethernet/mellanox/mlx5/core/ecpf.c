/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
/* Copyright (c) 2019 Mellanox Technologies. */

#include "ecpf.h"
#include <linux/mlx5/driver.h>
#include "mlx5_core.h"
#include "eswitch.h"
#include "en.h"

bool mlx5_read_embedded_cpu(struct mlx5_core_dev *dev)
{
	return (ioread32be(&dev->iseg->initializing) >> MLX5_ECPU_BIT_NUM) & 1;
}

static bool mlx5_ecpf_esw_admins_host_pf(const struct mlx5_core_dev *dev)
{
	/* In separate host mode, PF enables itself.
	 * When ECPF is eswitch manager, eswitch enables host PF after
	 * eswitch is setup.
	 */
	return mlx5_core_is_ecpf_esw_manager(dev);
}

int mlx5_cmd_host_pf_enable_hca(struct mlx5_core_dev *dev)
{
	u32 out[MLX5_ST_SZ_DW(enable_hca_out)] = {};
	u32 in[MLX5_ST_SZ_DW(enable_hca_in)]   = {};

	MLX5_SET(enable_hca_in, in, opcode, MLX5_CMD_OP_ENABLE_HCA);
	MLX5_SET(enable_hca_in, in, function_id, 0);
	MLX5_SET(enable_hca_in, in, embedded_cpu_function, 0);
	return mlx5_cmd_exec(dev, &in, sizeof(in), &out, sizeof(out));
}

int mlx5_cmd_host_pf_disable_hca(struct mlx5_core_dev *dev)
{
	u32 out[MLX5_ST_SZ_DW(disable_hca_out)] = {};
	u32 in[MLX5_ST_SZ_DW(disable_hca_in)]   = {};

	MLX5_SET(disable_hca_in, in, opcode, MLX5_CMD_OP_DISABLE_HCA);
	MLX5_SET(disable_hca_in, in, function_id, 0);
	MLX5_SET(disable_hca_in, in, embedded_cpu_function, 0);
	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
}

static int mlx5_host_pf_init(struct mlx5_core_dev *dev)
{
	int err;

	if (mlx5_ecpf_esw_admins_host_pf(dev))
		return 0;

	/* ECPF shall enable HCA for host PF in the same way a PF
	 * does this for its VFs when ECPF is not a eswitch manager.
	 */
	err = mlx5_cmd_host_pf_enable_hca(dev);
	if (err)
		mlx5_core_err(dev, "Failed to enable external host PF HCA err(%d)\n", err);

	return err;
}

static void mlx5_host_pf_cleanup(struct mlx5_core_dev *dev)
{
	int err;

	if (mlx5_ecpf_esw_admins_host_pf(dev))
		return;

	err = mlx5_cmd_host_pf_disable_hca(dev);
	if (err) {
		mlx5_core_err(dev, "Failed to disable external host PF HCA err(%d)\n", err);
		return;
	}
}

int mlx5_ec_init(struct mlx5_core_dev *dev)
{
	if (!mlx5_core_is_ecpf(dev))
		return 0;

	return mlx5_host_pf_init(dev);
}

void mlx5_ec_cleanup(struct mlx5_core_dev *dev)
{
	int err;

	if (!mlx5_core_is_ecpf(dev))
		return;

	mlx5_host_pf_cleanup(dev);

	err = mlx5_wait_for_pages(dev, &dev->priv.page_counters[MLX5_HOST_PF]);
	if (err)
		mlx5_core_warn(dev, "Timeout reclaiming external host PF pages err(%d)\n", err);

	err = mlx5_wait_for_pages(dev, &dev->priv.page_counters[MLX5_VF]);
	if (err)
		mlx5_core_warn(dev, "Timeout reclaiming external host VFs pages err(%d)\n", err);
}

static int mlx5_regex_query(struct mlx5_core_dev *dev, int vport)
{
	u32 in_query[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
	u32 *out_query;
	int res = 0;

	out_query = kzalloc(MLX5_ST_SZ_BYTES(query_hca_cap_out), GFP_KERNEL);
	if (!out_query)
		return -ENOMEM;

	MLX5_SET(query_hca_cap_in, in_query, opcode,
		 MLX5_CMD_OP_QUERY_HCA_CAP);
	MLX5_SET(query_hca_cap_in, in_query, op_mod,
		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
		 HCA_CAP_OPMOD_GET_CUR);
	MLX5_SET(query_hca_cap_in, in_query, other_function, 1);
	MLX5_SET(query_hca_cap_in, in_query, function_id, vport);

	res =  mlx5_cmd_exec(dev, in_query, MLX5_ST_SZ_BYTES(query_hca_cap_in),
			     out_query, MLX5_ST_SZ_BYTES(query_hca_cap_out));
	if (res)
		goto out;

	res = MLX5_GET(query_hca_cap_out,
		       out_query, capability.cmd_hca_cap.regexp_mmo_qp);
out:
	kfree(out_query);
	return res;
}

static int mlx5_regex_enable(struct mlx5_core_dev *dev, int vport, bool en)
{
	u32 out_set[MLX5_ST_SZ_BYTES(set_hca_cap_out)] = {};
	u32 in_query[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
	void *set_hca_cap, *query_hca_cap;
	u32 *out_query, *in_set;
	int err = 0;

	out_query = kzalloc(MLX5_ST_SZ_BYTES(query_hca_cap_out), GFP_KERNEL);
	if (!out_query)
		return -ENOMEM;

	in_set = kzalloc(MLX5_ST_SZ_BYTES(set_hca_cap_in), GFP_KERNEL);
	if (!in_set) {
		kfree(out_query);
		return -ENOMEM;
	}

	MLX5_SET(query_hca_cap_in, in_query, opcode,
		 MLX5_CMD_OP_QUERY_HCA_CAP);
	MLX5_SET(query_hca_cap_in, in_query, op_mod,
		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
		 HCA_CAP_OPMOD_GET_CUR);
	MLX5_SET(query_hca_cap_in, in_query, other_function, 1);
	MLX5_SET(query_hca_cap_in, in_query, function_id, vport);

	err =  mlx5_cmd_exec(dev, in_query, MLX5_ST_SZ_BYTES(query_hca_cap_in),
			     out_query, MLX5_ST_SZ_BYTES(query_hca_cap_out));
	if (err)
		goto out;

	query_hca_cap = MLX5_ADDR_OF(query_hca_cap_out, out_query, capability);
	set_hca_cap = MLX5_ADDR_OF(set_hca_cap_in, in_set, capability);
	memcpy(set_hca_cap, query_hca_cap, MLX5_ST_SZ_BYTES(cmd_hca_cap));

	MLX5_SET(set_hca_cap_in, in_set, opcode,
		 MLX5_CMD_OP_SET_HCA_CAP);
	MLX5_SET(set_hca_cap_in, in_set, op_mod,
		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
		 HCA_CAP_OPMOD_GET_MAX);
	MLX5_SET(set_hca_cap_in, in_set, other_function, 1);
	MLX5_SET(set_hca_cap_in, in_set, function_id, vport);
	MLX5_SET(set_hca_cap_in, in_set,
		 capability.cmd_hca_cap.regexp_mmo_qp, en);
	if (en) {
		MLX5_SET(set_hca_cap_in, in_set,
			 capability.cmd_hca_cap.regexp_num_of_engines,
			 MLX5_CAP_GEN_MAX(dev, regexp_num_of_engines));
		MLX5_SET(set_hca_cap_in, in_set,
			 capability.cmd_hca_cap.regexp_params,
			 MLX5_CAP_GEN_MAX(dev, regexp_params));
	}
	err =  mlx5_cmd_exec(dev, in_set, MLX5_ST_SZ_BYTES(set_hca_cap_in),
			     out_set, MLX5_ST_SZ_BYTES(set_hca_cap_out));
	if (err)
		goto out;

out:
	kfree(out_query);
	kfree(in_set);
	return err;
}

static ssize_t max_tx_rate_store(struct kobject *kobj,
				 struct kobj_attribute *attr,
				 const char *buf,
				 size_t count)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	struct mlx5_vport *evport = mlx5_eswitch_get_vport(esw, tmp->vport);
	u32 max_tx_rate;
	u32 min_tx_rate;
	int err;

	if (IS_ERR(evport))
		return PTR_ERR(evport);

	mutex_lock(&esw->state_lock);
	min_tx_rate = evport->qos.min_rate;
	mutex_unlock(&esw->state_lock);

	err = kstrtou32(buf, 0, &max_tx_rate);
	if (err)
		return err;

	if (max_tx_rate && max_tx_rate <= min_tx_rate)
		return -EINVAL;

	err = mlx5_eswitch_set_vport_rate(esw, tmp->vport,
					  max_tx_rate, min_tx_rate);

	return err ? err : count;
}

static ssize_t max_tx_rate_show(struct kobject *kobj,
				struct kobj_attribute *attr,
				char *buf)
{
	return sprintf(buf,
		       "usage: write <Rate (Mbit/s)> to set max transmit rate\n");
}

static ssize_t min_tx_rate_store(struct kobject *kobj,
				 struct kobj_attribute *attr,
				 const char *buf,
				 size_t count)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	struct mlx5_vport *evport = mlx5_eswitch_get_vport(esw, tmp->vport);
	u32 max_tx_rate;
	u32 min_tx_rate;
	int err;

	if (IS_ERR(evport))
		return PTR_ERR(evport);

	mutex_lock(&esw->state_lock);
	max_tx_rate = evport->qos.max_rate;
	mutex_unlock(&esw->state_lock);

	err = kstrtou32(buf, 0, &min_tx_rate);
	if (err)
		return err;

	if (max_tx_rate && max_tx_rate <= min_tx_rate)
		return -EINVAL;

	err = mlx5_eswitch_set_vport_rate(esw, tmp->vport,
					  max_tx_rate, min_tx_rate);

	return err ? err : count;
}

static ssize_t min_tx_rate_show(struct kobject *kobj,
				struct kobj_attribute *attr,
				char *buf)
{
	return sprintf(buf,
		       "usage: write <Rate (Mbit/s)> to set min transmit rate\n");
}

static ssize_t mac_store(struct kobject *kobj,
			 struct kobj_attribute *attr,
			 const char *buf,
			 size_t count)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	u8 mac[ETH_ALEN];
	int err;

	err = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
		     &mac[0], &mac[1], &mac[2], &mac[3], &mac[4], &mac[5]);
	if (err == 6)
		goto set_mac;

	if (sysfs_streq(buf, "Random"))
		eth_random_addr(mac);
	else
		return -EINVAL;

set_mac:
	err = mlx5_eswitch_set_vport_mac(esw, tmp->vport, mac);
	return err ? err : count;
}

static ssize_t mac_show(struct kobject *kobj,
			struct kobj_attribute *attr,
			char *buf)
{
	return sprintf(buf,
		       "usage: write <LLADDR|Random> to set Mac Address\n");
}

static ssize_t regex_en_store(struct kobject *kobj,
			      struct kobj_attribute *attr,
			      const char *buf,
			      size_t count)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	int err;

	if (!MLX5_CAP_GEN_MAX(esw->dev, regexp_mmo_qp))
		return -EOPNOTSUPP;
	if (sysfs_streq(buf, "1"))
		err = mlx5_regex_enable(esw->dev, tmp->vport, 1);
	else if (sysfs_streq(buf, "0"))
		err = mlx5_regex_enable(esw->dev, tmp->vport, 0);
	else
		err = -EINVAL;

	return err ? err : count;
}

static ssize_t regex_en_show(struct kobject *kobj,
			     struct kobj_attribute *attr,
			     char *buf)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	int res;

	res = mlx5_regex_query(esw->dev, tmp->vport);
	if (res < 0)
		return sprintf(buf, "Failed to query device\n");

	return sprintf(buf, "%d\n", res);
}

static int strpolicy(const char *buf, enum port_state_policy *policy)
{
	if (sysfs_streq(buf, "Down")) {
		*policy = MLX5_POLICY_DOWN;
		return 0;
	}

	if (sysfs_streq(buf, "Up")) {
		*policy = MLX5_POLICY_UP;
		return 0;
	}

	if (sysfs_streq(buf, "Follow")) {
		*policy = MLX5_POLICY_FOLLOW;
		return 0;
	}
	return -EINVAL;
}

static ssize_t vport_state_store(struct kobject *kobj,
				 struct kobj_attribute *attr,
				 const char *buf,
				 size_t count)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	struct mlx5_vport *evport = mlx5_eswitch_get_vport(esw, tmp->vport);
	int opmod = MLX5_VPORT_STATE_OP_MOD_ESW_VPORT;
	enum port_state_policy policy;
	int err;

	err = strpolicy(buf, &policy);
	if (err)
		return err;

	if (!mlx5_esw_allowed(esw))
		return -EPERM;
	if (IS_ERR(evport))
		return PTR_ERR(evport);

	mutex_lock(&esw->state_lock);

	err = mlx5_modify_vport_admin_state(esw->dev, opmod,
					    tmp->vport, 1, policy);
	if (err) {
		mlx5_core_warn(esw->dev, "Failed to set vport %d link state, opmod = %d, err = %d",
			       tmp->vport, opmod, err);
		goto unlock;
	}

	evport->info.link_state = policy;

unlock:
	mutex_unlock(&esw->state_lock);
	return err ? err : count;
}

static ssize_t vport_state_show(struct kobject *kobj,
				struct kobj_attribute *attr,
				char *buf)
{
	return sprintf(buf, "usage: write <Up|Down|Follow> to set VF State\n");
}

static const char *policy_str(enum port_state_policy policy)
{
	switch (policy) {
	case MLX5_POLICY_DOWN:		return "Down\n";
	case MLX5_POLICY_UP:		return "Up\n";
	case MLX5_POLICY_FOLLOW:	return "Follow\n";
	default:			return "Invalid policy\n";
	}
}

#define _sprintf(p, buf, format, arg...)                               \
       ((PAGE_SIZE - (int)(p - buf)) <= 0 ? 0 :                        \
       scnprintf(p, PAGE_SIZE - (int)(p - buf), format, ## arg))

static u8 mlx5_query_vport_admin_state(struct mlx5_core_dev *mdev,
				       u8 opmod,
				       u16 vport, u8 other_vport)
{
	u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
	u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
	int err;

	MLX5_SET(query_vport_state_in, in, opcode,
		 MLX5_CMD_OP_QUERY_VPORT_STATE);
	MLX5_SET(query_vport_state_in, in, op_mod, opmod);
	MLX5_SET(query_vport_state_in, in, vport_number, vport);
	MLX5_SET(query_vport_state_in, in, other_vport, other_vport);

	err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
	if (err)
		return 0;

	return MLX5_GET(query_vport_state_out, out, admin_state);
}

static ssize_t config_show(struct kobject *kobj,
			   struct kobj_attribute *attr,
			   char *buf)
{
	struct mlx5_smart_nic_vport *tmp =
		container_of(kobj, struct mlx5_smart_nic_vport, kobj);
	struct mlx5_eswitch *esw = tmp->esw;
	struct mlx5_vport *evport =  mlx5_eswitch_get_vport(esw, tmp->vport);
	int opmod = MLX5_VPORT_STATE_OP_MOD_ESW_VPORT;
	struct mlx5_vport_info *ivi;
	int other_vport = 1;
	char *p = buf;
	u8 port_state;

	if (IS_ERR(evport))
		return PTR_ERR(evport);

	mutex_lock(&esw->state_lock);
	ivi = &evport->info;
	p += _sprintf(p, buf, "MAC        : %pM\n", ivi->mac);
	p += _sprintf(p, buf, "MaxTxRate  : %d\n", evport->qos.max_rate);
	p += _sprintf(p, buf, "MinTxRate  : %d\n", evport->qos.min_rate);
	port_state = mlx5_query_vport_admin_state(esw->dev, opmod,
						  tmp->vport, other_vport);
	p += _sprintf(p, buf, "State      : %s\n", policy_str(port_state));
	mutex_unlock(&esw->state_lock);

	return (ssize_t)(p - buf);
}

static ssize_t smart_nic_attr_show(struct kobject *kobj,
				   struct attribute *attr, char *buf)
{
	struct kobj_attribute *kattr;
	ssize_t ret = -EIO;

	kattr = container_of(attr, struct kobj_attribute, attr);
	if (kattr->show)
		ret = kattr->show(kobj, kattr, buf);
	return ret;
}

static ssize_t smart_nic_attr_store(struct kobject *kobj,
				    struct attribute *attr,
				    const char *buf, size_t count)
{
	struct kobj_attribute *kattr;
	ssize_t ret = -EIO;

	kattr = container_of(attr, struct kobj_attribute, attr);
	if (kattr->store)
		ret = kattr->store(kobj, kattr, buf, count);
	return ret;
}

static struct kobj_attribute attr_max_tx_rate = {
	.attr = {.name = "max_tx_rate",
		 .mode = 0644 },
	.show = max_tx_rate_show,
	.store = max_tx_rate_store,
};

static struct kobj_attribute attr_min_tx_rate = {
	.attr = {.name = "min_tx_rate",
		 .mode = 0644 },
	.show = min_tx_rate_show,
	.store = min_tx_rate_store,
};

static struct kobj_attribute attr_mac = {
	.attr = {.name = "mac",
		 .mode = 0644 },
	.show = mac_show,
	.store = mac_store,
};

static struct kobj_attribute attr_vport_state = {
	.attr = {.name = "vport_state",
		 .mode = 0644 },
	.show = vport_state_show,
	.store = vport_state_store,
};

static struct kobj_attribute attr_regex_en = {
	.attr = {.name = "regex_en",
		 .mode = 0644 },
	.show = regex_en_show,
	.store = regex_en_store,
};

static struct kobj_attribute attr_config = {
	.attr = {.name = "config",
		 .mode = 0444 },
	.show = config_show,
};

static struct attribute *smart_nic_attrs[] = {
	&attr_config.attr,
	&attr_max_tx_rate.attr,
	&attr_min_tx_rate.attr,
	&attr_mac.attr,
	&attr_vport_state.attr,
	&attr_regex_en.attr,
	NULL,
};

ATTRIBUTE_GROUPS(smart_nic);

static const struct sysfs_ops smart_nic_sysfs_ops = {
	.show   = smart_nic_attr_show,
	.store  = smart_nic_attr_store
};

static struct kobj_type smart_nic_type = {
	.sysfs_ops     = &smart_nic_sysfs_ops,
	.default_groups = smart_nic_groups
};

void mlx5_smartnic_sysfs_init(struct net_device *dev)
{
	struct mlx5e_priv *priv = netdev_priv(dev);
	struct mlx5_core_dev *mdev = priv->mdev;
	struct mlx5_smart_nic_vport *tmp;
	struct mlx5_eswitch *esw;
	int num_vports;
	int err;
	int i;

	if (!mlx5_core_is_ecpf(mdev) || !mlx5_esw_host_functions_enabled(mdev))
		return;

	esw = mdev->priv.eswitch;
	esw->smart_nic_sysfs.kobj =
		kobject_create_and_add("smart_nic", &dev->dev.kobj);
	if (!esw->smart_nic_sysfs.kobj)
		return;

	num_vports = mlx5_core_max_vfs(mdev) + 1;
	esw->smart_nic_sysfs.vport =
		kcalloc(num_vports, sizeof(struct mlx5_smart_nic_vport),
			GFP_KERNEL);
	if (!esw->smart_nic_sysfs.vport)
		goto err_attr_mem;

	for (i = 0; i < num_vports; i++) {
		tmp = &esw->smart_nic_sysfs.vport[i];
		tmp->esw = esw;
		tmp->vport = i;
		if (i == 0)
			err = kobject_init_and_add(&tmp->kobj, &smart_nic_type,
						   esw->smart_nic_sysfs.kobj,
						   "pf");
		else
			err = kobject_init_and_add(&tmp->kobj, &smart_nic_type,
						   esw->smart_nic_sysfs.kobj,
						   "vf%d", i - 1);
		if (err)
			goto err_attr;
	}

	return;

err_attr:
	for (; i >= 0;	i--) {
		kobject_put(&esw->smart_nic_sysfs.vport[i].kobj);
		esw->smart_nic_sysfs.vport[i].esw = NULL;
	}
	kfree(esw->smart_nic_sysfs.vport);
	esw->smart_nic_sysfs.vport = NULL;

err_attr_mem:
	kobject_put(esw->smart_nic_sysfs.kobj);
	esw->smart_nic_sysfs.kobj = NULL;
}

void mlx5_smartnic_sysfs_cleanup(struct net_device *dev)
{
	struct mlx5e_priv *priv = netdev_priv(dev);
	struct mlx5_core_dev *mdev = priv->mdev;
	struct mlx5_smart_nic_vport *tmp;
	struct mlx5_eswitch *esw;
	int i;

	if (!mlx5_core_is_ecpf(mdev) || !mlx5_esw_host_functions_enabled(mdev))
		return;

	esw = mdev->priv.eswitch;

	if (!esw->smart_nic_sysfs.kobj || !esw->smart_nic_sysfs.vport)
		return;

	for  (i = 0; i < mlx5_core_max_vfs(mdev) + 1; i++) {
		tmp = &esw->smart_nic_sysfs.vport[i];
		if (!tmp->esw)
			continue;
		kobject_put(&tmp->kobj);
	}

	kfree(esw->smart_nic_sysfs.vport);
	esw->smart_nic_sysfs.vport = NULL;

	kobject_put(esw->smart_nic_sysfs.kobj);
	esw->smart_nic_sysfs.kobj = NULL;
}

static ssize_t regex_store(struct kobject *kobj, struct kobj_attribute *attr,
			   const char *buf, size_t count)
{
	struct mlx5_regex_vport *regex =
		container_of(kobj, struct mlx5_regex_vport, kobj);
	int err;

	if (!MLX5_CAP_GEN_MAX(regex->dev, regexp_mmo_qp))
		return -EOPNOTSUPP;
	if (sysfs_streq(buf, "1"))
		err = mlx5_regex_enable(regex->dev, regex->vport, 1);
	else if (sysfs_streq(buf, "0"))
		err = mlx5_regex_enable(regex->dev, regex->vport, 0);
	else
		err = -EINVAL;

	return err ? err : count;
}

static ssize_t regex_show(struct kobject *kobj, struct kobj_attribute *attr,
			  char *buf)
{
	struct mlx5_regex_vport *regex =
		container_of(kobj, struct mlx5_regex_vport, kobj);
	int res;

	res = mlx5_regex_query(regex->dev, regex->vport);
	if (res < 0)
		return sprintf(buf, "Failed to query device\n");

	return sprintf(buf, "%d\n", res);
}

static struct kobj_attribute attr_regex = {
	.attr = {.name = "regex_en",
		 .mode = 0644 },
	.show = regex_show,
	.store = regex_store,
};

static struct attribute *regex_attrs[] = {
	&attr_regex.attr,
	NULL,
};

static ssize_t regex_attr_show(struct kobject *kobj,
			       struct attribute *attr, char *buf)
{
	return smart_nic_attr_show(kobj, attr, buf);
}

static ssize_t regex_attr_store(struct kobject *kobj,
				struct attribute *attr,
				const char *buf, size_t count)
{
	return smart_nic_attr_store(kobj, attr, buf, count);
}

static const struct sysfs_ops regex_sysfs_ops = {
	.show   = regex_attr_show,
	.store  = regex_attr_store
};

ATTRIBUTE_GROUPS(regex);

static struct kobj_type regex_type = {
	.sysfs_ops     = &regex_sysfs_ops,
	.default_groups = regex_groups
};

int mlx5_regex_sysfs_init(struct mlx5_core_dev *dev)
{
	struct mlx5_core_regex *regex = &dev->priv.regex;
	struct device *device = &dev->pdev->dev;
	struct mlx5_regex_vport *vport;
	u16 num_vports;
	int i, ret = 0;

	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_host_functions_enabled(dev))
		return 0;

	regex->kobj = kobject_create_and_add("regex", &device->kobj);
	if (!regex->kobj)
		return -ENOMEM;

	num_vports = mlx5_core_max_vfs(dev) + 1;
	regex->vport = kcalloc(num_vports, sizeof(struct mlx5_regex_vport),
			       GFP_KERNEL);
	if (!regex->vport) {
		ret = -ENOMEM;
		goto err_vport;
	}

	for (i = 0; i < num_vports; i++) {
		vport = &regex->vport[i];
		vport->dev = dev;
		vport->vport = i;
		if (i == 0)
			ret = kobject_init_and_add(&vport->kobj, &regex_type,
						   regex->kobj, "pf");
		else
			ret = kobject_init_and_add(&vport->kobj, &regex_type,
						   regex->kobj, "vf%d",
						   i - 1);
		if (ret)
			goto err_attr;
	}

	return 0;

err_attr:
	for (--i; i >= 0; i--)
		kobject_put(&regex->vport[i].kobj);
	kfree(regex->vport);
	regex->vport = NULL;
err_vport:
	kobject_put(regex->kobj);
	regex->kobj = NULL;
	return ret;
}

void mlx5_regex_sysfs_cleanup(struct mlx5_core_dev *dev)
{
	struct mlx5_core_regex *regex = &dev->priv.regex;
	struct mlx5_regex_vport *vport;
	u16 num_vports, i;

	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_host_functions_enabled(dev))
		return;

	num_vports = mlx5_core_max_vfs(dev) + 1;

	for  (i = 0; i < num_vports; i++) {
		vport = &regex->vport[i];
		kobject_put(&vport->kobj);
	}

	kfree(regex->vport);
	regex->vport = NULL;

	kobject_put(regex->kobj);
	regex->kobj = NULL;
}
