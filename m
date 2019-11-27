Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C310A789
	for <lists+linux-cifs@lfdr.de>; Wed, 27 Nov 2019 01:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK0AhG (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 26 Nov 2019 19:37:06 -0500
Received: from mx.cjr.nz ([51.158.111.142]:15906 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfK0AhG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 26 Nov 2019 19:37:06 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 4C76280A21;
        Wed, 27 Nov 2019 00:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1574815024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8D6yQBr4F0CuegDfYL72lMv0Q6TAcL/SngjZkQfJSs0=;
        b=FUj9kWU/n1ePt0xlb5McLzKnDNdyR0kxnl9T4QprKH6tdCWYAgmh+24KVTZlx7oIwz6E4w
        MbPnMI/K0sKH5RMyG4QYtGHzV70HgyiM8BAjES1+Y1s0WpCVcAwbrJfS/TDa1lVovP18FJ
        t3bwkcOByw/dw8BH/+oM6uS4oHTLGKC9dNWfFpWXUsceKIY8C7S7WdE2SbYlCr4EHpmKwW
        yU6GUiKwZUFVSHMr1SVSIfOi1Gmte7wfMGoi0XQpRJGpVCFuAjCDhjebbRxRoPAaRwUlBr
        dJrLFaoDUSC7HfyDUIUX2rWyAVKV7KWOrwqlNn13QqwlqyeM88BoQ9Wqfeo8JA==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH v3 00/11] DFS fixes
Date:   Tue, 26 Nov 2019 21:36:23 -0300
Message-Id: <20191127003634.14072-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

Follow v3 of DFS fixes and cleanups, and one fix related to
multichannel support.

This new version addresses Aurelien and Pavel comments on spliting the
huge cleanup changes into different commits.

Paulo Alcantara (SUSE) (11):
  cifs: Fix use-after-free bug in cifs_reconnect()
  cifs: Fix lookup of root ses in DFS referral cache
  cifs: Fix potential softlockups while refreshing DFS cache
  cifs: Clean up DFS referral cache
  cifs: Get rid of kstrdup_const()'d paths
  cifs: Introduce helpers for finding TCP connection
  cifs: Merge is_path_valid() into get_normalized_path()
  cifs: Fix potential deadlock when updating vol in cifs_reconnect()
  cifs: Avoid doing network I/O while holding cache lock
  cifs: Fix retrieval of DFS referrals in cifs_mount()
  cifs: Always update signing key of first channel

 fs/cifs/connect.c       |   78 ++-
 fs/cifs/dfs_cache.c     | 1094 ++++++++++++++++++++-------------------
 fs/cifs/smb2pdu.c       |   41 +-
 fs/cifs/smb2transport.c |    4 +
 4 files changed, 662 insertions(+), 555 deletions(-)

-- 
2.24.0

