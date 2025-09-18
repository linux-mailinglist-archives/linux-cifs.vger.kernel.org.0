Return-Path: <linux-cifs+bounces-5685-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF342B22E40
	for <lists+linux-cifs@lfdr.de>; Tue, 12 Aug 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D517D9CC
	for <lists+linux-cifs@lfdr.de>; Tue, 12 Aug 2025 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677962D46B1;
	Tue, 12 Aug 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="KvsLd1Zy"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E253263F22
	for <linux-cifs@vger.kernel.org>; Tue, 12 Aug 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017156; cv=none; b=LDWaz+kmKs1raIUHjchz1YdwlFGCaMU5K1ULoh/FruZK/OFDYSGSNpKnPTUpMcBMVf55XPNWg0kSK2pomkPlzGGG7AHf+F2ljKTHmaE8Vtmz5Qs3UiE6nepjt7gOPXpwJuyKtu3uNWRiP+YmjU4n/Njo3l4YI5QbogGtIN2JY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017156; c=relaxed/simple;
	bh=ggvSxhGYlA+9cWU0M97mua6BZ4mBePPgWM6gV4RuUYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZftjTOu51tApqcgHmuNkKhPp1l5ShszGbtxT52ttFOwyF8k1ObFhzbHFxp2ZE85iuCMUuiDn27s/Sb9fZyVj+WL+AAOwvmAWX7dnBCpQ4A4oxX750NDYirb+Of4tIw2rs8uoPtdgck9licn2q+kHrln2A5NwYD95bZEIEgIciZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=KvsLd1Zy; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=ERVUo3T0K1V1ICM1xbcGMqpxXJvvpB6g8yY0M1SC97I=; b=KvsLd1ZyDGzhzAMu2fBrvUFrUX
	ZeMlVBiMYeCal40kLbmjdLITf45QvAMyPcmapL3iYXlUJhtjucxo0FYWTrXnrVCVmRktoSNzvN+NG
	zUTYQRZsTQyzy5MXkTGYJabXlG0AwcuE2kB6I/C9ZkpeMKQ5z4oYW9zOqE1sZXUL2EJ6q0gUV5xN/
	g5N+Rwmlv0V8sRGgQWnC4Ahhbvbi8ZRobCIdcJhxAsp9BP1aFXYJ1iuViv3zAPeqiGufby0fgbaIP
	avJTwayr7ywrF1BNUCaV9TNfPxno0Jixl6coth3A38AWOPP8ef2Yu57VGhAQxxPwClVm5nIWJFzrU
	93KvOIhCsrnuZd2V3yapF85X0NN3BwtVpemlomkOD+tXSXgt93nXN968gTeHLr4UYHGe7Er/IhIfs
	XqRNzTykW+YNoVxTmuWPIlBo5w10I2arYM9TpI3+DGTbMq3BPBx8r6QDPQi4QVQA7CrjkzocZkZKY
	3hZp+sfHkJk3gfvwQSdblhGA;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uls8F-002SgS-0o;
	Tue, 12 Aug 2025 16:45:51 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH] smb: server: split ksmbd_rdma_stop_listening() out of ksmbd_rdma_destroy()
Date: Tue, 12 Aug 2025 18:45:46 +0200
Message-ID: <20250812164546.29238-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't call destroy_workqueue(smb_direct_wq); before stop_sessions()!

Otherwise already existing connections try to use smb_direct_wq as
a NULL pointer.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/server/connection.c     | 3 ++-
 fs/smb/server/transport_rdma.c | 5 ++++-
 fs/smb/server/transport_rdma.h | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d1f36f899699..525409706805 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -517,7 +517,8 @@ void ksmbd_conn_transport_destroy(void)
 {
 	mutex_lock(&init_lock);
 	ksmbd_tcp_destroy();
-	ksmbd_rdma_destroy();
+	ksmbd_rdma_stop_listening();
 	stop_sessions();
+	ksmbd_rdma_destroy();
 	mutex_unlock(&init_lock);
 }
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 99964a75d13e..16bf68dbf4ae 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2200,7 +2200,7 @@ int ksmbd_rdma_init(void)
 	return 0;
 }
 
-void ksmbd_rdma_destroy(void)
+void ksmbd_rdma_stop_listening(void)
 {
 	if (!smb_direct_listener.cm_id)
 		return;
@@ -2209,7 +2209,10 @@ void ksmbd_rdma_destroy(void)
 	rdma_destroy_id(smb_direct_listener.cm_id);
 
 	smb_direct_listener.cm_id = NULL;
+}
 
+void ksmbd_rdma_destroy(void)
+{
 	if (smb_direct_wq) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
diff --git a/fs/smb/server/transport_rdma.h b/fs/smb/server/transport_rdma.h
index 0fb692c40e21..659ed668de2d 100644
--- a/fs/smb/server/transport_rdma.h
+++ b/fs/smb/server/transport_rdma.h
@@ -13,13 +13,15 @@
 
 #ifdef CONFIG_SMB_SERVER_SMBDIRECT
 int ksmbd_rdma_init(void);
+void ksmbd_rdma_stop_listening(void);
 void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
 unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
-static inline int ksmbd_rdma_destroy(void) { return 0; }
+static inline void ksmbd_rdma_stop_listening(void) { return };
+static inline void ksmbd_rdma_destroy(void) { return; }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
 static inline unsigned int get_smbd_max_read_write_size(void) { return 0; }
-- 
2.43.0


