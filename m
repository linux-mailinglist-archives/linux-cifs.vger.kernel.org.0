Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C372A19C
	for <lists+linux-cifs@lfdr.de>; Fri,  9 Jun 2023 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFIRrv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 9 Jun 2023 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIRru (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 9 Jun 2023 13:47:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEFDD
        for <linux-cifs@vger.kernel.org>; Fri,  9 Jun 2023 10:47:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so954390a12.3
        for <linux-cifs@vger.kernel.org>; Fri, 09 Jun 2023 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686332869; x=1688924869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXHL4rbnBke9oDpZAUPXu1H2QGHdN6ca0eZSQ1UNlhM=;
        b=BNCWjbnjosBRHeABzR/60W0+z15Mh3jazrz+3Use840BEqaxXeAHd0SQTRejwK0vh+
         2ioeCI/BBpB7iCBB9fG2GbwpQdK9FsA0JWy90iJiwo9aZXKmr22TNlxB0TzH5LisxAfB
         2oP4UQYiXgMfKObQbepwdU1vRscZakaUlYjl5v+FVT0dJzNvVe1awDbazAWsRPUKf4TT
         rIMJrsm4LTPcf5tOaVsO47oW0UDQKzVwbUbpHN41UY4Cg9Y1wa0DrIfxKdKtWltel0Pw
         wN/O3Evq6+68iyAOhJNLCxecRFhZHBYkFG3/rnVLaSN9/zcr+g10o6QMKqd8Hs3wToNX
         Sr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332869; x=1688924869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXHL4rbnBke9oDpZAUPXu1H2QGHdN6ca0eZSQ1UNlhM=;
        b=duo2FAAq4TNTSFJsaWjT8Uf8EMjJJuaI8RUVOQxioU/evKGtMo6IC67km3/zA/J8oZ
         Uf/FxlyakEvTkZ17Da9Mw0fodBoJop/dpLzks6WscLAWZ2wO/3Jg4TypeR/VhUiBjFMk
         ZttvMdA9u2sLJ0+MkaSHjNHv02HgTCydSxOX/E7iApBp93YF9CKkid77OWFxS13H+W9w
         WGcgl2I73Y8gSp0jgFlYUYdr3d2xMxMrJkaWfjjO+IzTDTToUmbdq7QilKfZb3TFN/hI
         ChjkhOevnFRS5wTaWlR+Z7uRYyOUKawFFCxE3DZQMH4YmcA0Cl77ltpHR9z+MddSU2dh
         +VFQ==
X-Gm-Message-State: AC+VfDxDkl09AiD3lPj/Y/EqPS3JP5OEremfY79XxiLI8YbT/KKkJRhv
        DALOX0mPuAo338eB/V1C9NqsOEsLIVtRvyRE
X-Google-Smtp-Source: ACHHUZ6gT0tba9d1vsl6H7oUXkhgS3LntiO6u23McMA6RWUFpcqfZwCW+qgl6PEDn9X0xs1hMqVltQ==
X-Received: by 2002:a17:90a:1d1:b0:253:34da:487 with SMTP id 17-20020a17090a01d100b0025334da0487mr1664763pjd.35.1686332868568;
        Fri, 09 Jun 2023 10:47:48 -0700 (PDT)
Received: from lindev-local-latest.corp.microsoft.com ([2404:f801:8028:1:7e0e:5dff:fea8:2c14])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a71c400b0025671de4606sm5003064pjs.4.2023.06.09.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:47:48 -0700 (PDT)
From:   Shyam Prasad N <nspmangalore@gmail.com>
X-Google-Original-From: Shyam Prasad N <sprasad@microsoft.com>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        bharathsm.hsk@gmail.com, tom@talpey.com
Cc:     Shyam Prasad N <sprasad@microsoft.com>
Subject: [PATCH 3/6] cifs: add a warning when the in-flight count goes negative
Date:   Fri,  9 Jun 2023 17:46:56 +0000
Message-Id: <20230609174659.60327-3-sprasad@microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609174659.60327-1-sprasad@microsoft.com>
References: <20230609174659.60327-1-sprasad@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We've seen the in-flight count go into negative with some
internal stress testing in Microsoft.

Adding a WARN when this happens, in hope of understanding
why this happens when it happens.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6e3be58cfe49..43162915e03c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -91,6 +91,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 					    server->conn_id, server->hostname, *val,
 					    add, server->in_flight);
 	}
+	WARN_ON(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
-- 
2.34.1

