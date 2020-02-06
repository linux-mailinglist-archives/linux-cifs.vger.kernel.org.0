Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBD15443E
	for <lists+linux-cifs@lfdr.de>; Thu,  6 Feb 2020 13:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBFMte (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 6 Feb 2020 07:49:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:47256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBFMte (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 6 Feb 2020 07:49:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F13CAE2D;
        Thu,  6 Feb 2020 12:49:32 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: fix channel signing
Date:   Thu,  6 Feb 2020 13:49:26 +0100
Message-Id: <20200206124926.25376-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The server var was accidentally used as an iterator over the global
list of connections, thus overwritten the passed argument. This
resulted in the wrong signing key being returned for extra channels.

Fix this by using a separate var to iterate.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/smb2transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index fe6acfce3390..08b703b7a15e 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -104,13 +104,14 @@ int smb2_get_sign_key(__u64 ses_id, struct TCP_Server_Info *server, u8 *key)
 {
 	struct cifs_chan *chan;
 	struct cifs_ses *ses = NULL;
+	struct TCP_Server_Info *it = NULL;
 	int i;
 	int rc = 0;
 
 	spin_lock(&cifs_tcp_ses_lock);
 
-	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
-		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+	list_for_each_entry(it, &cifs_tcp_ses_list, tcp_ses_list) {
+		list_for_each_entry(ses, &it->smb_ses_list, smb_ses_list) {
 			if (ses->Suid == ses_id)
 				goto found;
 		}
-- 
2.16.4

