Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA81A1996E9
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Mar 2020 14:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgCaM71 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 31 Mar 2020 08:59:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:50596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbgCaM71 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 31 Mar 2020 08:59:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4649ACE3;
        Tue, 31 Mar 2020 12:59:25 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, piastryyy@gmail.com,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: ignore cached share root handle closing errors
Date:   Tue, 31 Mar 2020 14:59:23 +0200
Message-Id: <20200331125923.1063-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix tcon use-after-free and NULL ptr deref.

Customer system crashes with the following kernel log:

[462233.169868] CIFS VFS: Cancelling wait for mid 4894753 cmd: 14       => a QUERY DIR
[462233.228045] CIFS VFS: cifs_put_smb_ses: Session Logoff failure rc=-4
[462233.305922] CIFS VFS: cifs_put_smb_ses: Session Logoff failure rc=-4
[462233.306205] CIFS VFS: cifs_put_smb_ses: Session Logoff failure rc=-4
[462233.347060] CIFS VFS: cifs_put_smb_ses: Session Logoff failure rc=-4
[462233.347107] CIFS VFS: Close unmatched open
[462233.347113] BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
...
    [exception RIP: cifs_put_tcon+0xa0] (this is doing tcon->ses->server)
 #6 [...] smb2_cancelled_close_fid at ... [cifs]
 #7 [...] process_one_work at ...
 #8 [...] worker_thread at ...
 #9 [...] kthread at ...

The most likely explanation we have is:

* When we put the last reference of a tcon (refcount=0), we close the
  cached share root handle.
* If closing a handle is interupted, SMB2_close() will
  queue a SMB2_close() in a work thread.
* The queued object keeps a tcon ref so we bump the tcon
  refcount, jumping from 0 to 1.
* We reach the end of cifs_put_tcon(), we free the tcon object despite
  it now having a refcount of 1.
* The queued work now runs, but the tcon, ses & server was freed in
  the meantime resulting in a crash.

THREAD 1
========
cifs_put_tcon                 => tcon refcount reach 0
  SMB2_tdis
   close_shroot_lease
    close_shroot_lease_locked => if cached root has lease && refcount reach 0
     smb2_close_cached_fid    => if cached root valid
      SMB2_close              => retry close in a worker thread if interrupted
       smb2_handle_cancelled_close
        __smb2_handle_cancelled_close    => !! tcon refcount bump 0 => 1 !!
         INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
         queue_work(cifsiod_wq, &cancelled->work) => queue work
 tconInfoFree(tcon);    ==> freed!
 cifs_put_smb_ses(ses); ==> freed!

THREAD 2 (workqueue)
========
smb2_cancelled_close_fid
  SMB2_close(0, cancelled->tcon, ...); => use-after-free of tcon
  cifs_put_tcon(cancelled->tcon);      => tcon refcount reach 0 second time
  *CRASH*

Fixes: d9191319358d ("CIFS: Close cached root handle only if it has a lease")
Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/smb2ops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b36c46f48705..cb3896a9f004 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -607,8 +607,9 @@ smb2_close_cached_fid(struct kref *ref)
 
 	if (cfid->is_valid) {
 		cifs_dbg(FYI, "clear cached root file handle\n");
-		SMB2_close(0, cfid->tcon, cfid->fid->persistent_fid,
-			   cfid->fid->volatile_fid);
+		/* ignore errors here & do not retry in worker thread */
+		SMB2_close_flags(0, cfid->tcon, cfid->fid->persistent_fid,
+				 cfid->fid->volatile_fid, 0);
 		cfid->is_valid = false;
 		cfid->file_all_info_is_valid = false;
 		cfid->has_lease = false;
-- 
2.16.4

