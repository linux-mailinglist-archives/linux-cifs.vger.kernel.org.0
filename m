Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81297BFA17
	for <lists+linux-cifs@lfdr.de>; Thu, 26 Sep 2019 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfIZTb1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 26 Sep 2019 15:31:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44315 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTb1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 26 Sep 2019 15:31:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so49813pll.11
        for <linux-cifs@vger.kernel.org>; Thu, 26 Sep 2019 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VrHrjzt3sjcG3Iy3BHBAfwtcSmU1GcHkdCBhDpI1hG4=;
        b=ADxx9B+Ra/HeU4hpr9voxGuHK4ezjKu5D0jSf1Wjwo5WntEOodWTuCRU4H/+qRBZQh
         Wz5HJKGzESTX7LiUA4CWWAcDw43LQO6XOtnFk3yuVgRe4Xvj1nrVuUsnNna6lQWqdf/3
         Hznh0s/RcXlKjj4tIKJac/bKhslb4WyR+IWI1y7QhUJBZzOPuczJ9/yT2GftqyyUixY0
         37wgHLCFknY1lnskynWZYlaaeyInvBpBFY7Btm2BcosRHIEhhFJF76XaiL+Ri6PZlXz9
         vf9R3zQLzdr+bobHG6AMSbH5ji8bjLTrAySl2VJ+DoMKyT32YQ4wRMhrmtBmg71MpS81
         /2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VrHrjzt3sjcG3Iy3BHBAfwtcSmU1GcHkdCBhDpI1hG4=;
        b=P8rchAht0WDJDWm0lwqSm42xkaG3wzLV9exH1U98MWm/Q/1zARHpCJwx1UOx0IFD/f
         sj4N0AG0c4RGUuhHqNP1NyBCmlN7EnFqHfVvNwnKY2I9PVPUuR2WnC7I+uZxiev9kXt8
         07xn2qPr8Qh/dNm6dknNhKYZy6iCQ4HocPtXqc+JGG5XOaxp8Ytsxg7SqQpqDQ4HvBy7
         l7jWBiwNsyaTI3O/ln8zl69OiQiiqKzVX1vkST5/FCKKfmncpX5EE/pVoiHnyzaJ/Fgy
         v6K3JyyPJ7YyLcmuXX/QwsJhrUpcSuo+q43X0kbbw2G9IpfHTpGKfOUgmwWhV82ycq1x
         l3kA==
X-Gm-Message-State: APjAAAWf0eLfX9AHGF7yi3SK5+NJHPo9vxAScwNS8+KUSnSxA/1s9g7C
        9Z++Vi4yzY0NK8Oz+KlegMRXkvA=
X-Google-Smtp-Source: APXvYqzQ2zU30WytIw170Pv86DIU/HBf9y4wnYZ0MWKK1PLGvwY5g+lOvbTAfwBYon32pSJb/Qx/3A==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr249451plq.154.1569526286483;
        Thu, 26 Sep 2019 12:31:26 -0700 (PDT)
Received: from ubuntu-vm.mshome.net ([131.107.147.106])
        by smtp.gmail.com with ESMTPSA id v12sm2981894pgr.31.2019.09.26.12.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:31:25 -0700 (PDT)
From:   Pavel Shilovsky <piastryyy@gmail.com>
X-Google-Original-From: Pavel Shilovsky <pshilov@microsoft.com>
To:     linux-cifs@vger.kernel.org
Cc:     Moritz M <mailinglist@moritzmueller.ee>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH] CIFS: Fix oplock handling for SMB 2.1+ protocols
Date:   Thu, 26 Sep 2019 12:31:20 -0700
Message-Id: <20190926193120.23769-1-pshilov@microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

There may be situations when a server negotiates SMB 2.1
protocol version or higher but responds to a CREATE request
with an oplock rather than a lease.

Currently the client doesn't handle such a case correctly:
when another CREATE comes in the server sends an oplock
break to the initial CREATE and the client doesn't send
an ack back due to a wrong caching level being set (READ
instead of RWH). Missing an oplock break ack makes the
server wait until the break times out which dramatically
increases the latency of the second CREATE.

Fix this by properly detecting oplocks when using SMB 2.1
protocol version and higher.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/smb2ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 047066493832..00d2ac80cd6e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3314,6 +3314,11 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 	if (oplock == SMB2_OPLOCK_LEVEL_NOCHANGE)
 		return;
 
+	/* Check if the server granted an oplock rather than a lease */
+	if (oplock & SMB2_OPLOCK_LEVEL_EXCLUSIVE)
+		return smb2_set_oplock_level(cinode, oplock, epoch,
+					     purge_cache);
+
 	if (oplock & SMB2_LEASE_READ_CACHING_HE) {
 		new_oplock |= CIFS_CACHE_READ_FLG;
 		strcat(message, "R");
-- 
2.17.1

