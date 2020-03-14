Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAA185445
	for <lists+linux-cifs@lfdr.de>; Sat, 14 Mar 2020 04:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCNDil (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 13 Mar 2020 23:38:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCNDil (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 13 Mar 2020 23:38:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay11so5246707plb.0
        for <linux-cifs@vger.kernel.org>; Fri, 13 Mar 2020 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=llA26CLoySugc9/PRqFtXmozHddIjnPaYD8AWl5Fhkk=;
        b=UvVMNFvxb+P/iX3QNVp9ivyQyaUnQBUaWa7WKkcmXuU5mqvM0NcF6dXW3N6U1BlLbV
         Beo7XmrW8pHdS/F4/d9xur2l8SpWNIe9w2X/h2cmsANX7yymynOhu4kIwifeqzEG+U9o
         6NDGo4N74wzJJ9UjsE/P1UWlD7Z8IjfucHUlggpmmSrha4ZHmSHU4ocXm51Iua+i1vKG
         4oToniYCtJHrmf0X8DSjrWW7A/HisEaYIkXpb0/h16nExP4wyddNkA6qK5Hh6rnVDz8j
         blqehr47pwOVyEQRRJd3hUzbCm3NvRIQHPiVG75jk59g8ENct5NLweym8fO8bF+tiEgG
         Sq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=llA26CLoySugc9/PRqFtXmozHddIjnPaYD8AWl5Fhkk=;
        b=FqI4JIvBDJwHt0DHQY8fSCEgR4M79zrymh4SVlkXhO+DtVAmWj53QmWF8Y4QCWwuLM
         R7G3W7Z1UFcwSQFNDcJz03KulqGiliDGi8cVEWxQeOouowbSb47Eqxf8Qum9IwpCOMv/
         Td1gNHYX5UdGYKE4cfNfDk/yd5Lwbi7fG/44mPkuHTiBoj3CL8EeYNa9NNJult8dduqy
         bkETB9jp62iptPn85pcn8vpcM535iheXhAsWWEIWfRmQffIF0KHCkIMXspMX5cfapTQq
         Uh7PLHVqxAobEY5ES3LSzpZHdWqG45loJ8chkTmNMaHVQ7MbxzbxT/P/k/sm3v/fYcp7
         KeEQ==
X-Gm-Message-State: ANhLgQ1UnWfXTnqdvls1rYHK6E/fsxFrtdzkx7BDan0C2y+/fbyPZC+E
        BarnzEe9qnVVZePkhtmreugR/69J
X-Google-Smtp-Source: ADFU+vvDsblzQ0SAIyXPUAjiWIl3gFRScZfD/odsKL+xBcg7SkT/F12JKT3/2mqN2UaMp5IyqF9kxw==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr16596965plp.217.1584157120046;
        Fri, 13 Mar 2020 20:38:40 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h11sm10068137pfq.56.2020.03.13.20.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 20:38:39 -0700 (PDT)
Date:   Sat, 14 Mar 2020 11:38:31 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-cifs@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
Subject: [PATCH] CIFS: fiemap: do not return EINVAL if get nothing
Message-ID: <20200314033831.wm7uwy33j3brdgjp@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

If we call fiemap on a truncated file with none blocks allocated,
it makes sense we get nothing from this call. No output means
no blocks have been counted, but the call succeeded. It's a valid
response.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c31e84ee3c39..32b7f9795d4a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3417,7 +3417,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 	if (rc)
 		goto out;
 
-	if (out_data_len < sizeof(struct file_allocated_range_buffer)) {
+	if (out_data_len && out_data_len < sizeof(struct file_allocated_range_buffer)) {
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.20.1
