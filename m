Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51A2C8BFD
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgK3SDv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:03:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:45290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgK3SDv (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:03:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2FE30AC55
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:10 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Subject: [PATCH v4 00/11] Witness protocol support for transparent failover
Date:   Mon, 30 Nov 2020 19:02:46 +0100
Message-Id: <20201130180257.31787-1-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Changes from v3:
  * Add registration ID attribute to the unregister netlink message.
    The userspace daemon will include it in the log output as it is
    useful for debugging purposes.

Changes from v2:
  * Fix 'no previous prototype' kernel test robot warning in
    fs/cifs/netlink.c

Changes from v1:
  * Update SPDX header in user space API files to LGPL-2.1+ with
    Linux-syscall-note

[PATCH v4 01/11] cifs: Make extract_hostname function public
[PATCH v4 02/11] cifs: Make extract_sharename function public
[PATCH v4 03/11] cifs: Register generic netlink family
[PATCH v4 04/11] cifs: add witness mount option and data structs
[PATCH v4 05/11] cifs: Send witness register and unregister commands
[PATCH v4 06/11] cifs: Set witness notification handler for messages
[PATCH v4 07/11] cifs: Add witness information to debug data dump
[PATCH v4 08/11] cifs: Send witness register messages to userspace
[PATCH v4 09/11] cifs: Simplify reconnect code when dfs upcall is
[PATCH v4 10/11] cifs: Handle witness client move notification
[PATCH v4 11/11] cifs: Handle witness share moved notification

 fs/cifs/Kconfig                        |  11 +
 fs/cifs/Makefile                       |   2 +
 fs/cifs/cache.c                        |  24 -
 fs/cifs/cifs_debug.c                   |  13 +
 fs/cifs/cifs_swn.c                     | 727 +++++++++++++++++++++++++
 fs/cifs/cifs_swn.h                     |  25 +
 fs/cifs/cifsfs.c                       |  22 +-
 fs/cifs/cifsglob.h                     |   8 +
 fs/cifs/cifsproto.h                    |   2 +
 fs/cifs/connect.c                      | 141 +++--
 fs/cifs/fscache.c                      |   1 +
 fs/cifs/fscache.h                      |   1 -
 fs/cifs/misc.c                         |  56 ++
 fs/cifs/netlink.c                      |  89 +++
 fs/cifs/netlink.h                      |  16 +
 include/uapi/linux/cifs/cifs_netlink.h |  63 +++
 16 files changed, 1122 insertions(+), 79 deletions(-)

