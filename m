Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7D3F4D26
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Aug 2021 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhHWPQL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 23 Aug 2021 11:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhHWPQL (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 23 Aug 2021 11:16:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89AA4613C8;
        Mon, 23 Aug 2021 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629731728;
        bh=t2nGmgbFyFHZClVecWGEauO0ZXehWvD+RnY19p3jJTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQmy2JgP1mrQwWCinr/Co9x6gJTiu3VM95lWbgcLtdN3RRLeA89M6tyPdKe7L9Hh+
         /s8QhtJSGklika0FdriVzndgPOiYZQBilWEoxvkV5tkGgQmmO5xJ+HPgHFLT8wykIi
         ikDf4115NQHSwHshHgX2yDiE4Q6BYEGzBGfnqu10DgzPhDuk7J+AU6R9aPOeiWQ5Gz
         xSaHLA6LfIosGq2Px9iRNQV4J3f/DZTCrpQM/qeqeMCxuGqj1VWE3uD3H8Di4Uz3dm
         acodX2PdGJ2asVf9D31ELhp5162fcGXLE7Vdj23X9mnhLXqd4rt223gkEdyjgWDRNS
         X1/EWkYyXOHnw==
From:   Christian Brauner <brauner@kernel.org>
To:     Steve French <stfrench@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-cifs@vger.kernel.org
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 08/11] ndr: fix translation in ndr_encode_posix_acl()
Date:   Mon, 23 Aug 2021 17:13:54 +0200
Message-Id: <20210823151357.471691-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823151357.471691-1-brauner@kernel.org>
References: <20210823025816.7496-1-namjae.jeon@samsung.com>
 <20210823151357.471691-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; h=from:subject; bh=ZYcpc2Ya/JkXl/1tehn8jHa9g1H3Hgwqutmw0szQaUQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQq7zayvZTzQ6L+Iq9o1/ol+96Hndsa+OiZ8sbTApZeswvV t3i1dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE8QjDHy45D/0JM6c7Sn3XV+o+vU njcNueqzVNc8R25IS76tbI5DEyNL3Zesll1vqQnKYaZQe+7mvhumzBnAdqLv3c7fvo9LGf7AA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The sid_to_id() helper encodes raw ownership information suitable for
s*id handling. This is conceptually equivalent to reporting ownership
information via stat to userspace. In this case the consumer is ksmbd
instead of a regular user. So when encoding raw ownership information
suitable for s*id handling later we need to map the id up according to
the user namespace of ksmbd itself taking any idmapped mounts into
account.

Cc: Steve French <stfrench@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ksmbd/ndr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/ndr.c b/fs/ksmbd/ndr.c
index df23dfbaf657..4c4ea27ef44b 100644
--- a/fs/ksmbd/ndr.c
+++ b/fs/ksmbd/ndr.c
@@ -254,8 +254,8 @@ int ndr_encode_posix_acl(struct ndr *n,
 		ndr_write_int32(n, 0);
 	}
 
-	ndr_write_int64(n, from_kuid(user_ns, inode->i_uid));
-	ndr_write_int64(n, from_kgid(user_ns, inode->i_gid));
+	ndr_write_int64(n, from_kuid(&init_user_ns, i_uid_into_mnt(user_ns, inode)));
+	ndr_write_int64(n, from_kgid(&init_user_ns, i_gid_into_mnt(user_ns, inode)));
 	ndr_write_int32(n, inode->i_mode);
 
 	if (acl) {
-- 
2.30.2

