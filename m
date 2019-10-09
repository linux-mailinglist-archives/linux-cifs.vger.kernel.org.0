Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 325BED06FC
	for <lists+linux-cifs@lfdr.de>; Wed,  9 Oct 2019 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfJIGCA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 9 Oct 2019 02:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfJIGCA (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 9 Oct 2019 02:02:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A9A383F40;
        Wed,  9 Oct 2019 06:02:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 188D6600CD;
        Wed,  9 Oct 2019 06:01:56 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-cifs@vger.kernel.org, piastryyy@gmail.com, smfrench@gmail.com
Subject: [PATCH v3] mount.cifs.rst: remove prefixpath mount option.
Date:   Wed,  9 Oct 2019 11:31:51 +0530
Message-Id: <20191009060151.7913-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Oct 2019 06:02:00 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This option is deprecated and currently ignored since
kernel v3.1

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 mount.cifs.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mount.cifs.rst b/mount.cifs.rst
index ee5086c..29e2f35 100644
--- a/mount.cifs.rst
+++ b/mount.cifs.rst
@@ -586,12 +586,6 @@ noposixpaths
 posixpaths
   Inverse of ``noposixpaths`` .
 
-prefixpath=arg
-  It's possible to mount a subdirectory of a share. The preferred way to
-  do this is to append the path to the UNC when mounting. However, it's
-  also possible to do the same by setting this option and providing the
-  path there.
-
 vers=arg
   SMB protocol version. Allowed values are:
 
-- 
2.21.0

