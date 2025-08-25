Return-Path: <linux-cifs+bounces-5924-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73729B34C5A
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Aug 2025 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B80924013F
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Aug 2025 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC327F017;
	Mon, 25 Aug 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="utLjKQkr"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BD23E32E
	for <linux-cifs@vger.kernel.org>; Mon, 25 Aug 2025 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154663; cv=none; b=RxFD5j6d/u12mHmQlBPuRjGv80vfqfnVCvHxEWYd8fGZl8x78XEtmvfgghKePlE4xR46kdA55mHA18n56pQNbxVw4xgCuI2AB82hUWCEG2RVdGoaGMvkUmbJMeGz4BNrMpRqPRXpu0q85PPcTierYQlT0P2jR9m3412Q43L8P7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154663; c=relaxed/simple;
	bh=9ZtQ4hIALf4DypQW70tXLqzHVDfoMttbK/dkOgK8XqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGviwrwh/ZZzkl+81ptM4jQAUoiXzZqaBKIZ0M3dCAo/P+oEu/I1W7XvGlotxwHst3pLrpHCo1laX17YitOeYRCpr/ZGWIOt9XOCctIGiiEE5J/B+KqZQ2eL8arSOuJP7W5lw11cA6d1rifSoEODyUxKhhzx1gbuRk6MUMX/N3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=utLjKQkr; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=Zb6gTdOo3PGEqJtIe5GOgjpoBu5JolByNmjXIVTR9WA=; b=utLjKQkru7eYvjmaRwuW3POwI2
	4Ofe+H8qAjeRj9OCGhnGwXGkY3CyW3GFqums98/S2EIGfe4aTXMpetBNnqMPfS7i+WhNLxB+6RK7u
	abefyFKI8V5sVgAB/19V2cR1CsBNeicQoDWQ6wOGsFL6d7q+oOvEkKUM9PVViJZSvyp6IZsXQX+cY
	aRQ21vYZ+XF0/KUOz8L3jgAt92udm9+d37nH4IRvjIvbWVh9KKAVe6AqnAoa3eAkklhYar7KWqJnR
	gfbwWxaldMMCpdb8YT0+pdeqrhQwFm5GlvmRBpEDzgqdflZT3QNs1xA9tPR5hOv/nSqjZoKATQdK8
	itTdgVXTfFqcMIHhvN0U1EfZHJQWY5rJj5oCXdTg8/omDjgMCFIFeNyr5MvdPjuQO5OkdgUN/pM5i
	E3ZENGRFGfNrggOaUDeEDPTSymTrFYfnr+VA2rJIeKsSykphzyXshhTy8dcFwtiXEukxXW00or3yS
	ezkEDFihSjrbYrQ2G7s8nfIU;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uqe35-000jcs-2Q;
	Mon, 25 Aug 2025 20:44:15 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 014/142] smb: smbdirect: introduce smbdirect_socket.statistics
Date: Mon, 25 Aug 2025 22:39:35 +0200
Message-ID: <b77a2ad958e810525f4cb2f816659ddf6284c09a.1756139607.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756139607.git.metze@samba.org>
References: <cover.1756139607.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be used by the client and maybe shared code in future.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/common/smbdirect/smbdirect_socket.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/common/smbdirect/smbdirect_socket.h b/fs/smb/common/smbdirect/smbdirect_socket.h
index fade09dfc63d..5df0143ccd6a 100644
--- a/fs/smb/common/smbdirect/smbdirect_socket.h
+++ b/fs/smb/common/smbdirect/smbdirect_socket.h
@@ -188,6 +188,17 @@ struct smbdirect_socket {
 			wait_queue_head_t wait_queue;
 		} credits;
 	} rw_io;
+
+	/*
+	 * For debug purposes
+	 */
+	struct {
+		u64 get_receive_buffer;
+		u64 put_receive_buffer;
+		u64 enqueue_reassembly_queue;
+		u64 dequeue_reassembly_queue;
+		u64 send_empty;
+	} statistics;
 };
 
 static __always_inline void smbdirect_socket_init(struct smbdirect_socket *sc)
-- 
2.43.0


