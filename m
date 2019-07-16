Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF46A0C9
	for <lists+linux-cifs@lfdr.de>; Tue, 16 Jul 2019 05:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfGPDX5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 15 Jul 2019 23:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfGPDX5 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 15 Jul 2019 23:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4407C3DE0F;
        Tue, 16 Jul 2019 03:23:57 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CEF560BF7;
        Tue, 16 Jul 2019 03:23:56 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: flush before set-info if we have writeable handles
Date:   Tue, 16 Jul 2019 13:23:49 +1000
Message-Id: <20190716032349.10711-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 03:23:57 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Servers can defer destaging any data and updating the mtime until close().
This means that if we do a setinfo to modify the mtime while other handles
are open for write the server may overwrite our setinfo timestamps when
if flushes the file on close() of the writeable handle.

To avoid this we add an explicit flush() before any attempts to use setinfo
and update the mtime IF we have writeable handles open.

This makes "cp -p" preserve the mtime when copying files to some smb servers.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2inode.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 278405d26c47..a3603ec3a086 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -516,7 +516,11 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink;
+	struct cifs_tcon *tcon;
+	struct TCP_Server_Info *server;
 	int rc;
+	struct cifsInodeInfo *cifsi;
+	struct cifsFileInfo *wrcfile;
 
 	if ((buf->CreationTime == 0) && (buf->LastAccessTime == 0) &&
 	    (buf->LastWriteTime == 0) && (buf->ChangeTime == 0) &&
@@ -527,7 +531,19 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 
-	rc = smb2_compound_op(xid, tlink_tcon(tlink), cifs_sb, full_path,
+	tcon = tlink_tcon(tlink);
+	server = tcon->ses->server;
+
+	if (buf->LastWriteTime) {
+		cifsi = CIFS_I(inode);
+		wrcfile = find_writable_file(cifsi, false);
+		if (wrcfile) {
+			filemap_write_and_wait(inode->i_mapping);
+			server->ops->flush(xid, tcon, &wrcfile->fid);
+			cifsFileInfo_put(wrcfile);
+		}
+	}
+	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN, 0, buf,
 			      SMB2_OP_SET_INFO);
 	cifs_put_tlink(tlink);
-- 
2.13.6

