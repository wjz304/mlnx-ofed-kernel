/nl Examine kernel functionality

# DO NOT insert new defines in this section!!!
# Add your defines ONLY in LINUX_CONFIG_COMPAT section
AC_DEFUN([BP_CHECK_RHTABLE],
[
	AC_MSG_CHECKING([if file include/linux/rhashtable-types.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rhashtable-types.h>
	],[
		struct rhltable x;
		x = x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RHASHTABLE_TYPES, 1,
			[file rhashtable-types exists])
	],[
		AC_MSG_RESULT(no)
		AC_MSG_CHECKING([if rhltable defined])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <linux/rhashtable.h>
		],[
			struct rhltable x;
			x = x;

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_RHLTABLE, 1,
				[struct rhltable is defined])
			AC_MSG_CHECKING([if struct rhashtable_params contains insecure_elasticity])
			MLNX_BG_LB_LINUX_TRY_COMPILE([
				#include <linux/rhashtable.h>
			],[
				struct rhashtable_params x;
				unsigned int y;
				y = (unsigned int)x.insecure_elasticity;

				return 0;
			],[
				AC_MSG_RESULT(yes)
				MLNX_AC_DEFINE(HAVE_RHASHTABLE_INSECURE_ELASTICITY, 1,
					[struct rhashtable_params has insecure_elasticity])
			],[
				AC_MSG_RESULT(no)
			])
			AC_MSG_CHECKING([if struct rhashtable_params contains insecure_max_entries])
			MLNX_BG_LB_LINUX_TRY_COMPILE([
				#include <linux/rhashtable.h>
			],[
				struct rhashtable_params x;
				unsigned int y;
				y = (unsigned int)x.insecure_max_entries;

				return 0;
			],[
				AC_MSG_RESULT(yes)
				MLNX_AC_DEFINE(HAVE_RHASHTABLE_INSECURE_MAX_ENTRIES, 1,
					[struct rhashtable_params has insecure_max_entries])
			],[
				AC_MSG_RESULT(no)
			])
			AC_MSG_CHECKING([if struct rhashtable contains max_elems])
			MLNX_BG_LB_LINUX_TRY_COMPILE([
				#include <linux/rhashtable.h>
			],[
				struct rhashtable x;
				unsigned int y;
				y = (unsigned int)x.max_elems;

				return 0;
			],[
				AC_MSG_RESULT(yes)
				MLNX_AC_DEFINE(HAVE_RHASHTABLE_MAX_ELEMS, 1,
					[struct rhashtable has max_elems])
			],[
				AC_MSG_RESULT(no)
			])
		],[
			AC_MSG_RESULT(no)
			AC_MSG_CHECKING([if struct netns_frags contains rhashtable])
			MLNX_BG_LB_LINUX_TRY_COMPILE([
				#include <linux/in6.h>
				#include <net/inet_frag.h>
			],[
				struct netns_frags x;
				struct rhashtable rh;
				rh = x.rhashtable;

				return 0;
			],[
				AC_MSG_RESULT(yes)
				MLNX_AC_DEFINE(HAVE_NETNS_FRAGS_RHASHTABLE, 1,
					[struct netns_frags has rhashtable])
			],[
				AC_MSG_RESULT(no)
			])
		])
	])
])


AC_DEFUN([LINUX_CONFIG_COMPAT],
[
	AC_MSG_CHECKING([if have hmm_pfn_to_map_order])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/hmm.h>
	],[
		unsigned int i = hmm_pfn_to_map_order(0UL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HMM_PFN_TO_MAP_ORDER, 1,
			[have hmm_pfn_to_map_order])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vm_flags_clear exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/hmm.h>
	],[
		vm_flags_clear(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VM_FLAGS_CLEAR, 1,
			[vm_flags_clear exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if hmm_range has hmm_pfns])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/hmm.h>
	],[
		struct hmm_range h;
		h.hmm_pfns = NULL;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HMM_RANGE_HAS_HMM_PFNS, 1,
			[hmm_range has hmm_pfns])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if hmm_range_fault has one param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/hmm.h>
	],[
		int l;
		l = hmm_range_fault(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HMM_RANGE_FAULT_HAS_ONE_PARAM, 1,
			[hmm_range_fault has one param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rdma/ib_umem.h ib_umem_dmabuf_get_pinned defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <rdma/ib_umem.h>
	],[
		ib_umem_dmabuf_get_pinned(NULL, 0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IB_UMEM_DMABUF_GET_PINNED, 1,
			[rdma/ib_umem.h ib_umem_dmabuf_get_pinned defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if debugfs.h debugfs_create_ulong defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/debugfs.h>
	],[
		debugfs_create_ulong(NULL, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEBUGFS_CREATE_ULONG, 1,
			[debugfs.h debugfs_create_ulong defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if debugfs.h debugfs_lookup defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/debugfs.h>
	],[
		debugfs_lookup(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEBUGFS_LOOKUP, 1,
			[debugfs.h debugfs_lookup defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has is_tcf_police])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <net/tc_act/tc_police.h>
	],[
		return is_tcf_police(NULL) ? 1 : 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_POLICE, 1,
			[is_tcf_police is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has is_tcf_tunnel_set && is_tcf_tunnel_release])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <net/tc_act/tc_tunnel_key.h>
	],[
		return is_tcf_tunnel_set(NULL) && is_tcf_tunnel_release(NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_TUNNEL, 1,
			[is_tcf_tunnel_set and is_tcf_tunnel_release are defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has netdev_notifier_info_to_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		return netdev_notifier_info_to_dev(NULL) ? 1 : 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NOTIFIER_INFO_TO_DEV, 1,
			[netdev_notifier_info_to_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if udp_tunnel.h has struct udp_tunnel_nic_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <net/udp_tunnel.h>
	],[
		struct udp_tunnel_nic_info x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UDP_TUNNEL_NIC_INFO, 1,
			[udp_tunnel.h has struct udp_tunnel_nic_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has register_netdevice_notifier_rh])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		return register_netdevice_notifier_rh(NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REGISTER_NETDEVICE_NOTIFIER_RH, 1,
			[register_netdevice_notifier_rh is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdevice.h has netdev_hold])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		netdev_hold(NULL,NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_HOLD, 1,
			[linux/netdevice.h has netdev_hold])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdevice.h has unregister_netdevice_notifier_net])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		unregister_netdevice_notifier_net(NULL,NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UNREGISTER_NETDEVICE_NOTIFIER_NET, 1,
			[unregister_netdevice_notifier_net is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdevice.h has register_netdevice_notifier_dev_net])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		register_netdevice_notifier_dev_net(NULL,NULL,NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REGISTER_NETDEVICE_NOTIFIER_DEV_NET, 1,
			[register_netdevice_notifier_dev_net is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdevice.h has dev_xdp_prog_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		dev_xdp_prog_id(NULL,0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_XDP_PROG_ID, 1,
			[dev_xdp_prog_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_net_notifier exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		struct netdev_net_notifier notifier;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NET_NOTIFIER, 1,
			[struct netdev_net_notifier is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/netdevice.h has net_prefetch])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
	],[
		net_prefetch(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_PREFETCH, 1,
			[net_prefetch is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pagemap.h has release_pages ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pagemap.h>
	],[
		release_pages(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RELEASE_PAGES, 1,
			[release_pages is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/mm.h has is_cow_mapping])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		is_cow_mapping(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_COW_MAPPING, 1,
			[is_cow_mapping is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/mm.h has get_user_pages_longterm])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages_longterm(0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_LONGTERM, 1,
			[get_user_pages_longterm is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if get_user_pages has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(0, 0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_4_PARAMS, 1,
			[get_user_pages has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if get_user_pages has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_5_PARAMS, 1,
			[get_user_pages has 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if get_user_pages has 7 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(NULL, NULL, 0, 0, 0, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_7_PARAMS, 1,
			[get_user_pages has 7 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has memcpy_and_pad])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/string.h>
	],
	[
		memcpy_and_pad(NULL, 0, NULL, 0, ' ');

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MEMCPY_AND_PAD, 1,
		[memcpy_and_pad is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if map_lock has mmap_read_lock])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		mmap_read_lock(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMAP_READ_LOCK, 1,
			[map_lock has mmap_read_lock])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 7 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_7_PARAMS, 1,
			[get_user_pages_remote is defined with 7 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 7 parameters and parameter 2 is integer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, 0, 0, 0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_7_PARAMS_AND_SECOND_INT, 1,
			[get_user_pages_remote is defined with 7 parameters and parameter 2 is integer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 8 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_8_PARAMS, 1,
			[get_user_pages_remote is defined with 8 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm has get_user_pages_remote with 8 parameters with locked])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
	],[
		get_user_pages_remote(NULL, NULL, 0, 0, 0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_REMOTE_8_PARAMS_W_LOCKED, 1,
			[get_user_pages_remote is defined with 8 parameters with locked])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel has ktime_get_ns])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ktime.h>
	],[
		unsigned long long ns;

		ns = ktime_get_ns();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KTIME_GET_NS, 1,
			  [ktime_get_ns defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if page_ref.h has page_ref_count/add/sub/inc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/page_ref.h>
	],[
		page_ref_count(NULL);
		page_ref_add(NULL, 0);
		page_ref_sub(NULL, 0);
		page_ref_inc(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_REF_COUNT_ADD_SUB_INC, 1,
			  [page_ref_count/add/sub/inc defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kernel.h has int_pow])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/kernel.h>
	],[
		return int_pow(2, 3);

	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INT_POW, 1,
			  [int_pow defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if hwmon.h hwmon_device_register_with_info exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/hwmon.h>
	],[
		hwmon_device_register_with_info(NULL, NULL, NULL, NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HWMON_DEVICE_REGISTER_WITH_INFO, 1,
			  [hwmon.h hwmon_device_register_with_info exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if hwmon.h hwmon_ops has read_string])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/hwmon.h>
	],[

		struct hwmon_ops x = {
			.read_string = NULL,
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HWMON_OPS_READ_STRING, 1,
			  [hwmon.h hwmon_ops has read_string])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if hwmon.h hwmon_ops read_string get const str])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/hwmon.h>

		static int mlx5_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
						  int channel, const char **str)
		{
			return 0;
		}

	],[

		struct hwmon_ops x = {
			.read_string = mlx5_hwmon_read_string,
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HWMON_READ_STRING_CONST_STR, 1,
			  [hwmon.h hwmon_ops read_string get const str])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if prandom.h has get_random_u32_inclusive])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/random.h>
	],[
		int a;
		a = get_random_u32_inclusive(0, 100);

	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_RANDOM_U32_INCLUSIVE, 1,
			  [get_random_u32_inclusive defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if prandom.h has get_random_u32])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/random.h>
	],[
		int a;
		a = get_random_u32();

	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_RANDOM_U32, 1,
			  [get_random_u32 defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_get_devlink_port])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops ndops = {
			.ndo_get_devlink_port = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_DEVLINK_PORT, 1,
			  [ndo_get_devlink_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_fmsg_u8_pair_put returns int])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int err = devlink_fmsg_u8_pair_put(NULL, "test", 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INT_DEVLINK_FMSG_U8_PAIR, 1,
			  [devlink_fmsg_u8_pair_put returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_port_ops had port_fn_ipsec_crypto_get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_port_ops dl_port_ops  = {
			.port_fn_ipsec_crypto_get = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_IPSEC_CRYPTO, 1,
			  [port_fn_ipsec_crypto_get is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_port_ops had port_fn_ipsec_packet_get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_port_ops dl_port_ops  = {
			.port_fn_ipsec_packet_get = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_IPSEC_PACKET, 1,
			  [port_fn_ipsec_packet_get is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_get_phys_port_name])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops ndops = {
			.ndo_get_phys_port_name = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_PHYS_PORT_NAME, 1,
			  [ndo_get_phys_port_name is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has devlink_port member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device nd = {
			.devlink_port = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_DEVLINK_PORT, 1,
			  [struct net_device has devlink_port member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has xdp_metadata_ops member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device nd = {
			.xdp_metadata_ops = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_METADATA_OPS, 1,
			  [struct net_device has struct net_device has xdp_metadata_ops member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devl_rate_leaf_create get 3 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_rate_leaf_create(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_RATE_LEAF_CREATE_GET_3_PARAMS, 1,
			[devl_rate_leaf_create 3 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devlink_port_type_eth_set get 1 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_type_eth_set(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_TYPE_ETH_SET_GET_1_PARAM, 1,
			[devlink_port_type_eth_set get 1 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_param_driverinit_value_get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_param_driverinit_value_get(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_PARAM_DRIVERINIT_VALUE_GET, 1,
			[devlink.h has devl_param_driverinit_value_get])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_port_health_reporter_create])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_port_health_reporter_create(NULL, NULL, 0, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_PORT_HEALTH_REPORTER_CREATE, 1,
			[devlink.h has devl_port_health_reporter_create])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_health_reporter_create])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_health_reporter_create(NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_HEALTH_REPORTER_CREATE, 1,
			[devlink.h has devl_health_reporter_create])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_info_driver_name_put])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_info_driver_name_put(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_INFO_DRIVER_NAME_PUT, 1,
			[devlink.h has devlink_info_driver_name_put])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_set_features])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_set_features(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_SET_FEATURES, 1,
			[devlink.h has devlink_set_features])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_to_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_to_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TO_DEV, 1,
			[devlink.h has devlink_to_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devl_port_register defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_port_register(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_PORT_REGISTER, 1,
			[devlink.h devl_port_register defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devl_trap_groups_register defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_trap_groups_register(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_TRAP_GROUPS_REGISTER, 1,
			[devlink.h devl_trap_groups_register defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devlink_param_register defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_param_register(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_REGISTER, 1,
			[devlink.h devlink_param_register defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_register get 1 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_register(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_REGISTER_GET_1_PARAMS, 1,
			[devlink.h has devlink_register get 1 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_register(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_REGISTER, 1,
			[devlink.h has devl_register])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_resource_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_resource_register(NULL, NULL, 0, 0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_RESOURCE_REGISTER, 1,
			[devlink.h has devl_resource_register])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_resource_register_6_params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_resource_register(NULL, NULL, 0, 0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RESOURCE_REGISTER_6_PARAMS, 1,
			[devlink.h has devlink_resource_register_6_params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_resource_register_8_params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_resource_register(NULL, NULL, false, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RESOURCE_REGISTER_8_PARAMS, 1,
			[devlink.h has devlink_resource_register_8_params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devl_resources_unregister])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devl_resources_unregister(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVL_RESOURCES_UNREGISTER, 1,
			[devlink.h has devl_resources_unregister])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_resources_unregister 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_resources_unregister(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RESOURCES_UNREGISTER_2_PARAMS, 1,
			[devlink.h has devlink_resources_unregister 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_resources_unregister 1 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_resources_unregister(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RESOURCES_UNREGISTER_1_PARAMS, 1,
			[devlink.h has devlink_resources_unregister 1 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_alloc get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_alloc(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_ALLOC_GET_3_PARAMS, 1,
			[devlink.h has devlink_alloc get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_port_attrs_pci_sf_set get 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_sf_set(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_SF_SET_GET_4_PARAMS, 1,
			[devlink.h has devlink_port_attrs_pci_sf_set get 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_port_attrs_pci_sf_set get 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_sf_set(NULL, 0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_SF_SET_GET_5_PARAMS, 1,
			[devlink.h has devlink_port_attrs_pci_sf_set get 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h devlink_port_attrs_pci_vf_set get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_vf_set(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_VF_SET_GET_3_PARAMS, 1,
			  [devlink.h devlink_port_attrs_pci_vf_set get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_port_attrs_pci_vf_set has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_vf_set(NULL, NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_VF_SET_GET_5_PARAMS, 1,
			  [devlink_port_attrs_pci_vf_set has 5 params])
	],[
		AC_MSG_RESULT(no)
		AC_MSG_CHECKING([if devlink has devlink_port_attrs_pci_vf_set has 5 params and controller num])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <net/devlink.h>
		],[
			devlink_port_attrs_pci_vf_set(NULL, 0, 0, 0, 0);
			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_VF_SET_GET_CONTROLLER_NUM, 1,
				 [devlink_port_attrs_pci_vf_set has 5 params and controller num])
		],[
			AC_MSG_RESULT(no)
		])
	])

	AC_MSG_CHECKING([if devlink.h devlink_port_attrs_pci_pf_set get 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_pf_set(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_PF_SET_GET_2_PARAMS, 1,
			  [devlink.h devlink_port_attrs_pci_pf_set get 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink.h has devlink_fmsg_binary_pair_nest_start])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_fmsg_binary_pair_nest_start(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FMSG_BINARY_PAIR_NEST_START, 1,
			  [devlink.h has devlink_fmsg_binary_pair_nest_start is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_flash_update_status_notify])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_flash_update_status_notify(NULL, NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FLASH_UPDATE_STATUS_NOTIFY, 1,
			  [devlink_flash_update_status_notify])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_flash_update_end_notify])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_flash_update_end_notify(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FLASH_UPDATE_END_NOTIFY, 1,
			  [devlink_flash_update_end_notify])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_info_version_fixed_put])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_info_version_fixed_put(NULL, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_INFO_VERSION_FIXED_PUT, 1,
			  [devlink_info_version_fixed_put exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_port_type_eth_set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_type_eth_set(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_TYPE_ETH_SET_GET_2_PARAM, 1,
			  [devlink_port_type_eth_set exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_health_reporter_state_update])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_health_reporter_state_update(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HEALTH_REPORTER_STATE_UPDATE, 1,
			  [devlink_health_reporter_state_update exist])
	],[
		AC_MSG_RESULT(no)
	])

        AC_MSG_CHECKING([if devlink_health_reporter_ops.recover has extack parameter])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>
		static int reporter_recover(struct devlink_health_reporter *reporter,
						     void *context,
						     struct netlink_ext_ack *extack)
		{
			return 0;
		}
        ],[
		struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
			.recover = reporter_recover
		}
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_HEALTH_REPORTER_RECOVER_HAS_EXTACK, 1,
                          [devlink_health_reporter_ops.recover has extack])
        ],[
                AC_MSG_RESULT(no)
        ])

        AC_MSG_CHECKING([if devlink_health_reporter_ops has diagnose])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>
        ],[

		struct devlink_health_reporter_ops devlink_reporter_ops = {
			.diagnose = NULL,
		};
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_HEALTH_REPORTER_DIAGNOSE, 1,
                          [devlink_health_reporter_ops has diagnose])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if devlink has devlink_param_driverinit_value_get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_param_driverinit_value_get(NULL, 0, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_DRIVERINIT_VAL, 1,
			  [devlink_param_driverinit_value_get exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PARAM_GENERIC_ID_MAX])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int i = DEVLINK_PARAM_GENERIC_ID_MAX;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_GENERIC_ID_MAX, 1,
			  [devlink enum  has HAVE_DEVLINK_PARAM_GENERIC_ID_MAX])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int i = DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE, 1,
			  [devlink enum has DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has HAVE_DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int i = DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH, 1,
			  [devlink enum has HAVE_DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink struct devlink_port exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_port i;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_STRUCT, 1,
			  [devlink struct devlink_port exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink struct devlink_port_new_attrs exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_port_new_attrs i;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_NEW_ATTRS_STRUCT, 1,
			  [devlink struct devlink_port_new_attrs exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_port_attrs_set has 7 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_set(NULL, 0, 0, 0, 0, NULL ,0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATRRS_SET_GET_7_PARAMS, 1,
			  [devlink_port_attrs_set has 7 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_port_attrs_set has 5 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_set(NULL, 0, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATRRS_SET_GET_5_PARAMS, 1,
			  [devlink_port_attrs_set has 5 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_port_attrs_set has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_set(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATRRS_SET_GET_2_PARAMS, 1,
			  [devlink_port_attrs_set has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PARAM_GENERIC_ID_ENABLE_ROCE])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int i = DEVLINK_PARAM_GENERIC_ID_ENABLE_ROCE;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_GENERIC_ID_ENABLE_ROCE, 1,
			  [struct devlink_param exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PARAM_GENERIC_ID_ENABLE_REMOTE_DEV_RESET])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int i = DEVLINK_PARAM_GENERIC_ID_ENABLE_REMOTE_DEV_RESET;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_GENERIC_ID_ENABLE_REMOTE_DEV_RESET, 1,
			  [enum DEVLINK_PARAM_GENERIC_ID_ENABLE_REMOTE_DEV_RESET exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum devlink_port_flavour exist])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <uapi/linux/devlink.h>
        ],[
                enum devlink_port_flavour flavour;
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_FLAVOUR, 1,
                          [enum devlink_port_flavour exist])
        ],[
                AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum devlink_port_fn_state exist])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <uapi/linux/devlink.h>
        ],[
                enum devlink_port_fn_state fn_state;
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_FN_STATE, 1,
                          [enum devlink_port_fn_state exist])
        ],[
                AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum devlink_port_fn_opstate exist])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <uapi/linux/devlink.h>
        ],[
                enum devlink_port_fn_opstate fn_opstate;
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_FN_OPSTATE, 1,
                          [enum devlink_port_fn_opstate exist])
        ],[
                AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PORT_FLAVOUR_VIRTUAL])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <uapi/linux/devlink.h>
        ],[
                int i = DEVLINK_PORT_FLAVOUR_VIRTUAL;
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_FLAVOUR_VIRTUAL, 1,
                          [enum DEVLINK_PORT_FLAVOUR_VIRTUAL is defined])
        ],[
                AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink enum has DEVLINK_PORT_FLAVOUR_PCI_SF])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <uapi/linux/devlink.h>
        ],[
                int i = DEVLINK_PORT_FLAVOUR_PCI_SF;
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_FLAVOUR_PCI_SF, 1,
                          [enum DEVLINK_PORT_FLAVOUR_PCI_SF is defined])
        ],[
                AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_param exist in net/devlink.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_param soso;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM, 1,
			  [struct devlink_param exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_reload_disable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_reload_disable(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RELOAD_DISABLE, 1,
			  [devlink_reload_disable exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_reload_enable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_reload_enable(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_RELOAD_ENABLE, 1,
			  [devlink_reload_enable exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_net])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_net(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_NET, 1,
			  [devlink_net exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has reload has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	        #include <net/devlink.h>

	        static int devlink_reload(struct devlink *devlink,
	                                struct netlink_ext_ack *extack)
	        {
	                return 0;
	        }

	],[
	        struct devlink_ops dlops = {
	                .reload = devlink_reload,
	        };

	        return 0;
	],[
	        AC_MSG_RESULT(yes)
	        MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_RELOAD, 1,
	                  [reload is defined])
	],[
	        AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has reload_up/down])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.reload_up = NULL,
			.reload_down = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_RELOAD_UP_DOWN, 1,
			  [reload_up/down is defined])
	],[
		AC_MSG_RESULT(no)
	])

        AC_MSG_CHECKING([if devlink_ops.port_function_hw_addr_get has 4 params])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>

		static int devlink_port_function_hw_addr_get(struct devlink_port *port, u8 *hw_addr,
							int *hw_addr_len,
							struct netlink_ext_ack *extack)
		{
		        return 0;
		}

        ],[
                struct devlink_ops dlops = {
                        .port_function_hw_addr_get = devlink_port_function_hw_addr_get,
		};

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_PORT_FUNCTION_HW_ADDR_GET_GET_4_PARAM, 1,
                          [port_function_hw_addr_get has 4 params])
        ],[
                AC_MSG_RESULT(no)
        ])

        AC_MSG_CHECKING([if devlink_ops.port_function_state_get has 4 params])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>

               static int mlx5_devlink_sf_port_fn_state_get(struct devlink_port *dl_port,
                                                            enum devlink_port_fn_state *state,
                                                            enum devlink_port_fn_opstate *opstate,
                                                            struct netlink_ext_ack *extack)
               {
                       return 0;
               }

        ],[
                struct devlink_ops dlops = {
                       .port_fn_state_get = mlx5_devlink_sf_port_fn_state_get,
               };

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_PORT_FUNCTION_STATE_GET_4_PARAM, 1,
                          [port_function_state_get has 4 params])
        ],[
                AC_MSG_RESULT(no)
        ])

       AC_MSG_CHECKING([if struct devlink_ops has port_function_state_get/set])
       MLNX_BG_LB_LINUX_TRY_COMPILE([
               #include <net/devlink.h>
       ],[
               struct devlink_ops dlops = {
                       .port_fn_state_get = NULL,
                       .port_fn_state_set = NULL,
               };

               return 0;
       ],[
               AC_MSG_RESULT(yes)
               MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_PORT_FUNCTION_STATE_GET, 1,
                         [port_function_state_get/set is defined])
       ],[
               AC_MSG_RESULT(no)
       ])

        AC_MSG_CHECKING([if devlink_ops.reload_down has 3 params])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>

		static int devlink_reload_down(struct devlink *devlink, bool netns_change,
                                    struct netlink_ext_ack *extack)
		{
		        return 0;
		}

        ],[
                struct devlink_ops dlops = {
                        .reload_down = devlink_reload_down,
		};

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_RELOAD_DOWN_HAS_3_PARAMS, 1,
                          [reload_down has 3 params])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if devlink_ops.reload_down has 5 params])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/devlink.h>

		static int devlink_reload_down(struct devlink *devlink, bool netns_change,
				enum devlink_reload_action action, enum devlink_reload_limit limit,
                		struct netlink_ext_ack *extack)
		{
		        return 0;
		}

        ],[
                struct devlink_ops dlops = {
                        .reload_down = devlink_reload_down,
		};

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEVLINK_RELOAD_DOWN_SUPPORT_RELOAD_ACTION, 1,
                          [reload_down has 5 params])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if struct devlink_port_ops exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_port_ops dlops = {
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_OPS, 1,
			  [struct devlink_port_ops exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has info_get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.info_get = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_INFO_GET, 1,
			  [info_get is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink struct devlink_trap exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_trap t;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_SUPPORT, 1,
			[devlink struct devlink_trap exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		int n = DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_DMAC_FILTER, 1,
			[devlink has DEVLINK_TRAP_GENERIC_ID_DMAC_FILTER])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_ops.trap_action_set has 4 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>

		static int mlx5_devlink_trap_action_set(struct devlink *devlink,
							const struct devlink_trap *trap,
							enum devlink_trap_action action,
							struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct devlink_ops dlops = {
			.trap_action_set = mlx5_devlink_trap_action_set,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_ACTION_SET_4_ARGS, 1,
			[devlink_ops.trap_action_set has 4 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_trap_report has 5 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_trap_report(NULL, NULL, NULL, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_REPORT_5_ARGS, 1,
			[devlink_trap_report has 5 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has DEVLINK_TRAP_GROUP_GENERIC with 2 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		static const struct devlink_trap_group mlx5_trap_groups_arr[] = {
			DEVLINK_TRAP_GROUP_GENERIC(L2_DROPS, 0),
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_GROUP_GENERIC_2_ARGS, 1,
			[devlink has DEVLINK_TRAP_GROUP_GENERIC with 2 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_trap_groups_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_trap_groups_register(NULL, NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_TRAP_GROUPS_REGISTER, 1,
			[devlink has devlink_trap_groups_register])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_port_health_reporter_create])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_health_reporter *r;

		r = devlink_port_health_reporter_create(NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_HEALTH_REPORTER_CREATE, 1,
			[devlink_health_reporter_create is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_port_health_reporter_destroy])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_health_reporter_destroy(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_HEALTH_REPORTER_DESTROY, 1,
			[devlink_port_health_reporter_destroy is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_health_reporter_create with 5 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_health_reporter *r;

		r = devlink_health_reporter_create(NULL, NULL, 0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HEALTH_REPORTER_CREATE_5_ARGS, 1,
			[devlink_health_reporter_create has 5 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_health_reporter_create with 4 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_health_reporter *r;

		r = devlink_health_reporter_create(NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HEALTH_REPORTER_CREATE_4_ARGS, 1,
			[devlink_health_reporter_create has 4 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_health_reporter & devlink_fmsg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		/* test for devlink_health_reporter and devlink_fmsg */
		struct devlink_health_reporter *r;
		struct devlink_fmsg *fmsg;
		int err;

		devlink_health_reporter_destroy(r);
		devlink_health_reporter_priv(r);

		err = devlink_health_report(r, NULL, NULL);

		devlink_fmsg_arr_pair_nest_start(fmsg, "name");
		devlink_fmsg_arr_pair_nest_end(fmsg);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HEALTH_REPORT_BASE_SUPPORT, 1,
			  [structs devlink_health_reporter & devlink_fmsg exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_fmsg_binary_put])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_fmsg *fmsg;
		int err;
		int value;

		err =  devlink_fmsg_binary_put(fmsg, &value, 2);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FMSG_BINARY_PUT, 1,
			  [devlink_fmsg_binary_put exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_fmsg_binary_pair_put])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>

		/* Only interested in function with arg u32 and not u16 */
		/* See upstream commit e2cde864a1d3e3626bfc8fa088fbc82b04ce66ed */
		int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name, const void *value, u32 value_len);
	],[
		struct devlink_fmsg *fmsg;
		int err;
		int value;

		err =  devlink_fmsg_binary_pair_put(fmsg, "name", &value, 2);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FMSG_BINARY_PAIR_PUT_ARG_U32_RETURN_INT, 1,
			  [devlink_fmsg_binary_pair_put exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_fmsg_binary_pair_put])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>

		/* Only interested in function with arg u32 and not u16 */
		/* See upstream commit e2cde864a1d3e3626bfc8fa088fbc82b04ce66ed */
		void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name, const void *value, u32 value_len);
	],[
		struct devlink_fmsg *fmsg;
		int value;

		devlink_fmsg_binary_pair_put(fmsg, "name", &value, 2);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FMSG_BINARY_PAIR_PUT_ARG_U32_RETURN_VOID, 1,
			  [devlink_fmsg_binary_pair_put exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has eswitch_mode_get/set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.eswitch_mode_get = NULL,
			.eswitch_mode_set = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_ESWITCH_MODE_GET_SET, 1,
			  [eswitch_mode_get/set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops.eswitch_mode_set has extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
		int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
		                                struct netlink_ext_ack *extack) {
			return 0;
		}
	],[
		static const struct devlink_ops dlops = {
			.eswitch_mode_set = mlx5_devlink_eswitch_mode_set,
		};
		dlops.eswitch_mode_set(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_ESWITCH_MODE_SET_EXTACK, 1,
			  [struct devlink_ops.eswitch_mode_set has extack])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has port_function_roce/mig_get/set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.port_fn_migratable_get = NULL,
			.port_fn_migratable_set = NULL,
			.port_fn_roce_get = NULL,
			.port_fn_roce_set = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_PORT_FN_ROCE_MIG, 1,
			  [port_function_roce/mig_get/set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has port_function_hw_addr_get/set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.port_function_hw_addr_get = NULL,
			.port_function_hw_addr_set = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_PORT_FUNCTION_HW_ADDR_GET, 1,
			  [port_function_hw_addr_get/set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has rate functions])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.rate_leaf_tx_share_set = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_RATE_FUNCTIONS, 1,
			  [rate functions are defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has eswitch_encap_mode_set/get])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.eswitch_encap_mode_set = NULL,
			.eswitch_encap_mode_get = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_ESWITCH_ENCAP_MODE_SET, 1,
			  [eswitch_encap_mode_set/get is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops defines eswitch_encap_mode_set/get with enum arg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
		#include <uapi/linux/devlink.h>
	],[
		int local_eswitch_encap_mode_get(struct devlink *devlink,
					      enum devlink_eswitch_encap_mode *p_encap_mode) {
			return 0;
		}
		int local_eswitch_encap_mode_set(struct devlink *devlink,
					      enum devlink_eswitch_encap_mode encap_mode,
					      struct netlink_ext_ack *extack) {
			return 0;
		}

		struct devlink_ops dlops = {
			.eswitch_encap_mode_set = local_eswitch_encap_mode_set,
			.eswitch_encap_mode_get = local_eswitch_encap_mode_get,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_ESWITCH_ENCAP_MODE_SET_GET_WITH_ENUM, 1,
			  [eswitch_encap_mode_set/get is defined with enum])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if struct devlink_ops has eswitch_inline_mode_get/set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.eswitch_inline_mode_get = NULL,
			.eswitch_inline_mode_set = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_ESWITCH_INLINE_MODE_GET_SET, 1,
			  [eswitch_inline_mode_get/set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops has flash_update])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_ops dlops = {
			.flash_update = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_HAS_FLASH_UPDATE, 1,
			  [flash_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct devlink_ops flash_update get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
		#include <linux/netlink.h>

		static int flash_update_func(struct devlink *devlink,
			    struct devlink_flash_update_params *params,
			    struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct devlink_ops dlops = {
			.flash_update = flash_update_func,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLASH_UPDATE_GET_3_PARAMS, 1,
			  [struct devlink_ops flash_update get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink has devlink_port_attrs_pci_pf_set has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_pf_set(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_PF_SET_4_PARAMS, 1,
			  [devlink_port_attrs_pci_pf_set has 4 params])
	],[
		AC_MSG_RESULT(no)
		AC_MSG_CHECKING([if devlink has devlink_port_attrs_pci_pf_set has 4 params and controller num])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <net/devlink.h>
		],[
			devlink_port_attrs_pci_pf_set(NULL, 0, 0, 0);
			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_PF_SET_CONTROLLER_NUM, 1,
				  [devlink_port_attrs_pci_pf_set has 4 params and controller num])
		],[
			AC_MSG_RESULT(no)
		])
	])

	AC_MSG_CHECKING([if devlink has devlink_port_attrs_pci_pf_set has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_port_attrs_pci_pf_set(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PORT_ATTRS_PCI_PF_SET_2_PARAMS, 1,
			  [devlink_port_attrs_pci_pf_set has 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devlink_flash_update_params has struct firmware fw])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		struct devlink_flash_update_params *x;
		x->fw = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_FLASH_UPDATE_PARAMS_HAS_STRUCT_FW, 1,
			  [devlink_flash_update_params has struct firmware fw])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_info has vlan_proto])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_info *ivf;

		ivf->vlan_proto = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VF_VLAN_PROTO, 1,
			  [vlan_proto is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if IP6_ECN_set_ce has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/inet_ecn.h>
	],[
		IP6_ECN_set_ce(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IP6_SET_CE_2_PARAMS, 1,
			  [IP6_ECN_set_ce has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if exists netif_carrier_event])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_carrier_event(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_CARRIER_EVENT, 1,
			  [netif_carrier_event exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netif_device_present get const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		const struct net_device *dev;
		netif_device_present(dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_DEVICE_PRESENT_GET_CONST, 1,
			  [netif_device_present get const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_master_upper_dev_link gets 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_master_upper_dev_link(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_MASTER_UPPER_DEV_LINK_4_PARAMS, 1,
			  [netdev_master_upper_dev_link gets 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has devlink_port])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;

		dev->devlink_port = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_HAS_DEVLINK_PORT, 1,
			  [struct net_device has devlink_port])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has lower_level])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device dev;

		dev.lower_level = 1;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_LOWER_LEVEL, 1,
			  [struct net_device has lower_level])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_lag_hash has NETDEV_LAG_HASH_VLAN_SRCMAC])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int x = NETDEV_LAG_HASH_VLAN_SRCMAC;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_LAG_HASH_VLAN_SRCMAC, 1,
			  [netdev_lag_hash has NETDEV_LAG_HASH_VLAN_SRCMAC])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h kernel_ethtool_ringparam has tcp_data_split member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
                struct kernel_ethtool_ringparam x = {
			.tcp_data_split = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KERNEL_RINGPARAM_TCP_DATA_SPLIT, 1,
			  [ethtool.h kernel_ethtool_ringparam has tcp_data_split member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has struct kernel_ethtool_ringparam])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
                struct kernel_ethtool_ringparam x;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_KERNEL_ETHTOOL_RINGPARAM, 1,
			  [ethtool.h has struct kernel_ethtool_ringparam])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi ethtool.h has IPV6_USER_FLOW])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
                int x = IPV6_USER_FLOW;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_USER_FLOW, 1,
			  [uapi ethtool has IPV6_USER_FLOW])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi ethtool.h has FLOW_RSS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		int x = FLOW_RSS;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_RSS, 1,
			  [uapi ethtool has FLOW_RSS])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has supported_coalesce_params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.supported_coalesce_params = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SUPPORTED_COALESCE_PARAM, 1,
			  [supported_coalesce_params is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_tunable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_tunable = NULL,
			.set_tunable = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_SET_TUNABLE, 1,
			  [get/set_tunable is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get_module_eeprom_by_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_module_eeprom_by_page = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_MODULE_EEPROM_BY_PAGE, 1,
			[ethtool_ops has get_module_eeprom_by_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has __ethtool_get_link_ksettings])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		 __ethtool_get_link_ksettings(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___ETHTOOL_GET_LINK_KSETTINGS, 1,
			  [__ethtool_get_link_ksettings is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has min/max])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->min_mtu = 0;
		dev->max_mtu = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_MIN_MAX_MTU, 1,
			  [net_device min/max is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has needs_free_netdev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;

		dev->needs_free_netdev = true;
		dev->priv_destructor = NULL;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_NEEDS_FREE_NETDEV, 1,
			  [net_device needs_free_netdev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has close_list])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev = NULL;
		struct list_head xlist;

		dev->close_list = xlist;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_HAS_CLOSE_LIST, 1,
			  [net_device close_list is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h has tls_is_skb_tx_device_offloaded])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		tls_is_skb_tx_device_offloaded(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_IS_SKB_TX_DEVICE_OFFLOADED, 1,
			  [net/tls.h has tls_is_skb_tx_device_offloaded])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h has struct tls_offload_resync_async])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		struct tls_offload_resync_async	x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_OFFLOAD_RESYNC_ASYNC_STRUCT, 1,
			  [net/tls.h has struct tls_offload_resync_async is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ktls related structs exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/tls.h>
	],[
		struct tlsdev_ops dev;
		struct tls_offload_context_tx tx_ctx;
		struct tls12_crypto_info_aes_gcm_128 crypto_info;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KTLS_STRUCTS, 1,
			  [ktls related structs exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tlsdev_ops has tls_dev_resync])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		struct tlsdev_ops dev;

		dev.tls_dev_resync = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLSDEV_OPS_HAS_TLS_DEV_RESYNC, 1,
			  [struct tlsdev_ops has tls_dev_resync])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/skbuff.h skb_frag_fill_page_desc exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_frag_fill_page_desc(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FRAG_FILL_PAGE_DESC, 1,
			  [linux/skbuff.h skb_frag_fill_page_desc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/skbuff.h napi_build_skb exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		napi_build_skb(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NAPI_BUILD_SKB, 1,
			  [linux/skbuff.h napi_build_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skb_frag_off_add exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_frag_off_add(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FRAG_OFF_ADD, 1,
			  [linux/skbuff.h skb_frag_off_add is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skb_frag_off_set exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_frag_off_set(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FRAG_OFF_SET, 1,
			  [linux/skbuff.h skb_frag_off_set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if napi_reschedule exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int ret;

		ret = napi_reschedule(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NAPI_RESCHEDULE, 1,
			  [napi_reschedule exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_xdp exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_xdp xdp;
		xdp = xdp;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_XDP, 1,
			  [struct netdev_xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device has devlink_port as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device netdev = {
			.devlink_port = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_DEVLINK_PORT, 1,
			  [struct net_device has devlink_port as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_xdp])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_bpf = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_XDP, 1,
			  [net_device_ops has ndo_xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if struct net_device_ops has ndo_xdp_xmit])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_xdp_xmit = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_XDP_XMIT, 1,
			  [net_device_ops has ndo_xdp_xmit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_xdp_flush])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_xdp_flush = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_XDP_FLUSH, 1,
			  [ndo_xdp_flush is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_xsk_wakeup])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_xsk_wakeup = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_XSK_WAKEUP, 1,
			  [ndo_xsk_wakeup is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_xdp])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended netdev_ops_extended = {
			.ndo_xdp = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_XDP_EXTENDED, 1,
			  [extended ndo_xdp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum tc_htb_command exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		enum tc_htb_command x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ENUM_TC_HTB_COMMAND, 1,
			  [enum tc_htb_command is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_mqprio_qopt_offload exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_mqprio_qopt_offload x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_MQPRIO_QOPT_OFFLOAD, 1,
			  [tc_mqprio_qopt_offload is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_cls_flower_offload exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_flower_offload x;
		x = x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_FLOWER_OFFLOAD, 1,
			  [struct tc_cls_flower_offload is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_block_offload exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_block_offload x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_BLOCK_OFFLOAD, 1,
			  [struct tc_block_offload is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_block_offload exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct flow_block_offload x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_BLOCK_OFFLOAD, 1,
			  [struct flow_block_offload exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_block_offload hash unlocked_driver_cb])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct flow_block_offload x;
		x.unlocked_driver_cb = true;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UNLOCKED_DRIVER_CB, 1,
			  [struct flow_block_offload has unlocked_driver_cb])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_notifier_info has extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <linux/netlink.h>
	],[
		struct netdev_notifier_info *x;
                x->extack = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NOTIFIER_INFO_EXTACK, 1,
			  [struct netdev_notifier_info has extack])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netlink_ext_ack exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_ext_ack extack = {};

		NL_SET_ERR_MSG_MOD(&extack, "test");
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETLINK_EXTACK, 1,
			  [struct netlink_ext_ack exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if NL_SET_ERR_MSG_WEAK_MOD exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_ext_ack extack = {};

		NL_SET_ERR_MSG_WEAK_MOD(&extack, "test");
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NL_SET_ERR_MSG_WEAK_MOD, 1,
			  [NL_SET_ERR_MSG_WEAK_MOD exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_cls_common_offload has extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_common_offload x;
		x.extack = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLS_OFFLOAD_EXTACK_FIX, 1,
			  [struct tc_cls_common_offload has extack])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_block_offload has extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_block_offload x;
		x.extack = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_BLOCK_OFFLOAD_EXTACK, 1,
			  [struct tc_block_offload has extack])
	],[
		AC_MSG_RESULT(no)
	])

	BP_CHECK_RHTABLE

	AC_MSG_CHECKING([if struct ptp_clock_info has adjfreq])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.adjfreq = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_CLOCK_INFO_NDO_ADJFREQ, 1,
			  [adjfreq is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has gettimex64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.gettimex64 = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GETTIMEX64, 1,
			  [gettimex64 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has gettime])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.gettime = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_CLOCK_INFO_GETTIME_32BIT, 1,
			  [gettime 32bit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has adjphase])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.adjphase = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_CLOCK_INFO_ADJPHASE, 1,
			  [adjphase is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ptp_clock_info has adjfine])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		struct ptp_clock_info info = {
			.adjfine = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_CLOCK_INFO_NDO_ADJFINE, 1,
			  [adjfine is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if adjust_by_scaled_ppm exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		adjust_by_scaled_ppm(0,0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ADJUST_BY_SCALED_PPM, 1,
			  [adjfine is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_iov_vf_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_iov_vf_id(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IOV_VF_ID, 1,
			  [pci_iov_vf_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_iov_get_pf_drvdata])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_iov_get_pf_drvdata(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IOV_GET_PF_DRVDATA, 1,
			  [pci_iov_get_pf_drvdata is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h pci_bus_addr_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_bus_addr_t x = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_BUS_ADDR_T, 1,
			  [pci_bus_addr_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has page_is_pfmemalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		bool x = page_is_pfmemalloc(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_IS_PFMEMALLOC, 1,
			[page_is_pfmemalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has want_init_on_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		bool x = want_init_on_alloc(__GFP_ZERO);

		return 0;
	],[
	AC_MSG_RESULT(yes)
	MLNX_AC_DEFINE(HAVE_WANT_INIT_ON_ALLOC, 1,
		[want_init_on_alloc is defined])
	],[
	AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct page has dma_addr array member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct page page;

		page.dma_addr[0] = 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_DMA_ADDR_ARRAY, 1,
			[struct page has dma_addr array member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct page has pfmemalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct page *page;
		page->pfmemalloc = true;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_PFMEMALLOC, 1,
			[pfmemalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has select_queue_fallback_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		select_queue_fallback_t fallback;

		fallback = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SELECT_QUEUE_FALLBACK_T, 1,
			  [select_queue_fallback_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has skb_frag_off])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_frag_off(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FRAG_OFF, 1,
			  [skb_frag_off is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has dev_page_is_reusable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		dev_page_is_reusable(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_PAGE_IS_REUSABLE, 1,
			  [dev_page_is_reusable is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if gfp.h has gfpflags_allow_blocking])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/gfp.h>
	],[
		gfpflags_allow_blocking(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HAS_GFPFLAGES_ALLOW_BLOCKING, 1,
			  [gfpflags_allow_blocking is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if gfp.h has __GFP_DIRECT_RECLAIM])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/gfp.h>
	],[
		gfp_t gfp_mask = __GFP_DIRECT_RECLAIM;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HAS_GFP_DIRECT_RECLAIM, 1,
			  [__GFP_DIRECT_RECLAIM is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h skb_flow_dissect])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_flow_dissect(NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FLOW_DISSECT, 1,
			  [skb_flow_dissect is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/pkt_cls.h has tc_skb_ext_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/pkt_cls.h>
	],[
		struct sk_buff skb;

		tc_skb_ext_alloc(&skb);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SKB_EXT_ALLOC, 1,
			  [tc_skb_ext_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h dev_change_flags has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		dev_change_flags(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_CHANGE_FLAGS_HAS_3_PARAMS, 1,
			  [dev_change_flags has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uaccess.h access_ok has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uaccess.h>
	],[
		access_ok(0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ACCESS_OK_HAS_3_PARAMS, 1,
			  [access_ok has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h put_user_pages_dirty_lock has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		put_user_pages_dirty_lock(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PUT_USER_PAGES_DIRTY_LOCK_3_PARAMS, 1,
			  [put_user_pages_dirty_lock has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h put_user_pages_dirty_lock has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		put_user_pages_dirty_lock(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PUT_USER_PAGES_DIRTY_LOCK_2_PARAMS, 1,
			  [put_user_pages_dirty_lock has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h skb_flow_dissect_flow_keys has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/flow_dissector.h>
	],[
		struct sk_buff *skb;
		struct flow_keys *flow;

		skb_flow_dissect_flow_keys(skb, flow, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FLOW_DISSECT_FLOW_KEYS_HAS_3_PARAMS, 1,
			  [skb_flow_dissect_flow_keys has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h skb_flow_dissect_flow_keys has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_flow_dissect_flow_keys(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_FLOW_DISSECT_FLOW_KEYS_HAS_2_PARAMS, 1,
			  [skb_flow_dissect_flow_keys has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ptp_classify.h has ptp_classify_raw])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_classify.h>
	],[
		ptp_classify_raw(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_CLASSIFY_RAW, 1,
			  [ptp_classify_raw is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has enum NAPI_STATE_MISSED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int napi = NAPI_STATE_MISSED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NAPI_STATE_MISSED, 1,
			  [NAPI_STATE_MISSED is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bitfield.h exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bitfield.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITFIELD_H, 1,
			  [bitfield.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/flow_dissector.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_H, 1,
			  [flow_dissector.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has struct flow_dissector_mpls_lse])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		struct flow_dissector_mpls_lse ls;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_MPLS_LSE, 1,
			  [flow_dissector.h has struct flow_dissector_mpls_lse])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_IP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		int n = FLOW_DISSECTOR_KEY_ENC_IP;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_ENC_IP, 1,
			  [flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_IP])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_CONTROL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		int n = FLOW_DISSECTOR_KEY_ENC_CONTROL;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_ENC_CONTROL, 1,
			  [flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_CONTROL])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has FLOW_DISSECTOR_KEY_MPLS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		int n = FLOW_DISSECTOR_KEY_MPLS;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_MPLS, 1,
			  [flow_dissector.h has FLOW_DISSECTOR_KEY_MPLS])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has dissector_uses_key])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		dissector_uses_key(NULL, 1);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_USES_KEY, 1,
			  [flow_dissector.h has dissector_uses_key])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_KEYID])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		int n = FLOW_DISSECTOR_KEY_ENC_KEYID;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_ENC_KEYID, 1,
			  [flow_dissector.h has FLOW_DISSECTOR_KEY_ENC_KEYID])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if call_switchdev_notifiers has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		call_switchdev_notifiers(0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CALL_SWITCHDEV_NOTIFIERS_4_PARAMS, 1,
			  [call_switchdev_notifiers is defined with 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum switchdev_attr_id has SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		enum switchdev_attr_id x = SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL, 1,
			  [enum switchdev_attr_id has SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum switchdev_notifier_type has SWITCHDEV_PORT_ATTR_SET])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		enum switchdev_notifier_type xx = SWITCHDEV_PORT_ATTR_SET;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SWITCHDEV_PORT_ATTR_SET, 1,
			  [SWITCHDEV_PORT_ATTR_SET is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if switchdev.h has struct switchdev_ops])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
		#include <linux/netdevice.h>
	],[
		struct switchdev_ops x;
		struct net_device *ndev;

		ndev->switchdev_ops = &x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SWITCHDEV_OPS, 1,
			  [HAVE_SWITCHDEV_OPS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct switchdev_obj_port_vlan has vid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		struct switchdev_obj_port_vlan x;
		x.vid = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_SWITCHDEV_OBJ_PORT_VLAN_VID, 1,
			  [struct switchdev_obj_port_vlan has vid])
	],[
		AC_MSG_RESULT(no)
	])
	AC_MSG_CHECKING([if struct switchdev_brport_flags exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		struct switchdev_brport_flags x;
		x.mask = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_SWITCHDEV_BRPORT_FLAGS, 1,
			  [struct switchdev_brport_flags exist])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if switchdev.h has switchdev_port_same_parent_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		switchdev_port_same_parent_id(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SWITCHDEV_PORT_SAME_PARENT_ID, 1,
			  [switchdev_port_same_parent_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct sk_buff has xmit_more])
	case $LINUXRELEASE in
	3\.1[[0-7]]*fbk*|2*fbk*)
	AC_MSG_RESULT(Not checking xmit_more support for fbk kernel: $LINUXRELEASE)
	;;
	*)
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff *skb;
		skb->xmit_more = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SK_BUFF_XMIT_MORE, 1,
			  [xmit_more is defined])
	],[
		AC_MSG_RESULT(no)
	])
	;;
	esac

	AC_MSG_CHECKING([if xfrm_dev_offload has flags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_dev_offload x = {
                        .flags = XFRM_DEV_OFFLOAD_FLAG_ACQ,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_DEV_OFFLOAD_FLAG_ACQ, 1,
			  [xfrm_dev_offload has flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xfrm_dev_offload has real_dev as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_dev_offload x = {
                        .real_dev = NULL,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_DEV_REAL_DEV, 1,
			  [xfrm_dev_offload has real_dev as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xfrm_state_offload has dir as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_state_offload x = {
                        .dir = 0,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_STATE_DIR, 1,
			  [xfrm_dev_offload has state as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xfrm_dev_offload has dir as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_dev_offload x = {
                        .dir = 0,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_DEV_DIR, 1,
			  [xfrm_dev_offload has dir as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xfrm_dev_offload has type as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_dev_offload x = {
                        .type = 0,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_DEV_TYPE, 1,
			  [xfrm_dev_offload has type as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xfrm_state_offload has real_dev as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_state_offload x = {
                        .real_dev = NULL,
                };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_STATE_REAL_DEV, 1,
			  [xfrm_state_offload has real_dev as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if secpath_set returns struct sec_path *])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct sec_path *temp = secpath_set(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SECPATH_SET_RETURN_POINTER, 1,
			  [if secpath_set returns struct sec_path *])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if eth_get_headlen has 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		eth_get_headlen(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETH_GET_HEADLEN_3_PARAMS, 1,
			  [eth_get_headlen is defined with 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if eth_get_headlen has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/etherdevice.h>
	],[
		eth_get_headlen(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETH_GET_HEADLEN_2_PARAMS, 1,
			  [eth_get_headlen is defined with 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct skbuff.h has napi_consume_skb])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		napi_consume_skb(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NAPI_CONSUME_SKB, 1,
			  [napi_consume_skb is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct skbuff.h has skb_inner_transport_offset])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_inner_transport_offset(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_INNER_TRANSPORT_OFFSET, 1,
			  [skb_inner_transport_offset is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_vlan.h has vlan_get_encap_level])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		vlan_get_encap_level(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VLAN_GET_ENCAP_LEVEL, 1,
			  [vlan_get_encap_level is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct vlan_ethhdr has addrs member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_vlan.h>
	],[
		struct vlan_ethhdr vhdr = {
			.addrs = {0},
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VLAN_ETHHDR_HAS_ADDRS, 1,
			  [struct vlan_ethhdr has addrs member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_select_queue has accel_priv])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		static u16 select_queue(struct net_device *dev, struct sk_buff *skb,
				        struct net_device *sb_dev)
		{
			return 0;
		}
	],[
		struct net_device_ops ndops = {
			.ndo_select_queue = select_queue,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SELECT_QUEUE_HAS_3_PARMS_NO_FALLBACK, 1,
			  [ndo_select_queue has 3 params with no fallback])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_select_queue has a second net_device parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		static u16 select_queue(struct net_device *dev, struct sk_buff *skb,
		                        struct net_device *sb_dev,
		                        select_queue_fallback_t fallback)
		{
			return 0;
		}
	],[
		struct net_device_ops ndops = {
			.ndo_select_queue = select_queue,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SELECT_QUEUE_NET_DEVICE, 1,
			  [ndo_select_queue has a second net_device parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/trace/trace_events.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
                #undef TRACE_INCLUDE_PATH
                #undef TRACE_INCLUDE_FILE
                #undef TRACE_INCLUDE
                #define TRACE_INCLUDE(a) "/dev/null"

		#include <trace/trace_events.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_EVENTS_H, 1,
			  [include/trace/trace_events.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/count_zeros.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/count_zeros.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_COUNT_ZEROS_H, 1,
			[include/linux/count_zeros.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/bits.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bits.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITS_H, 1,
			[include/linux/bits.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/build_bug.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/build_bug.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BUILD_BUG_H, 1,
			  [include/linux/build_bug.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/devlink.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_H, 1,
			  [include/net/devlink.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/devlink.h devlink_alloc_ns defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/devlink.h>
	],[
		devlink_alloc_ns(NULL, 0, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_ALLOC_NS, 1,
			  [include/net/devlink.h devlink_alloc_ns defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum devlink_param_cmode exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/devlink.h>
	],[
		enum devlink_param_cmode p;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVLINK_PARAM_CMODE, 1,
			  [enum devlink_param_cmode exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/switchdev.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/switchdev.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SWITCHDEV_H, 1,
			  [include/net/switchdev.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_vlan.h has is_tcf_vlan])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_vlan.h>
	],[
		is_tcf_vlan(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_VLAN, 1,
			  [is_tcf_vlan is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_vlan.h has tcf_vlan_push_prio])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_vlan.h>
	],[
		tcf_vlan_push_prio(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_VLAN_PUSH_PRIO, 1,
			  [tcf_vlan_push_prio is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_VLAN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_VLAN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_VLAN, 1,
			  [FLOW_DISSECTOR_KEY_VLAN is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_dissector_key_vlan has vlan_eth_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		struct flow_dissector_key_vlan vlan;

		vlan.vlan_eth_type = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_VLAN_ETH_TYPE, 1,
			  [struct flow_dissector_key_vlan has vlan_eth_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_CVLAN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_CVLAN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_CVLAN, 1,
			  [FLOW_DISSECTOR_KEY_CVLAN is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_IP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_IP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_IP, 1,
			  [FLOW_DISSECTOR_KEY_IP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_TCP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_TCP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_TCP, 1,
			  [FLOW_DISSECTOR_KEY_TCP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_CONTINUE exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_CONTINUE;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_CONTINUE, 1,
			  [FLOW_ACTION_CONTINUE exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_JUMP and PIPE exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_JUMP;
		enum flow_action_id action2 = FLOW_ACTION_PIPE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_JUMP_AND_PIPE, 1,
			  [FLOW_ACTION_JUMP and PIPE exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_PRIORITY exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_PRIORITY;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_PRIORITY, 1,
			  [FLOW_ACTION_PRIORITY exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_VLAN_PUSH_ETH exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_VLAN_PUSH_ETH;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_VLAN_PUSH_ETH, 1,
			  [FLOW_ACTION_VLAN_PUSH_ETH exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if HAVE_FLOW_OFFLOAD_ACTION exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_offload_action act = {};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_OFFLOAD_ACTION, 1,
			  [HAVE_FLOW_OFFLOAD_ACTION exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_offload_has_one_action exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action action;

		flow_offload_has_one_action(&action);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_OFFLOAD_HAS_ONE_ACTION, 1,
			  [flow_offload_has_one_action exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_tx_maxrate])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_set_tx_maxrate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SET_TX_MAXRATE, 1,
			  [ndo_set_tx_maxrate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has *ndo_set_tx_maxrate])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_set_tx_maxrate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SET_TX_MAXRATE_EXTENDED, 1,
			  [extended ndo_set_tx_maxrate is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has *ndo_chane_mtu_extended])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_change_mtu = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_CHANGE_MTU_EXTENDED, 1,
			  [extended ndo_change_mtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_chane_mtu_rh74])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_change_mtu_rh74 = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_CHANGE_MTU_RH74, 1,
			  [extended ndo_change_mtu_rh74 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_extended has min/max_mtu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_extended x = {
			.min_mtu = 0,
			.max_mtu = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_MIN_MAX_MTU_EXTENDED, 1,
			  [extended min/max_mtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_setup_tc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SETUP_TC, 1,
			  [ndo_setup_tc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has  has *ndo_setup_tc_rh])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended x = {
			.ndo_setup_tc_rh = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SETUP_TC_RH_EXTENDED, 1,
			  [ndo_setup_tc_rh is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx4_en_setup_tc(struct net_device *dev, u32 handle,
							 __be16 protocol, struct tc_to_netdev *tc)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx4_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SETUP_TC_4_PARAMS, 1,
			  [ndo_setup_tc takes 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes chain_index])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx_en_setup_tc(struct net_device *dev, u32 handle, u32 chain_index,
							__be16 protocol, struct tc_to_netdev *tc)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SETUP_TC_TAKES_CHAIN_INDEX, 1,
			  [ndo_setup_tc takes chain_index])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_setup_tc takes tc_setup_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx_en_setup_tc(struct net_device *dev, enum tc_setup_type type,
				    void *type_data)
		{
			return 0;
		}
	],[
		struct net_device_ops x = {
			.ndo_setup_tc = mlx_en_setup_tc,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SETUP_TC_TAKES_TC_SETUP_TYPE, 1,
			  [ndo_setup_tc takes tc_setup_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has tcf_exts_to_list])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tcf_exts_to_list(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_EXTS_TO_LIST, 1,
			  [tcf_exts_to_list is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has tc_setup_flow_action])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_setup_flow_action(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_FLOW_ACTION_FUNC, 1,
			  [tc_setup_flow_action is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has tc_setup_offload_action])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_setup_offload_action(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_OFFLOAD_ACTION_FUNC, 1,
			  [tc_setup_offload_action is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has tc_setup_offload_action get 3 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_setup_offload_action(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_OFFLOAD_ACTION_FUNC_HAS_3_PARAM, 1,
			  [tc_setup_offload_action is defined and get 3 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has tc_setup_flow_action with rtnl_held])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_setup_flow_action(NULL, NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_FLOW_ACTION_WITH_RTNL_HELD, 1,
			  [tc_setup_flow_action has rtnl_held])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has __tc_indr_block_cb_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		__tc_indr_block_cb_register(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___TC_INDR_BLOCK_CB_REGISTER, 1,
			  [__tc_indr_block_cb_register is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h has TC_CLSMATCHALL_STATS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		enum tc_matchall_command x = TC_CLSMATCHALL_STATS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLSMATCHALL_STATS, 1,
			  [TC_CLSMATCHALL_STATS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have __flow_indr_block_cb_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		__flow_indr_block_cb_register(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___FLOW_INDR_BLOCK_CB_REGISTER, 1,
			  [__flow_indr_block_cb_register is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have flow_cls_offload_flow_rule])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_cls_offload_flow_rule(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_CLS_OFFLOAD_FLOW_RULE, 1,
			  [flow_cls_offload_flow_rule is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have flow_block_cb_setup_simple])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_block_cb_setup_simple(NULL, NULL, NULL, NULL, NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_BLOCK_CB_SETUP_SIMPLE, 1,
			  [flow_block_cb_setup_simple is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have flow_block_cb_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_block_cb_alloc(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_BLOCK_CB_ALLOC, 1,
			  [flow_block_cb_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have flow_setup_cb_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_setup_cb_t *cb = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_SETUP_CB_T, 1,
			  [flow_setup_cb_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have netif_is_gretap])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if.h>
		#include <net/gre.h>
	],[
		struct net_device dev = {};

		netif_is_gretap(&dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_GRETAP, 1,
			  [netif_is_gretap is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have netif_is_vxlan])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		struct net_device dev = {};

		netif_is_vxlan(&dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_VXLAN, 1,
			  [netif_is_vxlan is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has is_tcf_mirred_redirect])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		is_tcf_mirred_redirect(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_MIRRED_REDIRECT, 1,
			  [is_tcf_mirred_redirect is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has is_tcf_mirred_egress_redirect])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		is_tcf_mirred_egress_redirect(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_MIRRED_EGRESS_REDIRECT, 1,
			  [is_tcf_mirred_egress_redirect is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has is_tcf_mirred_mirror])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		is_tcf_mirred_mirror(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_MIRRED_MIRROR, 1,
			  [is_tcf_mirred_mirror is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has is_tcf_mirred_egress_mirror])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		is_tcf_mirred_egress_mirror(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_MIRRED_EGRESS_MIRROR, 1,
			  [is_tcf_mirred_egress_mirror is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has tcf_mirred_ifindex])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		tcf_mirred_ifindex(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_MIRRED_IFINDEX, 1,
			  [tcf_mirred_ifindex is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_mirred.h has tcf_mirred_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mirred.h>
	],[
		tcf_mirred_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_MIRRED_DEV, 1,
			  [tcf_mirred_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/ipv6_stubs.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ipv6_stubs.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_STUBS_H, 1,
			  [net/ipv6_stubs.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_gact.h has is_tcf_gact_goto_chain])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		is_tcf_gact_goto_chain(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_GACT_GOTO_CHAIN, 1,
			  [is_tcf_gact_goto_chain is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_gact.h has is_tcf_gact_shot])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		is_tcf_gact_shot(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_GACT_SHOT, 1,
			  [is_tcf_gact_shot is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_gact.h has is_tcf_gact_ok])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		struct tc_action a = {};
		is_tcf_gact_ok(&a);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_GACT_OK, 1,
			  [is_tcf_gact_ok is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_gact.h has __is_tcf_gact_act with 3 variables])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		struct tc_action a = {};
		__is_tcf_gact_act(&a, 0, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_GACT_ACT, 1,
			  [__is_tcf_gact_act is defined with 3 variables])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_gact.h has __is_tcf_gact_act with 2 variables])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_gact.h>
	],[
		struct tc_action a = {};
		__is_tcf_gact_act(&a, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_GACT_ACT_OLD, 1,
			  [__is_tcf_gact_act is defined with 2 variables])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_skbedit.h has is_tcf_skbedit_mark])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_skbedit.h>
	],[
		is_tcf_skbedit_mark(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_SKBEDIT_MARK, 1,
			  [is_tcf_skbedit_mark is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has *ndo_get_stats64 that returns void])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		void get_stats_64(struct net_device *dev,
						  struct rtnl_link_stats64 *storage)
		{
			return;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_stats64 = get_stats_64;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_STATS64_RET_VOID, 1,
			  [ndo_get_stats64 is defined and returns void])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_eth_ioctl])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_eth_ioctl = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_ETH_IOCTL, 1,
			  [net_device_ops has ndo_eth_ioctl is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_stats64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		struct rtnl_link_stats64* get_stats_64(struct net_device *dev,
                                                     struct rtnl_link_stats64 *storage)
		{
			struct rtnl_link_stats64 stats_64;
			return &stats_64;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_stats64 = get_stats_64;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_STATS64, 1,
			  [ndo_get_stats64 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_get_port_parent_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_port_parent_id(struct net_device *dev,
				       struct netdev_phys_item_id *ppid)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_get_port_parent_id = get_port_parent_id;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_PORT_PARENT_ID, 1,
			  [HAVE_NDO_GET_PORT_PARENT_ID is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_get_phys_port_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_phys_port_name(struct net_device *dev,
				       char *name, size_t len)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended netdev_ops;

		netdev_ops.ndo_get_phys_port_name = get_phys_port_name;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_PHYS_PORT_NAME_EXTENDED, 1,
			  [ is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_nested_priv])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_nested_priv x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NESTED_PRIV_STRUCT, 1,
			  [netdevice.h has struct netdev_nested_priv])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended ops_extended;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_DEVICE_OPS_EXTENDED, 1,
			  [struct net_device_ops_extended is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops has ndo_set_vf_trust])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_trust(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;

		netdev_ops.ndo_set_vf_trust = set_vf_trust;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_TRUST, 1,
			  [ndo_set_vf_trust is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_set_vf_trust])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_trust(struct net_device *dev, int vf, bool setting)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended netdev_ops;

		netdev_ops.ndo_set_vf_trust = set_vf_trust;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_OPS_NDO_SET_VF_TRUST_EXTENDED, 1,
			  [extended ndo_set_vf_trust is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has ndo_set_vf_vlan])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops netdev_ops = {
			.ndo_set_vf_vlan = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SET_VF_VLAN, 1,
			  [ndo_set_vf_vlan is defined in net_device_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_set_vf_vlan])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device_ops_extended netdev_ops_extended = {
			.ndo_set_vf_vlan = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SET_VF_VLAN_EXTENDED, 1,
			  [ndo_set_vf_vlan is defined in net_device_ops_extended])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has enum netdev_lag_tx_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum netdev_lag_tx_type x;
		x = 0;

		return x;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LAG_TX_TYPE, 1,
			  [enum netdev_lag_tx_type is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dev_addr_mod exists])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
        #include <linux/netdevice.h>
        ],[
                dev_addr_mod(NULL, 0, NULL, 0);
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_DEV_ADDR_MOD, 1,
                        [function dev_addr_mod exists])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if netdev_get_xmit_slave exists])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
        #include <linux/netdevice.h>
        ],[
                netdev_get_xmit_slave(NULL, NULL, 0);
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_NETDEV_GET_XMIT_SLAVE, 1,
                        [function netdev_get_xmit_slave exists])
        ],[
                AC_MSG_RESULT(no)
        ])

        AC_MSG_CHECKING([if net/lag.h exists])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/lag.h>
        ],[
                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_NET_LAG_H, 1,
                          [net/lag.h exists])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if net/lag.h net_lag_port_dev_txable exists])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/lag.h>
        ],[
		net_lag_port_dev_txable(NULL);

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_NET_LAG_PORT_DEV_TXABLE, 1,
                          [net/lag.h exists])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if ndo_get_ringparam get 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>

		static void ipoib_get_ringparam(struct net_device *dev,
                                 struct ethtool_ringparam *param,
                                 struct kernel_ethtool_ringparam *kernel_param,
                                 struct netlink_ext_ack *extack)
		{
			return;
		}
	],[
		struct ethtool_ops ipoib_ethtool_ops  = {
			.get_ringparam = ipoib_get_ringparam,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_RINGPARAM_GET_4_PARAMS, 1,
			  [ndo_get_ringparam get 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_get_coalesce get 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>

		static int ipoib_get_coalesce(struct net_device *dev,
			struct ethtool_coalesce *coal,
			struct kernel_ethtool_coalesce *kernel_coal,
			struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct ethtool_ops ipoib_ethtool_ops  = {
			.get_coalesce = ipoib_get_coalesce,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_COALESCE_GET_4_PARAMS, 1,
			  [ndo_get_coalesce get 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get_pause_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_pause_stats = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_PAUSE_STATS, 1,
			  [get_pause_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_link_ksettings])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_link_ksettings = NULL,
			.set_link_ksettings = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_SET_LINK_KSETTINGS, 1,
			  [get/set_link_ksettings is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_rxfh_context])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_rxfh_context  = NULL,
			.set_rxfh_context  = NULL,

		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETHTOOL_GET_RXFH_CONTEXT, 1,
			  [get/set_rxfh_context is defined])
	],[
		AC_MSG_RESULT(no)
	])

        AC_MSG_CHECKING([if struct ethtool_ops has get_link_ext_state])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <linux/ethtool.h>
        ],[
                const struct ethtool_ops en_ethtool_ops = {
                        .get_link_ext_state = NULL,
                };

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_GET_LINK_EXT_STATE, 1,
                          [.get_link_ext_state is defined])
        ],[
                AC_MSG_RESULT(no)
        ])

       AC_MSG_CHECKING([if ethtool supports 25G,50G,100G link speeds])
       MLNX_BG_LB_LINUX_TRY_COMPILE([
              #include <uapi/linux/ethtool.h>
       ],[
              const enum ethtool_link_mode_bit_indices speeds[] = {
                      ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
                      ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
                      ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT
              };

              return 0;
       ],[
              AC_MSG_RESULT(yes)
              MLNX_AC_DEFINE(HAVE_ETHTOOL_25G_50G_100G_SPEEDS, 1,
                        [ethtool supprts 25G,50G,100G link speeds])
       ],[
              AC_MSG_RESULT(no)
       ])

       AC_MSG_CHECKING([if ethtool supports 50G-pre-lane link modes])
       MLNX_BG_LB_LINUX_TRY_COMPILE([
              #include <uapi/linux/ethtool.h>
       ],[
              const enum ethtool_link_mode_bit_indices speeds[] = {
		ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
		ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
		ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
		ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
		ETHTOOL_LINK_MODE_50000baseDR_Full_BIT,
		ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
		ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
		ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
		ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
		ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT,
		ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
		ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
		ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
		ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT,
		ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
		};

              return 0;
       ],[
              AC_MSG_RESULT(yes)
              MLNX_AC_DEFINE(HAVE_ETHTOOL_50G_PER_LANE_LINK_MODES, 1,
                        [ethtool supprts 50G-pre-lane link modes])
       ],[
              AC_MSG_RESULT(no)
       ])

	AC_MSG_CHECKING([if struct ethtool_ops has get/set_settings])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		const struct ethtool_ops en_ethtool_ops = {
			.get_settings = NULL,
			.set_settings = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETHTOOL_GET_SET_SETTINGS, 1,
			  [get/set_settings is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/ethtool_netlink.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool_netlink.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETHTOOL_NETLINK_H, 1,
			  [linux/ethtool_netlink.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if TCA_VLAN_ACT_MODIFY exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/tc_act/tc_vlan.h>
	],[
		u16 x = TCA_VLAN_ACT_MODIFY;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCA_VLAN_ACT_MODIFY, 1,
			  [TCA_VLAN_ACT_MODIFY exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ETH_MAX_MTU exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if_ether.h>
	],[
		u16 max_mtu = ETH_MAX_MTU;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETH_MAX_MTU, 1,
			  [ETH_MAX_MTU exists])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if ETH_MIN_MTU exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if_ether.h>
	],[
		u16 min_mtu = ETH_MIN_MTU;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETH_MIN_MTU, 1,
			  [ETH_MIN_MTU exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan.h has vxlan_vni_field])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		vxlan_vni_field(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VXLAN_VNI_FIELD, 1,
			  [vxlan_vni_field is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has IFF_RXFH_CONFIGURED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		int x = IFF_RXFH_CONFIGURED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_IFF_RXFH_CONFIGURED, 1,
			  [IFF_RXFH_CONFIGURED is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_for_each_lower_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *lag, *dev;
		struct list_head *iter;
		netdev_for_each_lower_dev(lag, dev, iter);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_FOR_EACH_LOWER_DEV, 1,
			  [netdev_for_each_lower_dev is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irq.h irq_data has member affinity])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
		#include <linux/cpumask.h>
	],[
		struct irq_data y;
		const struct cpumask *x = y.affinity;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_DATA_AFFINITY, 1,
			  [irq_data member affinity is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irq.h has irq_get_effective_affinity_mask])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
		#include <linux/cpumask.h>
	],[
		irq_get_effective_affinity_mask(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_GET_EFFECTIVE_AFFINITY_MASK, 1,
			  [irq_get_effective_affinity_mask is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if irq.h has irq_get_affinity_mask])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/irq.h>
		#include <linux/cpumask.h>
	],[
		irq_get_affinity_mask(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_GET_AFFINITY_MASK, 1,
			  [irq_get_affinity_mask is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ifla_vf_info has trust])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_info *ivf;

		ivf->trusted = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VF_INFO_TRUST, 1,
			  [trust is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_link.h has IFLA_VF_IB_NODE_PORT_GUID])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		int type = IFLA_VF_IB_NODE_GUID;

		type = IFLA_VF_IB_PORT_GUID;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IFLA_VF_IB_NODE_PORT_GUID, 1,
			  [trust is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pkt_cls.h enum enum tc_fl_command has TC_CLSFLOWER_STATS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		enum tc_fl_command x = TC_CLSFLOWER_STATS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLSFLOWER_STATS_FIX, 1,
			  [pkt_cls.h enum enum tc_fl_command has TC_CLSFLOWER_STATS])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_cls_flower_offload has stats field])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_flower_offload *f;
		struct flow_stats stats;

		f->stats = stats;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLS_FLOWER_OFFLOAD_HAS_STATS_FIELD_FIX, 1,
			  [struct tc_cls_flower_offload has stats field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/inetdevice.h inet_confirm_addr has 5 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/inetdevice.h>
        ],[
               inet_confirm_addr(NULL, NULL, 0, 0, 0);

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_INET_CONFIRM_ADDR_5_PARAMS, 1,
                          [inet_confirm_addr has 5 parameters])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if linux/inetdevice.h has for_ifa define])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/inetdevice.h>
        ],[
		struct in_device *in_dev;

		for_ifa(in_dev) {
		}

		endfor_ifa(in_dev);
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_FOR_IFA, 1,
                          [for_ifa defined])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if netdevice.h has netdev_port_same_parent_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_port_same_parent_id(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_PORT_SAME_PARENT_ID, 1,
			  [netdev_port_same_parent_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_phys_item_id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_phys_item_id x;
		x.id_len = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_PHYS_ITEM_ID, 1,
			  [netdev_phys_item_id is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_features.h has NETIF_F_HW_TLS_RX])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		netdev_features_t tls_rx = NETIF_F_HW_TLS_RX;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_F_HW_TLS_RX, 1,
			[NETIF_F_HW_TLS_RX is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tls_offload_context_tx has destruct_work as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		struct tls_offload_context_tx tls_ctx_tx;
		memset(&tls_ctx_tx.destruct_work, 0, sizeof(struct work_struct));

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_OFFLOAD_DESTRUCT_WORK, 1,
			  [tls_offload_context_tx has destruct_work as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_features.h has NETIF_F_GRO_HW])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		netdev_features_t value = NETIF_F_GRO_HW;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_F_GRO_HW, 1,
			[NETIF_F_GRO_HW is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has NETIF_IS_LAG_MASTER])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		netif_is_lag_master(dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_LAG_MASTER, 1,
			[NETIF_IS_LAG_MASTER is defined in netdevice.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has NETIF_IS_LAG_PORT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		netif_is_lag_port(dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_LAG_PORT, 1,
			[NETIF_IS_LAG_PORT is defined in netdevice.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ktime.h ktime is union and has tv64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ktime.h>
	],[
		ktime_t x;
		x.tv64 = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KTIME_UNION_TV64, 1,
			  [ktime is union and has tv64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vxlan have ndo_add_vxlan_port])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, sa_family_t sa_family, __be16 port)
		{
			return;
		}
		#endif
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_add_vxlan_port = add_vxlan_port;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_ADD_VXLAN_PORT, 1,
			[ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if udp_tunnel.h has udp_tunnel_drop_rx_port])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <net/udp_tunnel.h>
	],[
		udp_tunnel_drop_rx_port(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UDP_TUNNEL_RX_INFO, 1,
			[udp_tunnel.h has udp_tunnel_drop_rx_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_add_vxlan_port have udp_tunnel_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, struct udp_tunnel_info *ti)
		{
			return;
		}
		#endif

	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_udp_tunnel_add = add_vxlan_port;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_UDP_TUNNEL_ADD, 1,
			[ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_udp_tunnel_add])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		#if IS_ENABLED(CONFIG_VXLAN)
		void add_vxlan_port(struct net_device *dev, struct udp_tunnel_info *ti)
		{
			return;
		}
		#endif

	],[
		struct net_device_ops_extended x = {
			.ndo_udp_tunnel_add = add_vxlan_port,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_UDP_TUNNEL_ADD_EXTENDED, 1,
			[extended ndo_add_vxlan_port is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst.h has skb_dst_update_pmtu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/dst.h>
	],[
		struct sk_buff x;
		skb_dst_update_pmtu(&x, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_DST_UPDATE_PMTU, 1,
			  [skb_dst_update_pmtu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ipv6_stub has ipv6_dst_lookup_flow])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
		#include <net/ipv6_stubs.h>
	],[
		int x = ipv6_stub->ipv6_dst_lookup_flow(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_DST_LOOKUP_FLOW, 1,
			  [if ipv6_stub has ipv6_dst_lookup_flow])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ipv6_stub has ipv6_dst_lookup_flow in addrconf.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
	],[
		int x = ipv6_stub->ipv6_dst_lookup_flow(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_DST_LOOKUP_FLOW_ADDR_CONF, 1,
			  [if ipv6_stub has ipv6_dst_lookup_flow in addrconf.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if nla_policy has validation_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		struct nla_policy x;
		x.validation_type = NLA_VALIDATE_MIN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_POLICY_HAS_VALIDATION_TYPE, 1,
			  [nla_policy has validation_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has nla_strscpy])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_strscpy(NULL, NULL ,0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_STRSCPY, 1,
			  [nla_strscpy exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has nla_nest_start_noflag])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_nest_start_noflag(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_NEST_START_NOFLAG, 1,
			  [nla_nest_start_noflag exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has nlmsg_validate_deprecated ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nlmsg_validate_deprecated(NULL, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLMSG_VALIDATE_DEPRECATED, 1,
			  [nlmsg_validate_deprecated exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has nlmsg_parse_deprecated ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nlmsg_parse_deprecated(NULL, 0, NULL, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLMSG_PARSE_DEPRECATED, 1,
			  [nlmsg_parse_deprecated exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has nla_parse_deprecated ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_parse_deprecated(NULL, 0, NULL, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_PARSE_DEPRECATED, 1,
			  [nla_parse_deprecated exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h nla_parse takes 6 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_parse(NULL, 0, NULL, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_PARSE_6_PARAMS, 1,
			  [nla_parse takes 6 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/netlink.h has nla_put_u64_64bit])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netlink.h>
	],[
		nla_put_u64_64bit(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NLA_PUT_U64_64BIT, 1,
			  [nla_put_u64_64bit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netlink.h has struct netlink_ext_ack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_ext_ack x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETLINK_EXT_ACK, 1,
			  [struct netlink_ext_ack is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct genl_ops has member validate])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/genetlink.h>
	],[
		struct genl_ops x;

		x.validate = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENL_OPS_VALIDATE, 1,
			  [struct genl_ops has member validate])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct genl_family has member resv_start_op])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/genetlink.h>
	],[
		struct genl_family x;

		x.resv_start_op = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENL_FAMILY_RESV_START_OP, 1,
			  [struct genl_family has member resv_start_op])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct genl_family has member policy])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/genetlink.h>
	],[
		struct genl_family x;

		x.policy = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENL_FAMILY_POLICY, 1,
			  [struct genl_family has member policy])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netlink_callback has member extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netlink.h>
	],[
		struct netlink_callback x;

		x.extack = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETLINK_CALLBACK_EXTACK, 1,
			  [struct netlink_callback has member extack])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sysfs.h has sysfs_emit])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sysfs.h>
	],[
		sysfs_emit(NULL, "");

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SYSFS_EMIT, 1,
			  [sysfs_emit is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has struct ethtool_pause_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_pause_stats x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETHTOOL_PAUSE_STATS, 1,
			  [ethtool_pause_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has struct ethtool_rmon_hist_range])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_rmon_hist_range x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ETHTOOL_RMON_HIST_RANGE, 1,
			  [ethtool_rmon_hist_range is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has get_link_ext_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.get_link_ext_stats = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_LINK_EXT_STATS, 1,
			[get_link_ext_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has get/set_fecparam])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.get_fecparam = NULL,
			.set_fecparam = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_SET_FECPARAM, 1,
			[get/set_fecparam is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has ndo eth_phy_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.get_eth_phy_stats = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_ETH_PHY_STATS, 1,
			[eth_phy_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ethtool.h has ndo get_fec_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ethtool.h>
	],[
		struct ethtool_ops x = {
			.get_fec_stats = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_FEC_STATS, 1,
			[get_fec_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has skb_put_zero])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_put_zero(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_PUT_ZERO, 1,
			  [skb_put_zero is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h has skb_set_redirected])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff x;
		skb_set_redirected(&x, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_SET_REDIRECTED, 1,
			  [skb_set_redirected is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if skbuff.h struct sk_buff has member sw_hash])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct sk_buff x = {
			.sw_hash = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_SWHASH, 1,
			  [sk_buff has member sw_hash])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if addrconf.h has addrconf_ifid_eui48])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
	],[
		u8 *a;

		int x = addrconf_ifid_eui48(a, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ADDRCONF_IFID_EUI48, 1,
			  [addrconf_ifid_eui48 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if addrconf.h has addrconf_addr_eui48])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
	],[
		addrconf_addr_eui48(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ADDRCONF_ADDR_EUI48, 1,
			  [addrconf_addr_eui48 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if addrconf.h ipv6_dst_lookup takes net])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/addrconf.h>
	],[
		int x = ipv6_stub->ipv6_dst_lookup(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_DST_LOOKUP_TAKES_NET, 1,
			  [ipv6_dst_lookup takes net])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/dcbnl.h struct dcbnl_rtnl_ops has *ieee_getqcn])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		struct dcbnl_rtnl_ops x = {
			.ieee_getqcn = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IEEE_GETQCN, 1,
			  [ieee_getqcn is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dcbnl.h has struct ieee_qcn])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		struct ieee_qcn x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_IEEE_QCN, 1,
			  [ieee_qcn is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_for_each_all_upper_dev_rcu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		struct net_device *upper;
		struct list_head *list;

		netdev_for_each_all_upper_dev_rcu(dev, upper, list);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_FOR_EACH_ALL_UPPER_DEV_RCU, 1,
			  [netdev_master_upper_dev_get_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_walk_all_upper_dev_rcu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

	],[
		netdev_walk_all_upper_dev_rcu(NULL, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_WALK_ALL_UPPER_DEV_RCU, 1,
			  [netdev_walk_all_upper_dev_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_walk_all_lower_dev_rcu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_walk_all_lower_dev_rcu(NULL, NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_WALK_ALL_LOWER_DEV_RCU, 1,
			  [netdev_walk_all_lower_dev_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_has_upper_dev_all_rcu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct net_device *dev;
		struct net_device *upper;

		netdev_has_upper_dev_all_rcu(dev, upper);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_HAS_UPPER_DEV_ALL_RCU, 1,
			  [netdev_has_upper_dev_all_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_notifier_changeupper_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_notifier_changeupper_info info;

		info.master = 1;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NOTIFIER_CHANGEUPPER_INFO, 1,
			  [netdev_notifier_changeupper_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if build_bug.h has static_assert])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/build_bug.h>
                #define A 5
                #define B 6
	],[
                static_assert(A < B);

                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STATIC_ASSERT, 1,
			[build_bug.h has static_assert])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ip_fib.h fib_nh_notifier_info exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bug.h>
		#include <net/ip_fib.h>
	],[
                struct fib_nh_notifier_info fnh_info;
                struct fib_notifier_info info;

                /* also checking family attr in fib_notifier_info */
                info.family = AF_INET;

                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_NH_NOTIFIER_INFO, 1,
			[fib_nh_notifier_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if register_fib_notifier has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/fib_notifier.h>
	],[
		register_fib_notifier(NULL, NULL, NULL, NULL);
	],[
	AC_MSG_RESULT(yes)
	MLNX_AC_DEFINE(HAVE_REGISTER_FIB_NOTIFIER_HAS_4_PARAMS, 1,
		[register_fib_notifier has 4 params])
	],[
	AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function fib_info_nh exists in file net/nexthop.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/nexthop.h>
	],[
		fib_info_nh(NULL, 0);
                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_INFO_NH, 1,
			[function fib_info_nh exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function fib6_info_nh_dev exists in file net/nexthop.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/nexthop.h>
	],[
		fib6_info_nh_dev(NULL);
                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB6_INFO_NH_DEV, 1,
			[function fib6_info_nh_dev exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct fib6_entry_notifier_info exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ip6_fib.h>
	],[
		struct fib6_entry_notifier_info info;

                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB6_ENTRY_NOTIFIER_INFO, 1,
			[struct fib6_entry_notifier_info exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct fib6_entry_notifier_info has member struct fib6_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ip6_fib.h>
	],[
		struct fib6_entry_notifier_info info;
		struct fib6_info rt;

		info.rt = &rt;
		info.rt->fib6_dst.plen = 0;
                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB6_INFO_IN_FIB6_ENTRY_NOTIFIER_INFO, 1,
			[struct fib6_entry_notifier_info has member struct fib6_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/fib_notifier.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/fib_notifier.h>
	],[
		struct fib_notifier_info info;

                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_NOTIFIER_HEADER_FILE, 1,
			[has net/fib_notifier.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct fib_notifier_info has member family])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/fib_notifier.h>
	],[
		struct fib_notifier_info info;

		info.family = 0;
                return 0;
        ],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_NOTIFIER_INFO_HAS_FAMILY, 1,
			[struct fib_notifier_info has member family])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/kobject.h kobj_type has default_groups member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/kobject.h>
	],[
		struct kobj_type x = {
			.default_groups = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KOBJ_TYPE_DEFAULT_GROUPS, 1,
			[linux/kobject.h kobj_type has default_groups member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/lockdep.h has lockdep_unregister_key])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/lockdep.h>
	],[
		lockdep_unregister_key(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LOCKDEP_UNREGISTER_KEY, 1,
			[linux/lockdep.h has lockdep_unregister_key])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/lockdep.h has lockdep_assert_held_exclusive])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/lockdep.h>
	],[
		lockdep_assert_held_exclusive(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LOCKUP_ASSERT_HELD_EXCLUSIVE, 1,
			[linux/lockdep.h has lockdep_assert_held_exclusive])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/lockdep.h has lockdep_assert_held_write])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/lockdep.h>
	],[
		lockdep_assert_held_write(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LOCKUP_ASSERT_HELD_WRITE, 1,
			[linux/lockdep.h has lockdep_assert_held_write])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ip_fib.h fib_lookup has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bug.h>
		#include <linux/string.h>
		#include <net/ip_fib.h>
	],[
		fib_lookup(NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_LOOKUP_4_PARAMS, 1,
			[fib_lookup has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if fib_nh has fib_nh_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ip_fib.h>
	],[
		struct fib_nh x = {
			.fib_nh_dev = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FIB_NH_DEV, 1,
			[fib_nh has fib_nh_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if workqueue.h has __cancel_delayed_work])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/workqueue.h>
	],[
		__cancel_delayed_work(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___CANCEL_DELAYED_WORK, 1,
			  [__cancel_delayed_work is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if workqueue.h has WQ_NON_REENTRANT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/workqueue.h>
	],[
		struct workqueue_struct *my_wq = alloc_workqueue("my_wq", WQ_NON_REENTRANT, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_WQ_NON_REENTRANT, 1,
			  [WQ_NON_REENTRANT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct page has dma_addr])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct page x = {
			.dma_addr = 0
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_DMA_ADDR, 1,
			  [struct page has dma_addr])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vm_fault_t exist in mm_types.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		vm_fault_t a;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VM_FAULT_T, 1,
			  [vm_fault_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct mm_struct has member atomic_pinned_vm])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct mm_struct x;
                atomic64_t y;
		x.pinned_vm = y;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ATOMIC_PINNED_VM, 1,
			  [atomic_pinned_vm is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct mm_struct has member pinned_vm])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
	],[
		struct mm_struct x;
		x.pinned_vm = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PINNED_VM, 1,
			  [pinned_vm is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sock.h sk_wait_data has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sock.h>
	],[
		sk_wait_data(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SK_WAIT_DATA_3_PARAMS, 1,
			  [sk_wait_data has 3 params])
	],[
		AC_MSG_RESULT(no)
	])

        AC_MSG_CHECKING([if sock.h sk_data_ready has 2 parameters])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <net/sock.h>
        ],[
                static struct socket *mlx_lag_compat_rtnl_sock;
                mlx_lag_compat_rtnl_sock->sk->sk_data_ready(NULL , 0);

                return 0;
        ],[
                AC_MSG_RESULT(yes)
                MLNX_AC_DEFINE(HAVE_SK_DATA_READY_2_PARAMS, 1,
                          [sk_data_ready has 2 params])
        ],[
                AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if route.h struct rtable has member rt_gw_family])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/route.h>
	],[
		struct rtable x = {
			.rt_gw_family = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RT_GW_FAMILY, 1,
			  [rt_gw_family is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if route.h struct rtable has member rt_uses_gateway])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/route.h>
	],[
		struct rtable x = {
			.rt_uses_gateway = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RT_USES_GATEWAY, 1,
			  [rt_uses_gateway is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([cancel_work],
		[kernel/workqueue.c],
		[AC_DEFINE(HAVE_CANCEL_WORK_EXPORTED, 1,
			[cancel_work is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([unpin_user_pages_dirty_lock],
		[mm/gup.c],
		[AC_DEFINE(HAVE_UNPIN_USER_PAGES_DIRTY_LOCK_EXPORTED, 1,
			[unpin_user_pages_dirty_lock is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([unpin_user_page_range_dirty_lock],
		[mm/gup.c],
		[AC_DEFINE(HAVE_UNPIN_USER_PAGE_RANGE_DIRTY_LOCK_EXPORTED, 1,
			[unpin_user_page_range_dirty_lock is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([compat_ptr_ioctl],
		[fs/ioctl.c],
		[AC_DEFINE(HAVE_COMPAT_PTR_IOCTL_EXPORTED, 1,
			[compat_ptr_ioctl is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([flow_rule_match_cvlan],
		[net/core/flow_offload.c],
		[AC_DEFINE(HAVE_FLOW_RULE_MATCH_CVLAN, 1,
			[flow_rule_match_cvlan is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([devlink_params_publish],
		[net/core/devlink.c],
		[AC_DEFINE(HAVE_DEVLINK_PARAMS_PUBLISHED, 1,
			[devlink_params_publish is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([debugfs_create_file_unsafe],
		[fs/debugfs/inode.c],
		[AC_DEFINE(HAVE_DEBUGFS_CREATE_FILE_UNSAFE, 1,
			[debugfs_create_file_unsafe is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([devlink_param_publish],
		[net/core/devlink.c],
		[AC_DEFINE(HAVE_DEVLINK_PARAM_PUBLISH, 1,
			[devlink_param_publish is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([split_page],
		[mm/page_alloc.c],
		[AC_DEFINE(HAVE_SPLIT_PAGE_EXPORTED, 1,
			[split_page is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([ip6_dst_hoplimit],
                [net/ipv6/output_core.c],
                [AC_DEFINE(HAVE_IP6_DST_HOPLIMIT, 1,
                        [ip6_dst_hoplimit is exported by the kernel])],
        [])

	LB_CHECK_SYMBOL_EXPORT([udp4_hwcsum],
		[net/ipv4/udp.c],
		[AC_DEFINE(HAVE_UDP4_HWCSUM, 1,
			[udp4_hwcsum is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([__ip_dev_find],
		[net/ipv4/devinet.c],
		[AC_DEFINE(HAVE___IP_DEV_FIND, 1,
			[HAVE___IP_DEV_FIND is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([inet_confirm_addr],
		[net/ipv4/devinet.c],
		[AC_DEFINE(HAVE_INET_CONFIRM_ADDR_EXPORTED, 1,
			[inet_confirm_addr is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if ipv6.h has ip6_make_flowinfo])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ipv6.h>
	],[
		ip6_make_flowinfo(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IP6_MAKE_FLOWINFO, 1,
		[ip6_make_flowinfo is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([dev_pm_qos_update_user_latency_tolerance],
		[drivers/base/power/qos.c],
		[AC_DEFINE(HAVE_PM_QOS_UPDATE_USER_LATENCY_TOLERANCE_EXPORTED, 1,
			[dev_pm_qos_update_user_latency_tolerance is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if pm_qos.h has DEV_PM_QOS_RESUME_LATENCY])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pm_qos.h>
	],[
		enum dev_pm_qos_req_type type = DEV_PM_QOS_RESUME_LATENCY;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_PM_QOS_RESUME_LATENCY, 1,
			  [DEV_PM_QOS_RESUME_LATENCY is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sock.h has skwq_has_sleeper])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
		#include <net/sock.h>
	],[
		struct socket_wq wq;
		skwq_has_sleeper(&wq);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKWQ_HAS_SLEEPER, 1,
			  [skwq_has_sleeper is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net.h sock_create_kern has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
		#include <net/sock.h>
	],[
		sock_create_kern(NULL, 0, 0, 0, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SOCK_CREATE_KERN_5_PARAMS, 1,
			  [sock_create_kern has 5 params is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_pool_zalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_pool_zalloc(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_POOL_ZALLOC, 1,
			  [pci_pool_zalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pcie_relaxed_ordering_enabled])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_relaxed_ordering_enabled(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCIE_RELAXED_ORDERING_ENABLED, 1,
			  [pcie_relaxed_ordering_enabled is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if  netdev_features.h has NETIF_F_GSO_IPXIP6])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		int x = NETIF_F_GSO_IPXIP6;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_F_GSO_IPXIP6, 1,
			  [NETIF_F_GSO_IPXIP6 is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if  netdev_features.h has ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		int x = NETIF_F_GSO_UDP_L4;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_F_GSO_UDP_L4, 1,
			  [HAVE_NETIF_F_GSO_UDP_L4 is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct netdev_features.h has NETIF_F_GSO_PARTIAL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdev_features.h>
	],[
		int x = NETIF_F_GSO_PARTIAL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_F_GSO_PARTIAL, 1,
			  [NETIF_F_GSO_PARTIAL is defined in netdev_features.h])
	],[
		AC_MSG_RESULT(no)
	])

	# this checker will test if the function exist AND gets const
	# otherwise it will fail.
	AC_MSG_CHECKING([if if_vlan.h has is_vlan_dev get const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <linux/if_vlan.h>
	],[
		const struct net_device *dev;
		is_vlan_dev(dev);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_VLAN_DEV_CONST, 1,
			  [is_vlan_dev get const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_bridge_setlink])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
				   u16 flags)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_bridge_setlink = bridge_setlink;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_BRIDGE_SETLINK, 1,
			  [ndo_bridge_setlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_bridge_setlink])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
				   u16 flags, struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_bridge_setlink = bridge_setlink;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_BRIDGE_SETLINK_EXTACK, 1,
			  [ndo_bridge_setlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_bridge_getlink])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
				   struct net_device *dev, u32 filter_mask,
				   int nlflags)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_bridge_getlink = bridge_getlink;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_BRIDGE_GETLINK_NLFLAGS, 1,
			  [ndo_bridge_getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_bridge_getlink])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
				   struct net_device *dev, u32 filter_mask)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_bridge_getlink = bridge_getlink;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_BRIDGE_GETLINK, 1,
			  [ndo_bridge_getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/rtnetlink.h] has ndo_dflt_bridge_getlink)
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
	],[
		ndo_dflt_bridge_getlink(NULL, 0, 0, NULL, 0, 0, 0,
					0, 0, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_DFLT_BRIDGE_GETLINK_FLAG_MASK_NFLAGS_FILTER, 1,
			  [ndo_dflt_bridge_getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/rtnetlink.h] has ndo_dflt_bridge_getlink)
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
	],[
		ndo_dflt_bridge_getlink(NULL, 0, 0, NULL, 0, 0, 0,
					0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_DFLT_BRIDGE_GETLINK_FLAG_MASK_NFLAGS, 1,
			  [ndo_dflt_bridge_getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/rtnetlink.h] has ndo_dflt_bridge_getlink)
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
	],[
		ndo_dflt_bridge_getlink(NULL, 0, 0, NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_DFLT_BRIDGE_GETLINK_FLAG_MASK, 1,
			  [ndo_dflt_bridge_getlink is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_vf_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int get_vf_stats(struct net_device *dev, int vf, struct ifla_vf_stats *vf_stats)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_get_vf_stats = get_vf_stats;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_VF_STATS, 1,
			  [ndo_get_vf_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_set_vf_guid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int set_vf_guid(struct net_device *dev, int vf, u64 guid, int guid_type)
		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_set_vf_guid = set_vf_guid;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_SET_VF_GUID, 1,
			  [ndo_set_vf_guid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops has *ndo_get_vf_guid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <linux/if_link.h>

		int get_vf_guid(struct net_device *dev, int vf, struct ifla_vf_guid *node_guid,
                                                   struct ifla_vf_guid *port_guid)

		{
			return 0;
		}
	],[
		struct net_device_ops netdev_ops;
		netdev_ops.ndo_get_vf_guid = get_vf_guid;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_VF_GUID, 1,
			  [ndo_get_vf_guid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_link.h struct has struct ifla_vf_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>

	],[
		struct ifla_vf_stats x;
		x = x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IFLA_VF_STATS, 1,
			  [struct ifla_vf_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if if_link.h struct has struct ifla_vf_guid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if_link.h>

	],[
		struct ifla_vf_guid x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IFLA_VF_GUID, 1,
			  [struct ifla_vf_guid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_irq_get_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_irq_get_node(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IRQ_GET_NODE, 1,
			  [pci_irq_get_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_irq_get_affinity])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_irq_get_affinity(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IRQ_GET_AFFINITY, 1,
			  [pci_irq_get_affinity is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([elfcorehdr_addr],
		[kernel/crash_dump.c],
		[AC_DEFINE(HAVE_ELFCOREHDR_ADDR_EXPORTED, 1,
			[elfcorehdr_addr is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([fib_lookup],
		[net/ipv4/fib_rules.c],
		[AC_DEFINE(HAVE_FIB_LOOKUP_EXPORTED, 1,
			[fib_lookup is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([idr_get_next_ul],
		[lib/idr.c],
		[AC_DEFINE(HAVE_IDR_GET_NEXT_UL_EXPORTED, 1,
			[idr_get_next_ul is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if idr.h has ida_free])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		ida_free(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDA_FREE, 1,
			  [idr.h has ida_free])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has ida_alloc_range])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		ida_alloc_range(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDA_ALLOC_RANGE, 1,
			  [idr.h has ida_alloc_range])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr struct has idr_rt])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		struct idr tmp_idr;
		struct radix_tree_root tmp_radix;

		tmp_idr.idr_rt = tmp_radix;
		tmp_idr.idr_base = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDR_RT, 1,
			  [struct idr has idr_rt])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr_remove return value exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		void *ret;

		ret = idr_remove(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDR_REMOVE_RETURN_VALUE, 1,
			  [idr_remove return value exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has ida_is_empty])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		struct ida ida;
		ida_is_empty(&ida);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDA_IS_EMPTY, 1,
			  [ida_is_empty is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has idr_is_empty])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		struct ida ida;
		idr_is_empty(&ida.idr);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDR_IS_EMPTY, 1,
			  [idr_is_empty is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xarray is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/xarray.h>
	],[
                struct xa_limit x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XARRAY, 1,
			  [xa_array is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xa_for_each_range is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/xarray.h>
	],[
		#ifdef xa_for_each_range
			return 0;
		#else
			#return 1;
		#endif
	],[
	AC_MSG_RESULT(yes)
	MLNX_AC_DEFINE(HAVE_XA_FOR_EACH_RANGE, 1,
		[xa_for_each_range is defined])
	],[
	AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if DEFINE_SHOW_ATTRIBUTE is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/seq_file.h>
	],[
		#ifdef DEFINE_SHOW_ATTRIBUTE
			return 0;
		#else
			#return 1;
		#endif
	],[
	AC_MSG_RESULT(yes)
	MLNX_AC_DEFINE(HAVE_DEFINE_SHOW_ATTRIBUTE, 1,
		[DEFINE_SHOW_ATTRIBUTE is defined])
	],[
	AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if nospec.h has array_index_nospec])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nospec.h>
	],[
		array_index_nospec(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ARRAY_INDEX_NOSPEC, 1,
			  [array_index_nospec is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has ida_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		ida_alloc(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDA_ALLOC, 1,
			  [ida_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if idr.h has ida_alloc_max])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/idr.h>
	],[
		ida_alloc_max(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IDA_ALLOC_MAX, 1,
			  [ida_alloc_max is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_transfer_length is defind])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		scsi_transfer_length(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_TRANSFER_LENGTH, 1,
			  [scsi_transfer_length is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_cmd_to_rq is defind])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		scsi_cmd_to_rq(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_CMD_TO_RQ, 1,
			  [scsi_cmd_to_rq is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_done is defind])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		scsi_done(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_DONE, 1,
			  [scsi_done is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_get_sector is defind])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		scsi_get_sector(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_GET_SECTOR, 1,
			  [scsi_get_sector is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has strnicmp])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/string.h>
	],[
		char a[10] = "aaa";
		char b[10] = "bbb";
		strnicmp(a, b, sizeof(a));

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRNICMP, 1,
			  [strnicmp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has kfree_const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/string.h>
	],[
		const char *x;
		kfree_const(x);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KFREE_CONST, 1,
			  [kfree_const is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has strscpy_pad])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/string.h>
	],[
		strscpy_pad(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRSCPY_PAD, 1,
			  [strscpy_pad is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct dcbnl_rtnl_ops has dcbnl_get/set buffer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/dcbnl.h>
	],[
		const struct dcbnl_rtnl_ops en_dcbnl_ops = {
			.dcbnl_getbuffer = NULL,
			.dcbnl_setbuffer = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DCBNL_GETBUFFER, 1,
			  [struct dcbnl_rtnl_ops has dcbnl_get/set buffer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if device.h struct class has class_groups])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>

	],[
		struct class cm_class = {
			.class_groups   = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CLASS_GROUPS, 1,
			  [struct class has class_groups])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_namespace get const struct device])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
		static const void *net_namespace(const struct device *d) {
			void* p = NULL;
			return p;
		}

	],[
		struct class cm_class = {
			.namespace = net_namespace,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_NAMESPACE_GET_CONST_DEVICE, 1,
			  [net_namespace get const struct device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dev_uevent get const struct device])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
		static int foo(const struct device *dev, struct kobj_uevent_env *env) {
			return 0;
		}

	],[
		struct class my_class = {
			.dev_uevent = foo,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CLASS_DEV_UEVENT_CONST_DEV, 1,
			  [dev_uevent get const struct device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if devnode get const struct device])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
		static char * foo(const struct device *dev,  umode_t *mode) {
			return NULL;
		}

	],[
		struct class my_class = {
			.devnode = foo,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVNODE_GET_CONST_DEVICE, 1,
			  [devnode get const struct device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h struct vm_operations_struct has .fault])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		static vm_fault_t rdma_umap_fault(struct vm_fault *vmf) {
			vm_fault_t a;
			return a;
		}

	],[
		struct vm_operations_struct rdma_umap_ops = {
			.fault = rdma_umap_fault,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VM_OPERATIONS_STRUCT_HAS_FAULT, 1,
			  [vm_operations_struct has .fault])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bus_find_device get const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
	],[
		const void *data;
 		bus_find_device(NULL, NULL, data, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BUS_FIND_DEVICE_GET_CONST, 1,
			  [bus_find_device get const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if device.h struct device has dma_ops])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
	],[
		struct device devx = {
			.dma_ops = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_DMA_OPS, 1,
			  [struct device has dma_ops])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dst_ops.h update_pmtu has 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/dst_ops.h>

		static void mtu_up (struct dst_entry *dst, struct sock *sk,
				    struct sk_buff *skb, u32 mtu)
		{
			return;
		}
	],[
		struct dst_ops x = {
			.update_pmtu = mtu_up,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UPDATE_PMTU_4_PARAMS, 1,
			  [update_pmtu has 4 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h rtnl_link_ops newlink has 4 paramters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/rtnetlink.h>

		static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
						struct nlattr *tb[], struct nlattr *data[])
		{
			return 0;
		}
	],[
		struct rtnl_link_ops x = {
			.newlink = ipoib_new_child_link,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RTNL_LINK_OPS_NEWLINK_4_PARAMS, 1,
			  [newlink has 4 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netns_ipv4 tcp_death_row memebr is not pointer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/netns/ipv4.h>

	],[
		struct inet_timewait_death_row row;

		struct netns_ipv4 x = {
			.tcp_death_row = row,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV4_NOT_POINTER_TCP_DEATH_ROW, 1,
			  [netns_ipv4 tcp_death_row memebr is not pointer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h if struct rtnl_link_ops has netns_refund])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/rtnetlink.h>

	],[
		struct rtnl_link_ops x = {
			.netns_refund = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_LINK_OPS_IPOIB_LINK_OPS_HAS_NETNS_REFUND, 1,
			  [struct rtnl_link_ops has netns_refund])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rtnetlink.h rtnl_link_ops newlink has 5 paramters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/rtnetlink.h>

		static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
										struct nlattr *tb[], struct nlattr *data[],
										struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct rtnl_link_ops x = {
			.newlink = ipoib_new_child_link,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RTNL_LINK_OPS_NEWLINK_5_PARAMS, 1,
			  [newlink has 5 paramters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/ipv6.h has struct hop_jumbo_hdr])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ipv6.h>
	],[

		struct hop_jumbo_hdr jumbo;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_HOP_JUMBO_HDR, 1,
			  [net/ipv6.h has struct  hop_jumbo_hdr])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/ipv6.h has ipv6_mod_enabled])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ipv6.h>
	],[

		ipv6_mod_enabled();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IPV6_MOD_ENABLED, 1,
			  [ipv6_mod_enabled is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/skbuff.h skb_metadata_set defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_metadata_set(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_METADATA_SET, 1,
			  [linux/skbuff.h skb_metadata_set defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/flow_keys.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/flow_keys.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_FLOW_KEYS_H, 1,
			  [net/flow_keys.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pm_domain.h has dev_pm_domain_attach])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pm_domain.h>
	],[
		dev_pm_domain_attach(NULL, true);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_PM_DOMAIN_ATTACH, 1,
			  [pm_domain.h has dev_pm_domain_attach])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_trans_update])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_trans_update(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_TRANS_UPDATE, 1,
			  [netif_trans_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/inet_lro.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/inet_lro.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INET_LRO_H, 1,
			  [include/linux/inet_lro.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_xmit_more])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_xmit_more();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_XMIT_MORE, 1,
			  [netdev_xmit_more is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h alloc_netdev_mqs has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		alloc_netdev_mqs(0, NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ALLOC_NETDEV_MQS_5_PARAMS, 1,
			  [alloc_netdev_mqs has 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h alloc_netdev_mq has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		alloc_netdev_mq(0, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ALLOC_NETDEV_MQ_4_PARAMS, 1,
			  [alloc_netdev_mq has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h get_user_pages has 8 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		get_user_pages(NULL, NULL, 0, 0, 0, 0, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GET_USER_PAGES_8_PARAMS, 1,
			[get_user_pages has 8 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has FOLL_LONGTERM])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		int x = FOLL_LONGTERM;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FOLL_LONGTERM, 1,
			[FOLL_LONGTERM is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvzalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvzalloc(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVZALLOC, 1,
			[kvzalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has mmget])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/mm.h>
	],[
		mmget(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMGET, 1,
			[mmget is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has mmget_not_zero])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <linux/sched/mm.h>
	],[
		mmget_not_zero(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCHED_MM_MMGET_NOT_ZERO, 1,
			[mmget_not_zero is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sched.h has mmget_not_zero])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched.h>
	],[
		mmget_not_zero(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCHED_MMGET_NOT_ZERO, 1,
			[sched_mmget_not_zero is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has mmgrab])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/mm.h>
	],[
		mmgrab(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMGRAB, 1,
			[mmgrab is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvmalloc_array])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvmalloc_array(0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
	MLNX_AC_DEFINE(HAVE_KVMALLOC_ARRAY, 1,
			[kvmalloc_array is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvmalloc_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvmalloc_node(0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVMALLOC_NODE, 1,
			[kvmalloc_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvmalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvmalloc(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVMALLOC, 1,
			[kvmalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvzalloc_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvzalloc_node(0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVZALLOC_NODE, 1,
			[kvzalloc_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has kvcalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/slab.h>
	],[
		kvcalloc(0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVCALLOC, 1,
			[kvcalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm_types.h struct page has _count])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
		#include <linux/mm_types.h>
	],[
		struct page p;
		p._count.counter = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MM_PAGE__COUNT, 1,
			  [struct page has _count])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if configfs.h default_groups is list_head])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/configfs.h>
	],[
		struct config_group x = {
			.group_entry = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CONFIGFS_DEFAULT_GROUPS_LIST, 1,
			  [default_groups is list_head])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/irq_poll.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/irq_poll.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_POLL_H, 1,
			  [include/linux/irq_poll.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-mapping.h has struct dma_attrs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		struct dma_attrs *attrs;
		int ret;

		ret = dma_get_attr(DMA_ATTR_WRITE_BARRIER, attrs);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_DMA_ATTRS, 1,
			  [struct dma_attrs is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-mapping.h has dma_pci_p2pdma_supported])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_pci_p2pdma_supported(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_PCI_P2PDMA_SUPPORTED, 1,
			  [linux/dma-mapping.h has dma_pci_p2pdma_supported])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/proc_fs.h has pde_data])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/proc_fs.h>
	],[
		pde_data(NULL);
		return 0;

	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PDE_DATA, 1,
			  [linux/proc_fs.h has pde_data])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/proc_fs.h has struct proc_ops])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/proc_fs.h>
	],[
		struct proc_ops x = {
			.proc_open    = NULL,
		        .proc_read    = NULL,
		        .proc_lseek  = NULL,
		        .proc_release = NULL,
		};

		return 0;

	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PROC_OPS_STRUCT, 1,
			  [struct proc_ops is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_mark_disk_dead exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_mark_disk_dead(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MARK_DISK_DEAD, 1,
			[blk_mark_disk_dead exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has map_queue])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_ops ops = {
			.map_queue = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_MAP_QUEUE, 1,
			  [struct blk_mq_ops has map_queue])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_freeze_queue_wait_timeout])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_freeze_queue_wait_timeout(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_FREEZE_QUEUE_WAIT_TIMEOUT, 1,
			  [blk_mq_freeze_queue_wait_timeout is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_freeze_queue_wait])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_freeze_queue_wait(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_FREEZE_QUEUE_WAIT, 1,
			  [blk_mq_freeze_queue_wait is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has map_queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_ops ops = {
			.map_queues = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_MAP_QUEUES, 1,
			  [struct blk_mq_ops has map_queues])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/blk-mq-pci.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq-pci.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_PCI_H, 1,
			  [include/linux/blk-mq-pci.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has DMA_ATTR_NO_WARN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		int x = DMA_ATTR_NO_WARN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_ATTR_NO_WARN, 1,
			  [DMA_ATTR_NO_WARN is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has dma_zalloc_coherent function])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_zalloc_coherent(NULL, 0, NULL, GFP_KERNEL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_ZALLOC_COHERENT, 1,
			  [dma-mapping.h has dma_zalloc_coherent function])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has dma_alloc_attrs takes unsigned long attrs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_alloc_attrs(NULL, 0, NULL, GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_SET_ATTR_TAKES_UNSIGNED_LONG_ATTRS, 1,
			  [dma_alloc_attrs takes unsigned long attrs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h struct xdp_buff has data_hard_start])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff d = {
			.data_hard_start = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_DATA_HARD_START_FILTER_H, 1,
			  [filter.h xdp_buff data_hard_start is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdp.h struct xdp_buff has data_hard_start])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff d = {
			.data_hard_start = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_DATA_HARD_START_XDP_H, 1,
			  [xdp.h xdp_buff data_hard_start is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_set_features_flag])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>

	],[
		xdp_set_features_flag(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_SET_FEATURES_FLAG, 1,
			  [xdp_set_features_flag defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has struct xdp_frame])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>

	],[
		struct xdp_frame f = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_FRAME_IN_NET_XDP, 1,
			  [struct xdp_frame is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has struct xdp_frame workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uek_kabi.h>
		#include <net/xdp.h>

	],[
		struct xdp_frame f = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_FRAME_IN_UEK_KABI, 1,
			[struct xdp_frame is defined in 5.4.17-2011.1.2.el8uek.x86_64])
	],[
		AC_MSG_RESULT(no)

	])

	AC_MSG_CHECKING([if net/xdp_sock_drv.h has xsk_buff_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_buff_alloc(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_BUFF_ALLOC, 1,
			  [xsk_buff_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock_drv.h has xsk_buff_alloc_batch])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_buff_alloc_batch(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_BUFF_ALLOC_BATCH, 1,
			  [xsk_buff_alloc_batch is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock_drv.h has xsk_buff_set_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_buff_set_size(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_BUFF_SET_SIZE, 1,
			  [xsk_buff_set_size is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock_drv.h has xsk_buff_xdp_get_frame_dma])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_buff_xdp_get_frame_dma(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_BUFF_GET_FRAME_DMA, 1,
			  [xsk_buff_xdp_get_frame_dma is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock.h has xsk_umem_release_addr_rq])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock.h>
	],[
		xsk_umem_release_addr_rq(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_UMEM_RELEASE_ADDR_RQ, 1,
			  [xsk_umem_release_addr_rq is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock.h has xsk_umem_adjust_offset])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock.h>
	],[
		xsk_umem_adjust_offset(NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_UMEM_ADJUST_OFFSET, 1,
			  [xsk_umem_adjust_offset is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_soc_drv.h has xsk_umem_consume_tx get 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_umem_consume_tx(NULL,NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_UMEM_CONSUME_TX_GET_2_PARAMS_IN_SOCK_DRV, 1,
			  [net/xdp_soc_drv.h has xsk_umem_consume_tx get 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock.h has xsk_umem_consume_tx get 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock.h>
	],[
		xsk_umem_consume_tx(NULL,NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_UMEM_CONSUME_TX_GET_2_PARAMS_IN_SOCK, 1,
			[net/xdp_sock.h has xsk_umem_consume_tx get 2 params])
	],[
		AC_MSG_RESULT(no)
	])

		 AC_MSG_CHECKING([if xdp_sock.h struct xdp_umem has member chunk_size])
		 MLNX_BG_LB_LINUX_TRY_COMPILE([
        		 #include <net/xdp_sock.h>
	 ],[
       		  struct xdp_umem xdp = {
                 .chunk_size = 0,
        		 };

         		return 0;
	 ],[
        	AC_MSG_RESULT(yes)
        	MLNX_AC_DEFINE(HAVE_XDP_UMEM_CHUNK_SIZE, 1,
                 		  [chunk_size is defined])
		 ],[
       		 AC_MSG_RESULT(no)
	 ])

		 AC_MSG_CHECKING([if xdp_sock.h struct xdp_umem has member flags])
		 MLNX_BG_LB_LINUX_TRY_COMPILE([
        		 #include <net/xdp_sock.h>
	 ],[
       		  struct xdp_umem xdp = {
                 .flags = 0,
        		 };

         		return 0;
	 ],[
        	AC_MSG_RESULT(yes)
        	MLNX_AC_DEFINE(HAVE_XDP_UMEM_FLAGS, 1,
                 		  [flags is defined])
		 ],[
       		 AC_MSG_RESULT(no)
	 ])

	AC_MSG_CHECKING([if filter.h has xdp_do_flush_map])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		xdp_do_flush_map();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_DO_FLUSH_MAP, 1,
			  [filter.h has xdp_do_flush_map])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if filter.h has bpf_warn_invalid_xdp_action get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		bpf_warn_invalid_xdp_action(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BPF_WARN_IVALID_XDP_ACTION_GET_3_PARAMS, 1,
			  [filter.h has bpf_warn_invalid_xdp_action get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h has xdp_set_data_meta_invalid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff d;
		xdp_set_data_meta_invalid(&d);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_SET_DATA_META_INVALID_FILTER_H, 1,
			  [xdp_set_data_meta_invalid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if filter.h has xdp_set_data_meta_invalid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff d;
		xdp_set_data_meta_invalid(&d);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_SET_DATA_META_INVALID_XDP_H, 1,
			  [xdp_set_data_meta_invalid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi.h has SG_MAX_SEGMENTS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi.h>
	],[
		int x = SG_MAX_SEGMENTS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_MAX_SEGMENTS, 1,
			  [SG_MAX_SEGMENTS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi.h has QUEUE_FULL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi.h>
	],[
		int x = QUEUE_FULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_QUEUE_FULL, 1,
			  [QUEUE_FULL is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has enum scsi_scan_mode])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		enum scsi_scan_mode xx = SCSI_SCAN_INITIAL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ENUM_SCSI_SCAN_MODE, 1,
			  [enum scsi_scan_mode is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has blist_flags_t])
       	MLNX_BG_LB_LINUX_TRY_COMPILE([
               	#include <scsi/scsi_device.h>
        ],[
               blist_flags_t x = 0;

               return 0;
        ],[
               AC_MSG_RESULT(yes)
               MLNX_AC_DEFINE(HAVE_BLIST_FLAGS_T, 1,
                         [blist_flags_t is defined])
        ],[
               AC_MSG_RESULT(no)
        ])

	AC_MSG_CHECKING([if scsi_device.h has scsi_block_targets])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_block_targets(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_BLOCK_TARGETS, 1,
			[scsi_block_targets is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if iscsi_transport.h struct iscsit_transport has member rdma_shutdown])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_transport.h>
	],[
		struct iscsit_transport it = {
			.rdma_shutdown = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSIT_TRANSPORT_RDMA_SHUTDOWN, 1,
			  [rdma_shutdown is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if iscsi_transport.h struct iscsit_transport has member iscsit_get_rx_pdu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_transport.h>
	],[
		struct iscsit_transport it = {
			.iscsit_get_rx_pdu = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSIT_TRANSPORT_ISCSIT_GET_RX_PDU, 1,
			  [iscsit_get_rx_pdu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if iscsi_target_core.h has struct iscsit_conn])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_target_core.h>
	],[
		struct iscsit_conn c;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSIT_CONN, 1,
			  [iscsi_target_core.h has struct iscsit_conn])

		AC_MSG_CHECKING([if iscsi_target_core.h struct iscsit_conn has member login_sockaddr])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <target/iscsi/iscsi_target_core.h>
		],[
			struct sockaddr_storage s;
			struct iscsit_conn c = {
				.login_sockaddr = s,
			};

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_ISCSIT_CONN_LOGIN_SOCKADDR, 1,
				  [iscsit_conn has member login_sockaddr])
		],[
			AC_MSG_RESULT(no)
		])

		AC_MSG_CHECKING([if iscsi_target_core.h struct iscsit_conn has member local_sockaddr])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <target/iscsi/iscsi_target_core.h>
		],[
			struct sockaddr_storage s;
			struct iscsit_conn c = {
				.local_sockaddr = s,
			};

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_ISCSIT_CONN_LOCAL_SOCKADDR, 1,
				  [iscsit_conn has members local_sockaddr])
		],[
			AC_MSG_RESULT(no)
		])
	],[
		AC_MSG_RESULT(no)

		AC_MSG_CHECKING([if iscsi_target_core.h struct iscsi_conn has member login_sockaddr])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <target/iscsi/iscsi_target_core.h>
		],[
			struct sockaddr_storage s;
			struct iscsi_conn c = {
				.login_sockaddr = s,
			};

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_ISCSI_CONN_LOGIN_SOCKADDR, 1,
				  [iscsi_conn has member login_sockaddr])
		],[
			AC_MSG_RESULT(no)
		])

		AC_MSG_CHECKING([if iscsi_target_core.h struct iscsi_conn has member local_sockaddr])
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <target/iscsi/iscsi_target_core.h>
		],[
			struct sockaddr_storage s;
			struct iscsi_conn c = {
				.local_sockaddr = s,
			};

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_ISCSI_CONN_LOCAL_SOCKADDR, 1,
				  [iscsi_conn has members local_sockaddr])
		],[
			AC_MSG_RESULT(no)
		])
	])

	AC_MSG_CHECKING([if iscsi_target_core.h has struct iscsit_cmd])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_target_core.h>
	],[
		struct iscsit_cmd c;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSIT_CMD, 1,
			  [iscsi_target_core.h has struct iscsit_cmd])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_queue_virt_boundary exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_virt_boundary(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_VIRT_BOUNDARY, 1,
				[blk_queue_virt_boundary exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h/linux/blk-mq.h has blk_rq_is_passthrough])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		blk_rq_is_passthrough(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_IS_PASSTHROUGH, 1,
				[blk_rq_is_passthrough is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if target_put_sess_cmd has 1 parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/target_core_base.h>
		#include <target/target_core_fabric.h>
	],[
		target_put_sess_cmd(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TARGET_PUT_SESS_CMD_HAS_1_PARAM, 1,
			  [target_put_sess_cmd in target_core_fabric.h has 1 parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if target/target_core_fabric.h has target_stop_session])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/target_core_base.h>
		#include <target/target_core_fabric.h>
	],[
		target_stop_session(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TARGET_STOP_SESSION, 1,
			  [target_stop_session is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has scsi_change_queue_depth])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_change_queue_depth(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_CHANGE_QUEUE_DEPTH, 1,
			[scsi_change_queue_depth exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member track_queue_depth])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.track_queue_depth = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_TRACK_QUEUE_DEPTH, 1,
			[scsi_host_template has members track_queue_depth])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member shost_groups])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.shost_groups = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_SHOST_GROUPS, 1,
			[scsi_host_template has members shost_groups])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member init_cmd_priv])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.init_cmd_priv = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_INIT_CMD_PRIV, 1,
			[scsi_host_template has member init_cmd_priv])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct Scsi_Host has member nr_hw_queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct Scsi_Host sh = {
			.nr_hw_queues = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_NR_HW_QUEUES, 1,
				[Scsi_Host has members nr_hw_queues])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct Scsi_Host has member max_segment_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct Scsi_Host sh = {
			.max_segment_size = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_MAX_SEGMENT_SIZE, 1,
				[Scsi_Host has members max_segment_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct Scsi_Host has member virt_boundary_mask])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct Scsi_Host sh = {
			.virt_boundary_mask = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_VIRT_BOUNDARY_MASK, 1,
				[Scsi_Host has members virt_boundary_mask])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h scsi_host_busy_iter fn has 2 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>

		bool fn(struct scsi_cmnd *scmnd, void *ctx)
		{
			return false;
		}
	],[
		scsi_host_busy_iter(NULL, fn, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_BUSY_ITER_FN_2_ARGS, 1,
				[scsi_host.h scsi_host_busy_iter fn has 2 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h has enum scsi_timeout_action])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		enum scsi_timeout_action a = SCSI_EH_DONE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_TIMEOUT_ACTION, 1,
				[scsi_host.h has enum scsi_timeout_action])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_cmnd.h struct scsi_cmnd  has member prot_flags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		struct scsi_cmnd sc = {
			.prot_flags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_CMND_PROT_FLAGS, 1,
			[scsi_cmnd has members prot_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if target_core_base.h struct se_cmd has member sense_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/target_core_base.h>

	],[
		struct se_cmd se = {
			.sense_info = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SE_CMD_HAS_SENSE_INFO, 1,
			[struct se_cmd has member sense_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if types.h has cycle_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/types.h>
	],[
		cycle_t x = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TYPE_CYCLE_T, 1,
			[type cycle_t is defined in linux/types.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/clocksource.h has cycle_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/clocksource.h>
	],[
		cycle_t x = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CLOCKSOURCE_CYCLE_T, 1,
			  [cycle_t is defined in linux/clocksource.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h struct scsi_device has member state_mutex])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mutex.h>
		#include <scsi/scsi_device.h>
	],[
		struct scsi_device *sdev;
		mutex_init(&sdev->state_mutex);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_DEVICE_STATE_MUTEX, 1,
			  [scsi_device.h struct scsi_device has member state_mutex])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h struct scsi_device has member budget_map])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		struct scsi_device sdev;
		sbitmap_init_node(&sdev.budget_map, 0, 0, 0, 0, false, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_DEVICE_BUDGET_MAP, 1,
			  [scsi_device.h struct scsi_device has member budget_map])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member use_blk_tags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.use_blk_tags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_USE_BLK_TAGS, 1,
			[scsi_host_template has members use_blk_tags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member change_queue_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.change_queue_type = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_CHANGE_QUEUE_TYPE, 1,
			[scsi_host_template has members change_queue_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_host.h struct scsi_host_template has member use_host_wide_tags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_host.h>
	],[
		struct scsi_host_template sh = {
			.use_host_wide_tags = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_HOST_TEMPLATE_USE_HOST_WIDE_TAGS, 1,
			[scsi_host_template has members use_host_wide_tags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if target_core_base.h se_cmd transport_complete_callback has three params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/target_core_base.h>

		sense_reason_t transport_complete_callback(struct se_cmd *se, bool b, int *i) {
			  return 0;
		}
	],[
		struct se_cmd se = {
			  .transport_complete_callback = transport_complete_callback,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SE_CMD_TRANSPORT_COMPLETE_CALLBACK_HAS_THREE_PARAM, 1,
			  [target_core_base.h se_cmd transport_complete_callback has three params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h struct request has rq_flags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		struct request rq = { .rq_flags = 0 };
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_RQ_FLAGS, 1,
			[blkdev.h struct request has rq_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h blk_mq_requeue_request has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_requeue_request(NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_REQUEUE_REQUEST_2_PARAMS, 1,
			  [blk-mq.h blk_mq_requeue_request has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_mq_quiesce_queue])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		blk_mq_quiesce_queue(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_QUIESCE_QUEUE, 1,
				[blk_mq_quiesce_queue exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has BLK_MQ_F_NO_SCHED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		int x = BLK_MQ_F_NO_SCHED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_F_NO_SCHED, 1,
				[BLK_MQ_F_NO_SCHED is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_rq_nr_phys_segments])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		blk_rq_nr_phys_segments(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_NR_PHYS_SEGMENTS, 1,
			[blk_rq_nr_phys_segments exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_rq_payload_bytes])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		blk_rq_payload_bytes(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_NR_PAYLOAD_BYTES, 1,
			[blk_rq_payload_bytes exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has req_op])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		struct request *req;
		req_op(req);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQ_OP, 1,
			[req_op exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_rq_nr_discard_segments])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		blk_rq_nr_discard_segments(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_NR_DISCARD_SEGMENTS, 1,
			[blk_rq_nr_discard_segments is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci_ids.h has PCI_CLASS_STORAGE_EXPRESS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci_ids.h>
	],[
		int x = PCI_CLASS_STORAGE_EXPRESS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_CLASS_STORAGE_EXPRESS, 1,
			  [PCI_CLASS_STORAGE_EXPRESS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum req_opf has REQ_OP_DRV_OUT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		enum req_opf xx = REQ_OP_DRV_OUT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQ_OPF_REQ_OP_DRV_OUT, 1,
			  [enum req_opf has REQ_OP_DRV_OUT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum req_op has REQ_OP_DRV_OUT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		enum req_op xx = REQ_OP_DRV_OUT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQ_OP_REQ_OP_DRV_OUT, 1,
			  [enum req_op has REQ_OP_DRV_OUT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has enum req_opf])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		enum req_opf xx = REQ_OP_DRV_OUT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_OPF, 1,
			  [enum req_opf is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has blk_mq_req_flags_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		blk_mq_req_flags_t x = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_REQ_FLAGS_T, 1,
			  [blk_mq_req_flags_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/cgroup_rdma.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/cgroup_rdma.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CGROUP_RDMA_H, 1,
			  [linux/cgroup_rdma exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __cgroup_bpf_run_filter_sysctl have 7 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf-cgroup.h>
	],[
		return __cgroup_bpf_run_filter_sysctl(NULL, NULL, 0, NULL, NULL, NULL, 0);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CGROUP_BPF_RUN_FILTER_SYSCTL_7_PARAMETERS, 1,
			[__cgroup_bpf_run_filter_sysctl have 7 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci-p2pdma.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci-p2pdma.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_P2PDMA_H, 1,
			  [linux/pci-p2pdma.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if trace/events/rdma_core.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <trace/events/rdma_core.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_EVENTS_RDMA_CORE_HEADER, 1,
			  [trace/events/rdma_core.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci-p2pdma.h has pci_p2pdma_unmap_sg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci-p2pdma.h>
	],[
		pci_p2pdma_unmap_sg(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_P2PDMA_UNMAP_SG, 1,
			  [pci_p2pdma_unmap_sg defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sched/signal.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/signal.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCHED_SIGNAL_H, 1,
			  [linux/sched/signal.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sched/mm.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/mm.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCHED_MM_H, 1,
			  [linux/sched/mm.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if memalloc_noio_save defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched.h>
		#include <linux/sched/mm.h>
	],[
		unsigned int noio_flag = memalloc_noio_save();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MEMALLOC_NOIO_SAVE, 1,
			  [memalloc_noio_save is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sched/task.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/task.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCHED_TASK_H, 1,
			  [linux/sched/task.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/ip_tunnels.h has struct ip_tunnel_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if.h>
		#include <net/ip_tunnels.h>
	],[
		struct ip_tunnel_info ip_tunnel_info_test;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IP_TUNNEL_INFO, 1,
			  [struct ip_tunnel_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ip_tunnel_info_opts_set has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if.h> /* for kernel linux-3.10.0-1149 */
		#include <net/ip_tunnels.h>
	],[
		ip_tunnel_info_opts_set(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IP_TUNNEL_INFO_OPTS_SET_4_PARAMS, 1,
			[ip_tunnel_info_opts_set has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __ip_tun_set_dst has 7 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/dst_metadata.h>
	],[
		__ip_tun_set_dst(0, 0, 0, 0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___IP_TUN_SET_DST_7_PARAMS, 1,
			[__ip_tun_set_dst has 7 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf_trace exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
		#include <linux/bpf_trace.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_BPF_TRACE_H, 1,
			  [linux/bpf_trace exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf_trace has trace_xdp_exception])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf_trace.h>
	],[
		trace_xdp_exception(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_XDP_EXCEPTION, 1,
			  [trace_xdp_exception is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bpf_prog_aux has xdp_has_frags as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		struct bpf_prog_aux x = {
			.xdp_has_frags = true
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_HAS_FRAGS, 1,
			  [struct bpf_prog_aux has xdp_has_frags as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_update_skb_shared_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_update_skb_shared_info(NULL, 0, 0, 0, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_UPDATE_SKB_SHARED_INFO, 1,
			  [xdp_update_skb_shared_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_get_shared_info_from_buff])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_get_shared_info_from_buff(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_GET_SHARED_INFO_FROM_BUFF, 1,
			  [xdp_update_skb_shared_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_BPF_H, 1,
			  [uapi/bpf.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([tcf_exts_num_actions],
		[net/sched/cls_api.c],
		[AC_DEFINE(HAVE_TCF_EXTS_NUM_ACTIONS, 1,
			[tcf_exts_num_actions is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([netpoll_poll_dev],
		[net/core/netpoll.c],
		[AC_DEFINE(HAVE_NETPOLL_POLL_DEV_EXPORTED, 1,
			[netpoll_poll_dev is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([bpf_prog_inc],
		[kernel/bpf/syscall.c],
		[AC_DEFINE(HAVE_BPF_PROG_INC_EXPORTED, 1,
			[bpf_prog_inc is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([__put_task_struct],
		[kernel/fork.c],
		[AC_DEFINE(HAVE_PUT_TASK_STRUCT_EXPORTED, 1,
			[__put_task_struct is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([mmput_async],
		[kernel/fork.c],
		[AC_DEFINE(HAVE_MMPUT_ASYNC_EXPORTED, 1,
			[mmput_async is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([get_pid_task],
		[kernel/pid.c],
		[AC_DEFINE(HAVE_GET_PID_TASK_EXPORTED, 1,
			[get_pid_task is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([get_task_pid],
		[kernel/pid.c],
		[AC_DEFINE(HAVE_GET_TASK_PID_EXPORTED, 1,
			[get_task_pid is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([get_task_comm],
		[fs/exec.c],
		[AC_DEFINE(HAVE_GET_TASK_COMM_EXPORTED, 1,
			[get_task_comm is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([__get_task_comm],
		[fs/exec.c],
		[AC_DEFINE(HAVE___GET_TASK_COMM_EXPORTED, 1,
			[__get_task_comm is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([mm_kobj],
		[mm/mm_init.c],
		[AC_DEFINE(HAVE_MM_KOBJ_EXPORTED, 1,
			[mm_kobj is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if linux/bpf.h has bpf_prog_sub])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		bpf_prog_sub(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BPF_PROG_SUB, 1,
			  [bpf_prog_sub is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bpf_prog_add\bfs_prog_inc functions return struct])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		struct bpf_prog *prog;

		prog = bpf_prog_add(prog, 0);
		prog = bpf_prog_inc(prog);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BPF_PROG_ADD_RET_STRUCT, 1,
			  [bpf_prog_add\bfs_prog_inc functions return struct])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bpf.h has XDP_REDIRECT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bpf.h>
	],[
		enum xdp_action x = XDP_REDIRECT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_REDIRECT, 1,
			  [XDP_REDIRECT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_cls_flower_offload has common])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_flower_offload x = {
			.common = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLS_FLOWER_OFFLOAD_COMMON_FIX, 1,
			  [struct tc_cls_flower_offload has common])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_to_netdev has egress_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct tc_to_netdev x = {
			.egress_dev = false,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_TO_NETDEV_EGRESS_DEV, 1,
			  [struct tc_to_netdev has egress_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_cls_flower_offload has egress_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_cls_flower_offload x = {
			.egress_dev = false,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLS_FLOWER_OFFLOAD_EGRESS_DEV, 1,
			  [struct tc_cls_flower_offload has egress_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_cls_offload exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_cls_offload x = {
			.classid = 3,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_CLS_OFFLOAD, 1,
			  [struct flow_cls_offload exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has ct_metadata.orig_dir])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.ct_metadata.orig_dir = true,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_CT_METADATA_ORIG_DIR, 1,
			  [struct flow_action_entry has ct_metadata.orig_dir])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has ptype])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.ptype = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_PTYPE, 1,
			  [struct flow_action_entry has ptype])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has mpls])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.mpls_push.label = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_MPLS, 1,
			  [struct flow_action_entry has mpls])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has police.index])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.police.index = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_POLICE_INDEX, 1,
			  [struct flow_action_entry has police.index])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has police.exceed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.police.exceed.act_id = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_POLICE_EXCEED, 1,
			  [struct flow_action_entry has police.exceed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has hw_index])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.hw_index = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_HW_INDEX, 1,
			  [struct flow_action_entry has hw_index])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has police.rate_pkt_ps])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry x = {
			.police.rate_pkt_ps = 1,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_POLICE_RATE_PKT_PS, 1,
			  [struct flow_action_entry has police.rate_pkt_ps])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_rule_match_meta exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_rule_match_meta(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_RULE_MATCH_META, 1,
			  [flow_rule_match_meta exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_action_hw_stats_check exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_action_hw_stats_check(NULL, NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_HW_STATS_CHECK, 1,
			  [flow_action_hw_stats_check exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_POLICE exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_POLICE;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_POLICE, 1,
			  [FLOW_ACTION_POLICE exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_CT exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_CT;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_CT, 1,
			  [FLOW_ACTION_CT exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if FLOW_ACTION_REDIRECT_INGRESS exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_action_id action = FLOW_ACTION_REDIRECT_INGRESS;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_REDIRECT_INGRESS, 1,
			  [FLOW_ACTION_REDIRECT_INGRESS exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if enum flow_block_binder_type exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		enum flow_block_binder_type binder_type;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ENUM_FLOW_BLOCK_BINDER_TYPE, 1,
			  [enum flow_block_binder_type exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_indr_block_bind_cb_t has 7 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/flow_offload.h>
		static
		int mlx5e_rep_indr_setup_cb(struct net_device *netdev, struct Qdisc *sch, void *cb_priv,
					    enum tc_setup_type type, void *type_data,
					    void *data,
					    void (*cleanup)(struct flow_block_cb *block_cb))
		{
			return 0;
		}

	],[
		flow_indr_dev_register(mlx5e_rep_indr_setup_cb, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_INDR_BLOCK_BIND_CB_T_7_PARAMS, 1,
			  [flow_indr_block_bind_cb_t has 7 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_indr_block_bind_cb_t has 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/flow_offload.h>
		static
		int mlx5e_rep_indr_setup_cb(struct net_device *netdev, void *cb_priv,
					    enum tc_setup_type type, void *type_data)
		{
			return 0;
		}

	],[
		flow_indr_dev_register(mlx5e_rep_indr_setup_cb, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_INDR_BLOCK_BIND_CB_T_4_PARAMS, 1,
			  [flow_indr_block_bind_cb_t has 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_indr_dev_unregister receive flow_setup_cb_t parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/flow_offload.h>
		static int mlx5e_rep_indr_setup_tc_cb(enum tc_setup_type type,
                                      void *type_data, void *indr_priv)
		{
			return 0;
		}

	],[
		flow_indr_dev_unregister(NULL,NULL, mlx5e_rep_indr_setup_tc_cb);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_INDR_DEV_UNREGISTER_FLOW_SETUP_CB_T, 1,
			  [flow_indr_dev_unregister receive flow_setup_cb_t parameter])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if flow_indr_dev_register exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/flow_offload.h>
	],[
		flow_indr_dev_register(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_INDR_DEV_REGISTER, 1,
			  [flow_indr_dev_register exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_stats_update has 5 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_stats_update(NULL, 0, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_STATS_UPDATE_5_PARAMS, 1,
			  [flow_stats_update has 5 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_stats_update has 6 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_stats_update(NULL, 0, 0, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_STATS_UPDATE_6_PARAMS, 1,
			  [flow_stats_update has 6 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if GRO_LEGACY_MAX_SIZE defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		unsigned int x = GRO_LEGACY_MAX_SIZE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GRO_LEGACY_MAX_SIZE, 1,
			  [GRO_LEGACY_MAX_SIZE defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if GRO_MAX_SIZE defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		unsigned long x = GRO_MAX_SIZE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GRO_MAX_SIZE, 1,
			  [GRO_MAX_SIZE defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_to_netdev has tc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct tc_to_netdev x;
		x.tc = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_TO_NETDEV_TC, 1,
			  [struct tc_to_netdev has tc])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_lag_upper_info has hash_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_lag_upper_info info;
		info.hash_type = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INFO_HASH_TYPE, 1,
			  [netdev_lag_upper_info has hash_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_has_offload_stats gets net_device])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		bool mlx5e_has_offload_stats(const struct net_device *dev, int attr_id)
		{
			return true;
		}
	],[
		struct net_device_ops ndops = {
			.ndo_has_offload_stats = mlx5e_has_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_HAS_OFFLOAD_STATS_GETS_NET_DEVICE, 1,
			  [ndo_has_offload_stats gets net_device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net_device_ops_extended has ndo_has_offload_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		bool mlx5e_has_offload_stats(const struct net_device *dev, int attr_id)
		{
			return true;
		}
	],[
		struct net_device_ops_extended ndops = {
			.ndo_has_offload_stats = mlx5e_has_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_HAS_OFFLOAD_STATS_EXTENDED, 1,
			  [ndo_has_offload_stats gets net_device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ndo_get_offload_stats defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx5e_get_offload_stats(int attr_id, const struct net_device *dev,
									void *sp)
		{
			return 0;
		}
	],[
		struct net_device_ops ndops = {
			.ndo_get_offload_stats = mlx5e_get_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_OFFLOAD_STATS, 1,
			  [ndo_get_offload_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct net_device_ops_extended has ndo_get_offload_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		int mlx5e_get_offload_stats(int attr_id, const struct net_device *dev,
									void *sp)
		{
			return 0;
		}
	],[
		struct net_device_ops_extended ndops = {
			.ndo_get_offload_stats = mlx5e_get_offload_stats,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_GET_OFFLOAD_STATS_EXTENDED, 1,
			  [extended ndo_get_offload_stats is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct mlx5e_netdev_ops has ndo_tx_timeout get 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
		{
			return;
		}
	],[
		struct net_device_ops mlx5e_netdev_ops = {
			.ndo_tx_timeout = mlx5e_tx_timeout,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NDO_TX_TIMEOUT_GET_2_PARAMS, 1,
			  [ndo_tx_timeout get 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ib_umem_notifier_invalidate_range_start has parameter blockable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
		static int notifier(struct mmu_notifier *mn,
				    struct mm_struct *mm,
				    unsigned long start,
				    unsigned long end,
				    bool blockable) {
			return 0;
		}
	],[
		static const struct mmu_notifier_ops notifiers = {
			.invalidate_range_start = notifier
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UMEM_NOTIFIER_PARAM_BLOCKABLE, 1,
			  [ib_umem_notifier_invalidate_range_start has parameter blockable])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has struct netdev_notifier_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_notifier_info x = {
			.dev = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NOTIFIER_INFO, 1,
			  [struct netdev_notifier_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has field upper_info in struct netdev_notifier_changeupper_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct netdev_notifier_changeupper_info x = {
			.upper_info = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_NOTIFIER_CHANGEUPPER_INFO_UPPER_INFO, 1,
			  [struct netdev_notifier_changeupper_info has upper_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_mpls.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_mpls.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_TC_ACT_TC_MPLS_H, 1,
			  [net/tc_act/tc_mpls.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_tunnel_key.h has tcf_tunnel_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_tunnel_key.h>
	],[
		const struct tc_action xx;
		tcf_tunnel_info(&xx);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_TUNNEL_INFO, 1,
			  [tcf_tunnel_info is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_pedit.h has tcf_pedit_nkeys])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_pedit.h>
	],[
		const struct tc_action xx;
		tcf_pedit_nkeys(&xx);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_PEDIT_NKEYS, 1,
			  [tcf_pedit_nkeys is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_pedit.h struct tcf_pedit has member tcfp_keys_ex])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_pedit.h>
	],[
		struct tcf_pedit x = {
			.tcfp_keys_ex = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_PEDIT_TCFP_KEYS_EX_FIX, 1,
			  [struct tcf_pedit has member tcfp_keys_ex])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_pedit.h struct tcf_pedit_parms has member tcfp_keys_ex])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_pedit.h>
	],[
		struct tcf_pedit_parms x = {
			.tcfp_keys_ex = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_PEDIT_PARMS_TCFP_KEYS_EX, 1,
			  [struct tcf_pedit_parms has member tcfp_keys_ex])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_device.h has function scsi_internal_device_block])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_device.h>
	],[
		scsi_internal_device_block(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_DEVICE_SCSI_INTERNAL_DEVICE_BLOCK, 1,
			[scsi_device.h has function scsi_internal_device_block])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if libiscsi.h has iscsi_eh_cmd_timed_out])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <scsi/libiscsi.h>
	],[
		iscsi_eh_cmd_timed_out(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSI_EH_CMD_TIMED_OUT, 1,
			[iscsi_eh_cmd_timed_out is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if libiscsi.h has iscsi_conn_unbind])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/libiscsi.h>
	],[
		iscsi_conn_unbind(NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSI_CONN_UNBIND, 1,
			[iscsi_conn_unbind is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if libiscsi.h iscsi_host_remove has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/libiscsi.h>
	],[
		iscsi_host_remove(NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSI_HOST_REMOVE_2_PARAMS, 1,
			[libiscsi.h iscsi_host_remove has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if libiscsi.h has struct iscsi_cmd])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/libiscsi.h>
	],[
		struct iscsi_cmd c;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSI_CMD, 1,
			[libiscsi.h has struct iscsi_cmd])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi_transport_iscsi.h has iscsi_put_endpoint])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_iscsi.h>
	],[
		iscsi_put_endpoint(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSI_PUT_ENDPOINT, 1,
			[iscsi_put_endpoint is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sed-opal.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sed-opal.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_SED_OPAL_H, 1,
			[linux/sed-opal.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h bio_init has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bio_init(NULL, NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_INIT_3_PARAMS, 1,
			  [bio.h bio_init has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_types.h has REQ_IDLE])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int flags = REQ_IDLE;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQ_IDLE, 1,
			[blk_types.h has REQ_IDLE])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has __blkdev_issue_zeroout])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		__blkdev_issue_zeroout(NULL, 0, 0, 0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_ISSUE_ZEROOUT, 1,
			[__blkdev_issue_zeroout exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if compiler.h has const __read_once_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/compiler.h>
	],[
		const unsigned long tmp;
		__read_once_size(&tmp, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CONST_READ_ONCE_SIZE, 1,
			[const __read_once_size exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if configfs_item_operations drop_link returns int])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/configfs.h>

		static int my_drop_link(struct config_item *parent, struct config_item *target)

		{
			return 0;
		}

	],[
		static struct configfs_item_operations item_ops = {
			.drop_link	= my_drop_link,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CONFIGFS_DROP_LINK_RETURNS_INT, 1,
			  [if configfs_item_operations drop_link returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/nvme-fc-driver.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
		#include <uapi/scsi/fc/fc_fs.h>
		#include <linux/nvme-fc-driver.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_NVME_FC_DRIVER_H, 1,
			[linux/nvme-fc-driver.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_freeze_queue_start])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_freeze_queue_start(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_FREEZE_QUEUE_START, 1,
			  [blk_freeze_queue_start is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_complete_request has 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_complete_request(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_COMPLETE_REQUEST_HAS_2_PARAMS, 1,
			  [linux/blk-mq.h blk_mq_complete_request has 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_ops init_request has 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		int init_request(struct blk_mq_tag_set *set, struct request * req,
				 unsigned int i, unsigned int k) {
			return 0;
		}
	],[
		struct blk_mq_ops ops = {
			.init_request = init_request,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_INIT_REQUEST_HAS_4_PARAMS, 1,
			  [linux/blk-mq.h blk_mq_ops init_request has 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_ops exit_request has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		void exit_request(struct blk_mq_tag_set *set, struct request * req,
				  unsigned int i) {
			return;
		}
	],[
		struct blk_mq_ops ops = {
			.exit_request = exit_request,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_EXIT_REQUEST_HAS_3_PARAMS, 1,
			  [linux/blk-mq.h blk_mq_ops exit_request has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_tag_set has member map])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_tag_set x = {
			.map = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_TAG_SET_HAS_MAP, 1,
			  [blk_mq_tag_set has member map])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_tag_set has member ops is const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
		static const struct blk_mq_ops xmq = {0};

	],[
		struct blk_mq_tag_set x = {
			.ops = &xmq,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_TAG_SET_HAS_CONST_OPS, 1,
			  [ blk_mq_tag_set member ops is const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has blk_queue_max_write_zeroes_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_max_write_zeroes_sectors(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_MAX_WRITE_ZEROES_SECTORS, 1,
			  [blk_queue_max_write_zeroes_sectors is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci.h has pci_free_irq])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_free_irq(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_FREE_IRQ, 1,
			  [linux/pci.h has pci_free_irq])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/security.h has register_lsm_notifier])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/security.h>
	],[
		register_lsm_notifier(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REGISTER_LSM_NOTIFIER, 1,
			  [linux/security.h has register_lsm_notifier])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/security.h has register_blocking_lsm_notifier])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/security.h>
	],[
		register_blocking_lsm_notifier(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REGISTER_BLOCKING_LSM_NOTIFIER, 1,
			  [linux/security.h has register_blocking_lsm_notifier])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-map-ops.h has DMA_F_PCI_P2PDMA_SUPPORTED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-map-ops.h>
	],[
		struct dma_map_ops * a;
		a->flags = DMA_F_PCI_P2PDMA_SUPPORTED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_F_PCI_P2PDMA_SUPPORTED, 1,
			  [linux/dma-map-ops.h has DMA_F_PCI_P2PDMA_SUPPORTED])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/cdev.h has cdev_set_parent])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/cdev.h>
	],[
		cdev_set_parent(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CDEV_SET_PARENT, 1,
			  [linux/cdev.h has cdev_set_parent])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/atomic.h has __atomic_add_unless])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/highmem.h>
	],[
		atomic_t x;
		__atomic_add_unless(&x, 1, 1);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___ATOMIC_ADD_UNLESS, 1,
			  [__atomic_add_unless is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/atomic.h has atomic_fetch_add_unless])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/highmem.h>
	],[
		atomic_t x;
		atomic_fetch_add_unless(&x, 1, 1);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ATOMIC_FETCH_ADD_UNLESS, 1,
			  [atomic_fetch_add_unless is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/net_tstamp.h has HWTSTAMP_FILTER_NTP_ALL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net_tstamp.h>
	],[
		int x = HWTSTAMP_FILTER_NTP_ALL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_HWTSTAMP_FILTER_NTP_ALL, 1,
			  [HWTSTAMP_FILTER_NTP_ALL is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/pkt_cls.h has tcf_exts_stats_update])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tcf_exts_stats_update(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_EXTS_STATS_UPDATE, 1,
			  [tcf_exts_stats_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct  tcf_exts has actions as array])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tcf_exts x;
		x.actions = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_EXTS_HAS_ARRAY_ACTIONS, 1,
			  [struct  tcf_exts has actions as array])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/pkt_cls.h has tc_cls_can_offload_and_chain0])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		tc_cls_can_offload_and_chain0(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_CLS_CAN_OFFLOAD_AND_CHAIN0, 1,
			  [tc_cls_can_offload_and_chain0 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tc_act/tc_sum.h has is_tcf_csum])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tc_act/tc_csum.h>
	],[
		is_tcf_csum(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_TCF_CSUM, 1,
			  [is_tcf_csum is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct  tc_action_ops has id])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		struct tc_action_ops x = { .id = 0, };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_ACTION_OPS_HAS_ID, 1,
			  [struct  tc_action_ops has id])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tcf_common exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		struct tcf_common pc;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_COMMON, 1,
			  [struct tcf_common is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tcf_hash helper functions have tcf_hashinfo parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tcf_hash_check(0, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_HASH_WITH_HASHINFO, 1,
			  [tcf_hash helper functions have tcf_hashinfo parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/nvme_ioctl.h has NVME_IOCTL_RESCAN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme_ioctl.h>
		#include <linux/types.h>
		#include <uapi/asm-generic/ioctl.h>
	],[
		unsigned int x = NVME_IOCTL_RESCAN;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UAPI_LINUX_NVME_IOCTL_RESCAN, 1,
			[uapi/linux/nvme_ioctl.h has NVME_IOCTL_RESCAN])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if refcount.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/refcount.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REFCOUNT, 1,
			  [refcount.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if refcount.h has refcount_dec_if_one])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/refcount.h>
	],[
		bool i = refcount_dec_if_one(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REFCOUNT_DEC_IF_ONE, 1,
			  [refcount.h has refcount_dec_if_one])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if firmware.h has request_firmware_direct])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/firmware.h>
	],[
		request_firmware_direct(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_FIRMWARE_DIRECT, 1,
			  [request_firmware_direct is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pr.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
		#include <linux/pr.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PR_H, 1,
			[linux/pr.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/device/bus.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device/bus.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_DEVICE_BUS_H, 1,
			[linux/device/bus.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bus_type remove function return void])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device/bus.h>

		static void auxiliary_bus_remove(struct device *dev)
		{
		}
	],[
		struct bus_type btype = {
			.remove = auxiliary_bus_remove,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BUS_TYPE_REMOVE_RETURN_VOID, 1,
			[bus_type remove function return void])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/kern_levels.h has LOGLEVEL_DEFAULT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/kern_levels.h>
	],[
		int i = LOGLEVEL_DEFAULT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LOGLEVEL_DEFAULT, 1,
			[linux/kern_levels.h has LOGLEVEL_DEFAULT])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if linux/t10-pi.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/t10-pi.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_T10_PI_H, 1,
			[linux/t10-pi.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pm.h struct dev_pm_info has member set_latency_tolerance])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pm.h>
		#include <asm/device.h>
		#include <linux/types.h>

		static void nvme_set_latency_tolerance(struct device *dev, s32 val)
		{
			return;
		}
	],[
		struct dev_pm_info dpinfo = {
			.set_latency_tolerance = nvme_set_latency_tolerance,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEV_PM_INFO_SET_LATENCY_TOLERANCE, 1,
			[set_latency_tolerance is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_alloc_request has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_alloc_request(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_ALLOC_REQUEST_HAS_3_PARAMS, 1,
			  [linux/blk-mq.h blk_mq_alloc_request has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has REQ_TYPE_DRV_PRIV])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		enum rq_cmd_type_bits rctb = REQ_TYPE_DRV_PRIV;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_REQ_TYPE_DRV_PRIV, 1,
			[REQ_TYPE_DRV_PRIV is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h blk_add_request_payload has 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_add_request_payload(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_ADD_REQUEST_PAYLOAD_HAS_4_PARAMS, 1,
			[blkdev.h blk_add_request_payload has 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has REQ_OP_FLUSH])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_OP_FLUSH;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_OP_FLUSH, 1,
			[REQ_OP_FLUSH is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has REQ_OP_DISCARD])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_OP_DISCARD;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_OP_DISCARD, 1,
			[REQ_OP_DISCARD is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has blk_status_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		blk_status_t xx;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_STATUS_T, 1,
			[blk_status_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h struct bio_integrity_payload has member bip_iter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
		#include <linux/bvec.h>
	],[
		struct bvec_iter bip_it = {0};
		struct bio_integrity_payload bip = {
			.bip_iter = bip_it,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_INTEGRITY_PYLD_BIP_ITER, 1,
			[bio_integrity_payload has members bip_iter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci_ids.h has PCI_VENDOR_ID_AMAZON])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci_ids.h>
	],[
		int x = PCI_VENDOR_ID_AMAZON;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IDS_PCI_VENDOR_ID_AMAZON, 1,
			[PCI_VENDOR_ID_AMAZON is defined in pci_ids])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has BLK_INTEGRITY_DEVICE_CAPABLE])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		enum  blk_integrity_flags bif = BLK_INTEGRITY_DEVICE_CAPABLE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_INTEGRITY_DEVICE_CAPABLE, 1,
			[BLK_INTEGRITY_DEVICE_CAPABLE is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has BLK_MAX_WRITE_HINTS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = BLK_MAX_WRITE_HINTS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MAX_WRITE_HINTS, 1,
			[BLK_MAX_WRITE_HINTS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_rq_append_bio])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct bio **bio;

		blk_rq_append_bio(NULL, bio);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_APPEND_BIO, 1,
			[blk_rq_append_bio is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if device.h has device_remove_file_self])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
	],[
		device_remove_file_self(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_REMOVE_FILE_SELF, 1,
			[device.h has device_remove_file_self])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has device_add_disk])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		device_add_disk(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_ADD_DISK, 1,
			[genhd.h has device_add_disk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has device_add_disk 3 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		device_add_disk(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_ADD_DISK_3_ARGS_NO_RETURN, 1,
			[genhd.h has device_add_disk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has device_add_disk 3 args and must_check])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int ret;
		ret = device_add_disk(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_ADD_DISK_3_ARGS_AND_RETURN, 1,
			[genhd.h has device_add_disk 3 args and must_check])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_unquiesce_queue])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_unquiesce_queue(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_UNQUIESCE_QUEUE, 1,
			  [blk_mq_unquiesce_queue is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_alloc_request_hctx])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_alloc_request_hctx(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_ALLOC_REQUEST_HCTX, 1,
			  [linux/blk-mq.h has blk_mq_alloc_request_hctx])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h struct pci_error_handlers has reset_notify])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>

		void reset(struct pci_dev *dev, bool prepare) {
			return;
		}
	],[
		struct pci_error_handlers x = {
			.reset_notify = reset,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_ERROR_HANDLERS_RESET_NOTIFY, 1,
			  [pci.h struct pci_error_handlers has reset_notify])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi.h has SCSI_MAX_SG_SEGMENTS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi.h>
	],[
		int x = SCSI_MAX_SG_SEGMENTS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_MAX_SG_SEGMENTS, 1,
			  [SCSI_MAX_SG_SEGMENTS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h sg_alloc_table_chained has 4 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		gfp_t gfp_mask;
		sg_alloc_table_chained(NULL, 0, gfp_mask, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ALLOC_TABLE_CHAINED_4_PARAMS, 1,
			[sg_alloc_table_chained has 4 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	 AC_MSG_CHECKING([if list_is_first is defined])
	 MLNX_BG_LB_LINUX_TRY_COMPILE([
	         #include <linux/list.h>
	 ],[
	         list_is_first(NULL, NULL);
	         return 0;
	 ],[
	         AC_MSG_RESULT(yes)
	         MLNX_AC_DEFINE(HAVE_LIST_IS_FIRST, 1,
	                   [list_is_first is defined])
	 ],[
	         AC_MSG_RESULT(no)
	 ])

	AC_MSG_CHECKING([if linux/scatterlist.h _sg_alloc_table_from_pages has 9 params])
        MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <linux/scatterlist.h>;
	],[
		struct scatterlist *sg;

		sg = __sg_alloc_table_from_pages(NULL, NULL, 0, 0,
					    0, 0, NULL, 0, GFP_KERNEL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ALLOC_TABLE_FROM_PAGES_GET_9_PARAMS, 1,
			[__sg_alloc_table_from_pages has 9 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h has sgl_free])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		sgl_free(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SGL_FREE, 1,
			[sgl_free is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h has sgl_alloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		sgl_alloc(0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SGL_ALLOC, 1,
			[sgl_alloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h has sg_zero_buffer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		sg_zero_buffer(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ZERO_BUFFER, 1,
			[sg_zero_buffer is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h has sg_append_table])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		struct sg_append_table  sgt_append;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_APPEND_TABLE, 1,
			[linux/scatterlist.h has sg_append_table])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uuid.h has uuid_gen])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uuid.h>
	],[
		uuid_t id;
		uuid_gen(&id);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UUID_GEN, 1,
			[uuid_gen is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uuid.h has uuid_is_null])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uuid.h>
	],[
		uuid_t uuid;
		uuid_is_null(&uuid);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UUID_IS_NULL, 1,
			[uuid_is_null is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uuid.h has uuid_be_to_bin])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uuid.h>
	],[
		uuid_be_to_bin(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UUID_BE_TO_BIN, 1,
			[uuid_be_to_bin is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uuid.h has uuid_equal])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uuid.h>
	],[
		uuid_equal(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UUID_EQUAL, 1,
			[uuid_equal is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/inet.h inet_pton_with_scope])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/inet.h>
	],[
		inet_pton_with_scope(NULL, 0, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INET_PTON_WITH_SCOPE, 1,
			[inet_pton_with_scope is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-resv.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-resv.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_RESV_H, 1,
			[linux/dma-resv.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-resv.h has DMA_RESV_USAGE_KERNEL])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-resv.h>
	],[
		enum dma_resv_usage usage;

		usage = DMA_RESV_USAGE_KERNEL;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_RESV_USAGE_KERNEL, 1,
			[linux/dma-resv.h has DMA_RESV_USAGE_KERNEL])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-resv.h has dma_resv_wait_timeout])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-resv.h>
	],[
		dma_resv_wait_timeout(NULL, 0, 0, 0);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_RESV_WAIT_TIMEOUT, 1,
			[linux/dma-resv.h has dma_resv_wait_timeout])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-resv.h has dma_resv_excl_fence])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-resv.h>
	],[
		dma_resv_excl_fence(NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_RESV_EXCL_FENCE, 1,
			[linux/dma-resv.h has dma_resv_excl_fence])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/nvme_ioctl.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme_ioctl.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UAPI_LINUX_NVME_IOCTL_H, 1,
			[uapi/linux/nvme_ioctl.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has QUEUE_FLAG_WC_FUA])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = QUEUE_FLAG_WC;
		int y = QUEUE_FLAG_FUA;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_QUEUE_FLAG_WC_FUA, 1,
			[QUEUE_FLAG_WC_FUA is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h sg_alloc_table_chained has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		sg_alloc_table_chained(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ALLOC_TABLE_CHAINED_3_PARAMS, 1,
			[sg_alloc_table_chained has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_tagset_busy_iter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static void
		nvme_cancel_request(struct request *req, void *data, bool reserved) {
			return;
		}
	],[
		blk_mq_tagset_busy_iter(NULL, nvme_cancel_request, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_TAGSET_BUSY_ITER, 1,
			  [blk_mq_tagset_busy_iter is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma_buf_dynamic_attach get 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-buf.h>
	],[
		dma_buf_dynamic_attach(NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_BUF_DYNAMIC_ATTACH_GET_4_PARAMS, 1,
			  [dma_buf_dynamic_attach get 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct dma_buf_attach_ops has allow_peer2peer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-buf.h>
	],[
		struct dma_buf_attach_ops x = {
			.allow_peer2peer = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_BUF_ATTACH_OPS_ALLOW_PEER2PEER, 1,
			  [struct dma_buf_attach_ops has allow_peer2peer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct request_queue has q_usage_counter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct percpu_ref counter = {0};
		struct request_queue rq = {
			.q_usage_counter = counter,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_QUEUE_Q_USAGE_COUNTER, 1,
			  [struct request_queue has q_usage_counter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has memdup_user_nul])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/string.h>
	],[
		memdup_user_nul(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MEMDUP_USER_NUL, 1,
		[memdup_user_nul is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if radix-tree.h hasradix_tree_is_internal_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/radix-tree.h>
	],[
		radix_tree_is_internal_node(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RADIX_TREE_IS_INTERNAL, 1,
		[radix_tree_is_internal_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if radix-tree.h has radix_tree_iter_delete])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/radix-tree.h>
	],[
		radix_tree_iter_delete(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RADIX_TREE_ITER_DELETE, 1,
		[radix_tree_iter_delete is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if radix-tree.h has radix_tree_iter_lookup])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/radix-tree.h>
	],[
		radix_tree_iter_lookup(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RADIX_TREE_ITER_LOOKUP, 1,
		[radix_tree_iter_lookup is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_queue_write_cache])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_write_cache(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_WRITE_CACHE, 1,
			[blkdev.h has blk_queue_write_cache])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if math64.h has mul_u32_u32])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/math64.h>
	],[
		mul_u32_u32(0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MUL_U32_U32, 1,
			[math64.h has mul_u32_u32])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_all_tag_busy_iter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static void
		nvme_cancel_request(struct request *req, void *data, bool reserved) {
			return;
		}
	],[
		blk_mq_all_tag_busy_iter(NULL, nvme_cancel_request, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_ALL_TAG_BUSY_ITER, 1,
			  [blk_mq_all_tag_busy_iter is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_update_nr_hw_queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_update_nr_hw_queues(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_UPDATE_NR_HW_QUEUES, 1,
			  [blk_mq_update_nr_hw_queues is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_map_queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_map_queues(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_MAP_QUEUES, 1,
			  [blk_mq_map_queues is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netif_napi_add get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_napi_add(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_NAPI_ADD_GET_3_PARAMS, 1,
			  [netif_napi_add get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_napi_add_weight])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_napi_add_weight(NULL, NULL, NULL ,0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_NAPI_ADD_WEIGHT, 1,
			  [netdevice.h has netif_napi_add_weight])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netif_is_rxfh_configured])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netif_is_rxfh_configured(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_RXFH_CONFIGURED, 1,
			  [netif_is_rxfh_configured is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bareudp.h has netif_is_bareudp])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/bareudp.h>
	],[
		netif_is_bareudp(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_BAREDUDP, 1,
			  [netif_is_bareudp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has enum tc_setup_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum tc_setup_type x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_TYPE, 1,
			  [TC_SETUP_TYPE is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has TC_SETUP_QDISC_MQPRIO])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum tc_setup_type x = TC_SETUP_QDISC_MQPRIO;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_QDISC_MQPRIO, 1,
			  [TC_SETUP_QDISC_MQPRIO is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has TC_SETUP_FT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		enum tc_setup_type x = TC_SETUP_FT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_FT, 1,
			  [TC_TC_SETUP_FT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if iscsit_set_unsolicited_dataout is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <target/iscsi/iscsi_transport.h>
	],[
		iscsit_set_unsolicited_dataout(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ISCSIT_SET_UNSOLICITED_DATAOUT, 1,
			  [iscsit_set_unsolicited_dataout is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mmu_notifier.h has mmu_notifier_call_srcu])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		mmu_notifier_call_srcu(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_CALL_SRCU, 1,
			  [mmu_notifier_call_srcu defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mmu_notifier.h has mmu_notifier_synchronize])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		mmu_notifier_synchronize();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_SYNCHRONIZE, 1,
			  [mmu_notifier_synchronize defined])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if mmu_notifier.h has mmu_notifier_range_blockable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
                const struct mmu_notifier_range *range;

		mmu_notifier_range_blockable(range);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_RANGE_BLOCKABLE, 1,
			  [mmu_notifier_range_blockable defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct mmu_notifier_ops has free_notifier ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		static struct mmu_notifier_ops notifiers = {
			.free_notifier = NULL,
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_OPS_HAS_FREE_NOTIFIER, 1,
			  [ struct mmu_notifier_ops has alloc/free_notifier ])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ib_umem_notifier_invalidate_range_start get struct mmu_notifier_range ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
		static int notifier(struct mmu_notifier *mn,
					const struct mmu_notifier_range *range)
		{
			return 0;
		}
	],[
		static const struct mmu_notifier_ops notifiers = {
			.invalidate_range_start = notifier
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_RANGE_STRUCT, 1,
			  [ ib_umem_notifier_invalidate_range_start get struct mmu_notifier_range ])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mmu_notifier.h has mmu_notifier_unregister_no_release])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		mmu_notifier_unregister_no_release(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_NOTIFIER_UNREGISTER_NO_RELEASE, 1,
			  [mmu_notifier_unregister_no_release defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have mmu interval notifier])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		static struct mmu_interval_notifier_ops int_notifier_ops_xx= {
			.invalidate = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MMU_INTERVAL_NOTIFIER, 1,
			  [mmu interval notifier defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct mmu_notifier_ops has invalidate_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mmu_notifier.h>
	],[
		static struct mmu_notifier_ops mmu_notifier_ops_xx= {
			.invalidate_page = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INVALIDATE_PAGE, 1,
			  [invalidate_page defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_mq_end_request accepts blk_status_t as second parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
		#include <linux/blk_types.h>
	],[
		blk_status_t error = BLK_STS_OK;

		blk_mq_end_request(NULL, error);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_END_REQUEST_TAKES_BLK_STATUS_T, 1,
			  [blk_mq_end_request accepts blk_status_t as second parameter])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if linux/blk_types.h has REQ_INTEGRITY])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_INTEGRITY;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_INTEGRITY, 1,
			[REQ_INTEGRITY is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bio.h bio_endio has 1 parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bio_endio(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_ENDIO_1_PARAM, 1,
			[linux/bio.h bio_endio has 1 parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has __blkdev_issue_discard])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		__blkdev_issue_discard(NULL, 0, 0, 0, 0, NULL);

		return 0;
	],[
	        AC_MSG_RESULT(yes)
	        MLNX_AC_DEFINE(HAVE___BLKDEV_ISSUE_DISCARD, 1,
	                [__blkdev_issue_discard is defined])
	],[
	        AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if __blkdev_issue_discard has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		__blkdev_issue_discard(NULL, 0, 0, 0, NULL);

		return 0;
	],[
	        AC_MSG_RESULT(yes)
	        MLNX_AC_DEFINE(HAVE___BLKDEV_ISSUE_DISCARD_5_PARAM, 1,
	                [__blkdev_issue_discard has 5 params])
	],[
	        AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bio.h submit_bio has 1 parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
		#include <linux/fs.h>
	],[
		submit_bio(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SUBMIT_BIO_1_PARAM, 1,
			[linux/bio.h submit_bio has 1 parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bio has member bi_iter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		struct bio b = {
			.bi_iter = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_BIO_BI_ITER, 1,
			[struct bio has member bi_iter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bio has member bi_disk])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		struct bio b = {
			.bi_disk = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_BI_DISK, 1,
			[struct bio has member bi_disk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bio has member bi_error])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		struct bio b = {
			.bi_error = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_BIO_BI_ERROR, 1,
			[struct bio has member bi_error])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct ifla_vf_stats has rx_dropped and tx_dropped])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/if_link.h>
	],[
		struct ifla_vf_stats x = {
			.rx_dropped = 0,
			.tx_dropped = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_IFLA_VF_STATS_RX_TX_DROPPED, 1,
			[struct ifla_vf_stats has memebers rx_dropped and tx_dropped])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/moduleparam.h has member param_ops_ullong])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/moduleparam.h>
	],[
		param_get_ullong(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PARAM_OPS_ULLONG, 1,
			[param_ops_ullong is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if fs.h has stream_open])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		stream_open(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STREAM_OPEN, 1,
			[fs.h has stream_open])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if linux/fs.h has struct kiocb definition])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		struct kiocb x = {
			.ki_flags = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FS_HAS_KIOCB, 1,
			[struct kiocb is defined in linux/fs.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has struct bio_aux])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/errno.h>
		#include <linux/blk_types.h>
	],[
		struct bio_aux x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RH7_STRUCT_BIO_AUX, 1,
			[struct bio_aux is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci.h has pci_irq_vector, pci_free_irq_vectors, pci_alloc_irq_vectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_irq_vector(NULL, 0);
		pci_free_irq_vectors(NULL);
		pci_alloc_irq_vectors(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_IRQ_API, 1,
			[linux/pci.h has pci_irq_vector, pci_free_irq_vectors, pci_alloc_irq_vectors])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h struct pci_error_handlers has reset_prepare])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>

		void reset_prepare(struct pci_dev *dev) {
			return;
		}
	],[
		struct pci_error_handlers x = {
			.reset_prepare = reset_prepare,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_ERROR_HANDLERS_RESET_PREPARE, 1,
			[pci.h struct pci_error_handlers has reset_prepare])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h struct pci_error_handlers has reset_done])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>

		void reset_done(struct pci_dev *dev) {
			return;
		}
	],[
		struct pci_error_handlers x = {
			.reset_done = reset_done,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_ERROR_HANDLERS_RESET_DONE, 1,
		[pci.h struct pci_error_handlers has reset_done])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/io-64-nonatomic-lo-hi.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io-64-nonatomic-lo-hi.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_64_NONATOMIC_LO_HI_H, 1,
			[linux/io-64-nonatomic-lo-hi.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_request_mem_regions])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_request_mem_regions(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_REQUEST_MEM_REGIONS, 1,
			[pci_request_mem_regions is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_release_mem_regions])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_release_mem_regions(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_RELEASE_MEM_REGIONS, 1,
			[pci_release_mem_regions is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h pcie_get_minimum_link])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_get_minimum_link(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCIE_GET_MINIMUM_LINK, 1,
			[pcie_get_minimum_link is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h pcie_print_link_status])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_print_link_status(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCIE_PRINT_LINK_STATUS, 1,
			[pcie_print_link_status is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pnv-pci.h has pnv_pci_set_p2p])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <asm/pnv-pci.h>
	],[
		pnv_pci_set_p2p(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PNV_PCI_SET_P2P, 1,
			[pnv-pci.h has pnv_pci_set_p2p])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct timerqueue_head has struct rb_root_cached])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rbtree.h>
		#include <linux/timerqueue.h>
	],[
		struct timerqueue_head *head;
		struct rb_node *leftmost = rb_first_cached(&head->rb_root);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TIMERQUEUE_HEAD_RB_ROOT_CACHED, 1,
			[struct timerqueue_head has struct rb_root_cached])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rbtree.h has struct rb_root_cached])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rbtree.h>
	],[
		struct rb_root_cached rb_root_cached_test;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RB_ROOT_CACHED, 1,
			[struct rb_root_cached is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([interval_tree_insert],
		[lib/interval_tree.c],
		[AC_DEFINE(HAVE_INTERVAL_TREE_EXPORTED, 1,
			[interval_tree functions exported by the kernel])],
	[])

	AC_MSG_CHECKING([if INTERVAL_TREE takes rb_root])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rbtree.h>
		#include <linux/interval_tree_generic.h>

		struct x_node {
			u64 __subtree_last;
			struct rb_node rb;
		};
		static u64 node_last(struct x_node *n)
		{
			return 0;
		}
		static u64 node_start(struct x_node *n)
		{
			return 0;
		}
		INTERVAL_TREE_DEFINE(struct x_node, rb, u64, __subtree_last,
			node_start, node_last, static, rbt_x)
	],[
		struct x_node x_interval_tree;
		struct rb_root x_tree;
		rbt_x_insert(&x_interval_tree, &x_tree);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INTERVAL_TREE_TAKES_RB_ROOT, 1,
			[INTERVAL_TREE takes rb_root])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if timer.h has timer_setup])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/timer.h>

		static void activate_timeout_handler_task(struct timer_list *t)
		{
			return;
		}
	],[
		struct timer_list tmr;
		timer_setup(&tmr, activate_timeout_handler_task, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TIMER_SETUP, 1,
			[timer_setup is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dmapool.h has dma_pool_zalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dmapool.h>
	],[
		dma_pool_zalloc(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_POOL_ZALLOC, 1,
			  [dma_pool_zalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if act_apt.h tc_setup_cb_egdev_register])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tc_setup_cb_egdev_register(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SETUP_CB_EGDEV_REGISTER, 1,
			  [tc_setup_cb_egdev_register is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if act_api.h has tcf_action_stats_update])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tcf_action_stats_update(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_ACTION_STATS_UPDATE, 1,
			  [tc_action_stats_update is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if act_api.h has tcf_action_stats_update with 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/act_api.h>
	],[
		tcf_action_stats_update(NULL, 0, 0, 0, true);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCF_ACTION_STATS_UPDATE_5_PARAMS, 1,
			  [tc_action_stats_update is defined and has 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/once.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/once.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ONCE_H, 1,
			  [include/linux/once.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has blk_path_error])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/errno.h>
		#include <linux/blkdev.h>
		#include <linux/blk_types.h>
	],[
		blk_path_error(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_PATH_ERROR, 1,
			  [blk_path_error is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if slab.h has kcalloc_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/slab.h>
	],[
		kcalloc_node(0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KCALLOC_NODE, 1,
			  [kcalloc_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if slab.h has kmalloc_array_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/slab.h>
	],[
		kmalloc_array_node(0, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KMALLOC_ARRAY_NODE, 1,
			  [kmalloc_array_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kref.h has kref_read])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/kref.h>
	],[
		kref_read(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KREF_READ, 1,
			  [kref_read is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/inet.h has inet_addr_is_any])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/inet.h>
	],[
		inet_addr_is_any(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INET_ADDR_IS_ANY, 1,
			[inet_addr_is_any is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_write_zeroes_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_write_zeroes_sectors(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_WRITE_ZEROES_SECTORS, 1,
			  [bdev_write_zeroes_sectors is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has blk_queue_flag_set])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_flag_set(0, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_FLAG_SET, 1,
				[blk_queue_flag_set is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uio.h has iov_iter_is_bvec])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uio.h>
	],[
		struct iov_iter i;

		iov_iter_is_bvec(&i);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IOV_ITER_IS_BVEC_SET, 1,
				[iov_iter_is_bvec is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/blk-mq-pci.h has blk_mq_pci_map_queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq-pci.h>
	],[
		blk_mq_pci_map_queues(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_PCI_MAP_QUEUES_3_ARGS, 1,
			[blk_mq_pci_map_queues is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_master_upper_dev_link gets 5 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_master_upper_dev_link(NULL, NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_MASTER_UPPER_DEV_LINK_5_PARAMS, 1,
			[netdev_master_upper_dev_link gets 5 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if BLK_EH_DONE exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		int x = BLK_EH_DONE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EH_DONE, 1,
				[BLK_EH_DONE is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has netdev_reg_state])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		netdev_reg_state(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_REG_STATE, 1,
			  [netdev_reg_state is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xfrmdev_ops has member xdo_dev_state_add get extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		static int my_xdo_dev_state_add(struct xfrm_state *x,
						struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct xfrmdev_ops x = {
			.xdo_dev_state_add = my_xdo_dev_state_add,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDO_XFRM_ADD_STATE_GET_EXTACK, 1,
			  [struct xfrmdev_ops has member xdo_dev_state_add get extack])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xfrmdev_ops has member xdo_dev_policy_add get extack])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>

		static int my_xdo_policy_add(struct xfrm_policy *x,
						struct netlink_ext_ack *extack)
		{
			return 0;
		}
	],[
		struct xfrmdev_ops x = {
			.xdo_dev_policy_add = my_xdo_policy_add,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDO_DEV_POLICY_ADD_GET_EXTACK, 1,
			  [struct xfrmdev_ops has member xdo_dev_policy_add get extack])
	],[
		AC_MSG_RESULT(no)
	])
	AC_MSG_CHECKING([if struct xfrmdev_ops has member xdo_dev_state_advance_esn])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct xfrmdev_ops x = {
			.xdo_dev_state_advance_esn = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDO_DEV_STATE_ADVANCE_ESN, 1,
			  [struct xfrmdev_ops has member xdo_dev_state_advance_esn])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xfrmdev_ops has member xdo_dev_policy_add])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct xfrmdev_ops x = {
			.xdo_dev_policy_add = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDO_DEV_POLICY_ADD, 1,
			  [struct xfrmdev_ops has member xdo_dev_policy_add ])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xfrmdev_ops has member xdo_dev_state_update_curlft])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		struct xfrmdev_ops x = {
			.xdo_dev_state_update_curlft = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDO_DEV_STATE_UPDATE_CURLFT, 1,
			  [struct xfrmdev_ops has member xdo_dev_state_update_curlft ])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if interrupt.h has irq_calc_affinity_vectors with 3 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/interrupt.h>
	],[
		int x = irq_calc_affinity_vectors(0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_CALC_AFFINITY_VECTORS_3_ARGS, 1,
			  [irq_calc_affinity_vectors is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if interrupt.h has irq_set_affinity_and_hint])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/interrupt.h>
	],[
		int x = irq_set_affinity_and_hint(0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_UPDATE_AFFINITY_HINT, 1,
			  [irq_set_affinity_and_hint is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/overflow.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/overflow.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_OVERFLOW_H, 1,
			  [linux/overflow.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/overflow.h has size_add size_mul size_sub])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/overflow.h>
	],[
		size_t a = 5;
		size_t b = 6;

		if ( size_add(a,b) && size_mul(a,b) && size_sub(a,b) )
			return 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SIZE_MUL_SUB_ADD, 1,
			  [linux/overflow.h has size_add size_mul size_sub])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/rtnetlink.h has net_rwsem])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rtnetlink.h>
	],[
		down_read(&net_rwsem);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RTNETLINK_NET_RWSEM, 1,
			  [linux/rtnetlink.h has net_rwsem])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/net/ip6_route.h rt6_lookup takes 6 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ip6_route.h>
	],[
		rt6_lookup(NULL, NULL, NULL, 0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RT6_LOOKUP_TAKES_6_PARAMS, 1,
			  [rt6_lookup takes 6 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if type __poll_t is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/types.h>
	],[
		__poll_t x = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TYPE___POLL_T, 1,
			  [type __poll_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if type rcu_callback_t is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/types.h>
	],[
		rcu_callback_t x = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TYPE_RCU_CALLBACK_T, 1,
			  [type rcu_callback_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function kvfree_call_rcu is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rcupdate.h>
	],[
		kvfree_call_rcu(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KVFREE_CALL_RCU, 1,
			  [function kvfree_call_rcu is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function kfree_rcu_mightsleep is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rcupdate.h>
	],[
		kfree_rcu_mightsleep(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KFREE_RCU_MIGHTSLEEP, 1,
			  [function kfree_rcu_mightsleep is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_init_buff])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_init_buff(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_INIT_BUFF, 1,
			  [net/xdp.h has xdp_init_buff])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has struct xdp_rxq_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_rxq_info *rxq;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_RXQ_INFO_IN_NET_XDP, 1,
			  [net/xdp.h has struct xdp_rxq_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has struct xdp_rxq_info WA for 5.4.17-2011.1.2.el8uek.x86_64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uek_kabi.h>
		#include <net/xdp.h>

	],[
		struct xdp_rxq_info *rxq;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_RXQ_INFO_IN_UEK_KABI, 1,
			[net/xdp.h has struct xdp_rxq_info WA for 5.4.17-2011.1.2.el8uek.x86_64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has __xdp_rxq_info_reg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		__xdp_rxq_info_reg(NULL, NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UNDERSCORE_XDP_RXQ_INFO_REG, 1,
			  [net/xdp.h has __xdp_rxq_info_reg])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_rxq_info_reg get 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_rxq_info_reg(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_RXQ_INFO_REG_4_PARAMS, 1,
			  [net/xdp.h has xdp_rxq_info_reg get 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h struct xdp_frame_bulk exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_frame_bulk x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_FRAME_BULK, 1,
			  [net/xdp.h struct xdp_frame_bulk exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdp_buff has data_meta as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff x;
		x.data_meta = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_HAS_DATA_META, 1,
			  [xdp_buff has daya_meta as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdp_buff has flags as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff x;
		x.flags = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_HAS_FLAGS, 1,
			  [xdp_buff has flags as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdp_buff has frame_sz as member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff x;
		x.frame_sz = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_HAS_FRAME_SZ, 1,
			  [xdp_buff has frame_sz as member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h struct xdp_buff exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		struct xdp_buff x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_H_HAVE_XDP_BUFF, 1,
			  [net/xdp.h struct xdp_buff exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/filter.h struct xdp_buff exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/filter.h>
	],[
		struct xdp_buff x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_BUFF_ON_FILTER, 1,
			  [linux/filter.h struct xdp_buff exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_convert_buff_to_frame])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_convert_buff_to_frame(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_CONVERT_BUFF_TO_FRAME, 1,
			  [net/xdp.h has xdp_convert_buff_to_frame])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_XDP_HEADER, 1,
			  [net/xdp.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h exists workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uek_kabi.h>
		#include <net/xdp.h>

	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_XDP_HEADER_UEK_KABI, 1,
			[net/xdp.h is defined workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has convert_to_xdp_frame])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		convert_to_xdp_frame(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_CONVERT_TO_XDP_FRAME_IN_NET_XDP, 1,
			  [net/xdp.h has convert_to_xdp_frame])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has convert_to_xdp_frame workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uek_kabi.h>
		#include <net/xdp.h>
	],[
		convert_to_xdp_frame(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_CONVERT_TO_XDP_FRAME_IN_UEK_KABI, 1,
			[net/xdp.h has convert_to_xdp_frame workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_rxq_info_reg_mem_model])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp.h>
	],[
		xdp_rxq_info_reg_mem_model(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_RXQ_INFO_REG_MEM_MODEL_IN_NET_XDP, 1,
			  [net/xdp.h has xdp_rxq_info_reg_mem_model])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp.h has xdp_rxq_info_reg_mem_model workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uek_kabi.h>
		#include <net/xdp.h>
	],[
		xdp_rxq_info_reg_mem_model(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_RXQ_INFO_REG_MEM_MODEL_IN_UEK_KABI, 1,
			[net/xdp.h has xdp_rxq_info_reg_mem_model workaround for 5.4.17-2011.1.2.el8uek.x86_64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct vdpa_config_ops has get_vq_dma_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vdpa.h>
	],[
		struct vdpa_config_ops vdpa_ops = {
			.get_vq_dma_dev = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VDPA_CONFIG_OPS_GET_VQ_DMA_DEV, 1,
			  [struct vdpa_config_ops has get_vq_dma_dev defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if vdpa_dev_set_config has device_features])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vdpa.h>
	],[
		struct vdpa_dev_set_config x;
		x.device_features = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VDPA_SET_CONFIG_HAS_DEVICE_FEATURES, 1,
			  [sturct vdpa_dev_set_config has device_features])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has sturct vfio_precopy_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vfio.h>
	],[
		struct vfio_precopy_info info = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VFIO_PRECOPY_INFO, 1,
			  [sturct vfio_precopy_info exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if has vfio_pci_core_init_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vfio_pci_core.h>
	],[
		vfio_pci_core_init_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VFIO_PCI_CORE_INIT, 1,
			  [vfio_pci_core_init_dev exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/vfio_pci_core.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vfio_pci_core.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VFIO_PCI_CORE_H, 1,
			  [linux/vfio_pci_core.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/gro.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/gro.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_GRO_H, 1,
			  [net/gro.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool.h page_pool_get_dma_addr defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool.h>
	],[
		page_pool_get_dma_addr(NULL);
		page_pool_set_dma_addr(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POOL_GET_DMA_ADDR_OLD, 1,
			  [net/page_pool.h page_pool_get_dma_addr defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool/helpers.h page_pool_get_dma_addr defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool/helpers.h>
	],[
		page_pool_get_dma_addr(NULL);
		page_pool_set_dma_addr(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POOL_GET_DMA_ADDR_HELPER, 1,
			  [net/page_pool.h page_pool_get_dma_addr defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/nexthop.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/nexthop.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_NEXTHOP_H, 1,
			  [net/nexthop.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_PAGE_POOL_OLD_H, 1,
			  [net/page_pool.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool/types.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool/types.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_PAGE_POOL_TYPES_H, 1,
			  [net/page_pool/types.h is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool.h has page_pool_release_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool.h>
	],[
		page_pool_release_page(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POOL_RELEASE_PAGE_IN_PAGE_POOL_H, 1,
			  [net/page_pool.h has page_pool_release_page])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if net/page_pool/types.h has page_pool_release_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool/types.h>
	],[
		page_pool_release_page(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POOL_RELEASE_PAGE_IN_TYPES_H, 1,
			  [net/page_pool/types.h has page_pool_release_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool/types.h has page_pool_put_defragged_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool/types.h>
	],[
		page_pool_put_defragged_page(NULL, NULL, 0, false);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POOL_DEFRAG_PAGE, 1,
			  [net/page_pool/types.h has page_pool_put_defragged_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool.h has page_pool_nid_changed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool.h>
	],[
		page_pool_nid_changed(NULL,0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POLL_NID_CHANGED_OLD, 1,
			  [net/page_pool.h has page_pool_nid_changed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/page_pool/helpers.h has page_pool_nid_changed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/page_pool/helpers.h>
	],[
		page_pool_nid_changed(NULL,0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_POLL_NID_CHANGED_HELPERS, 1,
			  [net/page_pool/helpers.h has page_pool_nid_changed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_TLS_H, 1,
			  [net/tls.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/tls.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/tls.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UAPI_LINUX_TLS_H, 1,
			  [uapi/linux/tls.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h has tls_driver_ctx])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		tls_driver_ctx(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_DRIVER_CTX, 1,
			  [net/tls.h has tls_driver_ctx])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h has tls_offload_rx_force_resync_request])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		tls_offload_rx_force_resync_request(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_OFFLOAD_RX_FORCE_RESYNC_REQUEST, 1,
			  [net/tls.h has tls_offload_rx_force_resync_request])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/tls.h has tls_offload_rx_resync_async_request_start])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/tls.h>
	],[
		tls_offload_rx_resync_async_request_start(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TLS_OFFLOAD_RX_RESYNC_ASYNC_REQUEST_START, 1,
			  [net/tls.h has tls_offload_rx_resync_async_request_start])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([idr_preload],
		[lib/radix-tree.c],
		[AC_DEFINE(HAVE_IDR_PRELOAD_EXPORTED, 1,
			[idr_preload is exported by the kernel])],
	[])

	LB_CHECK_SYMBOL_EXPORT([radix_tree_iter_delete],
		[lib/radix-tree.c],
		[AC_DEFINE(HAVE_RADIX_TREE_ITER_DELETE_EXPORTED, 1,
			[radix_tree_iter_delete is exported by the kernel])],
	[])
	LB_CHECK_SYMBOL_EXPORT([kobj_ns_grab_current],
		[lib/kobject.c],
		[AC_DEFINE(HAVE_KOBJ_NS_GRAB_CURRENT_EXPORTED, 1,
			[kobj_ns_grab_current is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if linux/blk_types.h has REQ_DRV])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_DRV;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_DRV, 1,
			  [REQ_DRV is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_alloc_queue_node has 3 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_alloc_queue_node(0, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_ALLOC_QUEUE_NODE_3_ARGS, 1,
				[blk_alloc_queue_node has 3 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have blk_queue_make_request])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_make_request(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_MAKE_REQUEST, 1,
				[blk_queue_make_request existing])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have put_unaligned_le24])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/unaligned/generic.h>
	],[
		put_unaligned_le24(0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PUT_UNALIGNED_LE24, 1,
				[put_unaligned_le24 existing])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for include/linux/part_stat.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/part_stat.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PART_STAT_H, 1, [part_stat.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pci_enable_atomic_ops_to_root])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pci_enable_atomic_ops_to_root(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_ENABLE_ATOMIC_OPS_TO_ROOT, 1,
		[pci_enable_atomic_ops_to_root is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has kstrtobool])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/string.h>
	],[
		char s[] = "test";
		bool res;
		int rc;

		rc = kstrtobool(s, &res);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KSTRTOBOOL, 1,
		[kstrtobool is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has poll])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_ops ops = {
			.poll = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_POLL, 1,
			  [struct blk_mq_ops has poll])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdev_bpf struct has pool member])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
		#include <net/xsk_buff_pool.h>
	],[
		struct xsk_buff_pool *x;
		struct netdev_bpf *xdp;

		xdp->xsk.pool = x;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETDEV_BPF_XSK_BUFF_POOL, 1,
			  [netdev_bpf struct has pool member])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if select_queue_fallback_t has third parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		extern select_queue_fallback_t fallback;
                fallback(NULL, NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SELECT_QUEUE_FALLBACK_T_3_PARAMS, 1,
			  [select_queue_fallback_t has third parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if t10_pi_ref_tag() exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_cmnd.h>
	],[
		t10_pi_ref_tag(NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_T10_PI_REF_TAG, 1,
			  [t10_pi_ref_tag() exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has QUEUE_FLAG_PCI_P2PDMA])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = QUEUE_FLAG_PCI_P2PDMA;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_QUEUE_FLAG_PCI_P2PDMA, 1,
			[QUEUE_FLAG_PCI_P2PDMA is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if memremap.h has is_pci_p2pdma_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/memremap.h>
	],[
		is_pci_p2pdma_page(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_PCI_P2PDMA_PAGE_IN_MEMREMAP_H, 1,
			[is_pci_p2pdma_page is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has gup_must_unshare get 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		gup_must_unshare(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MM_GUP_MUST_UNSHARE_GET_3_PARAMS, 1,
			[mm.h has gup_must_unshare get 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has assert_fault_locked])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		assert_fault_locked(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ASSERT_FAULT_LOCKED, 1,
			[mm.h has assert_fault_locked])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has is_pci_p2pdma_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		is_pci_p2pdma_page(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IS_PCI_P2PDMA_PAGE_IN_MM_H, 1,
			[is_pci_p2pdma_page is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if mm.h has release_pages])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm.h>
	],[
		release_pages(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RELEASE_PAGES_IN_MM_H, 1,
			[mm.h has release_pages])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([if t10-pi.h has t10_pi_prepare])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/t10-pi.h>
	],[
		t10_pi_prepare(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_T10_PI_PREPARE, 1,
			[t10_pi_prepare is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct request_queue has integrity])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct request_queue rq = {
			.integrity = {0},
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_QUEUE_INTEGRITY, 1,
			  [struct request_queue has integrity])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bio.h has bip_get_seed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bip_get_seed(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_BIP_GET_SEED, 1,
			[linux/bio.h has bip_get_seed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if t10-pi.h has enum t10_dif_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/t10-pi.h>
	],[
		enum t10_dif_type x = T10_PI_TYPE0_PROTECTION;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_T10_DIF_TYPE, 1,
			  [enum t10_dif_type is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_integrity has sector_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct blk_integrity bi = {
			.sector_size = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_INTEGRITY_SECTOR_SIZE, 1,
			  [struct blk_integrity has sector_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if need expose current_link_speed/width in sysfs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device.h>
		#include <linux/pci_regs.h>
	],[
		struct kobject kobj = {};
		struct device *dev = kobj_to_dev(&kobj);
		/* https://patchwork.kernel.org/patch/9759133/
		 * patch exposing link stats also introduce this const */
		#ifdef PCI_EXP_LNKCAP_SLS_8_0GB
		#error no need
		#endif

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NO_LINKSTA_SYSFS, 1,
			  [current_link_speed/width not exposed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/pkt_cls.h has TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/pkt_cls.h>
	],[
		int x = TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT, 1,
				[TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/pkt_cls.h has TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/pkt_cls.h>
	],[
		int x = TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST, 1,
				[TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if TCA_TUNNEL_KEY_ENC_TOS exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	        #include <uapi/linux/tc_act/tc_tunnel_key.h>
	],[
	        int x = TCA_TUNNEL_KEY_ENC_TOS;

	        return 0;
	],[
	        AC_MSG_RESULT(yes)
	        MLNX_AC_DEFINE(HAVE_TCA_TUNNEL_KEY_ENC_TOS, 1,
	                        [TCA_TUNNEL_KEY_ENC_TOS is defined])
	],[
	        AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if TCA_TUNNEL_KEY_ENC_DST_PORT exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	        #include <uapi/linux/tc_act/tc_tunnel_key.h>
	],[
	        int x = TCA_TUNNEL_KEY_ENC_DST_PORT;

	        return 0;
	],[
	        AC_MSG_RESULT(yes)
	        MLNX_AC_DEFINE(HAVE_TCA_TUNNEL_KEY_ENC_DST_PORT, 1,
	                        [TCA_TUNNEL_KEY_ENC_DST_PORT is defined])
	],[
	        AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has struct blk_mq_queue_map])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_queue_map x = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_QUEUE_MAP, 1,
			  [linux/blk-mq.h has struct blk_mq_queue_map])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has busy_tag_iter_fn return bool with 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static bool
		nvme_cancel_request(struct request *req, void *data) {
			return true;
		}
	],[
		busy_tag_iter_fn *fn = nvme_cancel_request;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_BUSY_TAG_ITER_FN_BOOL_2_PARAMS, 1,
			  [linux/blk-mq.h has busy_tag_iter_fn return bool])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has busy_tag_iter_fn return bool with 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static bool
		nvme_cancel_request(struct request *req, void *data, bool reserved) {
			return true;
		}
	],[
		busy_tag_iter_fn *fn = nvme_cancel_request;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_BUSY_TAG_ITER_FN_BOOL_3_PARAMS, 1,
			  [linux/blk-mq.h has busy_tag_iter_fn return bool])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has poll 1 arg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static int nvme_poll(struct blk_mq_hw_ctx *hctx) {
			return 0;
		}
	],[
		struct blk_mq_ops ops = {
			.poll = nvme_poll,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_POLL_1_ARG, 1,
			  [struct blk_mq_ops has poll 1 arg])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct Qdisc_ops has ingress_block_set net/sch_generic.h ])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sch_generic.h>
	],[
		struct Qdisc_ops ops = {
			.ingress_block_set = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_QDISC_SUPPORTS_BLOCK_SHARING, 1,
			  [struct Qdisc_ops has ingress_block_set])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uuid.h has guid_parse])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/uuid.h>
	],[
		char *str;
		guid_t uuid;
		int ret;

		ret = guid_parse(str, &uuid);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GUID_PARSE, 1,
		[guid_parse is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bitmap.h bitmap_zalloc_node])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/bitmap.h>
	],[
		unsigned long *bmap;

		bmap = bitmap_zalloc_node(1, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITMAP_ZALLOC_NODE, 1,
		[bitmap_zalloc_node is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bitmap.h has bitmap_kzalloc])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/bitmap.h>
	],[
		unsigned long *bmap;

		bmap = bitmap_zalloc(1, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITMAP_KZALLOC, 1,
		[bitmap_kzalloc is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bitmap.h has bitmap_free])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bitmap.h>
		#include <linux/slab.h>
	],[
		unsigned long *bmap;

		bmap = kcalloc(BITS_TO_LONGS(1), sizeof(unsigned long), 0);
		bitmap_free(bmap);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITMAP_FREE, 1,
		[bitmap_free is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bitmap.h has bitmap_from_arr32])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bitmap.h>
		#include <linux/slab.h>
	],[
		unsigned long *bmap;
		u32 *word;

		bmap = kcalloc(BITS_TO_LONGS(1), sizeof(unsigned long), 0);
		bitmap_from_arr32(bmap, word, 1);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BITMAP_FROM_ARR32, 1,
		[bitmap_from_arr32 is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has dma_map_sgtable])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		int i = dma_map_sgtable(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_MAP_SGTABLE, 1,
			[dma-mapping.h has dma_map_sgtable])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if tc_htb_command has moved_qid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct tc_htb_qopt_offload *x;
		x->moved_qid = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_HTB_COMMAND_HAS_MOVED_QID, 1,
			  [struct tc_htb_command has moved_qid])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if built in flower supports multi mask per prio])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/pkt_cls.h>
	],[
		struct rcu_work *rwork;
		work_func_t func;

		tcf_queue_work(rwork, func);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOWER_MULTI_MASK, 1,
			  [tcf_queue_work has 2 params per prio])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has enum hctx_type])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		enum hctx_type type = HCTX_TYPE_DEFAULT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_HCTX_TYPE, 1,
			[blk-mq.h has enum hctx_type])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has blk_mq_complete_request_sync])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_complete_request_sync(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_COMPLETE_REQUEST_SYNC, 1,
			[blk-mq.h has blk_mq_complete_request_sync])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if scsi/scsi_transport_fc.h has FC_PORT_ROLE_NVME_TARGET])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <scsi/scsi_transport_fc.h>
	],[
		int x = FC_PORT_ROLE_NVME_TARGET;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SCSI_TRANSPORT_FC_FC_PORT_ROLE_NVME_TARGET, 1,
			[scsi/scsi_transport_fc.h has FC_PORT_ROLE_NVME_TARGET])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has REQ_HIPRI])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_HIPRI;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_HIPRI, 1,
			  [REQ_HIPRI is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has commit_rqs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_ops ops = {
			.commit_rqs = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_COMMIT_RQS, 1,
			  [struct blk_mq_ops has commit_rqs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct irq_affinity has priv])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/interrupt.h>
	],[
		struct irq_affinity affd = {
			.priv = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IRQ_AFFINITY_PRIV, 1,
			  [struct irq_affinity has priv])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if interrupt.h has tasklet_setup])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/interrupt.h>
	],[
		tasklet_setup(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TASKLET_SETUP, 1,
			  [interrupt.h has tasklet_setup])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if fs.h has IOCB_NOWAIT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		int x = IOCB_NOWAIT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IOCB_NOWAIT, 1,
			[fs.h has IOCB_NOWAIT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if fs.h has FMODE_NOWAIT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		int x = FMODE_NOWAIT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FMODE_NOWAIT, 1,
			[fs.h has FMODE_NOWAIT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-attrs.h has struct dma_attrs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-attrs.h>
	],[
		struct dma_attrs attr = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_ATTRS, 1,
			[dma-attrs.h has struct dma_attrs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_delay_kick_requeue_list])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_delay_kick_requeue_list(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_DELAY_KICK_REQUEUE_LIST, 1,
			  [blk_mq_delay_kick_requeue_list is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has op_is_write])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		op_is_write(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_OP_IS_WRITE, 1,
			  [op_is_write is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma_map_bvec exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/dma-mapping.h>
	],[
		struct bio_vec bv = {};

		dma_map_bvec(NULL, &bv, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_DMA_MAP_BVEC, 1,
				[dma_map_bvec exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_indr_block_cb_alloc exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		flow_indr_block_cb_alloc(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_INDR_BLOCK_CB_ALLOC, 1,
				[flow_indr_block_cb_alloc exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_block_cb exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_block_cb a;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_BLOCK_CB, 1,
				[struct flow_block_cb exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/scatterlist.h sg_alloc_table_chained has nents_first_chunk parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		sg_alloc_table_chained(NULL, 0, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ALLOC_TABLE_CHAINED_NENTS_FIRST_CHUNK_PARAM, 1,
			[sg_alloc_table_chained has nents_first_chunk parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has request_to_qc_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		request_to_qc_t(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_TO_QC_T, 1,
			  [linux/blk-mq.h has request_to_qc_t])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_request_completed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_request_completed(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_REQUEST_COMPLETED, 1,
			  [linux/blk-mq.h has blk_mq_request_completed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has enum mq_rq_state])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		enum mq_rq_state state = MQ_RQ_COMPLETE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MQ_RQ_STATE, 1,
			  [mq_rq_state is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_tagset_wait_completed_request])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_tagset_wait_completed_request(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_TAGSET_WAIT_COMPLETED_REQUEST, 1,
			  [linux/blk-mq.h has blk_mq_tagset_wait_completed_request])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/net.h has kernel_getsockname 2 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
	],[
		kernel_getsockname(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KERNEL_GETSOCKNAME_2_PARAMS, 1,
			  [linux/net.h has kernel_getsockname 2 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if *xpo_secure_port returns void])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>

		void secure_port(struct svc_rqst *rqstp)
		{
			return;
		}
	],[
		struct svc_xprt_ops check_rdma_ops;

		check_rdma_ops.xpo_secure_port = secure_port;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPO_SECURE_PORT_NO_RETURN, 1,
			[xpo_secure_port is defined and returns void])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_fill_write_vector getting 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc.h>
	],[
		return svc_fill_write_vector(NULL, NULL, NULL, 0);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_FILL_WRITE_VECTOR_4_PARAMS, 1,
			[svc_fill_write_vector getting 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_fill_write_vector getting 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc.h>
	],[
		return svc_fill_write_vector(NULL, NULL, 0);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_FILL_WRITE_VECTOR_3_PARAMS, 1,
			[svc_fill_write_vector getting 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_fill_write_vector getting 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc.h>
	],[
		return svc_fill_write_vector(NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_FILL_WRITE_VECTOR_2_PARAMS, 1,
			[svc_fill_write_vector getting 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct svc_rqst has rq_xprt_hlen])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc.h>
	],[
		struct svc_rqst rqst;

		rqst.rq_xprt_hlen = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_RQST_RQ_XPRT_HLEN, 1,
			[struct svc_rqst has rq_xprt_hlen])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct svc_serv has sv_cb_list])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc.h>
	],[
		struct svc_serv serv;
		struct lwq      list;

		serv.sv_cb_list = list;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_SERV_SV_CB_LIST_LWQ, 1,
			[struct svc_serv has sv_cb_list])
	],[
		MLNX_BG_LB_LINUX_TRY_COMPILE([
			#include <linux/sunrpc/svc.h>
		],[
			struct svc_serv serv;
			struct list_head list;

			serv.sv_cb_list = list;

			return 0;
		],[
			AC_MSG_RESULT(yes)
			MLNX_AC_DEFINE(HAVE_SVC_SERV_SV_CB_LIST_LIST_HEAD, 1,
				[struct svc_serv has sv_cb_list])
		],[
			AC_MSG_RESULT(no)
		])
	])

	LB_CHECK_SYMBOL_EXPORT([svc_pool_wake_idle_thread],
		[net/sunrpc/svc.c],
		[AC_DEFINE(HAVE_SVC_POOL_WAKE_IDLE_THREAD, 1,
			[svc_pool_wake_idle_thread is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if *send_request has 'struct rpc_rqst *req' as a param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>

		int send_request(struct rpc_rqst *req)
		{
			return 0;
		}
	],[
		struct rpc_xprt_ops ops;

		ops.send_request = send_request;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPRT_OPS_SEND_REQUEST_RQST_ARG, 1,
			[*send_request has 'struct rpc_rqst *req' as a param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for rpc_reply_expected])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/clnt.h>
	],[
		return rpc_reply_expected(NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_REPLY_EXPECTED, 1, [rpc reply expected])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for xprt_request_get_cong])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		return xprt_request_get_cong(NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPRT_REQUEST_GET_CONG, 1, [get cong request])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpt_remotebuf" inside "struct svc_xprt"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt dummy_xprt;

		dummy_xprt.xpt_remotebuf[0] = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_XPRT_XPT_REMOTEBUF, 1,
			[struct svc_xprt has 'xpt_remotebuf' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpo_secure_port" inside "struct svc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_ops dummy_svc_ops;

		dummy_svc_ops.xpo_secure_port = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_XPRT_XPO_SECURE_PORT, 1,
			[struct svc_xprt_ops 'xpo_secure_port' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpo_prep_reply_hdr" inside "struct svc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_ops dummy_svc_ops;

		dummy_svc_ops.xpo_prep_reply_hdr = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_XPRT_XPO_PREP_REPLY_HDR, 1,
			[struct svc_xprt_ops 'xpo_prep_reply_hdr' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpo_read_payload" inside "struct svc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_ops dummy_svc_ops;

		dummy_svc_ops.xpo_read_payload = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPO_READ_PAYLOAD, 1,
			[struct svc_xprt_ops has 'xpo_read_payload' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpo_result_payload" inside "struct svc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_ops dummy_svc_ops;

		dummy_svc_ops.xpo_result_payload = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPO_RESULT_PAYLOAD, 1,
			[struct svc_xprt_ops has 'xpo_result_payload' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "xpo_release_ctxt" inside "struct svc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		struct svc_xprt_ops dummy_svc_ops;

		dummy_svc_ops.xpo_release_ctxt = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPO_RELEASE_CTXT, 1,
			[struct svc_xprt_ops has 'xpo_release_ctxt' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "free_slot" inside "struct rpc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt_ops dummy_ops;

		dummy_ops.free_slot = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_FREE_SLOT, 1,
			[struct rpc_xprt_ops has 'free_slot' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "set_retrans_timeout" inside "struct rpc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt_ops dummy_ops;

		dummy_ops.set_retrans_timeout = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_SET_RETRANS_TIMEOUT, 1,
			[struct rpc_xprt_ops has 'set_retrans_timeout' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "wait_for_reply_request" inside "struct rpc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt_ops dummy_ops;

		dummy_ops.wait_for_reply_request = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_WAIT_FOR_REPLY_REQUEST, 1,
			[struct rpc_xprt_ops has 'wait_for_reply_request' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "queue_lock" inside "struct rpc_xprt"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		spinlock_t *dummy_lock;
		struct rpc_xprt dummy_xprt;

		dummy_lock = &dummy_xprt.queue_lock;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPRT_QUEUE_LOCK, 1,
			[struct rpc_xprt has 'queue_lock' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if 'struct rpc_xprt_ops *ops' field is const inside 'struct rpc_xprt'])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		const struct rpc_xprt_ops ops = {0};
		struct rpc_xprt xprt;
		const struct rpc_xprt_ops *ptr = &ops;

		xprt.ops = ptr;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_CONST, 1,
			  [struct rpc_xprt_ops *ops' field is const inside 'struct rpc_xprt'])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if 'struct svc_xprt_ops *xcl_ops' field is const inside 'struct svc_xprt_class'])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		const struct svc_xprt_ops xcl_ops = {0};
		struct svc_xprt_class xprt;
		const struct svc_xprt_ops *ptr = &xcl_ops;

		xprt.xcl_ops = ptr;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_XPRT_CLASS_XCL_OPS_CONST, 1,
			  ['struct svc_xprt_ops *xcl_ops' field is const inside 'struct svc_xprt_class'])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xprt_wait_for_buffer_space has xprt as a parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt xprt = {0};

		xprt_wait_for_buffer_space(&xprt);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPRT_WAIT_FOR_BUFFER_SPACE_RQST_ARG, 1,
			  [xprt_wait_for_buffer_space has xprt as a parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "recv_lock" inside "struct rpc_xprt"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		spinlock_t *dummy_lock;
		struct rpc_xprt dummy_xprt;

		dummy_lock = &dummy_xprt.recv_lock;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_RECV_LOCK, 1, [struct rpc_xprt has 'recv_lock' field])
	],[
		AC_MSG_RESULT(no)
	])


	AC_MSG_CHECKING([for "xprt_class" inside "struct rpc_xprt"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt dummy_xprt;

		dummy_xprt.xprt_class = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_XPRT_CLASS, 1, [struct rpc_xprt has 'xprt_class' field])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([xprt_reconnect_delay],
		[net/sunrpc/xprt.c],
		[AC_DEFINE(HAVE_XPRT_RECONNECT_DELAY, 1,
			[xprt_reconnect_delay is exported by the kernel])],
	[])

	AC_MSG_CHECKING([for "bc_num_slots" inside "struct rpc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt_ops dummy_ops;

		dummy_ops.bc_num_slots = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_BC_NUM_SLOTS, 1,
			[struct rpc_xprt_ops has 'bc_num_slots' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "bc_up" inside "struct rpc_xprt_ops"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct rpc_xprt_ops dummy_ops;

		dummy_ops.bc_up = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RPC_XPRT_OPS_BC_UP, 1,
			[struct rpc_xprt_ops has 'bc_up' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "netid" inside "struct xprt_class"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xprt.h>
	],[
		struct xprt_class xc;

		xc.netid;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XPRT_CLASS_NETID, 1,
			[struct xprt_class has 'netid' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/sysctl.h has SYSCTL_ZERO])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sysctl.h>
	],[
		void *dummy;

		dummy = SYSCTL_ZERO;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SYSCTL_ZERO_ENABLED, 1,
			[linux/sysctl.h has SYSCTL_ZERO defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "child" field inside "struct ctl_table"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sysctl.h>
	],[
		 struct ctl_table dummy_table;

		dummy_table.child = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CTL_TABLE_CHILD, 1,
			[struct ctl_table have "child" field] )
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if defined XDRBUF_SPARSE_PAGES])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		int dummy;

		dummy = XDRBUF_SPARSE_PAGES;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDRBUF_SPARSE_PAGES, 1,
			  [XDRBUF_SPARSE_PAGES has defined in linux/sunrpc/xdr.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_init_encode has rqst as a parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		struct rpc_rqst *rqst = NULL;

		xdr_init_encode(NULL, NULL, NULL, rqst);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_INIT_ENCODE_RQST_ARG, 1,
			  [xdr_init_encode has rqst as a parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_init_decode has rqst as a parameter])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		struct rpc_rqst *rqst = NULL;

		xdr_init_decode(NULL, NULL, NULL, rqst);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_INIT_DECODE_RQST_ARG, 1,
			  [xdr_init_decode has rqst as a parameter])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_stream_remaining as defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		xdr_stream_remaining(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_STREAM_REMAINING, 1,
			  [xdr_stream_remaining as defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "rc_stream" inside "struct svc_rdma_recv_ctxt"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
		#include <linux/sunrpc/svc_rdma.h>
	],[
		struct xdr_stream dummy_stream;
		struct svc_rdma_recv_ctxt dummy_rctxt;

		dummy_rctxt.rc_stream = dummy_stream;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_RDMA_RECV_CTXT_RC_STREAM, 1,
			[struct svc_rdma_recv_ctxt has 'rc_stream' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for "sc_pending_recvs" inside "struct svcxprt_rdma"])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_rdma.h>
	],[
		struct svcxprt_rdma dummy_rdma;

		dummy_rdma.sc_pending_recvs = 0;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVCXPRT_RDMA_SC_PENDING_RECVS, 1,
			[struct svcxprt_rdma has 'sc_pending_recvs' field])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_encode_rdma_segment has defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
		#include <linux/sunrpc/rpc_rdma.h>
	],[
		xdr_encode_rdma_segment(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_ENCODE_RDMA_SEGMENT, 1,
			  [xdr_encode_rdma_segment has defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_decode_rdma_segment has defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
		#include <linux/sunrpc/rpc_rdma.h>
	],[
		xdr_decode_rdma_segment(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_DECODE_RDMA_SEGMENT, 1,
			  [xdr_decode_rdma_segment has defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_stream_encode_item_absent has defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		xdr_stream_encode_item_absent(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_STREAM_ENCODE_ITEM_ABSENT, 1,
			  [xdr_stream_encode_item_absent has defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_item_is_absent has defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		xdr_item_is_absent(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_ITEM_IS_ABSENT, 1,
			  [xdr_item_is_absent has defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xdr_buf_subsegment get const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
	],[
		const struct xdr_buf *dummy;
		xdr_buf_subsegment(dummy, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDR_BUF_SUBSEGMENT_CONST, 1,
			  [xdr_buf_subsegment get const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_xprt_is_dead has defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_xprt.h>
	],[
		svc_xprt_is_dead(NULL);

        return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_XPRT_IS_DEAD, 1,
			  [svc_xprt_is_dead has defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if svc_rdma_release_rqst has externed])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_rdma.h>
	],[
		svc_rdma_release_rqst(NULL);

        return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_RDMA_RELEASE_RQST, 1,
			  [svc_rdma_release_rqst has externed])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if sg_alloc_table_chained has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/scatterlist.h>
	],[
		return sg_alloc_table_chained(NULL, 0, GFP_ATOMIC, NULL);
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SG_ALLOC_TABLE_CHAINED_GFP_MASK, 1,
			  [sg_alloc_table_chained has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([xprt_pin_rqst],
		[net/sunrpc/xprt.c],
		[AC_DEFINE(HAVE_XPRT_PIN_RQST, 1,
			[xprt_pin_rqst is exported by the sunrpc core])],
	[])

	LB_CHECK_SYMBOL_EXPORT([xprt_add_backlog],
		[net/sunrpc/xprt.c],
		[AC_DEFINE(HAVE_XPRT_ADD_BACKLOG, 1,
			[xprt_add_backlog is exported by the sunrpc core])],
	[])

	LB_CHECK_SYMBOL_EXPORT([xprt_lock_connect],
		[net/sunrpc/xprt.c],
		[AC_DEFINE(HAVE_XPRT_LOCK_CONNECT, 1,
			[xprt_lock_connect is exported by the sunrpc core])],
	[])

	LB_CHECK_SYMBOL_EXPORT([svc_xprt_deferred_close],
		[net/sunrpc/svc_xprt.c],
		[AC_DEFINE(HAVE_SVC_XPRT_DEFERRED_CLOSE, 1,
			[svc_xprt_deferred_close is exported by the sunrpc core])],
	[])

	LB_CHECK_SYMBOL_EXPORT([svc_xprt_received],
		[net/sunrpc/svc_xprt.c],
		[AC_DEFINE(HAVE_SVC_XPRT_RECEIVED, 1,
			[svc_xprt_received is exported by the sunrpc core])],
	[])

	LB_CHECK_SYMBOL_EXPORT([svc_xprt_close],
		[net/sunrpc/svc_xprt.c],
		[AC_DEFINE(HAVE_SVC_XPRT_CLOSE, 1,
			[svc_xprt_close is exported by the sunrpc core])],
	[])

	AC_MSG_CHECKING([for trace/events/rpcrdma.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/svc_rdma.h>
		#include "../../net/sunrpc/xprtrdma/xprt_rdma.h"

		#include <trace/events/rpcrdma.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_RPCRDMA_H, 1, [rpcrdma.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([for struct svc_rdma_pcl])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sunrpc/xdr.h>
		#include <linux/sunrpc/svc_rdma_pcl.h>
	],[
		struct svc_rdma_pcl *pcl;

		pcl = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SVC_RDMA_PCL, 1, [struct svc_rdma_pcl exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h struct request_queue has timeout_work])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct request_queue q = { .timeout_work = {} };

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_QUEUE_TIMEOUT_WORK, 1,
			[blkdev.h struct request_queue has timeout_work])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if class_create get 1 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device/class.h>
	],[
	        static struct class *uverbs_class;
		uverbs_class = class_create("Test");

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CLASS_CREATE_GET_1_PARAM, 1,
			  [class_create get 1 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if show_class_attr_string get const])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/device/class.h>
	],[
	        const struct class *uverbs_class;
	        const struct class_attribute *uverbs_attr;

		show_class_attr_string(uverbs_class, uverbs_attr, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SHOW_CLASS_ATTR_STRING_GET_CONST, 1,
			  [show_class_attr_string get const])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netdevice.h has __netdev_tx_sent_queue])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/netdevice.h>
	],[
		__netdev_tx_sent_queue(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE___NETDEV_TX_SENT_QUEUE, 1,
			  [netdevice.h has __netdev_tx_sent_queue])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if synchronize_net done when updating netdev queues])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
	],[
		/*
		 * We can't have a real test for upstream commit ac5b70198adc
		 * This test is good for us. All kernels 4.16+ include the fix.
		 * And if the older kernels include this synchronize_net fix,
		 * it is still harmless for us to add it again in our backport.
		 */

		#if LINUX_VERSION_CODE < KERNEL_VERSION(4,16,0)
		#error No synchronize_net fix in kernel
		#endif
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_SYNCHRONIZE_IN_SET_REAL_NUM_TX_QUEUES, 1,
			  [kernel does synchronize_net for us])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_ENC_OPTS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_ENC_OPTS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_ENC_OPTS, 1,
			  [FLOW_DISSECTOR_KEY_ENC_OPTS is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h enum flow_dissector_key_keyid has FLOW_DISSECTOR_KEY_META])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		enum flow_dissector_key_id keyid = FLOW_DISSECTOR_KEY_META;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_KEY_META, 1,
			  [FLOW_DISSECTOR_KEY_META is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netif_is_geneve exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/if.h>
		#include <net/geneve.h>
	],[
		netif_is_geneve(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_GENEVE, 1,
			  [netif_is_geneve is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/mei_uuid.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/mei_uuid.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_LINUX_MEI_UUID_H, 1,
			  [uapi/linux/mei_uuid.h is exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/memremap.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/memremap.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_MEMREMAP_H, 1,
			  [net/bareudp.h is exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/bareudp.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/bareudp.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_BAREUDP_H, 1,
			  [net/bareudp.h is exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/psample.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/psample.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NET_PSAMPLE_H, 1,
			      [net/psample.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/psample.h has struct psample_metadata])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
		#include <net/psample.h>
	],[
		struct psample_metadata *x;
		x->trunc_size = 0;

		return 0
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_PSAMPLE_METADATA, 1,
			      [net/psample.h has struct psample_metadata])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if netif_is_bareudp exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/bareudp.h>
	],[
		netif_is_bareudp(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NETIF_IS_BAREUDP, 1,
			  [netif_is_bareudp is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has req_bvec])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		req_bvec(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_REQ_BVEC, 1,
				[linux/blkdev.h has req_bvec])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has QUEUE_FLAG_QUIESCED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = QUEUE_FLAG_QUIESCED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_QUEUE_FLAG_QUIESCED, 1,
				[linux/blkdev.h has QUEUE_FLAG_QUIESCED])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci-p2pdma.h has pci_p2pdma_map_sg_attrs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci-p2pdma.h>
	],[
		pci_p2pdma_map_sg_attrs(NULL, NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_P2PDMA_MAP_SG_ATTRS, 1,
			  [pci_p2pdma_map_sg_attrs defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/nvme_ioctl.h has struct nvme_passthru_cmd64])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme_ioctl.h>
		#include <linux/types.h>
		#include <uapi/asm-generic/ioctl.h>
	],[
		struct nvme_passthru_cmd64 cmd = {};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UAPI_LINUX_NVME_PASSTHRU_CMD64, 1,
			[uapi/linux/nvme_ioctl.h has struct nvme_passthru_cmd64])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has op_is_sync])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		op_is_sync(0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPE_OP_IS_SYNC, 1,
			[linux/blk_types.h has op_is_sync])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/suspend.h has pm_suspend_via_firmware])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/suspend.h>
	],[
		pm_suspend_via_firmware();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PM_SUSPEND_VIA_FIRMWARE, 1,
			[linux/suspend.h has pm_suspend_via_firmware])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-mapping.h has dma_max_mapping_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_max_mapping_size(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_MAX_MAPPING_SIZE, 1,
			  [linux/dma-mapping.h has dma_max_mapping_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct request_queue has backing_dev_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct backing_dev_info *bdi = NULL;
		struct request_queue rq = {
			.backing_dev_info = bdi,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_QUEUE_BACKING_DEV_INFO, 1,
			  [struct request_queue has backing_dev_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/skbuff.h has skb_queue_empty_lockless])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		skb_queue_empty_lockless(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_QUEUE_EMPTY_LOCKLESS, 1,
			  [linux/skbuff.h has skb_queue_empty_lockless])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pci.h has pcie_aspm_enabled])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_aspm_enabled(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCIE_ASPM_ENABLED, 1,
			[linux/pci.h has pcie_aspm_enabled])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/xdp_sock_drv.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XDP_SOCK_DRV_H, 1,
			  [net/xdp_sock_drv.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if xsk_buff_dma_sync_for_cpu get 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xdp_sock_drv.h>
	],[
		xsk_buff_dma_sync_for_cpu(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XSK_BUFF_DMA_SYNC_FOR_CPU_2_PARAMS, 1,
			  [xsk_buff_dma_sync_for_cpu get 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/linux/units.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/units.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UNITS_H, 1,
			  [include/linux/units.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h struct request has mq_hctx])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		struct request rq = { .mq_hctx = NULL };
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_MQ_HCTX, 1,
			[blkdev.h struct request has mq_hctx])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bio_integrity_bytes])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bio_integrity_bytes(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_BIO_INTEGRITY_BYTES, 1,
				[linux/blkdev.h has bio_integrity_bytes])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/compat.h has in_compat_syscall])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/compat.h>
	],[
		in_compat_syscall();

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IN_COMPAT_SYSCALL, 1,
	    			[linux/compat.h has in_compat_syscall])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if include/net/esp.h has esp_output_fill_trailer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
		#include <net/esp.h>
	],[
		esp_output_fill_trailer(NULL, 0, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ESP_OUTPUT_FILL_TRAILER, 1,
			  [esp_output_fill_trailer is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/compat.h has compat_uptr_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/compat.h>
	],[
		compat_uptr_t x;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_COMPAT_UPTR_T, 1,
				[linux/compat.h has compat_uptr_t])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_queue_max_active_zones exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_max_active_zones(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_MAX_ACTIVE_ZONES, 1,
				[blk_queue_max_active_zones exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has set_capacity_revalidate_and_notify])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		set_capacity_revalidate_and_notify(NULL, 0, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SET_CAPACITY_REVALIDATE_AND_NOTIFY, 1,
			[genhd.h has set_capacity_revalidate_and_notify])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct block_device_operations has submit_bio])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct block_device_operations ops = {
			.submit_bio = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLOCK_DEVICE_OPERATIONS_SUBMIT_BIO, 1,
			  [struct block_device_operations has submit_bio])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_queue_split has 1 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_split(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_SPLIT_1_PARAM, 1,
				[blk_queue_split has 1 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has bio_split_to_limits])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bio_split_to_limits(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_SPLIT_TO_LIMITS, 1,
				[blkdev.h has bio_split_to_limits])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if submit_bio_noacct exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		submit_bio_noacct(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SUBMIT_BIO_NOACCT, 1,
				[submit_bio_noacct exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci.h has pcie_find_root_port])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		pcie_find_root_port(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCIE_FIND_ROOT_PORT, 1,
			  [pci.h has pcie_find_root_port])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_should_fake_timeout])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_should_fake_timeout(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_SHOULD_FAKE_TIMEOUT, 1,
			  [linux/blk-mq.h has blk_should_fake_timeout])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_complete_request_remote])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_complete_request_remote(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_COMPLETE_REQUEST_REMOTE, 1,
			  [linux/blk-mq.h has blk_mq_complete_request_remote])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if trace_block_bio_complete has 2 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <trace/events/block.h>
	],[
		trace_block_bio_complete(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_BLOCK_BIO_COMPLETE_2_PARAM, 1,
			  [trace_block_bio_complete has 2 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/ip.h has ip_sock_set_tos])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/ip.h>
	],[
		ip_sock_set_tos(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IP_SOCK_SET_TOS, 1,
			  [net/ip.h has ip_sock_set_tos])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/tcp.h has skb_tcp_all_headers])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/tcp.h>
	],[
		skb_tcp_all_headers(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SKB_TCP_ALL_HEADERS, 1,
			  [linux/tcp.h has skb_tcp_all_headers])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/tcp.h has tcp_sock_set_syncnt])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/tcp.h>
	],[
		tcp_sock_set_syncnt(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCP_SOCK_SET_SYNCNT, 1,
			  [linux/tcp.h has tcp_sock_set_syncnt])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/tcp.h has tcp_sock_set_nodelay])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/tcp.h>
	],[
		tcp_sock_set_nodelay(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TCP_SOCK_SET_NODELAY, 1,
			  [linux/tcp.h has tcp_sock_set_nodelay])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has kmemdup_nul])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/string.h>
	],[
		kmemdup_nul(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KMEMDUP_NUL, 1,
			  [string.h has kmemdup_nul])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev_issue_flush has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blkdev_issue_flush(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_ISSUE_FLUSH_2_PARAM, 1,
				[blkdev_issue_flush has 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/sock.h has sock_no_linger])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sock.h>
	],[
		sock_no_linger(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SOCK_NO_LINGER, 1,
			  [net/sock.h has sock_no_linger])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/sock.h has sock_set_priority])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sock.h>
	],[
		sock_set_priority(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SOCK_SET_PRIORITY, 1,
			  [net/sock.h has sock_set_priority])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/sock.h has sock_set_reuseaddr])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sock.h>
	],[
		sock_set_reuseaddr(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SOCK_SET_REUSEADDR, 1,
			  [net/sock.h has sock_set_reuseaddr])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/net.h has sendpage_ok])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
	],[
		sendpage_ok(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SENDPAGE_OK, 1,
			[linux/net.h has sendpage_ok])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/page_ref.h has page_count])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/page_ref.h>
	],[
		page_count(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PAGE_COUNT, 1,
			[linux/page_ref.h has page_count])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ptp_find_pin_unlocked is defined])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/ptp_clock_kernel.h>
	],[
		ptp_find_pin_unlocked(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_FIND_PIN_UNLOCK, 1,
			  [ptp_find_pin_unlocked is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/xfrm.h has XFRM_OFFLOAD_PACKET])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/xfrm.h>
	],[
		int a = XFRM_OFFLOAD_PACKET;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_OFFLOAD_PACKET, 1,
			  [XFRM_OFFLOAD_PACKET is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct xfrm_offload has inner_ipproto])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/xfrm.h>
	],[
		struct xfrm_offload xo = {
			.inner_ipproto = 4,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_XFRM_OFFLOAD_INNER_IPPROTO, 1,
			  [struct xfrm_offload has inner_ipproto])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has bd_set_nr_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bd_set_nr_sectors(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BD_SET_NR_SECTORS, 1,
			  [genhd.h has bd_set_nr_sectors])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has QUEUE_FLAG_STABLE_WRITES])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = QUEUE_FLAG_STABLE_WRITES;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_QUEUE_FLAG_STABLE_WRITES, 1,
			[QUEUE_FLAG_STABLE_WRITES is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has revalidate_disk_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		revalidate_disk_size(NULL, false);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REVALIDATE_DISK_SIZE, 1,
			  [genhd.h has revalidate_disk_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if fs.h has inode_lock])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		inode_lock(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_INODE_LOCK, 1,
			[fs.h has inode_lock])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_set_request_complete])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_set_request_complete(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_SET_REQUEST_COMPLETE, 1,
			  [linux/blk-mq.h has blk_mq_set_request_complete])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has blk_alloc_queue_rh])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_alloc_queue_rh(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_ALLOC_QUEUE_RH, 1,
				[linux/blkdev.h has blk_alloc_queue_rh])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h struct request has block_device])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		struct block_device *bdev = NULL;
		struct request rq = { .part = bdev };
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_BDEV, 1,
			[blkdev.h struct request has block_device])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev_issue_flush has 1 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blkdev_issue_flush(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_ISSUE_FLUSH_1_PARAM, 1,
			[blkdev_issue_flush has 1 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h has bio_max_segs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bio_max_segs(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_MAX_SEGS, 1,
			[if bio.h has bio_max_segs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if trace_block_bio_remap has 4 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <trace/events/block.h>
	],[
		trace_block_bio_remap(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_BLOCK_BIO_REMAP_4_PARAM, 1,
			[trace_block_bio_remap has 4 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has bd_set_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bd_set_size(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BD_SET_SIZE, 1,
			[genhd.h has bd_set_size])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq_nowait has 5 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_execute_rq_nowait(NULL, NULL, NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_NOWAIT_5_PARAM, 1,
				[blk_execute_rq_nowait has 5 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq_nowait has 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_execute_rq_nowait(NULL, 0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_NOWAIT_3_PARAM, 1,
				[blk_execute_rq_nowait has 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq_nowait has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_execute_rq_nowait(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_NOWAIT_2_PARAM, 1,
				[blk_execute_rq_nowait has 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_execute_rq(NULL, NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_4_PARAM, 1,
				[blk_execute_rq  has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct enum has member BIO_REMAPPED])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int tmp = BIO_REMAPPED;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ENUM_BIO_REMAPPED, 1,
			[struct enum has member BIO_REMAPPED])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct pci_driver has member sriov_get_vf_total_msix/sriov_set_msix_vec_count])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci.h>
	],[
		struct pci_driver core_driver = {
			.sriov_get_vf_total_msix = NULL,
			.sriov_set_msix_vec_count = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SRIOV_GET_SET_MSIX_VEC_COUNT, 1,
			[struct pci_driver has member sriov_get_vf_total_msix/sriov_set_msix_vec_count])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if configfs.h has configfs_register_group])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/configfs.h>
	],[
		configfs_register_group(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CONFIGFS_REGISTER_GROUP, 1,
			  [configfs.h has configfs_register_group])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bio has member bi_bdev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/blk_types.h>
	],[
		struct bio b = {
			.bi_bdev = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_BI_BDEV, 1,
			  [struct bio has member bi_bdev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has bdev_nr_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_nr_sectors(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_NR_SECTORS, 1,
				[genhd.h has bdev_nr_sectors])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if BLK_STS_ZONE_ACTIVE_RESOURCE is defined in blk_types])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		blk_status_t error = BLK_STS_ZONE_ACTIVE_RESOURCE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_BLK_STS_ZONE_ACTIVE_RESOURCE, 1,
				[blk_types.h has BLK_STS_ZONE_ACTIVE_RESOURCE])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if dma-mapping.h has dma_set_min_align_mask])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_set_min_align_mask(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_SET_MIN_ALIGN_MASK, 1,
				[dma_set_min_align_mask is defined in dma-mapping])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h has bio_for_each_bvec])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		  #include <linux/bio.h>
	],[
		  struct bio *bio;
		  struct bvec_iter bi;
		  struct bio_vec bv;

		  bio_for_each_bvec(bv, bio, bi);

		  return 0;
	],[
		  AC_MSG_RESULT(yes)
		  MLNX_AC_DEFINE(HAVE_BIO_FOR_EACH_BVEC, 1,
			    [bio_for_each_bvec is defined in bio.h])
	],[
		  AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have linux/io-64-nonatomic-hi-lo.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io-64-nonatomic-hi-lo.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_64_NONATOMIC_HI_LO_H, 1,
				[can include linux/io-64-nonatomic-hi-lo.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has blk_mq_hctx_set_fq_lock_class])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_hctx_set_fq_lock_class(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_HCTX_SET_FQ_LOCK_CLASS, 1,
			[blk-mq.h has blk_mq_hctx_set_fq_lock_class])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h has BIO_MAX_VECS])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		int x = BIO_MAX_VECS;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_MAX_VECS, 1,
			[if bio.h has BIO_MAX_VECS])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h has blk_rq_bio_prep])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_rq_bio_prep(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_BIO_PREP, 1,
			[if blk-mq.h has blk_rq_bio_prep])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has blk_alloc_disk])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
                #include <linux/blkdev.h>
	],[
		blk_alloc_disk(0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_ALLOC_DISK, 1,
				[genhd.h has blk_alloc_disk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if asm-generic/unaligned.h has put_unaligned_le24])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <asm-generic/unaligned.h>
	],[
		put_unaligned_le24(0, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PUT_UNALIGNED_LE24_ASM_GENERIC, 1,
				[put_unaligned_le24 existing in asm-generic/unaligned.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has GENHD_FL_UP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = GENHD_FL_UP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENHD_FL_UP, 1,
			  [genhd.h has GENHD_FL_UP])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_alloc_disk])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_alloc_disk(NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_ALLOC_DISK, 1,
			  [blk_mq_alloc_disk is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has poll 2 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>

		static int nvme_poll(struct blk_mq_hw_ctx *hctx,
				     struct io_comp_batch *iob) {
			return 0;
		}
	],[
		struct blk_mq_ops ops = {
			.poll = nvme_poll,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_POLL_2_ARG, 1,
			  [struct blk_mq_ops has poll 2 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-integrity.h exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-integrity.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_INTEGRITY_H, 1,
			[linux/blk-integrity.h exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct bio has member bi_cookie])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		struct bio b = {
			.bi_cookie = 0,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_BI_COOKIE, 1,
			[struct bio has member bi_cookie])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has device_add_disk retrun])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int ret = device_add_disk(NULL, NULL, NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DEVICE_ADD_DISK_RETURN, 1,
			[genhd.h has device_add_disk retrun])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/fs.h has struct kiocb ki_complete 2 args])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>

		static void func(struct kiocb *iocb, long ret) {
			return;
		}
	],[
		struct kiocb x = {
			.ki_complete = func,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FS_KIOCB_KI_COMPLETE_2_ARG, 1,
			[linux/fs.h has struct kiocb ki_complete 2 args])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq has 2 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_execute_rq(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_2_PARAM, 1,
				[blk_execute_rq has 2 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if genhd.h has GENHD_FL_EXT_DEVT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = GENHD_FL_EXT_DEVT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENHD_FL_EXT_DEVT, 1,
			  [genhd.h has GENHD_FL_EXT_DEVT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-mq.h struct request has rq_disk])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct request rq = { .rq_disk = NULL };
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQ_RQ_DISK, 1,
			[blkdev.h struct request has rq_disk])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct blk_mq_ops has queue_rqs])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_ops ops = {
			.queue_rqs = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_QUEUE_RQS, 1,
			  [struct blk_mq_ops has queue_rqs])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bdev_nr_bytes exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_nr_bytes(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_NR_BYTES, 1,
			[bdev_nr_bytes exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if pci_ids.h has PCI_VENDOR_ID_REDHAT])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/pci_ids.h>
	],[
		int x = PCI_VENDOR_ID_REDHAT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_VENDOR_ID_REDHAT, 1,
			  [PCI_VENDOR_ID_REDHAT is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if acpi_storage_d3 exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/acpi.h>
	],[
		acpi_storage_d3(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ACPI_STORAGE_D3, 1,
			[acpi_storage_d3 exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/moduleparam.h has param_set_uint_minmax])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/moduleparam.h>
	],[
		param_set_uint_minmax(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PARAM_SET_UINT_MINMAX, 1,
			[linux/moduleparam.h has param_set_uint_minmax])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_wait_quiesce_done])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_wait_quiesce_done(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_WAIT_QUIESCE_DONE, 1,
			  [blk_mq_wait_quiesce_done is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_wait_quiesce_done with tagset param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_tag_set set = {0};

		blk_mq_wait_quiesce_done(&set);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_WAIT_QUIESCE_DONE_TAGSET, 1,
			  [blk_mq_wait_quiesce_done with tagset param is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if timeout from struct blk_mq_ops has 1 param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
		#include <linux/blkdev.h>

		static enum blk_eh_timer_return
		timeout_dummy(struct request *req) {
			return 0;
		}
	],[
		struct blk_mq_ops ops_dummy;

		ops_dummy.timeout = timeout_dummy;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_TIMEOUT_1_PARAM, 1,
			  [timeout from struct blk_mq_ops has 1 param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_destroy_queue])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_destroy_queue(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_DESTROY_QUEUE, 1,
			  [blk_mq_destroy_queue is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk_execute_rq has 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
		#include <linux/blkdev.h>
	],[
		blk_status_t x = blk_execute_rq(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_EXECUTE_RQ_3_PARAM, 1,
				[blk_execute_rq has 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if disk_uevent exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		disk_uevent(NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DISK_UEVENT, 1,
			[disk_uevent exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blk-cgroup.h has FC_APPID_LEN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-cgroup.h>
	],[
		int x = FC_APPID_LEN;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FC_APPID_LEN, 1,
			  [FC_APPID_LEN is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bvec.h has bvec_virt])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
		#include <linux/bvec.h>
	],[
		bvec_virt(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BVEC_VIRT, 1,
			[linux/bvec.h has bvec_virt])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/sock.h has sock_setsockopt sockptr_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/sock.h>
	],[
		sockptr_t optval = {};

		sock_setsockopt(NULL, 0, 0, optval, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_SOCK_SETOPTVAL_SOCKPTR_T, 1,
			  [net/sock.h has sock_setsockopt sockptr_t])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h blk_next_bio has 3 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		blk_next_bio(NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_NEXT_BIO_3_PARAMS, 1,
			  [bio.h blk_next_bio has 3 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if disk_update_readahead exists])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		disk_update_readahead(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DISK_UPDATE_READAHEAD, 1,
			[disk_update_readahead exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/vmalloc.h has __vmalloc 3 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/vmalloc.h>
	],[
		__vmalloc(0, 0, PAGE_KERNEL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_VMALLOC_3_PARAM, 1,
			[linux/vmalloc.h has __vmalloc 3 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h bio_init has 5 parameters])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bio_init(NULL, NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_INIT_5_PARAMS, 1,
			  [bio.h bio_init has 5 parameters])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if bio.h has bio_add_zone_append_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bio.h>
	],[
		bio_add_zone_append_page(NULL, NULL, 0, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_ADD_ZONE_APPEND_PAGE, 1,
			[bio.h has bio_add_zone_append_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_cleanup_disk()])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct gendisk *disk;

		blk_cleanup_disk(disk);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_CLEANUP_DISK, 1,
			[blk_cleanup_disk() is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has QUEUE_FLAG_DISCARD])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		int x = QUEUE_FLAG_DISCARD;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_QUEUE_FLAG_DISCARD, 1,
			[QUEUE_FLAG_DISCARD is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct gendisk has conv_zones_bitmap])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct gendisk disk;

		disk.conv_zones_bitmap = NULL;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENDISK_CONV_ZONES_BITMAP, 1,
			[struct gendisk has conv_zones_bitmap])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has bdev_nr_zones])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_nr_zones(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_NR_ZONES, 1,
			[blkdev.h has bdev_nr_zones])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has blk_queue_zone_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blk_queue_zone_sectors(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_QUEUE_ZONE_SECTORS, 1,
			[blkdev.h has blk_queue_zone_sectors])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/ptp_clock.h has PTP_PEROUT_DUTY_CYCLE])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <uapi/linux/ptp_clock.h>
	],[
		int x = PTP_PEROUT_DUTY_CYCLE;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PTP_PEROUT_DUTY_CYCLE, 1,
			[PTP_PEROUT_DUTY_CYCLE is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/dst_metadata.h has struct macsec_info])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/dst_metadata.h>
	],[
		struct macsec_info info = {};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRUCT_MACSEC_INFO_METADATA, 1,
			      [net/dst_metadata.h has struct macsec_info])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/macsec.c has function macsec_get_real_dev])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/macsec.h>
	],[
		macsec_get_real_dev(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FUNC_MACSEC_GET_REAL_DEV, 1,
			      [net/macsec.c has function macsec_get_real_dev])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_dissector.h has FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_dissector.h>
	],[
		int x = FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP, 1,
			  [FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	LB_CHECK_SYMBOL_EXPORT([rpc_task_gfp_mask],
		[net/sunrpc/sched.c],
		[AC_DEFINE(HAVE_RPC_TASK_GPF_MASK_EXPORTED, 1,
			[rpc_task_gfp_mask is exported by the kernel])],
	[])

	AC_MSG_CHECKING([if net/macsec.c has function macsec_netdev_is_offloaded])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/macsec.h>
	],[
		macsec_netdev_is_offloaded(NULL);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FUNC_MACSEC_NETDEV_IS_OFFLOADED, 1,
			      [net/macsec.c has function macsec_netdev_is_offloaded])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/fs.h struct file_operations has uring_cmd])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		struct file_operations xx = {
			.uring_cmd = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FILE_OPERATIONS_URING_CMD, 1,
			[uring_cmd is defined in file_operations])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has function disk_set_zoned])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		disk_set_zoned(NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DISK_SET_ZONED, 1,
			[disk_set_zoned is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/nvme_ioctl.h has NVME_IOCTL_IO64_CMD_VEC])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme_ioctl.h>
		#include <asm-generic/ioctl.h>
	],[
		unsigned int x = NVME_IOCTL_IO64_CMD_VEC;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NVME_IOCTL_IO64_CMD_VEC, 1,
			[NVME_IOCTL_IO64_CMD_VEC is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/t10-pi.h has ext_pi_ref_tag])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/t10-pi.h>
	],[
		ext_pi_ref_tag(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_EXT_PI_REF_TAG, 1,
			[ext_pi_ref_tag is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has blk_opf_t])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		blk_opf_t xx;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_OPF_T, 1,
			[blk_opf_t is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/fs.h sruct file has f_iocb_flags])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		struct file f = {
			.f_iocb_flags = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FILE_F_IOCB_FLAGS, 1,
			[sruct file has f_iocb_flags])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have linux/io_uring.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io_uring.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_URING_H, 1,
				[can include linux/io_uring.h])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h has bdev_max_zone_append_sectors])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_max_zone_append_sectors(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_MAX_ZONE_APPEND_SECTORS, 1,
			[blkdev.h has bdev_max_zone_append_sectors])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if file linux/blk-mq.h has enum rq_end_io_ret])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		enum rq_end_io_ret x;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RQ_END_IO_RET, 1,
			[if file rq_end_io_ret exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if file linux/sched/mm.h has memalloc_noreclaim_save])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/sched/mm.h>
	],[
		memalloc_noreclaim_save();
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_MEMALLOC_NORECLAIM_SAVE, 1,
			[if memalloc_noreclaim_save exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if function map_queues returns int])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		int foo(struct blk_mq_tag_set *x) {
			return 0;
		}

		struct blk_mq_ops ops = {
			.map_queues = foo,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_OPS_MAP_QUEUES_RETURN_INT, 1,
			  [function map_queues returns int])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-cgroup has blkcg_get_fc_appid])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-cgroup.h>
	],[
		blkcg_get_fc_appid(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKCG_GET_FC_APPID, 1,
			[blkcg_get_fc_appid is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has blkdev_compat_ptr_ioctl])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blkdev_compat_ptr_ioctl(NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_COMPAT_PTR_IOCTL, 1,
			[blkdev_compat_ptr_ioctl is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/moduleparam.h has __check_old_set_param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/moduleparam.h>
	],[
		__check_old_set_param(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CHECK_OLD_SET_PARAM, 1,
			[__check_old_set_param is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/vxlan.h has VXLAN_GBP_MASK])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		uint32_t gbp_mask = VXLAN_GBP_MASK;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CHECK_VXLAN_GBP_MASK, 1,
			[VXLAN_GBP_MASK is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct tc_skb_ext has act_miss])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/skbuff.h>
	],[
		struct tc_skb_ext ext = {};

		ext.act_miss = 1;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TC_SKB_EXT_ACT_MISS, 1,
			  [linux/skbuff.h struct tc_skb_ext has act-miss])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if net/vxlan.h has vxlan_build_gbp_hdr])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/vxlan.h>
	],[
		vxlan_build_gbp_hdr(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_CHECK_VXLAN_BUILD_GBP_HDR, 1,
			[vxlan_build_gbp_hdr is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has hw_index])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry ent = {};

		ent.hw_index = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_ENTRY_HW_INDEX, 1,
			  [net/flow_offload.h struct flow_action_entry has hw_index])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has miss_cookie])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry ent = {};

		ent.miss_cookie = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_ENTRY_MISS_COOKIE, 1,
			  [net/flow_offload.h struct flow_action_entry has miss_cookie])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has cookie])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry ent = {};
		struct flow_offload_action act = {};
		unsigned long cookie = 0;

		ent.cookie = cookie;
		cookie = ent.cookie;

		act.cookie = cookie;
		cookie = act.cookie;

		return cookie ? 1 : 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_ENTRY_COOKIE, 1,
			  [net/flow_offload.h struct flow_action_entry has cookie])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has act_cookie])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry ent = {};
		struct flow_offload_action act = {};
		unsigned long cookie = 0;

		ent.act_cookie = cookie;
		cookie = ent.act_cookie;

		act.cookie = cookie;
		cookie = act.cookie;

		return cookie ? 1 : 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_ENTRY_ACT_COOKIE, 1,
			  [net/flow_offload.h struct flow_action_entry has act_cookie])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct flow_action_entry has act pointer])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_action_entry ent = {};

		ent.act = 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FLOW_ACTION_ENTRY_ACT_POINTER, 1,
			  [net/flow_offload.h struct flow_action_entry has act pointer])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if flow_cls_offload has use_act_stats])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <net/flow_offload.h>
	],[
		struct flow_cls_offload cls;

		cls.use_act_stats = true;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_USE_ACT_STATS, 1,
			  [flow_cls_offload has use_act_stats])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if rhashtable.h has rhashtable_lookup_get_insert_fast])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/rhashtable.h>
	],[
		struct rhashtable ht = {};
		struct rhashtable_params p = {};
		void *ptr;

		ptr = rhashtable_lookup_get_insert_fast(&ht, 0, p);
		if (ptr)
			return 0;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_RHASHTABLE_LOOKUP_GET_INSERT_FAST, 1,
			  [rhashtable.h has rhashtable_lookup_get_insert_fast])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if uapi/linux/nvme_ioctl.h has NVME_URING_CMD_ADMIN])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme_ioctl.h>
		#include <asm-generic/ioctl.h>
	],[
		int x = NVME_URING_CMD_ADMIN;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_UAPI_LINUX_NVME_NVME_URING_CMD_ADMIN, 1,
			[uapi/linux/nvme_ioctl.h has NVME_URING_CMD_ADMIN])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_quiesce_tagset])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_quiesce_tagset(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_QUEIESCE_TAGSET, 1,
			  [blk_mq_quiesce_tagset is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_rq_map_user_io])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_rq_map_user_io(NULL, NULL, NULL, 0, 0, 0, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_RQ_MAP_USER_IO, 1,
			  [blk_rq_map_user_iv is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_start_io_acct])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_start_io_acct(NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_START_IO_ACCT, 1,
			  [bdev_start_io_acct is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_start_io_acct])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_start_io_acct(NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_START_IO_ACCT_3_PARAM, 1,
			  [bdev_start_io_acct is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/fs.h struct file_operations has uring_cmd_iopoll])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		struct file_operations xx = {
			.uring_cmd_iopoll = NULL,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_FILE_OPERATIONS_URING_CMD_IOPOLL, 1,
			[uring_cmd_iopoll is defined in file_operations])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/pr.h has enum pr_status])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
		#include <linux/pr.h>
	],[
		enum pr_status x;
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PR_STATUS, 1,
			[enum pr_status is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bvec.h has bvec_set_virt])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bvec.h>
	],[
		bvec_set_virt(NULL, NULL, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BVEC_SET_VIRT, 1,
			  [bvec_set_virt is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/dma-mapping.h has dma_opt_mapping_size])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/dma-mapping.h>
	],[
		dma_opt_mapping_size(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_DMA_OPT_MAPPING_SIZE, 1,
			  [dma_opt_mapping_size is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h has blk_mq_rq_state])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		blk_mq_rq_state(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_RQ_STATE, 1,
			  [blk_mq_rq_state is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/uio.h has ITER_DEST])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/uio.h>
	],[
		int x = ITER_DEST;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_ITER_DEST, 1,
				[ITER_DEST is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/bvec.h has bvec_set_page])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/bvec.h>
	],[
		bvec_set_page(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BVEC_SET_PAGE, 1,
			[linux/bvec.h has bvec_set_page])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_discard_granularity])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_discard_granularity(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_DISCARD_GRANULARITY, 1,
			[linux/blkdev.h has bdev_discard_granularity])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if kstrtox.h exist])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/kstrtox.h>
	],[
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_KSTRTOX_H, 1,
			  [kstrtox.h exist])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_write_cache])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_write_cache(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_WRITE_CACHE, 1,
			[linux/blkdev.h has bdev_write_cache])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if trace/events/sock.h has trace_sk_data_ready])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <trace/events/sock.h>
	],[
		trace_sk_data_ready(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRACE_EVENTS_TRACE_SK_DATA_READY, 1,
			  [trace/events/sock.h has trace_sk_data_ready])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk-mq.h blk_mq_tag_set has member nr_maps])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk-mq.h>
	],[
		struct blk_mq_tag_set x = {
			.nr_maps = 0,
		};

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_MQ_TAG_SET_HAS_NR_MAP, 1,
			  [blk_mq_tag_set has member nr_maps])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have io_uring_cmd struct in linux/io_uring.h])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io_uring.h>
	],[
		struct io_uring_cmd x ={};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_URING_CMD, 1,
				[io_uring_cmd exists])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if have io_uring_cmd_done has 4 params])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io_uring.h>
	],[
		io_uring_cmd_done(NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_URING_CMD_DONE_4_PARAMS, 1,
				[io_uring_cmd_done has 4 params])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if string.h has strscpy])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
	#include <linux/string.h>
	],
	[
		strscpy(NULL, NULL, 0);

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_STRSCPY, 1,
		[strscpy is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if io_uring.h has io_uring_sqe_cmd])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io_uring.h>
	],[
		io_uring_sqe_cmd(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_URING_SQE_CMD, 1,
				[io_uring_sqe_cmd is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/atomic/atomic-instrumented.h has try_cmpxchg])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/mm_types.h>
		#include <linux/atomic/atomic-instrumented.h>
	],[
			u32 x = 0;
			try_cmpxchg(&x, &x, x);
			return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_TRY_CMPXCHG, 1,
			[linux/atomic/atomic-instrumented.h has try_cmpxchg])
	],[
			AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_zone_no])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
			bdev_zone_no(NULL, 0);
			return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_ZONE_NO, 1,
			[linux/blkdev.h has bdev_zone_no])
	],[
			AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if blkdev.h struct request has deadline])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
		#include <linux/blk-mq.h>
	],[
		struct request rq = { .deadline = 0 };
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_REQUEST_HAS_DEADLINE, 1,
			[blkdev.h struct request has deadline])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_start_io_acct])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_start_io_acct(NULL, 0, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BIO_START_IO_ACCT, 1,
			  [bdev_start_io_acct is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blk_types.h has REQ_NOUNMAP])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		int x = REQ_NOUNMAP;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_TYPES_REQ_NOUNMAP, 1,
			[REQ_NOUNMAP is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has bdev_is_partition])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		bdev_is_partition(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BDEV_IS_PARTITION, 1,
			[bdev_is_partition is defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct gendisk has open_mode])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		struct gendisk disk;

		disk.open_mode = BLK_OPEN_READ;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_GENDISK_OPEN_MODE, 1,
			[struct gendisk has open_mode])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if BLK_STS_RESV_CONFLICT is defined in blk_types])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blk_types.h>
	],[
		blk_status_t error = BLK_STS_RESV_CONFLICT;

		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLK_STS_RESV_CONFLICT, 1,
				[blk_types.h has BLK_STS_RESV_CONFLICT])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/blkdev.h has blkdev_put with holder param])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/blkdev.h>
	],[
		blkdev_put(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_BLKDEV_PUT_HOLDER, 1,
			[blkdev_put has holder param])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct proto_ops has sendpage])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/net.h>
	],[
		struct proto_ops x = {
			.sendpage = NULL,
		};
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PROTO_OPS_SENDPAGE, 1,
			  [net.h struct proto_ops has sendpage])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if linux/aer.h has pci_enable_pcie_error_reporting])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/aer.h>
	],[
		pci_enable_pcie_error_reporting(NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_PCI_ENABLE_PCIE_ERROR_REPORTING, 1,
			[linux/aer.h has pci_enable_pcie_error_reporting])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if struct io_uring_cmd has cookie])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/io_uring.h>
	],[
		struct io_uring_cmd x = {
			.cookie = NULL,
		};
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_IO_URING_CMD_COOKIE, 1,
				[struct io_uring_cmd has cookie])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if nvme_auth_transform_key returns u8])
	MLNX_BG_LB_LINUX_TRY_COMPILE([
		#include <linux/nvme-auth.h>
	],[
		u8 *x = nvme_auth_transform_key(NULL, NULL);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		MLNX_AC_DEFINE(HAVE_NVME_AUTH_TRANSFORM_KEY_U8, 1,
				[nvme_auth_transform_key returns u8])
	],[
		AC_MSG_RESULT(no)
	])
])
#
# COMPAT_CONFIG_HEADERS
#
# add -include config.h
#
AC_DEFUN([COMPAT_CONFIG_HEADERS],[
#
#	Wait for remaining build tests running in background
#
	wait
#
#	Append confdefs.h files from CONFDEFS_H_DIR to the main confdefs.h file
#
	/bin/cat CONFDEFS_H_DIR/confdefs.h.* >> confdefs.h
	/bin/rm -rf CONFDEFS_H_DIR
#
#	Generate the config.h header file
#
	AC_CONFIG_HEADERS([config.h])
	EXTRA_KCFLAGS="-include $PWD/config.h $EXTRA_KCFLAGS"
	AC_SUBST(EXTRA_KCFLAGS)
])

AC_DEFUN([MLNX_PROG_LINUX],
[

LB_LINUX_PATH
LB_LINUX_SYMVERFILE
LB_LINUX_CONFIG([MODULES],[],[
    AC_MSG_ERROR([module support is required to build mlnx kernel modules.])
])
LB_LINUX_CONFIG([MODVERSIONS])
LB_LINUX_CONFIG([KALLSYMS],[],[
    AC_MSG_ERROR([compat_mlnx requires that CONFIG_KALLSYMS is enabled in your kernel.])
])

LINUX_CONFIG_COMPAT
COMPAT_CONFIG_HEADERS

])
