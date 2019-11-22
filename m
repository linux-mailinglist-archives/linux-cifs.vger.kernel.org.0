Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1D1074DF
	for <lists+linux-cifs@lfdr.de>; Fri, 22 Nov 2019 16:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKVPba (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 22 Nov 2019 10:31:30 -0500
Received: from mx.cjr.nz ([51.158.111.142]:28230 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKVPba (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 22 Nov 2019 10:31:30 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 5593180A4E;
        Fri, 22 Nov 2019 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1574436688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vhb+XNbq7Hko2pWyHjbUppjArYBt9Mbe9k3DfHgxQdw=;
        b=M4FdN7GtHHX1BVzM7b5GRs4/ad2qm+81e3yc7l9ENEzhhlYT/O1sEdXfBzXd7KHqBNr0fq
        rvyraMTSz5e2MQ+OBjjo1Wcy5xyPM3GWsNadPfWljOF5p8OnX2TViN5haCLUicaEO3s9MH
        H/ohz+lomDP64gmfRI2u79vabWA18TA9k277gIMTIUw6gTvZH0efuMm+F8cjMHUI1DpqjL
        7addeb7NbUwI681A9+R0RrT74tLLKUNgFJtWmXvOklMC/Wa8VEy5JxwgVKO0d8WSaHzBzn
        Hgweefn4ISQ0wzxND+TxTHXhdwEm5Jo1qXztIeiBcxs+pY11ZQaiIuruPShOmQ==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH 0/7] DFS fixes
Date:   Fri, 22 Nov 2019 12:30:50 -0300
Message-Id: <20191122153057.6608-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

Follow a set of DFS fixes and cleanups, and one fix related to
multichannel support.

Paulo Alcantara (SUSE) (7):
  cifs: Fix use-after-free bug in cifs_reconnect()
  cifs: Fix lookup of root ses in DFS referral cache
  cifs: Fix potential softlockups while refreshing DFS cache
  cifs: Clean up DFS referral cache
  cifs: Fix potential deadlock when updating vol in cifs_reconnect()
  cifs: Fix retrieval of DFS referrals in cifs_mount()
  cifs: Always update signing key of first channel

 fs/cifs/connect.c       |   78 ++-
 fs/cifs/dfs_cache.c     | 1019 ++++++++++++++++++++-------------------
 fs/cifs/smb2pdu.c       |   41 +-
 fs/cifs/smb2transport.c |    4 +
 4 files changed, 612 insertions(+), 530 deletions(-)

-- 
2.24.0

