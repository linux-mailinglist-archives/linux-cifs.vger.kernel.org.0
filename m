Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3FD2DC4
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Oct 2019 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfJJPcT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 10 Oct 2019 11:32:19 -0400
Received: from mx.cjr.nz ([51.158.111.142]:42354 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJPcT (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:32:19 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id B819A81032;
        Thu, 10 Oct 2019 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1570721537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DT05UIB34qgZ21VKCCSFG+qP5wQYRjlisOShZMc+G7U=;
        b=rvm3wqngV62GigB/4x+JaHVZN0J+zQW5cYVlwWmQrsB7CW2N814zObqkGOGFMU5CFVVdxO
        YWfEcBVte/uGQ2LRwuNeWUOcowm11Cvkbsu0MycTP407vCStPo3DBI4EQMAJtas+GjPQB5
        OGcicOncRo9effHUIA6pLqedYAsfoztG8JSYcfniB3eIyS4Y1g40TzRyrII9GvSXrYuDs6
        RhhswYCXTgt7oN6U87jDaNZjll9yZOHWCDDuOaTbpcIaOA86yWr3n1/xqe98x6tSuJNq+l
        7JtJFaA0FXGxnY6R0y7xKYluzh+OEfiSy1BvrWPB6x5/XqVSsjvfrStd0tSSpw==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        smfrench@gmail.com
Cc:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH] cifs: Handle -EINPROGRESS only when noblockcnt is set
Date:   Thu, 10 Oct 2019 12:31:58 -0300
Message-Id: <20191010153158.14160-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We only want to avoid blocking in connect when mounting SMB root
filesystems, otherwise bail out from generic_ip_connect() so cifs.ko
can perform any reconnect failover appropriately.

This fixes DFS failover/reconnection tests in upstream buildbot.

Fixes: 8eecd1c2e5bc ("cifs: Add support for root file systems")
Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/connect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a64dfa95a925..bdea4b3e8005 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3882,8 +3882,12 @@ generic_ip_connect(struct TCP_Server_Info *server)
 
 	rc = socket->ops->connect(socket, saddr, slen,
 				  server->noblockcnt ? O_NONBLOCK : 0);
-
-	if (rc == -EINPROGRESS)
+	/*
+	 * When mounting SMB root file systems, we do not want to block in
+	 * connect. Otherwise bail out and then let cifs_reconnect() perform
+	 * reconnect failover - if possible.
+	 */
+	if (server->noblockcnt && rc == -EINPROGRESS)
 		rc = 0;
 	if (rc < 0) {
 		cifs_dbg(FYI, "Error %d connecting to server\n", rc);
-- 
2.23.0

