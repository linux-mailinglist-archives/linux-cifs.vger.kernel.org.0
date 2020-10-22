Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A328296471
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Oct 2020 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898629AbgJVSNt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 22 Oct 2020 14:13:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505941AbgJVSNt (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 22 Oct 2020 14:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46A75ADDF
        for <linux-cifs@vger.kernel.org>; Thu, 22 Oct 2020 18:13:48 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Subject: [PATCH 00/11] Witness protocol support for transparent failover
Date:   Thu, 22 Oct 2020 20:13:28 +0200
Message-Id: <20201022181339.30771-1-scabrero@suse.de>
X-Mailer: git-send-email 2.28.0
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This patchset adds witness protocol support, enabling transparent
client failover for clustered shares. Both, regular and scale-out
clustered file servers are supported.

In summary, the client side of the protocol is implemented in userspace,
specifically in the samba's swnclient library, and a new daemon called
swnd provides the interface for the cifs module via netlink. This
reduces the kernel changes to just sending the commands to register and
unregister to receive the notifications and process these notifications
received from swnd.

[PATCH 01/11] cifs: Make extract_hostname function public
[PATCH 02/11] cifs: Make extract_sharename function public
[PATCH 03/11] cifs: Register generic netlink family
[PATCH 04/11] cifs: add witness mount option and data structs
[PATCH 05/11] cifs: Send witness register and unregister commands to
[PATCH 06/11] cifs: Set witness notification handler for messages
[PATCH 07/11] cifs: Add witness information to debug data dump
[PATCH 08/11] cifs: Send witness register messages to userspace
[PATCH 09/11] cifs: Simplify reconnect code when dfs upcall is
[PATCH 10/11] cifs: Handle witness client move notification
[PATCH 11/11] cifs: Handle witness share moved notification

 fs/cifs/Kconfig                        |  11 +
 fs/cifs/Makefile                       |   2 +
 fs/cifs/cache.c                        |  24 -
 fs/cifs/cifs_debug.c                   |  13 +
 fs/cifs/cifs_swn.c                     | 723 +++++++++++++++++++++++++
 fs/cifs/cifs_swn.h                     |  25 +
 fs/cifs/cifsfs.c                       |  22 +-
 fs/cifs/cifsglob.h                     |   8 +
 fs/cifs/cifsproto.h                    |   2 +
 fs/cifs/connect.c                      | 141 +++--
 fs/cifs/fscache.c                      |   1 +
 fs/cifs/fscache.h                      |   1 -
 fs/cifs/misc.c                         |  56 ++
 fs/cifs/netlink.c                      |  88 +++
 fs/cifs/netlink.h                      |  16 +
 include/uapi/linux/cifs/cifs_netlink.h |  63 +++
 16 files changed, 1117 insertions(+), 79 deletions(-)

