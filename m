Return-Path: <linux-cifs+bounces-7265-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89885C1B68B
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Oct 2025 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8299C1AA16D6
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Oct 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD3325705;
	Wed, 29 Oct 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Snfgmei2"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2891325709
	for <linux-cifs@vger.kernel.org>; Wed, 29 Oct 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748781; cv=none; b=cj0XG7aMRMkfnqtJ57/kw7ltW/kYkoFYpN7AsnacSYTghxP9ePDSEBzwmgtaAd8HlcSzKVh36F5zcRLTa1zAkXkfKddRWWg8b0jbxRvOvc+fkLL3sU8h8UKxcOGtPfwxwgGYCttdThb9DetYFipNvuEzGr/FjTkCCHb3QdgsbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748781; c=relaxed/simple;
	bh=EhMXmNOrACkd3F8tBD1wWtMKRhqXKutNA3qPY2aCeEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV6TWVk7UAOTSmt/dq2w9bLVlpkk6MVuk0zmsLlap+DNJOX7yRN52CHPTSMYkmlpjQ4I1R8EpGZ/bjNOjK0X3/hD4vp7Pf/9WxbNaFAVUhGtY8/sQ/ZPUgEIft3C8BUygn1h4LtnWXbep2y3RAGGRHe7Yaj8obMeOz+GgFO1ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Snfgmei2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c237eca60so61043896d6.1
        for <linux-cifs@vger.kernel.org>; Wed, 29 Oct 2025 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748778; x=1762353578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X04SYoNLU4lXihy/7jokwRTkJAnHLaJrwIaMuXlpVk=;
        b=Snfgmei2eA34cWYnPqbwCdZ37C79aoWrzxzD9jYGu40ZFe1IAF+d9m5avVagGgjbQ7
         GybsMtcf5bDEvMQrryOG5R6VuSB8928okQ989g34XUx8WmjNoX6spHgN995xKlpBBiwU
         uytX8PkoTs2/5tOQkDV+lzBQrn2slEH3/LIQ47WERekkPPAXVo3kmVobEmIs4dnZsZpq
         CPJyTHCViRZAtZFnPivolVkEKMRM7B64GzZ945Oa30EVtvRd8cwP/Zg5KPH2LL1GsbEI
         9BfRPQcJQck8af5PfUncB2RgwedCiPijtTSYoyCaRoEQj+DKZ2bODdcB1K6hjUBsyIlY
         Pulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748778; x=1762353578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X04SYoNLU4lXihy/7jokwRTkJAnHLaJrwIaMuXlpVk=;
        b=F2c5unSpp30rG+9qffhWu+RYRq4LxGAbE2eOojKIyg2jKbGnUYJz2//qp3B9LQB9Xf
         DOy4KHaktOJm4tbIkswXG0dhEcVnVuhJR0JZLTv9GsFu9p9v9lStzgRs3VvhSVQUc5n1
         l2swhH4RzuUz4QFadO/EvHHZ59f1U7xFPc13pFhRRI+BCPgC4F2FsO6eNXLYvUXFxYG4
         2Y2s081pEVUbnGfEpB12qoui1aqjHmH8jtiUjEH4ELxjfM1aVQjSji1vEngJqD82GAFn
         CCMbeenyI7MGchr8oFh+26sOj2n0Eb1Udv5S3g0/uibyWHKvsWWj/ywMU7TeEEAyNeNQ
         kyvg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0P2j1lOvJiHX70dZZMpuzdMQ8ZboA952g7VCCXLCztAH7ox+4hz9uqUO2sAusCvq25XxaK/KzPBf@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDkAlf/ArToMJ5uKaB0+a20lVUDljDOXkV9lnM4PuH/uy88S5
	sHM9UONYH0YSrcJWNCRF9MrfFrexDvBMhm6kVklS4c9buHUUsOmbDVBR
X-Gm-Gg: ASbGnctsJnI8uVtBhslNTySefkHtCFUdYRdEic3OBjP/a00Er/b60lB9/oBRlq3Ptig
	4j7wEQ2KD7sHxsPTUMZ9i0yLtcQSHzVDXG9hLVauu0fPqErmgUGATTTIBxILCCJoBEXt+n5GNjd
	F/UlCFMnonalTcnAkgYaapuMGB06sfT9Px4tnqrc7dDlQIUlOBYazHFREwMFFshHc0Vw9Mm9pe1
	+7aqOOz0p6WSRcS02dnuoOmX57T11jJ0DP3O+0wrBolpcaOPb+pIK1QA9/xG24dt8Hv9pRX/YBb
	ODw4vuS6rC/rokNgh4VoBt3AbgZUPGfFrlKyeZ9S4GmJA7NbcPMiQ8yVLGwefseqRaRuxLNqWWz
	YOSdWYlwSiuf/J3kO4EcVNN0tMbaI5d6eI+073LKip9+DWUMpj9gBVWZD8Pjg+qqpzYdeYkkFJP
	RpWDkPbfFCXj6Kci/hE7/X+4w0wOcA9IvC2CAs84kiMMsO/Kf4lKc=
X-Google-Smtp-Source: AGHT+IFmsqU8/IwGlJ0jvuDlkmabMMKSdK0oNJ0pgaL7TZGirx5xbAEFrPFfNWTmVpTlOnEMUE0V7g==
X-Received: by 2002:a05:6214:2a87:b0:7ec:6871:d0a3 with SMTP id 6a1803df08f44-88009b2d2d3mr37593046d6.11.1761748777370;
        Wed, 29 Oct 2025 07:39:37 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8bc4sm99556176d6.7.2025.10.29.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:39:36 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v4 07/15] quic: add connection id management
Date: Wed, 29 Oct 2025 10:35:49 -0400
Message-ID: <89b1c15bc12a5904ef0fe82591b8b411962f9d7a.1761748557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1761748557.git.lucien.xin@gmail.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces 'struct quic_conn_id_set' for managing Connection
IDs (CIDs), which are represented by 'struct quic_source_conn_id'
and 'struct quic_dest_conn_id'.

It provides helpers to add and remove CIDs from the set, and handles
insertion of source CIDs into the global connection ID hash table
when necessary.

- quic_conn_id_add(): Add a new Connection ID to the set, and inserts
  it to conn_id hash table if it is a source conn_id.

- quic_conn_id_remove(): Remove connection IDs the set with sequence
  numbers less than or equal to a number.

It also adds utilities to look up CIDs by value or sequence number,
search the global hash table for incoming packets, and check for
stateless reset tokens among destination CIDs. These functions are
essential for RX path connection lookup and stateless reset processing.

- quic_conn_id_find(): Find a Connection ID in the set by seq number.

- quic_conn_id_lookup(): Lookup a Connection ID from global hash table
  using the ID value, typically used for socket lookup on the RX path.

- quic_conn_id_token_exists(): Check if a stateless reset token exists
  in any dest Connection ID (used during stateless reset processing).

Note source/dest conn_id set is per socket, the operations on it are
always pretected by the sock lock.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v3:
  - Clarify in changelog that conn_id set is always protected by sock lock
    (suggested by Paolo).
  - Adjust global source conn_id hashtable operations for the new hashtable
    type.
v4:
  - Replace struct hlist_node with hlist_nulls_node for the node in
    struct quic_source_conn_id to support lockless lookup.
---
 net/quic/Makefile |   2 +-
 net/quic/connid.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 net/quic/connid.h | 162 +++++++++++++++++++++++++++++++++
 net/quic/socket.c |   6 ++
 net/quic/socket.h |  13 +++
 5 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/connid.c
 create mode 100644 net/quic/connid.h

diff --git a/net/quic/Makefile b/net/quic/Makefile
index 094e9da5d739..eee7501588d3 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_IP_QUIC) += quic.o
 
-quic-y := common.o family.o protocol.o socket.o stream.o
+quic-y := common.o family.o protocol.o socket.o stream.o connid.o
diff --git a/net/quic/connid.c b/net/quic/connid.c
new file mode 100644
index 000000000000..9a6eb8eedcc6
--- /dev/null
+++ b/net/quic/connid.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <linux/quic.h>
+#include <net/sock.h>
+
+#include "common.h"
+#include "connid.h"
+
+/* Lookup a source connection ID (scid) in the global source connection ID hash table. */
+struct quic_conn_id *quic_conn_id_lookup(struct net *net, u8 *scid, u32 len)
+{
+	struct quic_shash_head *head = quic_source_conn_id_head(net, scid, len);
+	struct quic_source_conn_id *s_conn_id;
+	struct quic_conn_id *conn_id = NULL;
+	struct hlist_nulls_node *node;
+
+	hlist_nulls_for_each_entry_rcu(s_conn_id, node, &head->head, node) {
+		if (net == sock_net(s_conn_id->sk) && s_conn_id->common.id.len == len &&
+		    !memcmp(scid, &s_conn_id->common.id.data, s_conn_id->common.id.len)) {
+			if (likely(refcount_inc_not_zero(&s_conn_id->sk->sk_refcnt)))
+				conn_id = &s_conn_id->common.id;
+			break;
+		}
+	}
+	return conn_id;
+}
+
+/* Check if a given stateless reset token exists in any connection ID in the connection ID set. */
+bool quic_conn_id_token_exists(struct quic_conn_id_set *id_set, u8 *token)
+{
+	struct quic_common_conn_id *common;
+	struct quic_dest_conn_id *dcid;
+
+	dcid = (struct quic_dest_conn_id *)id_set->active;
+	if (!memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN)) /* Fast path. */
+		return true;
+
+	list_for_each_entry(common, &id_set->head, list) {
+		dcid = (struct quic_dest_conn_id *)common;
+		if (common == id_set->active)
+			continue;
+		if (!memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN))
+			return true;
+	}
+	return false;
+}
+
+static void quic_source_conn_id_free_rcu(struct rcu_head *head)
+{
+	struct quic_source_conn_id *s_conn_id;
+
+	s_conn_id = container_of(head, struct quic_source_conn_id, rcu);
+	kfree(s_conn_id);
+}
+
+static void quic_source_conn_id_free(struct quic_source_conn_id *s_conn_id)
+{
+	u8 *data = s_conn_id->common.id.data;
+	u32 len = s_conn_id->common.id.len;
+	struct quic_shash_head *head;
+
+	if (!hlist_nulls_unhashed(&s_conn_id->node)) {
+		head = quic_source_conn_id_head(sock_net(s_conn_id->sk), data, len);
+		spin_lock_bh(&head->lock);
+		hlist_nulls_del_init_rcu(&s_conn_id->node);
+		spin_unlock_bh(&head->lock);
+	}
+
+	/* Freeing is deferred via RCU to avoid use-after-free during concurrent lookups. */
+	call_rcu(&s_conn_id->rcu, quic_source_conn_id_free_rcu);
+}
+
+static void quic_conn_id_del(struct quic_common_conn_id *common)
+{
+	list_del(&common->list);
+	if (!common->hashed) {
+		kfree(common);
+		return;
+	}
+	quic_source_conn_id_free((struct quic_source_conn_id *)common);
+}
+
+/* Add a connection ID with sequence number and associated private data to the connection ID set. */
+int quic_conn_id_add(struct quic_conn_id_set *id_set,
+		     struct quic_conn_id *conn_id, u32 number, void *data)
+{
+	struct quic_source_conn_id *s_conn_id;
+	struct quic_dest_conn_id *d_conn_id;
+	struct quic_common_conn_id *common;
+	struct quic_shash_head *head;
+	struct list_head *list;
+
+	/* Locate insertion point to keep list ordered by number. */
+	list = &id_set->head;
+	list_for_each_entry(common, list, list) {
+		if (number == common->number)
+			return 0; /* Ignore if it already exists on the list. */
+		if (number < common->number) {
+			list = &common->list;
+			break;
+		}
+	}
+
+	if (conn_id->len > QUIC_CONN_ID_MAX_LEN)
+		return -EINVAL;
+	common = kzalloc(id_set->entry_size, GFP_ATOMIC);
+	if (!common)
+		return -ENOMEM;
+	common->id = *conn_id;
+	common->number = number;
+	if (id_set->entry_size == sizeof(struct quic_dest_conn_id)) {
+		/* For destination connection IDs, copy the stateless reset token if available. */
+		if (data) {
+			d_conn_id = (struct quic_dest_conn_id *)common;
+			memcpy(d_conn_id->token, data, QUIC_CONN_ID_TOKEN_LEN);
+		}
+	} else {
+		/* For source connection IDs, mark as hashed and insert into the global source
+		 * connection ID hashtable.
+		 */
+		common->hashed = 1;
+		s_conn_id = (struct quic_source_conn_id *)common;
+		s_conn_id->sk = data;
+
+		head = quic_source_conn_id_head(sock_net(s_conn_id->sk), common->id.data,
+						common->id.len);
+		spin_lock_bh(&head->lock);
+		hlist_nulls_add_head_rcu(&s_conn_id->node, &head->head);
+		spin_unlock_bh(&head->lock);
+	}
+	list_add_tail(&common->list, list);
+
+	if (number == quic_conn_id_last_number(id_set) + 1) {
+		if (!id_set->active)
+			id_set->active = common;
+		id_set->count++;
+
+		/* Increment count for consecutive following IDs. */
+		list_for_each_entry_continue(common, &id_set->head, list) {
+			if (common->number != ++number)
+				break;
+			id_set->count++;
+		}
+	}
+	return 0;
+}
+
+/* Remove connection IDs from the set with sequence numbers less than or equal to a number. */
+void quic_conn_id_remove(struct quic_conn_id_set *id_set, u32 number)
+{
+	struct quic_common_conn_id *common, *tmp;
+	struct list_head *list;
+
+	list = &id_set->head;
+	list_for_each_entry_safe(common, tmp, list, list) {
+		if (common->number <= number) {
+			if (id_set->active == common)
+				id_set->active = tmp;
+			quic_conn_id_del(common);
+			id_set->count--;
+		}
+	}
+}
+
+struct quic_conn_id *quic_conn_id_find(struct quic_conn_id_set *id_set, u32 number)
+{
+	struct quic_common_conn_id *common;
+
+	list_for_each_entry(common, &id_set->head, list)
+		if (common->number == number)
+			return &common->id;
+	return NULL;
+}
+
+void quic_conn_id_update_active(struct quic_conn_id_set *id_set, u32 number)
+{
+	struct quic_conn_id *conn_id;
+
+	if (number == id_set->active->number)
+		return;
+	conn_id = quic_conn_id_find(id_set, number);
+	if (!conn_id)
+		return;
+	quic_conn_id_set_active(id_set, conn_id);
+}
+
+void quic_conn_id_set_init(struct quic_conn_id_set *id_set, bool source)
+{
+	id_set->entry_size = source ? sizeof(struct quic_source_conn_id) :
+				      sizeof(struct quic_dest_conn_id);
+	INIT_LIST_HEAD(&id_set->head);
+}
+
+void quic_conn_id_set_free(struct quic_conn_id_set *id_set)
+{
+	struct quic_common_conn_id *common, *tmp;
+
+	list_for_each_entry_safe(common, tmp, &id_set->head, list)
+		quic_conn_id_del(common);
+	id_set->count = 0;
+	id_set->active = NULL;
+}
+
+void quic_conn_id_get_param(struct quic_conn_id_set *id_set, struct quic_transport_param *p)
+{
+	p->active_connection_id_limit = id_set->max_count;
+}
+
+void quic_conn_id_set_param(struct quic_conn_id_set *id_set, struct quic_transport_param *p)
+{
+	id_set->max_count = p->active_connection_id_limit;
+}
diff --git a/net/quic/connid.h b/net/quic/connid.h
new file mode 100644
index 000000000000..bd9b76b85037
--- /dev/null
+++ b/net/quic/connid.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_CONN_ID_LIMIT	8
+#define QUIC_CONN_ID_DEF	7
+#define QUIC_CONN_ID_LEAST	2
+
+#define QUIC_CONN_ID_TOKEN_LEN	16
+
+/* Common fields shared by both source and destination Connection IDs */
+struct quic_common_conn_id {
+	struct quic_conn_id id;	/* The actual Connection ID value and its length */
+	struct list_head list;	/* Linked list node for conn_id list management */
+	u32 number;		/* Sequence number assigned to this Connection ID */
+	u8 hashed;		/* Non-zero if this ID is stored in source_conn_id hashtable */
+};
+
+struct quic_source_conn_id {
+	struct quic_common_conn_id common;
+	struct hlist_nulls_node node;	/* Hash table node for fast lookup by Connection ID */
+	struct rcu_head rcu;		/* RCU header for deferred destruction */
+	struct sock *sk;		/* Pointer to sk associated with this Connection ID */
+};
+
+struct quic_dest_conn_id {
+	struct quic_common_conn_id common;
+	u8 token[QUIC_CONN_ID_TOKEN_LEN];	/* Stateless reset token in rfc9000#section-10.3 */
+};
+
+struct quic_conn_id_set {
+	/* Connection ID in use on the current path */
+	struct quic_common_conn_id *active;
+	/* Connection ID to use for a new path (e.g., after migration) */
+	struct quic_common_conn_id *alt;
+	struct list_head head;	/* Head of the linked list of available connection IDs */
+	u8 entry_size;		/* Size of each connection ID entry (in bytes) in the list */
+	u8 max_count;		/* active_connection_id_limit in rfc9000#section-18.2 */
+	u8 count;		/* Current number of connection IDs in the list */
+};
+
+static inline u32 quic_conn_id_first_number(struct quic_conn_id_set *id_set)
+{
+	struct quic_common_conn_id *common;
+
+	common = list_first_entry(&id_set->head, struct quic_common_conn_id, list);
+	return common->number;
+}
+
+static inline u32 quic_conn_id_last_number(struct quic_conn_id_set *id_set)
+{
+	return quic_conn_id_first_number(id_set) + id_set->count - 1;
+}
+
+static inline void quic_conn_id_generate(struct quic_conn_id *conn_id)
+{
+	get_random_bytes(conn_id->data, QUIC_CONN_ID_DEF_LEN);
+	conn_id->len = QUIC_CONN_ID_DEF_LEN;
+}
+
+/* Select an alternate destination Connection ID for a new path (e.g., after migration). */
+static inline bool quic_conn_id_select_alt(struct quic_conn_id_set *id_set, bool active)
+{
+	if (id_set->alt)
+		return true;
+	/* NAT rebinding: peer keeps using the current source conn_id.
+	 * In this case, continue using the same dest conn_id for the new path.
+	 */
+	if (active) {
+		id_set->alt = id_set->active;
+		return true;
+	}
+	/* Treat the prev conn_ids as used.
+	 * Try selecting the next conn_id in the list, unless at the end.
+	 */
+	if (id_set->active->number != quic_conn_id_last_number(id_set)) {
+		id_set->alt = list_next_entry(id_set->active, list);
+		return true;
+	}
+	/* If there's only one conn_id in the list, reuse the active one. */
+	if (id_set->active->number == quic_conn_id_first_number(id_set)) {
+		id_set->alt = id_set->active;
+		return true;
+	}
+	/* No alternate conn_id could be selected.  Caller should send a
+	 * QUIC_FRAME_RETIRE_CONNECTION_ID frame to request new connection IDs from the peer.
+	 */
+	return false;
+}
+
+static inline void quic_conn_id_set_alt(struct quic_conn_id_set *id_set, struct quic_conn_id *alt)
+{
+	id_set->alt = (struct quic_common_conn_id *)alt;
+}
+
+/* Swap the active and alternate destination Connection IDs after path migration completes,
+ * since the path has already been switched accordingly.
+ */
+static inline void quic_conn_id_swap_active(struct quic_conn_id_set *id_set)
+{
+	void *active = id_set->active;
+
+	id_set->active = id_set->alt;
+	id_set->alt = active;
+}
+
+/* Choose which destination Connection ID to use for a new path migration if alt is true. */
+static inline struct quic_conn_id *quic_conn_id_choose(struct quic_conn_id_set *id_set, u8 alt)
+{
+	return (alt && id_set->alt) ? &id_set->alt->id : &id_set->active->id;
+}
+
+static inline struct quic_conn_id *quic_conn_id_active(struct quic_conn_id_set *id_set)
+{
+	return &id_set->active->id;
+}
+
+static inline void quic_conn_id_set_active(struct quic_conn_id_set *id_set,
+					   struct quic_conn_id *active)
+{
+	id_set->active = (struct quic_common_conn_id *)active;
+}
+
+static inline u32 quic_conn_id_number(struct quic_conn_id *conn_id)
+{
+	return ((struct quic_common_conn_id *)conn_id)->number;
+}
+
+static inline struct sock *quic_conn_id_sk(struct quic_conn_id *conn_id)
+{
+	return ((struct quic_source_conn_id *)conn_id)->sk;
+}
+
+static inline void quic_conn_id_set_token(struct quic_conn_id *conn_id, u8 *token)
+{
+	memcpy(((struct quic_dest_conn_id *)conn_id)->token, token, QUIC_CONN_ID_TOKEN_LEN);
+}
+
+static inline int quic_conn_id_cmp(struct quic_conn_id *a, struct quic_conn_id *b)
+{
+	return a->len != b->len || memcmp(a->data, b->data, a->len);
+}
+
+int quic_conn_id_add(struct quic_conn_id_set *id_set, struct quic_conn_id *conn_id,
+		     u32 number, void *data);
+bool quic_conn_id_token_exists(struct quic_conn_id_set *id_set, u8 *token);
+void quic_conn_id_remove(struct quic_conn_id_set *id_set, u32 number);
+
+struct quic_conn_id *quic_conn_id_find(struct quic_conn_id_set *id_set, u32 number);
+struct quic_conn_id *quic_conn_id_lookup(struct net *net, u8 *scid, u32 len);
+void quic_conn_id_update_active(struct quic_conn_id_set *id_set, u32 number);
+
+void quic_conn_id_get_param(struct quic_conn_id_set *id_set, struct quic_transport_param *p);
+void quic_conn_id_set_param(struct quic_conn_id_set *id_set, struct quic_transport_param *p);
+void quic_conn_id_set_init(struct quic_conn_id_set *id_set, bool source);
+void quic_conn_id_set_free(struct quic_conn_id_set *id_set);
diff --git a/net/quic/socket.c b/net/quic/socket.c
index d0a50b218f9f..d79542c4387d 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -41,6 +41,9 @@ static int quic_init_sock(struct sock *sk)
 	sk->sk_write_space = quic_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
+	quic_conn_id_set_init(quic_source(sk), 1);
+	quic_conn_id_set_init(quic_dest(sk), 0);
+
 	if (quic_stream_init(quic_streams(sk)))
 		return -ENOMEM;
 
@@ -55,6 +58,9 @@ static int quic_init_sock(struct sock *sk)
 
 static void quic_destroy_sock(struct sock *sk)
 {
+	quic_conn_id_set_free(quic_source(sk));
+	quic_conn_id_set_free(quic_dest(sk));
+
 	quic_stream_free(quic_streams(sk));
 
 	quic_data_free(quic_ticket(sk));
diff --git a/net/quic/socket.h b/net/quic/socket.h
index 3eba18514ae6..43f86cabb698 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -14,6 +14,7 @@
 #include "common.h"
 #include "family.h"
 #include "stream.h"
+#include "connid.h"
 
 #include "protocol.h"
 
@@ -37,6 +38,8 @@ struct quic_sock {
 	struct quic_data		alpn;
 
 	struct quic_stream_table	streams;
+	struct quic_conn_id_set		source;
+	struct quic_conn_id_set		dest;
 };
 
 struct quic6_sock {
@@ -79,6 +82,16 @@ static inline struct quic_stream_table *quic_streams(const struct sock *sk)
 	return &quic_sk(sk)->streams;
 }
 
+static inline struct quic_conn_id_set *quic_source(const struct sock *sk)
+{
+	return &quic_sk(sk)->source;
+}
+
+static inline struct quic_conn_id_set *quic_dest(const struct sock *sk)
+{
+	return &quic_sk(sk)->dest;
+}
+
 static inline bool quic_is_establishing(struct sock *sk)
 {
 	return sk->sk_state == QUIC_SS_ESTABLISHING;
-- 
2.47.1


