Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59CF21DC3B
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Jul 2020 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGMQbN (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Jul 2020 12:31:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730132AbgGMQbM (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 13 Jul 2020 12:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3v2F73edBr6Ggies7zt3y5ZooG1GfcT3tRqvWmvwJg=;
        b=XkbqXpCjzPO/WvXotw/Tf6eSP/Bjb1uqSGSE1cMbHD461H7K3fWAbhnq5h8QqdTk5taXD5
        k8RNSYVPWW8FMR2fQQQ6rAB+oVtUtmwUeOOeqozZrnlxeMmG2WuYFL3AVwEP6IsfKe0ieG
        hyXsh9AWy7Q/I4qhb1rnh4IH7mk5LxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-CjyeGd5yOpSG5Xhm4WMapA-1; Mon, 13 Jul 2020 12:31:09 -0400
X-MC-Unique: CjyeGd5yOpSG5Xhm4WMapA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75FE81085;
        Mon, 13 Jul 2020 16:31:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE2412B6DD;
        Mon, 13 Jul 2020 16:31:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/32] vm: Add wait/unlock functions for PG_fscache
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:31:04 +0100
Message-ID: <159465786405.1376674.15704703594171055681.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add functions to unlock and wait for unlock of PG_fscache analogously with
those for PG_lock.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/pagemap.h |   14 ++++++++++++++
 mm/filemap.c            |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cf2468da68e9..0b917990dc1e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -501,6 +501,7 @@ extern int __lock_page_killable(struct page *page);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 extern void unlock_page(struct page *page);
+extern void unlock_page_fscache(struct page *page);
 
 /*
  * Return true if the page was successfully locked
@@ -575,6 +576,19 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
+/**
+ * wait_on_page_fscache - Wait for PG_fscache to be cleared on a page
+ * @page: The page
+ *
+ * Wait for the fscache mark to be removed from a page, usually signifying the
+ * completion of a write from that page to the cache.
+ */
+static inline void wait_on_page_fscache(struct page *page)
+{
+	if (PagePrivate2(page))
+		wait_on_page_bit(compound_head(page), PG_fscache);
+}
+
 extern void put_and_wait_on_page_locked(struct page *page);
 
 void wait_on_page_writeback(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..4894e9705d34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1293,6 +1293,24 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
+/**
+ * unlock_page_fscache - Unlock a page pinned with PG_fscache
+ * @page: The page
+ *
+ * Unlocks the page and wakes up sleepers in wait_on_page_fscache().  Also
+ * wakes those waiting for the lock and writeback bits because the wakeup
+ * mechanism is shared.  But that's OK - those sleepers will just go back to
+ * sleep.
+ */
+void unlock_page_fscache(struct page *page)
+{
+	page = compound_head(page);
+	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
+	clear_bit_unlock(PG_fscache, &page->flags);
+	wake_up_page_bit(page, PG_fscache);
+}
+EXPORT_SYMBOL(unlock_page_fscache);
+
 /**
  * end_page_writeback - end writeback against a page
  * @page: the page


