Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A242BBEA0
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Nov 2020 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgKULS2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 21 Nov 2020 06:18:28 -0500
Received: from mail.archlinux.org ([95.216.189.61]:35416 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgKULS1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 21 Nov 2020 06:18:27 -0500
Received: from mail.archlinux.org (localhost [127.0.0.1])
        by mail.archlinux.org (Postfix) with ESMTP id B638F23A90B;
        Sat, 21 Nov 2020 11:12:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.archlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1,
        DKIMWL_WL_HIGH=-0.001,DKIM_SIGNED=0.1,DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1,NO_RECEIVED=-0.001,NO_RELAYS=-0.001,
        T_DMARC_POLICY_NONE=0.01 autolearn=ham autolearn_force=no version=3.4.4
X-Spam-BL-Results: 
From:   Jonas Witschel <diabonas@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archlinux.org;
        s=mail; t=1605957123;
        bh=6Ez5xiGffkXtY4sphIeiOXlt8trqEHcBIKN3+5R6cSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Nia0xPaGQ05DbfQYg9xfH1pbExJHPV2RAvh+A7uTuHwmiMsoL1xYAM4yqgvwudF19
         apoV8BvkNg+hCtt23iZ0oq1AX49zFB+8NxRMEJ66J+sdgUG6N8PZGMGiBAKlsLE1i0
         O5Xow8unPRFXy/tBwZEHh7DnkYlVGt72xuHRyFZJ9JbNHaHogRmJ7Yb5ak26DhHNpT
         z/Yduic0KUSI9oznhS/4SL/vmP3sVFvE1Shs3xh0Gdii3GPKA/Cp7urE0RshJT+kvs
         06kPf1wQRDOHpTKNjZ+78g4BKJoqxTXfEJ/qH/rC+zikN4xJtb4w8mrCqz42LRn42V
         ROiifXxEtRM5c8jD8ms2FSSBRjVldSBgLG++fx8Qv25x2fRG/vp+LO93dZ4jMEd2sG
         vxB+b/LYvRiRA4pvjSbvQwZzSRvK5rlEgQBGCl5PHQsSt1SvnJr32RhIJIVV5524+A
         expIQdiZcIpRn9dcssWrz/2qzHOmw/bpJc2SiRPhRvpjikrSTOdQWK+APyJMSDyi5K
         Qj5+SCPySO0PRepURNYYqbNFiu+WyP7yOufkbhta6pitlo+588P5bzHoH3dM7XVLxJ
         2OFedogPz3UKoX9D4uZD4KKE2Hq9jm75SB5Q0pjoWWTyv6jM69BFkjiAhyHpSx6Tio
         sdcYkNKm6Q5vq/Ikh6zzpqTQ=
To:     linux-cifs@vger.kernel.org
Cc:     Jonas Witschel <diabonas@archlinux.org>
Subject: [PATCH 1/2] mount.cifs: update the cap bounding set only when CAP_SETPCAP is given
Date:   Sat, 21 Nov 2020 12:11:44 +0100
Message-Id: <20201121111145.24975-2-diabonas@archlinux.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121111145.24975-1-diabonas@archlinux.org>
References: <20201121111145.24975-1-diabonas@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

libcap-ng 0.8.1 tightened the error checking on capng_apply, returning an error
of -4 when trying to update the capability bounding set without having the
CAP_SETPCAP capability to be able to do so. Previous versions of libcap-ng
silently skipped updating the bounding set and only updated the normal
CAPNG_SELECT_CAPS capabilities instead.

Check beforehand whether we have CAP_SETPCAP, in which case we can use
CAPNG_SELECT_BOTH to update both the normal capabilities and the bounding set.
Otherwise, we can at least update the normal capabilities, but refrain from
trying to update the bounding set to avoid getting an error.

Signed-off-by: Jonas Witschel <diabonas@archlinux.org>
---
 mount.cifs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mount.cifs.c b/mount.cifs.c
index 4feb397..88b8b69 100644
--- a/mount.cifs.c
+++ b/mount.cifs.c
@@ -338,6 +338,8 @@ static int set_password(struct parsed_mount_info *parsed_info, const char *src)
 static int
 drop_capabilities(int parent)
 {
+	capng_select_t set = CAPNG_SELECT_CAPS;
+
 	capng_setpid(getpid());
 	capng_clear(CAPNG_SELECT_BOTH);
 	if (parent) {
@@ -355,7 +357,10 @@ drop_capabilities(int parent)
 			return EX_SYSERR;
 		}
 	}
-	if (capng_apply(CAPNG_SELECT_BOTH)) {
+	if (capng_have_capability(CAPNG_EFFECTIVE, CAP_SETPCAP)) {
+		set = CAPNG_SELECT_BOTH;
+	}
+	if (capng_apply(set)) {
 		fprintf(stderr, "Unable to apply new capability set.\n");
 		return EX_SYSERR;
 	}
-- 
2.29.2
