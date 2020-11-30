Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AB2C8C0D
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbgK3SEf (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:04:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387806AbgK3SEe (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:04:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C089AF49
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:13 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v4 11/11] cifs: Handle witness share moved notification
Date:   Mon, 30 Nov 2020 19:02:57 +0100
Message-Id: <20201130180257.31787-12-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130180257.31787-1-scabrero@suse.de>
References: <20201130180257.31787-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Just log a message as it is not clear enough what this notification
means. It is received for example when a node belonging to a scale-out
file server dies, but it is also received as soon as a client registers
for notifications (w2k12r2) when the server is scale-out.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/cifs_swn.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
index a172769c239f..c505d35f5b57 100644
--- a/fs/cifs/cifs_swn.c
+++ b/fs/cifs/cifs_swn.c
@@ -538,6 +538,29 @@ static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_sto
 	return cifs_swn_reconnect(swnreg->tcon, addr);
 }
 
+static int cifs_swn_share_moved(struct cifs_swn_reg *swnreg, struct sockaddr_storage *addr)
+{
+	struct sockaddr_in *ipv4 = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)addr;
+
+	if (addr->ss_family == AF_INET)
+		cifs_dbg(FYI, "%s: share '%s' from '%s' moved to %pI4\n",
+				__func__, swnreg->share_name, swnreg->net_name,
+				&ipv4->sin_addr);
+	else if (addr->ss_family == AF_INET6)
+		cifs_dbg(FYI, "%s: share '%s' from '%s' moved to %pI6\n",
+				__func__, swnreg->share_name, swnreg->net_name,
+				&ipv6->sin6_addr);
+
+	/*
+	 * FIXME It is not clear enough how to handle this notification and what does it mean.
+	 * It is received for example when a node belonging to a scale-out file server dies, but
+	 * it is also received as soon as a client registers for notifications (w2k12r2) when the
+	 * share is scale-out and all nodes are working fine. Just log for now.
+	 */
+	return 0;
+}
+
 int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cifs_swn_reg *swnreg;
@@ -597,6 +620,17 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 		}
 		return cifs_swn_client_move(swnreg, &addr);
 	}
+	case CIFS_SWN_NOTIFICATION_SHARE_MOVE: {
+		struct sockaddr_storage addr;
+
+		if (info->attrs[CIFS_GENL_ATTR_SWN_IP]) {
+			nla_memcpy(&addr, info->attrs[CIFS_GENL_ATTR_SWN_IP], sizeof(addr));
+		} else {
+			cifs_dbg(FYI, "%s: missing IP address attribute\n", __func__);
+			return -EINVAL;
+		}
+		return cifs_swn_share_moved(swnreg, &addr);
+	}
 	default:
 		cifs_dbg(FYI, "%s: unknown notification type %d\n", __func__, type);
 		break;
-- 
2.29.2

