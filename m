Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9402329A4
	for <lists+linux-cifs@lfdr.de>; Mon,  3 Jun 2019 09:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFCHbt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 3 Jun 2019 03:31:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFCHbs (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 3 Jun 2019 03:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF4D9307CDF5;
        Mon,  3 Jun 2019 07:31:48 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-17.bne.redhat.com [10.64.54.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3815D9CD;
        Mon,  3 Jun 2019 07:31:48 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: fix panic in smb2_reconnect
Date:   Mon,  3 Jun 2019 17:31:38 +1000
Message-Id: <20190603073138.25211-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 03 Jun 2019 07:31:48 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

RH Bugzilla: 1702264

We need to protect so that the call to smb2_reconnect() in
smb2_reconnect_server() does not end up freeing the session
because it can lead to a use after free and crash.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 565b60b62f4d..c4f3e2403b58 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3116,6 +3116,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
 			list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
 			tcon_exist = true;
+			ses->ses_count++;
 		}
 	}
 	/*
@@ -3134,6 +3135,8 @@ void smb2_reconnect_server(struct work_struct *work)
 		else
 			resched = true;
 		list_del_init(&tcon->rlist);
+		if (tcon->ipc)
+			cifs_put_smb_ses(tcon->ses);
 		cifs_put_tcon(tcon);
 	}
 
-- 
2.13.6

