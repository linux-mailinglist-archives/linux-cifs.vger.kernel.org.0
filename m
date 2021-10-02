Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB341FC46
	for <lists+linux-cifs@lfdr.de>; Sat,  2 Oct 2021 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJBN1X (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 2 Oct 2021 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhJBN1W (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 2 Oct 2021 09:27:22 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08014C0613EC
        for <linux-cifs@vger.kernel.org>; Sat,  2 Oct 2021 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=YSNmPZU1olsydMKBGwCxmXeXz0b6Cx9UA3ZYFroFOGw=; b=RDc1vCnjbHQnxq/T/MV1hflsY2
        tBlgGyW5MCMYvv7u8Vdezm0bopfml6bu2kUo5f/ecpxH0yYsv5BGwxcz6g8w3Pm4UNmRSBQqi1OAw
        mbkE5uS063q5L1VR5RkFavsBtYfQ7zphUKNwbz+yZfFg1sfHGMWI+pxK6jo5vPop4zNFumaYPsZ+l
        YzJL9vOEkpOKNU8cS3/wB4hrL4j+1WCCr5bQ3TXP1HTJlFYL8vchbdwhFquxoMr0caRvkmHT4F72T
        peNUOcV/i74nSSisado39rXdWS59MMeex1CCQXZwLPXWAs/3Oxis+SDa028kMwm+Tp7C+ocT1d7fb
        OnwNDApcBBuCjR5N+LRpzZWNY7VaoXLKOM2uS69VaWQZeipqxnCaNPo+NPb7d89J9dfrdSmLo5DYf
        l1XA2yNiqcWoheIBlfP+dPAjAIpSQK6oxrK5avSWVqopTkiLTN9DmuHV/pjXNVm7qFJZi8QLlQBoC
        MFjID00aGHU4KFMiuVKH+pgF;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mWeoQ-001DcY-VF; Sat, 02 Oct 2021 13:12:23 +0000
From:   Ralph Boehme <slow@samba.org>
To:     linux-cifs@vger.kernel.org
Cc:     Ralph Boehme <slow@samba.org>, Namjae Jeon <linkinjeon@kernel.org>,
        Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v6 07/14] ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
Date:   Sat,  2 Oct 2021 15:12:05 +0200
Message-Id: <20211002131212.130629-8-slow@samba.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211002131212.130629-1-slow@samba.org>
References: <20211002131212.130629-1-slow@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

No change in behaviour.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Steve French <smfrench@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Ralph Boehme <slow@samba.org>
---
 fs/ksmbd/smb2misc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index c1f0f10ca9f9..76f53db7db8d 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -329,17 +329,12 @@ static int smb2_validate_credit_charge(struct smb2_hdr *hdr)
 
 int ksmbd_smb2_check_message(struct ksmbd_work *work)
 {
-	struct smb2_pdu *pdu = work->request_buf;
+	struct smb2_pdu *pdu = ksmbd_req_buf_next(work);
 	struct smb2_hdr *hdr = &pdu->hdr;
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(pdu);
 
-	if (work->next_smb2_rcv_hdr_off) {
-		pdu = ksmbd_req_buf_next(work);
-		hdr = &pdu->hdr;
-	}
-
 	if (le32_to_cpu(hdr->NextCommand) > 0) {
 		len = le32_to_cpu(hdr->NextCommand);
 	} else if (work->next_smb2_rcv_hdr_off) {
-- 
2.31.1

