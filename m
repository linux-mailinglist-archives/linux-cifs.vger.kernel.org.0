Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D996C8364
	for <lists+linux-cifs@lfdr.de>; Fri, 24 Mar 2023 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCXRbv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 24 Mar 2023 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCXRbs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 24 Mar 2023 13:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31117CE5
        for <linux-cifs@vger.kernel.org>; Fri, 24 Mar 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679679064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yS3LsgviE014HnSKQD34+joeCRTUmhUGUupA/8MRjOw=;
        b=KtdeWNsrRGA0k4stmvfW6d7ueXJobx8tpG0qDlcYSaisYfyT8AyLtYkCJ3dMbeJ2XX25R5
        rEUf86kcbD3w7L6ADzD8ZOHg2Mc6QSYT951IMpF9dbtZi+NTkw1BoVsn645FQ+r3t8cddw
        OmCKfttNxRv+6C6Wkz0codf/rtntWdY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-b3ffjvo9N1ugbUgSIlPPfw-1; Fri, 24 Mar 2023 13:31:03 -0400
X-MC-Unique: b3ffjvo9N1ugbUgSIlPPfw-1
Received: by mail-qt1-f197.google.com with SMTP id r4-20020ac867c4000000b003bfefb6dd58so1459821qtp.2
        for <linux-cifs@vger.kernel.org>; Fri, 24 Mar 2023 10:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679679060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS3LsgviE014HnSKQD34+joeCRTUmhUGUupA/8MRjOw=;
        b=eztAARW/lXc/u8O9fbuG19yTQ3ypJhGFKG7LltfcO3ktigKK2U8KPbvnqgEpfwTzCb
         AsEsAfWBEBJhvYyHVhQsZxErZvwJPzSSpnrNkIBk7TJQER8JmrO/dbvWGGP7oIAEPkYu
         ksJGd3dKHW8SJkpj11OYOxMr815IOPTynolyyghH3TZFR4JnN1F22hu5TR3aIVHsAQ7P
         tRittLQDnWgz502mAze9vQiQDpBN/c93rG07s4eqocawJ8ShyIPBz6vwki0/va6lnm27
         m32WWhILRw6cpLb5Q1MfKifrVmPeSoSdXew3tlHIlju5V++Okrs8iYSNZI/MokGRLsy0
         gH/w==
X-Gm-Message-State: AAQBX9fZYP0ytSY03qaIAPTx7lvblbXk9SfD2+MkWDcT8iN/PHpfxM8P
        8ZSTHwsR885qeVhB5vWCtdbjWKzOu1mTwJS1Ox7Ga4rNICEI9/E4QgO6Sii/aJ0/DhJkgCUwVUM
        swtmBMLA+bjcuG9yzcNDAmg==
X-Received: by 2002:ad4:5ce4:0:b0:5cd:3326:792 with SMTP id iv4-20020ad45ce4000000b005cd33260792mr6578286qvb.38.1679679059812;
        Fri, 24 Mar 2023 10:30:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350bL4q0XGxOQvO9LMmJSyYvbSuls1/y5BcXjsOOA+UHzr4CWRhukcoArhUedrPOnlcO+cjsmPw==
X-Received: by 2002:ad4:5ce4:0:b0:5cd:3326:792 with SMTP id iv4-20020ad45ce4000000b005cd33260792mr6578253qvb.38.1679679059593;
        Fri, 24 Mar 2023 10:30:59 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id cw2-20020ad44dc2000000b005dd8b9345aesm829312qvb.70.2023.03.24.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:30:59 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ksmbd: remove unused is_char_allowed function
Date:   Fri, 24 Mar 2023 13:30:56 -0400
Message-Id: <20230324173056.2652725-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

clang with W=1 reports
fs/ksmbd/unicode.c:122:19: error: unused function
  'is_char_allowed' [-Werror,-Wunused-function]
static inline int is_char_allowed(char *ch)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/ksmbd/unicode.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ksmbd/unicode.c b/fs/ksmbd/unicode.c
index a0db699ddafd..9ae676906ed3 100644
--- a/fs/ksmbd/unicode.c
+++ b/fs/ksmbd/unicode.c
@@ -113,24 +113,6 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 	goto out;
 }
 
-/*
- * is_char_allowed() - check for valid character
- * @ch:		input character to be checked
- *
- * Return:	1 if char is allowed, otherwise 0
- */
-static inline int is_char_allowed(char *ch)
-{
-	/* check for control chars, wildcards etc. */
-	if (!(*ch & 0x80) &&
-	    (*ch <= 0x1f ||
-	     *ch == '?' || *ch == '"' || *ch == '<' ||
-	     *ch == '>' || *ch == '|'))
-		return 0;
-
-	return 1;
-}
-
 /*
  * smb_from_utf16() - convert utf16le string to local charset
  * @to:		destination buffer
-- 
2.27.0

