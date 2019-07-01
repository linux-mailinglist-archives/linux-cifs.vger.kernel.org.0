Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75AF4C795
	for <lists+linux-cifs@lfdr.de>; Thu, 20 Jun 2019 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfFTGk1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 20 Jun 2019 02:40:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39766 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfFTGk0 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 20 Jun 2019 02:40:26 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hdqkD-0000lS-Oz; Thu, 20 Jun 2019 14:40:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hdqkB-0000KR-7G; Thu, 20 Jun 2019 14:40:23 +0800
Date:   Thu, 20 Jun 2019 14:40:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: cifs: Fix tracing build error with O=
Message-ID: <20190620064023.cwvcj5g4rgnmkmmn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Currently if you build the kernel with O= then fs/cifs fails with:

$ make O=build
...
  CC [M]  fs/cifs/trace.o
In file included from ../fs/cifs/trace.h:846:0,
                 from ../fs/cifs/trace.c:8:
../include/trace/define_trace.h:95:43: fatal error: ./trace.h: No such file or directory
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
                                           ^
compilation terminated.

The reason is that -I$(src) expands to -Ifs/cifs which does not
work with O=.  This patch fixes it by adding srctree to the front.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index 51af69a1a328..616163deee18 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for Linux CIFS/SMB2/SMB3 VFS client
 #
-ccflags-y += -I$(src)		# needed for trace events
+ccflags-y += -I$(srctree)/$(src)		# needed for trace events
 obj-$(CONFIG_CIFS) += cifs.o
 
 cifs-y := trace.o cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o \
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
