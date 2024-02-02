Return-Path: <linux-cifs+bounces-1105-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D9847879
	for <lists+linux-cifs@lfdr.de>; Fri,  2 Feb 2024 19:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580441F2D861
	for <lists+linux-cifs@lfdr.de>; Fri,  2 Feb 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758314D916;
	Fri,  2 Feb 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsS88CRH"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A714D913;
	Fri,  2 Feb 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899274; cv=none; b=TDrnWsO2SRwqcfVRh+jV8eMfGZyHiLCpK+C943INgSEiI1LI6k/PqTv/b539dxqFJyQAOhtv0KO9fegR5lJ+ah/Xu6X22M1FsQVFO9lz5EP6P+ODPMsX2bDPwqq8/P/X3A8Dsdwp0qBQWTnKx1+7LBLjjmwvfW2QO40ofHFfN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899274; c=relaxed/simple;
	bh=z+kMQvyKLJl5WYHGbGbyDn+Jv6UN7scqw716sR9s0pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dagmAm0WuzXOAzg61g0TVNypnOVLB74hL6LDfy7NjclWyCEsasGbugWoJ4jw/Zmig/auJ9glmlL9A0Meb1lTNdLnj1AX4r9QQQHWpX12U725wsVFhXA3v2dAXF78EzaEd9KoE1ZwWHLExkwvMlMDi86Dm90H+gmqhM/J7CDKr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsS88CRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34D5C43399;
	Fri,  2 Feb 2024 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899273;
	bh=z+kMQvyKLJl5WYHGbGbyDn+Jv6UN7scqw716sR9s0pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsS88CRHwp6/LJTnOxoyFbtEQzrTScKhQDMusddwvxLR+P7D/QfRBZZDrFDRknK3U
	 teqG5bN4GWdBQ78KzE5U8MMbgz0hhylffxlM6UMjh7UhQbTmBGuXQDaSkTUBaqPadH
	 fUKrZX2bmTcFCtCnu/vvr0UL7fEBoEjE+7tUusU9POLYaPBbpil1M0XAqHllneHg7M
	 JnHG9ORcc60CI6+FCTPboq+0uiAJEgEl/Oj5KtEymLDpjipWXVRgis0HC2vAQEd1vv
	 wBmAnUyaodQI3PGhCoOty4xo8T7qgn3psovDbWyhdD50BxfXNCaCAr0No6Bb/lVVAM
	 KD0++mc2l/bSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 09/15] cifs: translate network errors on send to -ECONNABORTED
Date: Fri,  2 Feb 2024 13:40:46 -0500
Message-ID: <20240202184057.541411-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit a68106a6928e0a6680f12bcc7338c0dddcfe4d11 ]

When the network stack returns various errors, we today bubble
up the error to the user (in case of soft mounts).

This change translates all network errors except -EINTR and
-EAGAIN to -ECONNABORTED. A similar approach is taken when
we receive network errors when reading from the socket.

The change also forces the cifsd thread to reconnect during
it's next activity.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 8a1dd8407a3a..97bf46de8e42 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -427,10 +427,17 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 						  server->conn_id, server->hostname);
 	}
 smbd_done:
-	if (rc < 0 && rc != -EINTR)
+	/*
+	 * there's hardly any use for the layers above to know the
+	 * actual error code here. All they should do at this point is
+	 * to retry the connection and hope it goes away.
+	 */
+	if (rc < 0 && rc != -EINTR && rc != -EAGAIN) {
 		cifs_server_dbg(VFS, "Error %d sending data on socket to server\n",
 			 rc);
-	else if (rc > 0)
+		rc = -ECONNABORTED;
+		cifs_signal_cifsd_for_reconnect(server, false);
+	} else if (rc > 0)
 		rc = 0;
 out:
 	cifs_in_send_dec(server);
-- 
2.43.0


