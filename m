Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1B331AC9
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Mar 2021 00:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCHXIZ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Mar 2021 18:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230444AbhCHXH4 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Mar 2021 18:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615244875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1AXhBG3ZACPFxWubjd3qOIZoFJ/0k6v0R83UGsk+XR0=;
        b=QcJUUZEH+CfHuI6Xlbme24dst2GqfJW9hI37gFVS/6e5oww6Wf2enAZuMi3Qy3J8o3DumA
        mmbkESpg7Yq5OHAd8GLnlyVCmWUsoSMbur6zFUJ7tFT4NQeSfwsYp8soAHmrRIfLIGQ8F9
        x28iX5MUAdootM85Cb7KG8pKzvuXKcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Qhw9P2XCPhqT_D4xoZiFlg-1; Mon, 08 Mar 2021 18:07:52 -0500
X-MC-Unique: Qhw9P2XCPhqT_D4xoZiFlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4734226868;
        Mon,  8 Mar 2021 23:07:51 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D601260C13;
        Mon,  8 Mar 2021 23:07:50 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: 
Date:   Tue,  9 Mar 2021 09:07:26 +1000
Message-Id: <20210308230735.337-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve, List

A WIP patch series that starts preparing the open_shroot (now called
open_cached_dir) to be able to be used for any directory, not just root
by moving the checks for directory name ("") as well as the nohandlecache
mount option into the open_cached_dir() function.

Additionally, store, and take out a refcount, for both the dentry
for the root  of the share as well as the directory we open in
open_cached_dir(). These two are the same right now but will start
to differ when we start using this for any directory, not just "".

And finally, do the final plumbing to check "is the lease still valid"
for the parent dirent when checking if we need to revalidate a dentry/inode
or not when called from (primarily) cifs_getattr().

This means that we can now safely serve attributes from out of cache
as long as :
1, we have a lease for the parent directory and a timestamp when the lease
   was aquired.
2, if the timestamp for when the cifs inode was cached is more recent than
   the timestamp for the lease.

I.e. we can server cached attributes back to userspace until the lease
has expired nad not need to rely on (unsafe) actimo.


