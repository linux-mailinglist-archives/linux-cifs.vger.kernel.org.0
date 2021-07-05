Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A03BB563
	for <lists+linux-cifs@lfdr.de>; Mon,  5 Jul 2021 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhGEDUJ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 4 Jul 2021 23:20:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25756 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGEDUE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 4 Jul 2021 23:20:04 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210705031726epoutp02aa3c2b3f38d6c10749778ec3792a5f9b~OxsDNmNEo0869408694epoutp02f
        for <linux-cifs@vger.kernel.org>; Mon,  5 Jul 2021 03:17:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210705031726epoutp02aa3c2b3f38d6c10749778ec3792a5f9b~OxsDNmNEo0869408694epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455046;
        bh=IAXQe2QIFIs9V36Sc+9KgT4p7euYJ9Rl6sUnbWs8EvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaEeReYH8wTXQlXlSexHFCHSpkfws+9iuxHzyeaoOWgWZt6JAziRq/ZdZOxQnMQyw
         tfIc9zek+UEh7frpdUnRLocStTULXlYguYIFLMp5KE2lzmxn+4UlzmgcnreVZvzdBt
         6mp0iA1E9r75iZ44ixzlpIv9hTFUK8hnwO3v6b+Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210705031726epcas1p3ae6e019845623dbb5d23776536f2d2dd~OxsCl5tnQ2361923619epcas1p39;
        Mon,  5 Jul 2021 03:17:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJ9ps0vBGz4x9Q3; Mon,  5 Jul
        2021 03:17:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.3C.09468.4C972E06; Mon,  5 Jul 2021 12:17:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210705031724epcas1p1d89789836e3113e50cc3112a736a7852~OxsBBULnR1197211972epcas1p1k;
        Mon,  5 Jul 2021 03:17:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705031724epsmtrp2cdf43a4dd6f3353fc91ba6924234a5ee~OxsBAZ31-1726817268epsmtrp20;
        Mon,  5 Jul 2021 03:17:24 +0000 (GMT)
X-AuditID: b6c32a37-0c7ff700000024fc-fc-60e279c4e091
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.AB.08394.4C972E06; Mon,  5 Jul 2021 12:17:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031724epsmtip2f2f91c66b32fdccf26d5e01bf26e8423~OxsAnoMb82672126721epsmtip2L;
        Mon,  5 Jul 2021 03:17:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v5 02/13] ksmbd: add server handler
Date:   Mon,  5 Jul 2021 12:07:18 +0900
Message-Id: <20210705030729.10292-3-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmvu6RykcJBv+emlg0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAblWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA/SmkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+PT
        /gVsBR+WMVXsuvKWtYHx9TvGLkZODgkBE4mLc28ydTFycQgJ7GCU2H9xFTOE84lRYu6fE1DO
        N0aJHZffscO07N3WwgaR2MsocaflE0LLu4MbgQZzcLAJaEv82SIK0iAiECtxY8drsBpmgdnM
        Erd2bmEFSQgLGEscfdfFBmKzCKhK/Ft+kgnE5hWwkdjQsBFqm7zE6g0HmEFsTgFbib1dV1lB
        BkkIPOCQWLj1K1SRi8TXBZ+YIGxhiVfHt0DFpSQ+v9vLBmGXS5w4+QuqpkZiw7x97CCHSgAd
        0fOiBMRkFtCUWL9LH6JCUWLn77ngMGIW4JN497WHFaKaV6KjTQiiRFWi79JhqIHSEl3tH6AG
        ekjMmhkMEhYSmMAo8ajVYAKj3CyE+QsYGVcxiqUWFOempxYbFhgjx9gmRnA61jLfwTjt7Qe9
        Q4xMHIyHGCU4mJVEeEPn3UsQ4k1JrKxKLcqPLyrNSS0+xGgKDLmJzFKiyfnAjJBXEm9oamRs
        bGxhYmZuZmqsJM67k+1QgpBAemJJanZqakFqEUwfEwenVAMT5wwrb6Mk5QVWnpv3zefNtdvp
        Wvqr5mP1ywVHFvz7YV4REaif8YthY4mfQHLTD+lJIjO2Ls47dslnaYBkZZj3jl2F5VqPLNmm
        f58yTzEtsv76376Hh1KEa15YTBNIS5656+oP1s/C/6//fTLvbP3ax9/+9U5pv2ZZ5rxTUv1C
        0EnR66+6TF+omLgGu3e/31GbskBlQefrC+HtWYpdHBd/Fk94It3/Q+VkSeale1llGU4OPfNF
        vlReuiOxNpdZce88B6uWqUvNTx68vvqf36024V+2HxfmhBa2V3R4tE/p7vZLKNxeNHu3uQt/
        2tes/R999+jsrb/obfSwmnv+ofaIhZap1eKrP0ecS/1yUvW7EktxRqKhFnNRcSIAhwssI1AE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO6RykcJBtefCFg0vj3NYnH89V92
        i8Z3yhav/01nsTg9YRGTxcrVR5ksrt1/z27x4v8uZouf/78zWuzZe5LF4vKuOWwWP6bXW/T2
        fWK1aL2iZbF74yI2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2+Dv3I7PH7IaLLB47Z91l99i8
        Qstj94LPTB67bzawebTu+Mvu8fHpLRaPvi2rGD22LH7I5LF+y1UWj8+b5Dw2PXnLFMAbxWWT
        kpqTWZZapG+XwJXxaf8CtoIPy5gqdl15y9rA+PodYxcjJ4eEgInE3m0tbF2MXBxCArsZJZZc
        3gOVkJY4duIMcxcjB5AtLHH4cDFIWEjgA6PE37neIGE2AW2JP1tEQcIiAvESNxtus4CMYRZY
        zyzxZuovFpCEsICxxNF3XWwgNouAqsS/5SeZQGxeARuJDQ0b2SFWyUus3nCAGcTmFLCV2Nt1
        lRVil41E988frBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOGy3NHYzb
        V33QO8TIxMF4iFGCg1lJhDd03r0EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5ak
        ZqemFqQWwWSZODilGpimiYY1+bA3H73C890tj9X+yKpP/t0np5354+5tdv5uyqz395oN10vm
        m/Rrm76O2tuVULLzWf6LoDWyVoGG986Ul626o6KtqC3Rd8JY7JTapcf3asJCZ1w9HTd3zqF0
        toVcmTt/G8zSjDlgLFOf/G5r5sS7vf43/mlvu8jyYeIc9nuPb881c9Ir2xRfttzNdZ/zbJ/9
        96U3/v80xaz+SYL93U0ylR6/XocXmT55cKJbd0uXYzmLh8SlDcXLn90y9gr6cyzg2b8NnHcO
        8U6K7j+iMvOX3ha9a49DQ57WzNIuV7+ewfLsyw6xO0e3qHv/tN//z8aiTPi0xUPeBMVcJzb+
        OWHWjS9NTe+tiHZdLe+rxFKckWioxVxUnAgARJZgpQoDAAA=
X-CMS-MailID: 20210705031724epcas1p1d89789836e3113e50cc3112a736a7852
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031724epcas1p1d89789836e3113e50cc3112a736a7852
References: <20210705030729.10292-1-namjae.jeon@samsung.com>
        <CGME20210705031724epcas1p1d89789836e3113e50cc3112a736a7852@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This adds server handler for central processing.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/glob.h          |  49 +++
 fs/ksmbd/ksmbd_netlink.h | 395 ++++++++++++++++++++++++
 fs/ksmbd/ksmbd_work.c    |  80 +++++
 fs/ksmbd/ksmbd_work.h    | 117 ++++++++
 fs/ksmbd/server.c        | 633 +++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/server.h        |  70 +++++
 6 files changed, 1344 insertions(+)
 create mode 100644 fs/ksmbd/glob.h
 create mode 100644 fs/ksmbd/ksmbd_netlink.h
 create mode 100644 fs/ksmbd/ksmbd_work.c
 create mode 100644 fs/ksmbd/ksmbd_work.h
 create mode 100644 fs/ksmbd/server.c
 create mode 100644 fs/ksmbd/server.h

diff --git a/fs/ksmbd/glob.h b/fs/ksmbd/glob.h
new file mode 100644
index 000000000000..49a5a3afa118
--- /dev/null
+++ b/fs/ksmbd/glob.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_GLOB_H
+#define __KSMBD_GLOB_H
+
+#include <linux/ctype.h>
+
+#include "unicode.h"
+#include "vfs_cache.h"
+
+#define KSMBD_VERSION	"3.1.9"
+
+extern int ksmbd_debug_types;
+
+#define KSMBD_DEBUG_SMB		BIT(0)
+#define KSMBD_DEBUG_AUTH	BIT(1)
+#define KSMBD_DEBUG_VFS		BIT(2)
+#define KSMBD_DEBUG_OPLOCK      BIT(3)
+#define KSMBD_DEBUG_IPC         BIT(4)
+#define KSMBD_DEBUG_CONN        BIT(5)
+#define KSMBD_DEBUG_RDMA        BIT(6)
+#define KSMBD_DEBUG_ALL         (KSMBD_DEBUG_SMB | KSMBD_DEBUG_AUTH |	\
+				KSMBD_DEBUG_VFS | KSMBD_DEBUG_OPLOCK |	\
+				KSMBD_DEBUG_IPC | KSMBD_DEBUG_CONN |	\
+				KSMBD_DEBUG_RDMA)
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#ifdef SUBMOD_NAME
+#define pr_fmt(fmt)	"ksmbd: " SUBMOD_NAME ": " fmt
+#else
+#define pr_fmt(fmt)	"ksmbd: " fmt
+#endif
+
+#define ksmbd_debug(type, fmt, ...)				\
+	do {							\
+		if (ksmbd_debug_types & KSMBD_DEBUG_##type)	\
+			pr_info(fmt, ##__VA_ARGS__);		\
+	} while (0)
+
+#define UNICODE_LEN(x)		((x) * 2)
+
+#endif /* __KSMBD_GLOB_H */
diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
new file mode 100644
index 000000000000..2fbe2bc1e093
--- /dev/null
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ *
+ *   linux-ksmbd-devel@lists.sourceforge.net
+ */
+
+#ifndef _LINUX_KSMBD_SERVER_H
+#define _LINUX_KSMBD_SERVER_H
+
+#include <linux/types.h>
+
+/*
+ * This is a userspace ABI to communicate data between ksmbd and user IPC
+ * daemon using netlink. This is added to track and cache user account DB
+ * and share configuration info from userspace.
+ *
+ *  - KSMBD_EVENT_HEARTBEAT_REQUEST(ksmbd_heartbeat)
+ *    This event is to check whether user IPC daemon is alive. If user IPC
+ *    daemon is dead, ksmbd keep existing connection till disconnecting and
+ *    new connection will be denied.
+ *
+ *  - KSMBD_EVENT_STARTING_UP(ksmbd_startup_request)
+ *    This event is to receive the information that initializes the ksmbd
+ *    server from the user IPC daemon and to start the server. The global
+ *    section parameters are given from smb.conf as initialization
+ *    information.
+ *
+ *  - KSMBD_EVENT_SHUTTING_DOWN(ksmbd_shutdown_request)
+ *    This event is to shutdown ksmbd server.
+ *
+ *  - KSMBD_EVENT_LOGIN_REQUEST/RESPONSE(ksmbd_login_request/response)
+ *    This event is to get user account info to user IPC daemon.
+ *
+ *  - KSMBD_EVENT_SHARE_CONFIG_REQUEST/RESPONSE(ksmbd_share_config_request/response)
+ *    This event is to get net share configuration info.
+ *
+ *  - KSMBD_EVENT_TREE_CONNECT_REQUEST/RESPONSE(ksmbd_tree_connect_request/response)
+ *    This event is to get session and tree connect info.
+ *
+ *  - KSMBD_EVENT_TREE_DISCONNECT_REQUEST(ksmbd_tree_disconnect_request)
+ *    This event is to send tree disconnect info to user IPC daemon.
+ *
+ *  - KSMBD_EVENT_LOGOUT_REQUEST(ksmbd_logout_request)
+ *    This event is to send logout request to user IPC daemon.
+ *
+ *  - KSMBD_EVENT_RPC_REQUEST/RESPONSE(ksmbd_rpc_command)
+ *    This event is to make DCE/RPC request like srvsvc, wkssvc, lsarpc,
+ *    samr to be processed in userspace.
+ *
+ *  - KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST/RESPONSE(ksmbd_spnego_authen_request/response)
+ *    This event is to make kerberos authentication to be processed in
+ *    userspace.
+ */
+
+#define KSMBD_GENL_NAME		"SMBD_GENL"
+#define KSMBD_GENL_VERSION		0x01
+
+#define KSMBD_REQ_MAX_ACCOUNT_NAME_SZ	48
+#define KSMBD_REQ_MAX_HASH_SZ		18
+#define KSMBD_REQ_MAX_SHARE_NAME	64
+
+/*
+ * IPC heartbeat frame to check whether user IPC daemon is alive.
+ */
+struct ksmbd_heartbeat {
+	__u32	handle;
+};
+
+/*
+ * Global config flags.
+ */
+#define KSMBD_GLOBAL_FLAG_INVALID		(0)
+#define KSMBD_GLOBAL_FLAG_SMB2_LEASES		BIT(0)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
+#define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
+
+/*
+ * IPC request for ksmbd server startup
+ */
+struct ksmbd_startup_request {
+	__u32	flags;			/* Flags for global config */
+	__s32	signing;		/* Signing enabled */
+	__s8	min_prot[16];		/* The minimum SMB protocol version */
+	__s8	max_prot[16];		/* The maximum SMB protocol version */
+	__s8	netbios_name[16];
+	__s8	work_group[64];		/* Workgroup */
+	__s8	server_string[64];	/* Server string */
+	__u16	tcp_port;		/* tcp port */
+	__u16	ipc_timeout;		/*
+					 * specifies the number of seconds
+					 * server will wait for the userspace to
+					 * reply to heartbeat frames.
+					 */
+	__u32	deadtime;		/* Number of minutes of inactivity */
+	__u32	file_max;		/* Limits the maximum number of open files */
+	__u32	smb2_max_write;		/* MAX write size */
+	__u32	smb2_max_read;		/* MAX read size */
+	__u32	smb2_max_trans;		/* MAX trans size */
+	__u32	share_fake_fscaps;	/*
+					 * Support some special application that
+					 * makes QFSINFO calls to check whether
+					 * we set the SPARSE_FILES bit (0x40).
+					 */
+	__u32	sub_auth[3];		/* Subauth value for Security ID */
+	__u32	ifc_list_sz;		/* interfaces list size */
+	__s8	____payload[];
+};
+
+#define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
+
+/*
+ * IPC request to shutdown ksmbd server.
+ */
+struct ksmbd_shutdown_request {
+	__s32	reserved;
+};
+
+/*
+ * IPC user login request.
+ */
+struct ksmbd_login_request {
+	__u32	handle;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ]; /* user account name */
+};
+
+/*
+ * IPC user login response.
+ */
+struct ksmbd_login_response {
+	__u32	handle;
+	__u32	gid;					/* group id */
+	__u32	uid;					/* user id */
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ]; /* user account name */
+	__u16	status;
+	__u16	hash_sz;			/* hash size */
+	__s8	hash[KSMBD_REQ_MAX_HASH_SZ];	/* password hash */
+};
+
+/*
+ * IPC request to fetch net share config.
+ */
+struct ksmbd_share_config_request {
+	__u32	handle;
+	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME]; /* share name */
+};
+
+/*
+ * IPC response to the net share config request.
+ */
+struct ksmbd_share_config_response {
+	__u32	handle;
+	__u32	flags;
+	__u16	create_mask;
+	__u16	directory_mask;
+	__u16	force_create_mode;
+	__u16	force_directory_mode;
+	__u16	force_uid;
+	__u16	force_gid;
+	__u32	veto_list_sz;
+	__s8	____payload[];
+};
+
+#define KSMBD_SHARE_CONFIG_VETO_LIST(s)	((s)->____payload)
+
+static inline char *
+ksmbd_share_config_path(struct ksmbd_share_config_response *sc)
+{
+	char *p = sc->____payload;
+
+	if (sc->veto_list_sz)
+		p += sc->veto_list_sz + 1;
+
+	return p;
+}
+
+/*
+ * IPC request for tree connection. This request include session and tree
+ * connect info from client.
+ */
+struct ksmbd_tree_connect_request {
+	__u32	handle;
+	__u16	account_flags;
+	__u16	flags;
+	__u64	session_id;
+	__u64	connect_id;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+	__s8	share[KSMBD_REQ_MAX_SHARE_NAME];
+	__s8	peer_addr[64];
+};
+
+/*
+ * IPC Response structure for tree connection.
+ */
+struct ksmbd_tree_connect_response {
+	__u32	handle;
+	__u16	status;
+	__u16	connection_flags;
+};
+
+/*
+ * IPC Request struture to disconnect tree connection.
+ */
+struct ksmbd_tree_disconnect_request {
+	__u64	session_id;	/* session id */
+	__u64	connect_id;	/* tree connection id */
+};
+
+/*
+ * IPC Response structure to logout user account.
+ */
+struct ksmbd_logout_request {
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ]; /* user account name */
+};
+
+/*
+ * RPC command structure to send rpc request like srvsvc or wkssvc to
+ * IPC user daemon.
+ */
+struct ksmbd_rpc_command {
+	__u32	handle;
+	__u32	flags;
+	__u32	payload_sz;
+	__u8	payload[];
+};
+
+/*
+ * IPC Request Kerberos authentication
+ */
+struct ksmbd_spnego_authen_request {
+	__u32	handle;
+	__u16	spnego_blob_len;	/* the length of spnego_blob */
+	__u8	spnego_blob[0];		/*
+					 * the GSS token from SecurityBuffer of
+					 * SMB2 SESSION SETUP request
+					 */
+};
+
+/*
+ * Response data which includes the GSS token and the session key generated by
+ * user daemon.
+ */
+struct ksmbd_spnego_authen_response {
+	__u32	handle;
+	struct ksmbd_login_response login_response; /*
+						     * the login response with
+						     * a user identified by the
+						     * GSS token from a client
+						     */
+	__u16	session_key_len; /* the length of the session key */
+	__u16	spnego_blob_len; /*
+				  * the length of  the GSS token which will be
+				  * stored in SecurityBuffer of SMB2 SESSION
+				  * SETUP response
+				  */
+	__u8	payload[]; /* session key + AP_REP */
+};
+
+/*
+ * This also used as NETLINK attribute type value.
+ *
+ * NOTE:
+ * Response message type value should be equal to
+ * request message type value + 1.
+ */
+enum ksmbd_event {
+	KSMBD_EVENT_UNSPEC			= 0,
+	KSMBD_EVENT_HEARTBEAT_REQUEST,
+
+	KSMBD_EVENT_STARTING_UP,
+	KSMBD_EVENT_SHUTTING_DOWN,
+
+	KSMBD_EVENT_LOGIN_REQUEST,
+	KSMBD_EVENT_LOGIN_RESPONSE		= 5,
+
+	KSMBD_EVENT_SHARE_CONFIG_REQUEST,
+	KSMBD_EVENT_SHARE_CONFIG_RESPONSE,
+
+	KSMBD_EVENT_TREE_CONNECT_REQUEST,
+	KSMBD_EVENT_TREE_CONNECT_RESPONSE,
+
+	KSMBD_EVENT_TREE_DISCONNECT_REQUEST	= 10,
+
+	KSMBD_EVENT_LOGOUT_REQUEST,
+
+	KSMBD_EVENT_RPC_REQUEST,
+	KSMBD_EVENT_RPC_RESPONSE,
+
+	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
+	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
+
+	KSMBD_EVENT_MAX
+};
+
+/*
+ * Enumeration for IPC tree connect status.
+ */
+enum KSMBD_TREE_CONN_STATUS {
+	KSMBD_TREE_CONN_STATUS_OK		= 0,
+	KSMBD_TREE_CONN_STATUS_NOMEM,
+	KSMBD_TREE_CONN_STATUS_NO_SHARE,
+	KSMBD_TREE_CONN_STATUS_NO_USER,
+	KSMBD_TREE_CONN_STATUS_INVALID_USER,
+	KSMBD_TREE_CONN_STATUS_HOST_DENIED	= 5,
+	KSMBD_TREE_CONN_STATUS_CONN_EXIST,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_CONNS,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_SESSIONS,
+	KSMBD_TREE_CONN_STATUS_ERROR,
+};
+
+/*
+ * User config flags.
+ */
+#define KSMBD_USER_FLAG_INVALID		(0)
+#define KSMBD_USER_FLAG_OK		BIT(0)
+#define KSMBD_USER_FLAG_BAD_PASSWORD	BIT(1)
+#define KSMBD_USER_FLAG_BAD_UID		BIT(2)
+#define KSMBD_USER_FLAG_BAD_USER	BIT(3)
+#define KSMBD_USER_FLAG_GUEST_ACCOUNT	BIT(4)
+
+/*
+ * Share config flags.
+ */
+#define KSMBD_SHARE_FLAG_INVALID		(0)
+#define KSMBD_SHARE_FLAG_AVAILABLE		BIT(0)
+#define KSMBD_SHARE_FLAG_BROWSEABLE		BIT(1)
+#define KSMBD_SHARE_FLAG_WRITEABLE		BIT(2)
+#define KSMBD_SHARE_FLAG_READONLY		BIT(3)
+#define KSMBD_SHARE_FLAG_GUEST_OK		BIT(4)
+#define KSMBD_SHARE_FLAG_GUEST_ONLY		BIT(5)
+#define KSMBD_SHARE_FLAG_STORE_DOS_ATTRS	BIT(6)
+#define KSMBD_SHARE_FLAG_OPLOCKS		BIT(7)
+#define KSMBD_SHARE_FLAG_PIPE			BIT(8)
+#define KSMBD_SHARE_FLAG_HIDE_DOT_FILES		BIT(9)
+#define KSMBD_SHARE_FLAG_INHERIT_OWNER		BIT(10)
+#define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
+#define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
+#define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
+
+/*
+ * Tree connect request flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB1	(0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_IPV6	BIT(0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB2	BIT(1)
+
+/*
+ * Tree connect flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_GUEST_ACCOUNT	BIT(0)
+#define KSMBD_TREE_CONN_FLAG_READ_ONLY		BIT(1)
+#define KSMBD_TREE_CONN_FLAG_WRITABLE		BIT(2)
+#define KSMBD_TREE_CONN_FLAG_ADMIN_ACCOUNT	BIT(3)
+
+/*
+ * RPC over IPC.
+ */
+#define KSMBD_RPC_METHOD_RETURN		BIT(0)
+#define KSMBD_RPC_SRVSVC_METHOD_INVOKE	BIT(1)
+#define KSMBD_RPC_SRVSVC_METHOD_RETURN	(KSMBD_RPC_SRVSVC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_WKSSVC_METHOD_INVOKE	BIT(2)
+#define KSMBD_RPC_WKSSVC_METHOD_RETURN	(KSMBD_RPC_WKSSVC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_IOCTL_METHOD		(BIT(3) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_OPEN_METHOD		BIT(4)
+#define KSMBD_RPC_WRITE_METHOD		BIT(5)
+#define KSMBD_RPC_READ_METHOD		(BIT(6) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_CLOSE_METHOD		BIT(7)
+#define KSMBD_RPC_RAP_METHOD		(BIT(8) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_RESTRICTED_CONTEXT	BIT(9)
+#define KSMBD_RPC_SAMR_METHOD_INVOKE	BIT(10)
+#define KSMBD_RPC_SAMR_METHOD_RETURN	(KSMBD_RPC_SAMR_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_LSARPC_METHOD_INVOKE	BIT(11)
+#define KSMBD_RPC_LSARPC_METHOD_RETURN	(KSMBD_RPC_LSARPC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+
+/*
+ * RPC status definitions.
+ */
+#define KSMBD_RPC_OK			0
+#define KSMBD_RPC_EBAD_FUNC		0x00000001
+#define KSMBD_RPC_EACCESS_DENIED	0x00000005
+#define KSMBD_RPC_EBAD_FID		0x00000006
+#define KSMBD_RPC_ENOMEM		0x00000008
+#define KSMBD_RPC_EBAD_DATA		0x0000000D
+#define KSMBD_RPC_ENOTIMPLEMENTED	0x00000040
+#define KSMBD_RPC_EINVALID_PARAMETER	0x00000057
+#define KSMBD_RPC_EMORE_DATA		0x000000EA
+#define KSMBD_RPC_EINVALID_LEVEL	0x0000007C
+#define KSMBD_RPC_SOME_NOT_MAPPED	0x00000107
+
+#define KSMBD_CONFIG_OPT_DISABLED	0
+#define KSMBD_CONFIG_OPT_ENABLED	1
+#define KSMBD_CONFIG_OPT_AUTO		2
+#define KSMBD_CONFIG_OPT_MANDATORY	3
+
+#endif /* _LINUX_KSMBD_SERVER_H */
diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
new file mode 100644
index 000000000000..fd58eb4809f6
--- /dev/null
+++ b/fs/ksmbd/ksmbd_work.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "server.h"
+#include "connection.h"
+#include "ksmbd_work.h"
+#include "mgmt/ksmbd_ida.h"
+
+static struct kmem_cache *work_cache;
+static struct workqueue_struct *ksmbd_wq;
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void)
+{
+	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, GFP_KERNEL);
+
+	if (work) {
+		work->compound_fid = KSMBD_NO_FID;
+		work->compound_pfid = KSMBD_NO_FID;
+		INIT_LIST_HEAD(&work->request_entry);
+		INIT_LIST_HEAD(&work->async_request_entry);
+		INIT_LIST_HEAD(&work->fp_entry);
+		INIT_LIST_HEAD(&work->interim_entry);
+	}
+	return work;
+}
+
+void ksmbd_free_work_struct(struct ksmbd_work *work)
+{
+	WARN_ON(work->saved_cred != NULL);
+
+	kvfree(work->response_buf);
+	kvfree(work->aux_payload_buf);
+	kfree(work->tr_buf);
+	kvfree(work->request_buf);
+	if (work->async_id)
+		ksmbd_release_id(&work->conn->async_ida, work->async_id);
+	kmem_cache_free(work_cache, work);
+}
+
+void ksmbd_work_pool_destroy(void)
+{
+	kmem_cache_destroy(work_cache);
+}
+
+int ksmbd_work_pool_init(void)
+{
+	work_cache = kmem_cache_create("ksmbd_work_cache",
+				       sizeof(struct ksmbd_work), 0,
+				       SLAB_HWCACHE_ALIGN, NULL);
+	if (!work_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_workqueue_init(void)
+{
+	ksmbd_wq = alloc_workqueue("ksmbd-io", 0, 0);
+	if (!ksmbd_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void ksmbd_workqueue_destroy(void)
+{
+	flush_workqueue(ksmbd_wq);
+	destroy_workqueue(ksmbd_wq);
+	ksmbd_wq = NULL;
+}
+
+bool ksmbd_queue_work(struct ksmbd_work *work)
+{
+	return queue_work(ksmbd_wq, &work->work);
+}
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
new file mode 100644
index 000000000000..c655bf371ce5
--- /dev/null
+++ b/fs/ksmbd/ksmbd_work.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_WORK_H__
+#define __KSMBD_WORK_H__
+
+#include <linux/ctype.h>
+#include <linux/workqueue.h>
+
+struct ksmbd_conn;
+struct ksmbd_session;
+struct ksmbd_tree_connect;
+
+enum {
+	KSMBD_WORK_ACTIVE = 0,
+	KSMBD_WORK_CANCELLED,
+	KSMBD_WORK_CLOSED,
+};
+
+/* one of these for every pending CIFS request at the connection */
+struct ksmbd_work {
+	/* Server corresponding to this mid */
+	struct ksmbd_conn               *conn;
+	struct ksmbd_session            *sess;
+	struct ksmbd_tree_connect       *tcon;
+
+	/* Pointer to received SMB header */
+	void                            *request_buf;
+	/* Response buffer */
+	void                            *response_buf;
+
+	/* Read data buffer */
+	void                            *aux_payload_buf;
+
+	/* Next cmd hdr in compound req buf*/
+	int                             next_smb2_rcv_hdr_off;
+	/* Next cmd hdr in compound rsp buf*/
+	int                             next_smb2_rsp_hdr_off;
+
+	/*
+	 * Current Local FID assigned compound response if SMB2 CREATE
+	 * command is present in compound request
+	 */
+	unsigned int                    compound_fid;
+	unsigned int                    compound_pfid;
+	unsigned int                    compound_sid;
+
+	const struct cred		*saved_cred;
+
+	/* Number of granted credits */
+	unsigned int			credits_granted;
+
+	/* response smb header size */
+	unsigned int                    resp_hdr_sz;
+	unsigned int                    response_sz;
+	/* Read data count */
+	unsigned int                    aux_payload_sz;
+
+	void				*tr_buf;
+
+	unsigned char			state;
+	/* Multiple responses for one request e.g. SMB ECHO */
+	bool                            multiRsp:1;
+	/* No response for cancelled request */
+	bool                            send_no_response:1;
+	/* Request is encrypted */
+	bool                            encrypted:1;
+	/* Is this SYNC or ASYNC ksmbd_work */
+	bool                            syncronous:1;
+	bool                            need_invalidate_rkey:1;
+
+	unsigned int                    remote_key;
+	/* cancel works */
+	int                             async_id;
+	void                            **cancel_argv;
+	void                            (*cancel_fn)(void **argv);
+
+	struct work_struct              work;
+	/* List head at conn->requests */
+	struct list_head                request_entry;
+	/* List head at conn->async_requests */
+	struct list_head                async_request_entry;
+	struct list_head                fp_entry;
+	struct list_head                interim_entry;
+};
+
+/**
+ * ksmbd_resp_buf_next - Get next buffer on compound response.
+ * @work: smb work containing response buffer
+ */
+static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
+{
+	return work->response_buf + work->next_smb2_rsp_hdr_off;
+}
+
+/**
+ * ksmbd_req_buf_next - Get next buffer on compound request.
+ * @work: smb work containing response buffer
+ */
+static inline void *ksmbd_req_buf_next(struct ksmbd_work *work)
+{
+	return work->request_buf + work->next_smb2_rcv_hdr_off;
+}
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void);
+void ksmbd_free_work_struct(struct ksmbd_work *work);
+
+void ksmbd_work_pool_destroy(void);
+int ksmbd_work_pool_init(void);
+
+int ksmbd_workqueue_init(void);
+void ksmbd_workqueue_destroy(void);
+bool ksmbd_queue_work(struct ksmbd_work *work);
+
+#endif /* __KSMBD_WORK_H__ */
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
new file mode 100644
index 000000000000..a8c59e96a2f7
--- /dev/null
+++ b/fs/ksmbd/server.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "glob.h"
+#include "oplock.h"
+#include "misc.h"
+#include <linux/sched/signal.h>
+#include <linux/workqueue.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "server.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "connection.h"
+#include "transport_ipc.h"
+#include "mgmt/user_session.h"
+#include "crypto_ctx.h"
+#include "auth.h"
+
+int ksmbd_debug_types;
+
+struct ksmbd_server_config server_conf;
+
+enum SERVER_CTRL_TYPE {
+	SERVER_CTRL_TYPE_INIT,
+	SERVER_CTRL_TYPE_RESET,
+};
+
+struct server_ctrl_struct {
+	int			type;
+	struct work_struct	ctrl_work;
+};
+
+static DEFINE_MUTEX(ctrl_lock);
+
+static int ___server_conf_set(int idx, char *val)
+{
+	if (idx >= ARRAY_SIZE(server_conf.conf))
+		return -EINVAL;
+
+	if (!val || val[0] == 0x00)
+		return -EINVAL;
+
+	kfree(server_conf.conf[idx]);
+	server_conf.conf[idx] = kstrdup(val, GFP_KERNEL);
+	if (!server_conf.conf[idx])
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_set_netbios_name(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_NETBIOS_NAME, v);
+}
+
+int ksmbd_set_server_string(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_SERVER_STRING, v);
+}
+
+int ksmbd_set_work_group(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_WORK_GROUP, v);
+}
+
+char *ksmbd_netbios_name(void)
+{
+	return server_conf.conf[SERVER_CONF_NETBIOS_NAME];
+}
+
+char *ksmbd_server_string(void)
+{
+	return server_conf.conf[SERVER_CONF_SERVER_STRING];
+}
+
+char *ksmbd_work_group(void)
+{
+	return server_conf.conf[SERVER_CONF_WORK_GROUP];
+}
+
+/**
+ * check_conn_state() - check state of server thread connection
+ * @work:     smb work containing server thread information
+ *
+ * Return:	0 on valid connection, otherwise 1 to reconnect
+ */
+static inline int check_conn_state(struct ksmbd_work *work)
+{
+	struct smb_hdr *rsp_hdr;
+
+	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+		rsp_hdr = work->response_buf;
+		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
+		return 1;
+	}
+	return 0;
+}
+
+#define TCP_HANDLER_CONTINUE	0
+#define TCP_HANDLER_ABORT	1
+
+static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
+			     u16 *cmd)
+{
+	struct smb_version_cmds *cmds;
+	u16 command;
+	int ret;
+
+	if (check_conn_state(work))
+		return TCP_HANDLER_CONTINUE;
+
+	if (ksmbd_verify_smb_message(work))
+		return TCP_HANDLER_ABORT;
+
+	command = conn->ops->get_cmd_val(work);
+	*cmd = command;
+
+andx_again:
+	if (command >= conn->max_cmds) {
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	cmds = &conn->cmds[command];
+	if (!cmds->proc) {
+		ksmbd_debug(SMB, "*** not implemented yet cmd = %x\n", command);
+		conn->ops->set_rsp_status(work, STATUS_NOT_IMPLEMENTED);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	if (work->sess && conn->ops->is_sign_req(work, command)) {
+		ret = conn->ops->check_sign_req(work);
+		if (!ret) {
+			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+			return TCP_HANDLER_CONTINUE;
+		}
+	}
+
+	ret = cmds->proc(work);
+
+	if (ret < 0)
+		ksmbd_debug(CONN, "Failed to process %u [%d]\n", command, ret);
+	/* AndX commands - chained request can return positive values */
+	else if (ret > 0) {
+		command = ret;
+		*cmd = command;
+		goto andx_again;
+	}
+
+	if (work->send_no_response)
+		return TCP_HANDLER_ABORT;
+	return TCP_HANDLER_CONTINUE;
+}
+
+static void __handle_ksmbd_work(struct ksmbd_work *work,
+				struct ksmbd_conn *conn)
+{
+	u16 command = 0;
+	int rc;
+
+	if (conn->ops->allocate_rsp_buf(work))
+		return;
+
+	if (conn->ops->is_transform_hdr &&
+	    conn->ops->is_transform_hdr(work->request_buf)) {
+		rc = conn->ops->decrypt_req(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+
+		work->encrypted = true;
+	}
+
+	rc = conn->ops->init_rsp_hdr(work);
+	if (rc) {
+		/* either uid or tid is not correct */
+		conn->ops->set_rsp_status(work, STATUS_INVALID_HANDLE);
+		goto send;
+	}
+
+	if (conn->ops->check_user_session) {
+		rc = conn->ops->check_user_session(work);
+		if (rc < 0) {
+			command = conn->ops->get_cmd_val(work);
+			conn->ops->set_rsp_status(work,
+					STATUS_USER_SESSION_DELETED);
+			goto send;
+		} else if (rc > 0) {
+			rc = conn->ops->get_ksmbd_tcon(work);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_NETWORK_NAME_DELETED);
+				goto send;
+			}
+		}
+	}
+
+	do {
+		rc = __process_request(work, conn, &command);
+		if (rc == TCP_HANDLER_ABORT)
+			break;
+
+		/*
+		 * Call smb2_set_rsp_credits() function to set number of credits
+		 * granted in hdr of smb2 response.
+		 */
+		if (conn->ops->set_rsp_credits) {
+			spin_lock(&conn->credits_lock);
+			rc = conn->ops->set_rsp_credits(work);
+			spin_unlock(&conn->credits_lock);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_INVALID_PARAMETER);
+				goto send;
+			}
+		}
+
+		if (work->sess &&
+		    (work->sess->sign || smb3_11_final_sess_setup_resp(work) ||
+		     conn->ops->is_sign_req(work, command)))
+			conn->ops->set_sign_rsp(work);
+	} while (is_chained_smb2_message(work));
+
+	if (work->send_no_response)
+		return;
+
+send:
+	smb3_preauth_hash_rsp(work);
+	if (work->sess && work->sess->enc && work->encrypted &&
+	    conn->ops->encrypt_resp) {
+		rc = conn->ops->encrypt_resp(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+	}
+
+	ksmbd_conn_write(work);
+}
+
+/**
+ * handle_ksmbd_work() - process pending smb work requests
+ * @wk:	smb work containing request command buffer
+ *
+ * called by kworker threads to processing remaining smb work requests
+ */
+static void handle_ksmbd_work(struct work_struct *wk)
+{
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct ksmbd_conn *conn = work->conn;
+
+	atomic64_inc(&conn->stats.request_served);
+
+	__handle_ksmbd_work(work, conn);
+
+	ksmbd_conn_try_dequeue_request(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * queue_ksmbd_work() - queue a smb request to worker thread queue
+ *		for proccessing smb command and sending response
+ * @conn:	connection instance
+ *
+ * read remaining data from socket create and submit work.
+ */
+static int queue_ksmbd_work(struct ksmbd_conn *conn)
+{
+	struct ksmbd_work *work;
+
+	work = ksmbd_alloc_work_struct();
+	if (!work) {
+		pr_err("allocation for work failed\n");
+		return -ENOMEM;
+	}
+
+	work->conn = conn;
+	work->request_buf = conn->request_buf;
+	conn->request_buf = NULL;
+
+	if (ksmbd_init_smb_server(work)) {
+		ksmbd_free_work_struct(work);
+		return -EINVAL;
+	}
+
+	ksmbd_conn_enqueue_request(work);
+	atomic_inc(&conn->r_count);
+	/* update activity on connection */
+	conn->last_active = jiffies;
+	INIT_WORK(&work->work, handle_ksmbd_work);
+	ksmbd_queue_work(work);
+	return 0;
+}
+
+static int ksmbd_server_process_request(struct ksmbd_conn *conn)
+{
+	return queue_ksmbd_work(conn);
+}
+
+static int ksmbd_server_terminate_conn(struct ksmbd_conn *conn)
+{
+	ksmbd_sessions_deregister(conn);
+	destroy_lease_table(conn);
+	return 0;
+}
+
+static void ksmbd_server_tcp_callbacks_init(void)
+{
+	struct ksmbd_conn_ops ops;
+
+	ops.process_fn = ksmbd_server_process_request;
+	ops.terminate_fn = ksmbd_server_terminate_conn;
+
+	ksmbd_conn_init_server_callbacks(&ops);
+}
+
+static void server_conf_free(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(server_conf.conf); i++) {
+		kfree(server_conf.conf[i]);
+		server_conf.conf[i] = NULL;
+	}
+}
+
+static int server_conf_init(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+	server_conf.enforced_signing = 0;
+	server_conf.min_protocol = ksmbd_min_protocol();
+	server_conf.max_protocol = ksmbd_max_protocol();
+	server_conf.auth_mechs = KSMBD_AUTH_NTLMSSP;
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+	server_conf.auth_mechs |= KSMBD_AUTH_KRB5 |
+				KSMBD_AUTH_MSKRB5;
+#endif
+	return 0;
+}
+
+static void server_ctrl_handle_init(struct server_ctrl_struct *ctrl)
+{
+	int ret;
+
+	ret = ksmbd_conn_transport_init();
+	if (ret) {
+		server_queue_ctrl_reset_work();
+		return;
+	}
+
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RUNNING);
+}
+
+static void server_ctrl_handle_reset(struct server_ctrl_struct *ctrl)
+{
+	ksmbd_ipc_soft_reset();
+	ksmbd_conn_transport_destroy();
+	server_conf_free();
+	server_conf_init();
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+}
+
+static void server_ctrl_handle_work(struct work_struct *work)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = container_of(work, struct server_ctrl_struct, ctrl_work);
+
+	mutex_lock(&ctrl_lock);
+	switch (ctrl->type) {
+	case SERVER_CTRL_TYPE_INIT:
+		server_ctrl_handle_init(ctrl);
+		break;
+	case SERVER_CTRL_TYPE_RESET:
+		server_ctrl_handle_reset(ctrl);
+		break;
+	default:
+		pr_err("Unknown server work type: %d\n", ctrl->type);
+	}
+	mutex_unlock(&ctrl_lock);
+	kfree(ctrl);
+	module_put(THIS_MODULE);
+}
+
+static int __queue_ctrl_work(int type)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = kmalloc(sizeof(struct server_ctrl_struct), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	__module_get(THIS_MODULE);
+	ctrl->type = type;
+	INIT_WORK(&ctrl->ctrl_work, server_ctrl_handle_work);
+	queue_work(system_long_wq, &ctrl->ctrl_work);
+	return 0;
+}
+
+int server_queue_ctrl_init_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_INIT);
+}
+
+int server_queue_ctrl_reset_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_RESET);
+}
+
+static ssize_t stats_show(struct class *class, struct class_attribute *attr,
+			  char *buf)
+{
+	/*
+	 * Inc this each time you change stats output format,
+	 * so user space will know what to do.
+	 */
+	static int stats_version = 2;
+	static const char * const state[] = {
+		"startup",
+		"running",
+		"reset",
+		"shutdown"
+	};
+
+	ssize_t sz = scnprintf(buf, PAGE_SIZE, "%d %s %d %lu\n", stats_version,
+			       state[server_conf.state], server_conf.tcp_port,
+			       server_conf.ipc_last_active / HZ);
+	return sz;
+}
+
+static ssize_t kill_server_store(struct class *class,
+				 struct class_attribute *attr, const char *buf,
+				 size_t len)
+{
+	if (!sysfs_streq(buf, "hard"))
+		return len;
+
+	pr_info("kill command received\n");
+	mutex_lock(&ctrl_lock);
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RESETTING);
+	__module_get(THIS_MODULE);
+	server_ctrl_handle_reset(NULL);
+	module_put(THIS_MODULE);
+	mutex_unlock(&ctrl_lock);
+	return len;
+}
+
+static const char * const debug_type_strings[] = {"smb", "auth", "vfs",
+						  "oplock", "ipc", "conn",
+						  "rdma"};
+
+static ssize_t debug_show(struct class *class, struct class_attribute *attr,
+			  char *buf)
+{
+	ssize_t sz = 0;
+	int i, pos = 0;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if ((ksmbd_debug_types >> i) & 1) {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"[%s] ",
+					debug_type_strings[i]);
+		} else {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"%s ",
+					debug_type_strings[i]);
+		}
+		sz += pos;
+	}
+	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	return sz;
+}
+
+static ssize_t debug_store(struct class *class, struct class_attribute *attr,
+			   const char *buf, size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if (sysfs_streq(buf, "all")) {
+			if (ksmbd_debug_types == KSMBD_DEBUG_ALL)
+				ksmbd_debug_types = 0;
+			else
+				ksmbd_debug_types = KSMBD_DEBUG_ALL;
+			break;
+		}
+
+		if (sysfs_streq(buf, debug_type_strings[i])) {
+			if (ksmbd_debug_types & (1 << i))
+				ksmbd_debug_types &= ~(1 << i);
+			else
+				ksmbd_debug_types |= (1 << i);
+			break;
+		}
+	}
+
+	return len;
+}
+
+static CLASS_ATTR_RO(stats);
+static CLASS_ATTR_WO(kill_server);
+static CLASS_ATTR_RW(debug);
+
+static struct attribute *ksmbd_control_class_attrs[] = {
+	&class_attr_stats.attr,
+	&class_attr_kill_server.attr,
+	&class_attr_debug.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ksmbd_control_class);
+
+static struct class ksmbd_control_class = {
+	.name		= "ksmbd-control",
+	.owner		= THIS_MODULE,
+	.class_groups	= ksmbd_control_class_groups,
+};
+
+static int ksmbd_server_shutdown(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_SHUTTING_DOWN);
+
+	class_unregister(&ksmbd_control_class);
+	ksmbd_workqueue_destroy();
+	ksmbd_ipc_release();
+	ksmbd_conn_transport_destroy();
+	ksmbd_crypto_destroy();
+	ksmbd_free_global_file_table();
+	destroy_lease_table(NULL);
+	ksmbd_work_pool_destroy();
+	ksmbd_exit_file_cache();
+	server_conf_free();
+	return 0;
+}
+
+static int __init ksmbd_server_init(void)
+{
+	int ret;
+
+	ret = class_register(&ksmbd_control_class);
+	if (ret) {
+		pr_err("Unable to register ksmbd-control class\n");
+		return ret;
+	}
+
+	ksmbd_server_tcp_callbacks_init();
+
+	ret = server_conf_init();
+	if (ret)
+		goto err_unregister;
+
+	ret = ksmbd_work_pool_init();
+	if (ret)
+		goto err_unregister;
+
+	ret = ksmbd_init_file_cache();
+	if (ret)
+		goto err_destroy_work_pools;
+
+	ret = ksmbd_ipc_init();
+	if (ret)
+		goto err_exit_file_cache;
+
+	ret = ksmbd_init_global_file_table();
+	if (ret)
+		goto err_ipc_release;
+
+	ret = ksmbd_inode_hash_init();
+	if (ret)
+		goto err_destroy_file_table;
+
+	ret = ksmbd_crypto_create();
+	if (ret)
+		goto err_release_inode_hash;
+
+	ret = ksmbd_workqueue_init();
+	if (ret)
+		goto err_crypto_destroy;
+	return 0;
+
+err_crypto_destroy:
+	ksmbd_crypto_destroy();
+err_release_inode_hash:
+	ksmbd_release_inode_hash();
+err_destroy_file_table:
+	ksmbd_free_global_file_table();
+err_ipc_release:
+	ksmbd_ipc_release();
+err_exit_file_cache:
+	ksmbd_exit_file_cache();
+err_destroy_work_pools:
+	ksmbd_work_pool_destroy();
+err_unregister:
+	class_unregister(&ksmbd_control_class);
+
+	return ret;
+}
+
+/**
+ * ksmbd_server_exit() - shutdown forker thread and free memory at module exit
+ */
+static void __exit ksmbd_server_exit(void)
+{
+	ksmbd_server_shutdown();
+	ksmbd_release_inode_hash();
+}
+
+MODULE_AUTHOR("Namjae Jeon <linkinjeon@kernel.org>");
+MODULE_VERSION(KSMBD_VERSION);
+MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ecb");
+MODULE_SOFTDEP("pre: hmac");
+MODULE_SOFTDEP("pre: md4");
+MODULE_SOFTDEP("pre: md5");
+MODULE_SOFTDEP("pre: nls");
+MODULE_SOFTDEP("pre: aes");
+MODULE_SOFTDEP("pre: cmac");
+MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: sha512");
+MODULE_SOFTDEP("pre: aead2");
+MODULE_SOFTDEP("pre: ccm");
+MODULE_SOFTDEP("pre: gcm");
+module_init(ksmbd_server_init)
+module_exit(ksmbd_server_exit)
diff --git a/fs/ksmbd/server.h b/fs/ksmbd/server.h
new file mode 100644
index 000000000000..ac9d932f8c8a
--- /dev/null
+++ b/fs/ksmbd/server.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SERVER_H__
+#define __SERVER_H__
+
+#include "smbacl.h"
+
+/*
+ * Server state type
+ */
+enum {
+	SERVER_STATE_STARTING_UP,
+	SERVER_STATE_RUNNING,
+	SERVER_STATE_RESETTING,
+	SERVER_STATE_SHUTTING_DOWN,
+};
+
+/*
+ * Server global config string index
+ */
+enum {
+	SERVER_CONF_NETBIOS_NAME,
+	SERVER_CONF_SERVER_STRING,
+	SERVER_CONF_WORK_GROUP,
+};
+
+struct ksmbd_server_config {
+	unsigned int		flags;
+	unsigned int		state;
+	short			signing;
+	short			enforced_signing;
+	short			min_protocol;
+	short			max_protocol;
+	unsigned short		tcp_port;
+	unsigned short		ipc_timeout;
+	unsigned long		ipc_last_active;
+	unsigned long		deadtime;
+	unsigned int		share_fake_fscaps;
+	struct smb_sid		domain_sid;
+	unsigned int		auth_mechs;
+
+	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+};
+
+extern struct ksmbd_server_config server_conf;
+
+int ksmbd_set_netbios_name(char *v);
+int ksmbd_set_server_string(char *v);
+int ksmbd_set_work_group(char *v);
+
+char *ksmbd_netbios_name(void);
+char *ksmbd_server_string(void);
+char *ksmbd_work_group(void);
+
+static inline int ksmbd_server_running(void)
+{
+	return READ_ONCE(server_conf.state) == SERVER_STATE_RUNNING;
+}
+
+static inline int ksmbd_server_configurable(void)
+{
+	return READ_ONCE(server_conf.state) < SERVER_STATE_RESETTING;
+}
+
+int server_queue_ctrl_init_work(void);
+int server_queue_ctrl_reset_work(void);
+#endif /* __SERVER_H__ */
-- 
2.17.1

