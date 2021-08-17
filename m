Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB03EEEE2
	for <lists+linux-cifs@lfdr.de>; Tue, 17 Aug 2021 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhHQPCH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 17 Aug 2021 11:02:07 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:38732 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhHQPCH (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 17 Aug 2021 11:02:07 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 11:02:06 EDT
Received: from localhost.localdomain (unknown [119.136.90.116])
        by mail-m17642.qiye.163.com (Hmail) with ESMTPA id EB46D22014E;
        Tue, 17 Aug 2021 22:55:48 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH] cifs: fix wrong release in sess_alloc_buffer() failed path
Date:   Tue, 17 Aug 2021 22:55:10 +0800
Message-Id: <20210817145510.639-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMZSxlWGR4aGkIfGUNLGE
        tMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Pjo*Iz9JHxIrSwsDKB0X
        LykaCkJVSlVKTUlCSUpJSk9CTk9KVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkJVSkhNVUJLVUpKTVlXWQgBWUFKT01PNwY+
X-HM-Tid: 0a7b549c8571d998kuwseb46d22014e
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

smb_buf is allocated by small_smb_init_no_tc(), and buf type is
CIFS_SMALL_BUFFER, so we should use cifs_small_buf_release() to
release it in failed path.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 fs/cifs/sess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index c5785fd3f52e..606fd7d6cb71 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -877,7 +877,7 @@ sess_alloc_buffer(struct sess_data *sess_data, int wct)
 	return 0;
 
 out_free_smb_buf:
-	kfree(smb_buf);
+	cifs_small_buf_release(smb_buf);
 	sess_data->iov[0].iov_base = NULL;
 	sess_data->iov[0].iov_len = 0;
 	sess_data->buf0_type = CIFS_NO_BUFFER;
-- 
2.17.1

