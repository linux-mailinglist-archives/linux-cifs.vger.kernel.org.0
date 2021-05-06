Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C849375BAC
	for <lists+linux-cifs@lfdr.de>; Thu,  6 May 2021 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEFT00 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 6 May 2021 15:26:26 -0400
Received: from mx.cjr.nz ([51.158.111.142]:15104 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhEFT00 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 6 May 2021 15:26:26 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id AB05480BA9;
        Thu,  6 May 2021 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1620329126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LwlzlGhHguvp+LEUJpUx9fmTufYmsXoW0IMzDqKrK6U=;
        b=MC8UbA6lR88lQkltqlvaXADHCbIsx1jOKwblXuEbWIXbsYzUxku6eira9lZlxeUeofu2Hq
        cRGHiL3x7+biQbn0c9JClrSSJqkgzJaV+47kbK7GOh4yR6bfuFKW0coU57G4smWUJTQKgl
        kcAzt1iKJbwW21+cfnRUnkZP+e+F0oWM5CnQd2nhH8A1uwmivDVlI1WONVhpWlXK/Yi7oX
        +REqpa2PywlfLqqCspXJlklGnp6H5MAQkJaW59ik9jRd5YF/ypWAc8cMVFSsEUI4gkicpc
        +HJCnutfRxNiGp2HXmwnKS6zNn6opp/yIU4iyzp4aFn5vLBwnjOfaSJuymQWbQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, piastryyy@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH] mount.cifs: fix crash when mount point does not exist
Date:   Thu,  6 May 2021 16:25:13 -0300
Message-Id: <20210506192513.2935-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

@mountpointp is initially set to a statically allocated string in
main(), and if we fail to update it in acquire_mountpoint(), make sure
to set it to NULL and avoid freeing it at mount_exit.

This fixes the following crash

	$ mount.cifs //srv/share /mnt/foo/bar -o ...
	Couldn't chdir to /mnt/foo/bar: No such file or directory
	munmap_chunk(): invalid pointer
	Aborted

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 mount.cifs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mount.cifs.c b/mount.cifs.c
index 7f898bbd215a..84274c98ddf5 100644
--- a/mount.cifs.c
+++ b/mount.cifs.c
@@ -1996,9 +1996,9 @@ acquire_mountpoint(char **mountpointp)
 	 */
 	realuid = getuid();
 	if (realuid == 0) {
-		dacrc = toggle_dac_capability(0, 1);
-		if (dacrc)
-			return dacrc;
+		rc = toggle_dac_capability(0, 1);
+		if (rc)
+			goto out;
 	} else {
 		oldfsuid = setfsuid(realuid);
 		oldfsgid = setfsgid(getgid());
@@ -2019,7 +2019,6 @@ acquire_mountpoint(char **mountpointp)
 		rc = EX_SYSERR;
 	}
 
-	*mountpointp = mountpoint;
 restore_privs:
 	if (realuid == 0) {
 		dacrc = toggle_dac_capability(0, 0);
@@ -2030,9 +2029,13 @@ restore_privs:
 		gid_t __attribute__((unused)) gignore = setfsgid(oldfsgid);
 	}
 
-	if (rc)
+out:
+	if (rc) {
 		free(mountpoint);
+		mountpoint = NULL;
+	}
 
+	*mountpointp = mountpoint;
 	return rc;
 }
 
-- 
2.31.1

