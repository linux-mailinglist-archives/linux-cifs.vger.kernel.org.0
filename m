Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F261D06C1
	for <lists+linux-cifs@lfdr.de>; Wed,  9 Oct 2019 06:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfJIEvm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 9 Oct 2019 00:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbfJIEvm (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 9 Oct 2019 00:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6524F18C4289;
        Wed,  9 Oct 2019 04:51:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3126D60BEC;
        Wed,  9 Oct 2019 04:51:38 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-cifs@vger.kernel.org, piastryyy@gmail.com, smfrench@gmail.com
Subject: [PATCH v2] mount.cifs.rst: update prefixpath mount option description.
Date:   Wed,  9 Oct 2019 10:21:36 +0530
Message-Id: <20191009045136.5065-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 09 Oct 2019 04:51:42 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This option is ignored after kernel v3.10

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 mount.cifs.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mount.cifs.rst b/mount.cifs.rst
index ee5086c..f1a57d1 100644
--- a/mount.cifs.rst
+++ b/mount.cifs.rst
@@ -590,7 +590,8 @@ prefixpath=arg
   It's possible to mount a subdirectory of a share. The preferred way to
   do this is to append the path to the UNC when mounting. However, it's
   also possible to do the same by setting this option and providing the
-  path there.
+  path there. This option is provided for backward compatibility.
+  It is ignored after kernel v3.10
 
 vers=arg
   SMB protocol version. Allowed values are:
-- 
2.21.0

