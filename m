Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0F590A6F
	for <lists+linux-cifs@lfdr.de>; Fri, 12 Aug 2022 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiHLC4k (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 11 Aug 2022 22:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLC4i (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 11 Aug 2022 22:56:38 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BE95E45
        for <linux-cifs@vger.kernel.org>; Thu, 11 Aug 2022 19:56:37 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id q19so18074962pfg.8
        for <linux-cifs@vger.kernel.org>; Thu, 11 Aug 2022 19:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r7kiUnKEikCghKDeLOJeCKHL3G/Jpyt3ZcPzu0gjE00=;
        b=V43XGhzWXsQhFjdL7HjlfaJP0j7dXIk5opr7lj52/O5nUooWbtyEJeY7QqsJVbDoSx
         oHxE5cIzhS14MNOZYBFi6aYTVZEInCL5aMfss3358LFHQPEMrIbdAC1nYPtigHtRVtKG
         48nGVoAcXz2wiugTkGtABqpP5MlRcIRJTMspPumbEhuY0EmNuCpZg/8U1FwKaZrdJGbm
         Q5E3baiBG2NyALgFcDze2hVXRbiME+T1oOksHUUHoYJG/AqJu9g+iWzzDGp6pMo+t/6H
         71DGXmueVUPn7mCnaubNgcSvZJ34WaY2MrgJNwJ/DZXm83hgOnrvm+TUvoEmOKlrdXqP
         xyCA==
X-Gm-Message-State: ACgBeo0FBfWa7YavBkdQEO3XAch+Owpk9+wb2SpYog5WSHDKXwueh1eA
        dHd0ZH/OCnhAZGrEO8afBYV4kqo8HDk=
X-Google-Smtp-Source: AA6agR7OBjijILoVL/otWbQSe7MrKdYq1G9y/CYJ/lkqQj4Eg5cgtMpJ9URo0XBM96U9fGb4UNk5fA==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr1926549pfm.37.1660272996603;
        Thu, 11 Aug 2022 19:56:36 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b00162529828aesm415772plh.109.2022.08.11.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 19:56:36 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ksmbd: don't remove dos attribute xattr on O_TRUNC open
Date:   Fri, 12 Aug 2022 11:56:14 +0900
Message-Id: <20220812025614.5673-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When smb client open file in ksmbd share with O_TRUNC, dos attribute
xattr is removed as well as data in file. This cause the FSCTL_SET_SPARSE
request from the client fails because ksmbd can't update the dos attribute
after setting ATTR_SPARSE_FILE. And this patch fix xfstests generic/469
test also.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5c36657ecfd..0c2e57397dd2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2330,9 +2330,7 @@ static int smb2_remove_smb_xattrs(struct path *path)
 			name += strlen(name) + 1) {
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
-		if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
-		    strncmp(&name[XATTR_USER_PREFIX_LEN], DOS_ATTRIBUTE_PREFIX,
-			    DOS_ATTRIBUTE_PREFIX_LEN) &&
+		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX, STREAM_PREFIX_LEN))
 			continue;
 
-- 
2.25.1

