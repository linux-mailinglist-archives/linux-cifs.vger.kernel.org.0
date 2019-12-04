Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077F5113691
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Dec 2019 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLDUiT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 4 Dec 2019 15:38:19 -0500
Received: from mx.cjr.nz ([51.158.111.142]:1594 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbfLDUiT (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 4 Dec 2019 15:38:19 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id EDAE2809F8;
        Wed,  4 Dec 2019 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1575491897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TeC72SaPnykUVsXPuidz9mFtN4uaZ8g7WqQUuTupXUo=;
        b=wS2ghlVA7LcWr9XJQdzJERUlznW5xalPghQ8jdmd3odrjDxonmzeOJ+RZ9HTDTXHl50BPY
        UAsf3tSfqak+M/ZS2tOTOLQrUeNfO+m80l0+bfyNCcvktNaPcd67Ttc/GIzw2/yBwkQHZK
        Dc+H0bKXjmHitUvtTYeWjri/a939jWCSo9YXGnBj4vfede4hZSbviVUE7HdCLwXFHsVgbN
        WOfTVHaZb2GWaFrWpNFt2SgONJdFor3EtiiMKtgcFz+y/hy5Ty9t1UN4DEdjdg5zank9W4
        ST6dUxgInc+xRgoRcU1FqgJbl4NkWdnzyTHJ4k988wKRuBUIKCGX1fNtJjFAhw==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH v4 0/6] DFS fixes
Date:   Wed,  4 Dec 2019 17:37:57 -0300
Message-Id: <20191204203803.2316-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

Follow v4 of DFS fixes and cleanups.

Add kref to vol_info structure and avoid potential races in cache_ttl
(Aurelien).

Paulo Alcantara (SUSE) (6):
  cifs: Clean up DFS referral cache
  cifs: Get rid of kstrdup_const()'d paths
  cifs: Introduce helpers for finding TCP connection
  cifs: Merge is_path_valid() into get_normalized_path()
  cifs: Fix potential deadlock when updating vol in cifs_reconnect()
  cifs: Avoid doing network I/O while holding cache lock

 fs/cifs/dfs_cache.c | 1110 +++++++++++++++++++++++--------------------
 1 file changed, 586 insertions(+), 524 deletions(-)

-- 
2.24.0

