Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCD15E884
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Feb 2020 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbgBNQQc (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Feb 2020 11:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392610AbgBNQQb (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BECE2468F;
        Fri, 14 Feb 2020 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696991;
        bh=9j8X2m67R4Ml4yEuJzG98wz75DIpMegNzJAmtFU/4bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MULZ9FeTa6EThUxhca/XeVVF30IABsq9z4utLCuA7MXj2Larfl7Y99MMYFiTNJs8K
         NCUBMvt6i0b3XKfbRJ1E1UMqciGitqVoUY+zhL+76FgDyzGgOEukc53ZAK3iUdV636
         vKIlLyjuYDz3zUVrD3Mt3q4eRAk+PXaTzF4OYZTI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 4.19 225/252] cifs: fix NULL dereference in match_prepath
Date:   Fri, 14 Feb 2020 11:11:20 -0500
Message-Id: <20200214161147.15842-225-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit fe1292686333d1dadaf84091f585ee903b9ddb84 ]

RHBZ: 1760879

Fix an oops in match_prepath() by making sure that the prepath string is not
NULL before we pass it into strcmp().

This is similar to other checks we make for example in cifs_root_iget()

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 576cf71576da1..6c62ce40608a1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3342,8 +3342,10 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 {
 	struct cifs_sb_info *old = CIFS_SB(sb);
 	struct cifs_sb_info *new = mnt_data->cifs_sb;
-	bool old_set = old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH;
-	bool new_set = new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH;
+	bool old_set = (old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
+		old->prepath;
+	bool new_set = (new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
+		new->prepath;
 
 	if (old_set && new_set && !strcmp(new->prepath, old->prepath))
 		return 1;
-- 
2.20.1

