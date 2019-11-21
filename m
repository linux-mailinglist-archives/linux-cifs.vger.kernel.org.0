Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE62105A6C
	for <lists+linux-cifs@lfdr.de>; Thu, 21 Nov 2019 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUTfY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 21 Nov 2019 14:35:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41271 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUTfX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 21 Nov 2019 14:35:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id t8so1957127plr.8
        for <linux-cifs@vger.kernel.org>; Thu, 21 Nov 2019 11:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Oh6L/EgpvxQaek7Or4Sg912pIEDcIEQsJoueynkkgp0=;
        b=SOZcT6w/LpiUfOpXqqBdhPT0fYb1phIH4NXSvrvYCUw6uESMwHUYsdjCceT2BAefVe
         fezgQG6m+fzA/NsuQ2u/p3gjxlCaTCbMtW6brsnDTBYKGaSmdzet43B8wAOddBqaQ/9u
         510cIF92YUCCsZtWksB5Dcmu/MXQbxkx+WQ9qM1ytjut/1817rylbga8OgpNCT+z7Rc1
         PPFoZCimiraydppTrx8BDs2RJgnlAURLg2sBHz63BzycV9t2iMbu+a7IQTPncIcCYQIB
         ebQ+WzbVeLgvt2S3bqmE/FFNgk6NXQyZqk2o8pUhAbPTKYAu7Oew+2lrCsr8Yt+0jnF+
         N0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Oh6L/EgpvxQaek7Or4Sg912pIEDcIEQsJoueynkkgp0=;
        b=EBudXVnw9/HJ7gfeAgmGVSwRW6d8Rexrf2L4LwRHFilCRh1TJtv9IV0tz63unX1/NQ
         106P4Kn3GSQVb3CMfHC/a6wOkLdTqcfxb8YiHdLHPGjiCWXwQ3J2Ior59VH10ZHJAYfW
         d0J4Qzog9FhlUSsQpGKpTmjBGBnmrtIy1mr+YjzlbS9sPuzNbSjfWVWwlFSyQgF/fXtl
         IkEK0fAl16GkVI329h7YwxskJRARTz8b0c716XWleepv9Bkih5JVtPSpCoi/sowl3Tde
         XwvUQsTFvMQnsHZ+ritLR65aAgrOPV+5rAGW1cny/zGMzd+ZDIVzZ0967b9OXCujBlSO
         Rx+Q==
X-Gm-Message-State: APjAAAWZ/wmoJZKjAoVP6gcWE2xoaHNFmIA82wp1oRUx6wnAiTnDqDTQ
        LZH9tI+tP6wuorOXUmf0ViOTLfA=
X-Google-Smtp-Source: APXvYqzVBdnaXBCA8SngBy8L1nvxZIM85IE0xDZgfhhr4ZIN3K14L5LC4fd44poh9UvsFRsFhV4zeg==
X-Received: by 2002:a17:902:760b:: with SMTP id k11mr10269829pll.126.1574364923212;
        Thu, 21 Nov 2019 11:35:23 -0800 (PST)
Received: from ubuntu-vm.mshome.net ([167.220.2.106])
        by smtp.gmail.com with ESMTPSA id h185sm3972216pgc.87.2019.11.21.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:35:22 -0800 (PST)
From:   Pavel Shilovsky <piastryyy@gmail.com>
X-Google-Original-From: Pavel Shilovsky <pshilov@microsoft.com>
To:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Frank Sorenson <sorenson@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: [PATCH 3/3] CIFS: Do not miss cancelled OPEN responses
Date:   Thu, 21 Nov 2019 11:35:14 -0800
Message-Id: <20191121193514.3086-3-pshilov@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121193514.3086-1-pshilov@microsoft.com>
References: <20191121193514.3086-1-pshilov@microsoft.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When an OPEN command is cancelled we mark a mid as
cancelled and let the demultiplex thread process it
by closing an open handle. The problem is there is
a race between a system call thread and the demultiplex
thread and there may be a situation when the mid has
been already processed before it is set as cancelled.

Fix this by processing cancelled requests when mids
are being destroyed which means that there is only
one thread referencing a particular mid. Also set
mids as cancelled unconditionally on their state.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/connect.c   |  6 ------
 fs/cifs/transport.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index e63d16d8048a..59feb2de389e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1229,12 +1229,6 @@ cifs_demultiplex_thread(void *p)
 		for (i = 0; i < num_mids; i++) {
 			if (mids[i] != NULL) {
 				mids[i]->resp_buf_size = server->pdu_size;
-				if ((mids[i]->mid_flags & MID_WAIT_CANCELLED) &&
-				    mids[i]->mid_state == MID_RESPONSE_RECEIVED &&
-				    server->ops->handle_cancelled_mid)
-					server->ops->handle_cancelled_mid(
-							mids[i]->resp_buf,
-							server);
 
 				if (!mids[i]->multiRsp || mids[i]->multiEnd)
 					mids[i]->callback(mids[i]);
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index bb52751ba783..987ffcd5ca3a 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -93,8 +93,14 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	__u16 smb_cmd = le16_to_cpu(midEntry->command);
 	unsigned long now;
 	unsigned long roundtrip_time;
-	struct TCP_Server_Info *server = midEntry->server;
 #endif
+	struct TCP_Server_Info *server = midEntry->server;
+
+	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
+	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    server->ops->handle_cancelled_mid)
+		server->ops->handle_cancelled_mid(midEntry->resp_buf, server);
+
 	midEntry->mid_state = MID_FREE;
 	atomic_dec(&midCount);
 	if (midEntry->large_buf)
@@ -1115,8 +1121,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
+			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
 			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
-				midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
-- 
2.17.1

