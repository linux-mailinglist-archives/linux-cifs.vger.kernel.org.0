Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E316942C
	for <lists+linux-cifs@lfdr.de>; Sun, 23 Feb 2020 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBWCYI (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 22 Feb 2020 21:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgBWCYI (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A274C20707;
        Sun, 23 Feb 2020 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424647;
        bh=VJl0l3HT/6xbtOrM+ACwuJjPmzziUCLCfBox3w+pcyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cI+K1ytMSCn9uv19ci5GUWUzIBKXTKKcgeJDdrnhl0zGTzd/DIrhpXLgAbWJAi2t4
         jp40Bi1Zd3L9JSktzVKniQXj9Iy0uqiO7+l51pQUVWNUjppl/SPnNoIPFgESYNAk34
         cHdx4zo7yZU6z5y2eEnlgRpDEr0W3sDXHZhNxkLU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Sorenson <sorenson@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 4.19 23/25] cifs: Fix mode output in debugging statements
Date:   Sat, 22 Feb 2020 21:23:37 -0500
Message-Id: <20200223022339.1885-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022339.1885-1-sashal@kernel.org>
References: <20200223022339.1885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit f52aa79df43c4509146140de0241bc21a4a3b4c7 ]

A number of the debug statements output file or directory mode
in hex.  Change these to print using octal.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 4 ++--
 fs/cifs/connect.c | 2 +-
 fs/cifs/inode.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 1d377b7f28605..130bdca9e5680 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -603,7 +603,7 @@ static void access_flags_to_mode(__le32 ace_flags, int type, umode_t *pmode,
 			((flags & FILE_EXEC_RIGHTS) == FILE_EXEC_RIGHTS))
 		*pmode |= (S_IXUGO & (*pbits_to_set));
 
-	cifs_dbg(NOISY, "access flags 0x%x mode now 0x%x\n", flags, *pmode);
+	cifs_dbg(NOISY, "access flags 0x%x mode now %04o\n", flags, *pmode);
 	return;
 }
 
@@ -632,7 +632,7 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	if (mode & S_IXUGO)
 		*pace_flags |= SET_FILE_EXEC_RIGHTS;
 
-	cifs_dbg(NOISY, "mode: 0x%x, access flags now 0x%x\n",
+	cifs_dbg(NOISY, "mode: %04o, access flags now 0x%x\n",
 		 mode, *pace_flags);
 	return;
 }
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 576cf71576da1..5a4d677a5b19d 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3792,7 +3792,7 @@ int cifs_setup_cifs_sb(struct smb_vol *pvolume_info,
 	cifs_sb->mnt_gid = pvolume_info->linux_gid;
 	cifs_sb->mnt_file_mode = pvolume_info->file_mode;
 	cifs_sb->mnt_dir_mode = pvolume_info->dir_mode;
-	cifs_dbg(FYI, "file mode: 0x%hx  dir mode: 0x%hx\n",
+	cifs_dbg(FYI, "file mode: %04ho  dir mode: %04ho\n",
 		 cifs_sb->mnt_file_mode, cifs_sb->mnt_dir_mode);
 
 	cifs_sb->actimeo = pvolume_info->actimeo;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 26154db6c87f1..fbebf241dbf24 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1579,7 +1579,7 @@ int cifs_mkdir(struct inode *inode, struct dentry *direntry, umode_t mode)
 	struct TCP_Server_Info *server;
 	char *full_path;
 
-	cifs_dbg(FYI, "In cifs_mkdir, mode = 0x%hx inode = 0x%p\n",
+	cifs_dbg(FYI, "In cifs_mkdir, mode = %04ho inode = 0x%p\n",
 		 mode, inode);
 
 	cifs_sb = CIFS_SB(inode->i_sb);
-- 
2.20.1

