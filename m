Return-Path: <linux-cifs+bounces-2341-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443D93A041
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Jul 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F4A1C220D9
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Jul 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAB13D609;
	Tue, 23 Jul 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Md/Wjm/w"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA321514DD;
	Tue, 23 Jul 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735536; cv=none; b=trnKTwHg+JvOQmijyYEghSHoKByE/q1XO6UU9fvzFzbCX/h76wSp54A3FgaG2Sr+KPFqfEVJrCwxa4X7vbUe+XLpABbB88vDpXRNCxfvUYQAKJw+ekcRH2NedS/6RXg1pnV+vhOu70/lSacL5a/2tDiC6yDjH/o4h7HcV4PC5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735536; c=relaxed/simple;
	bh=Q75RzGZ+m5jPtvmJXq8cBIiETcYTaC1zaEsQkzRqdco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUwCrj+PI3CPK+LtKioJYk02gSf2gb4Nn5X9ojc5K41PsA8bHhdb5T5U1Ha+9jk2ybV1OUI6tZur8iyQ4L4WcBXkjP4rzvNKpP9rCT4m25BMcbHYZz6/YFPnLHKeygDvRy514Ymh2+komasqNp8dSzFjadOPT9LDTVlhDvDV8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Md/Wjm/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB19C4AF09;
	Tue, 23 Jul 2024 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721735535;
	bh=Q75RzGZ+m5jPtvmJXq8cBIiETcYTaC1zaEsQkzRqdco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Md/Wjm/wRlL5ZTX5fGMXgblYywoPBBSb6CB0ko6DnTorRCHkAmciASSOULre6WVRw
	 cVCXExL2dAtol/skkm636iuyoyK+o/eyyRT7QxCgkG05S8JjT50uu0l9B/E27kI+fY
	 aMtDxVhB1r+jWRzsy047bH/MHustNiV3UTsUHWdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 2/9] cifs: Fix missing error code set
Date: Tue, 23 Jul 2024 13:51:56 +0200
Message-ID: <20240723114047.375094133@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723114047.281580960@linuxfoundation.org>
References: <20240723114047.281580960@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit d2c5eb57b6da10f335c30356f9696bd667601e6a upstream.

In cifs_strict_readv(), the default rc (-EACCES) is accidentally cleared by
a successful return from netfs_start_io_direct(), such that if
cifs_find_lock_conflict() fails, we don't return an error.

Fix this by resetting the default error code.

Fixes: 14b1cd25346b ("cifs: Fix locking in cifs_strict_readv()")
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1374635e89fa..6178c6d8097d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2877,6 +2877,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_direct(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
@@ -2889,6 +2890,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_read(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
-- 
2.45.2




