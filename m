Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35E76AAF89
	for <lists+linux-cifs@lfdr.de>; Sun,  5 Mar 2023 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCEMfD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 5 Mar 2023 07:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCEMfC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 5 Mar 2023 07:35:02 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D65EB63
        for <linux-cifs@vger.kernel.org>; Sun,  5 Mar 2023 04:35:01 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so10549068pjb.1
        for <linux-cifs@vger.kernel.org>; Sun, 05 Mar 2023 04:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678019700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws6vZDG9nd3B5Kpu44xBXsDs4IPcTYKZNaZkmCdfNhc=;
        b=xWz6ViY7TLQrKNTv61g9LvqaVbAvlKHAws3y09eU9jqJ3C3sowPpiXeeTgw6vtGU9S
         vzgyd0u8guuujl/GrZa0VPc3GS8ZngwmjaiJsH+LdbNMAIyLbGIHGIJst3nHN9PRCCSH
         en4HYtRb05XPAcYtr6ffvkvKYxoJP7axqGdVlBdhXuOeB0NNA0MAjctJD3UDL4mUymZt
         lgp06z09kMWXjQGBJMUB9lb2brKKVb4niHRRlwCCo3/Q6xdoswoqqXVtnGr4zQDBzcBW
         +vyBYJNknPQ4K3NtFnw2686RhROzipT6EjdB4/wNwE3tPzqCxzegc/2mM1DvPhHrymRb
         SFag==
X-Gm-Message-State: AO0yUKU42qmSqpHnjePVbfRaR2RSfBeWrULsYdRLoDpXlbb2+KP31pvK
        bHCa6mJgFbkmiSSRDPqvn/z3UZrb6jE=
X-Google-Smtp-Source: AK7set/1mcXOdLYK+7HKq5c15lis1StoOv68M0swocfGK9PyWHX7fBfEQtC2rWOKajIj7C1wqK3rKg==
X-Received: by 2002:a05:6a20:5486:b0:bc:a257:5b2a with SMTP id i6-20020a056a20548600b000bca2575b2amr10909605pzk.31.1678019699926;
        Sun, 05 Mar 2023 04:34:59 -0800 (PST)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b005a8dcd32851sm4683257pfn.11.2023.03.05.04.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:34:59 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH 2/2] ksmbd: add low bound validation to FSCTL_QUERY_ALLOCATED_RANGES
Date:   Sun,  5 Mar 2023 21:34:43 +0900
Message-Id: <20230305123443.21509-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230305123443.21509-1-linkinjeon@kernel.org>
References: <20230305123443.21509-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Smatch static checker warning:
 fs/ksmbd/vfs.c:1040 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'length'
 fs/ksmbd/vfs.c:1041 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'start'

Fix unexpected result that could caused from negative start and length.

Fixes: f44158485826 ("cifsd: add file operations")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b7a420e0fcc4..4af4230ab50b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7457,6 +7457,11 @@ static int fsctl_query_allocated_ranges(struct ksmbd_work *work, u64 id,
 	start = le64_to_cpu(qar_req->file_offset);
 	length = le64_to_cpu(qar_req->length);
 
+	if (start < 0 || length < 0) {
+		ksmbd_fd_put(work, fp);
+		return -EINVAL;
+	}
+
 	ret = ksmbd_vfs_fqar_lseek(fp, start, length,
 				   qar_rsp, in_count, out_count);
 	if (ret && ret != -E2BIG)
-- 
2.25.1

