Return-Path: <linux-cifs+bounces-5111-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211AAAE4108
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Jun 2025 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03501677EE
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Jun 2025 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D9924DD0F;
	Mon, 23 Jun 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGnqickd"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885D2550D3
	for <linux-cifs@vger.kernel.org>; Mon, 23 Jun 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682966; cv=none; b=Fle33d7Fw5vsY8ezQeNmWpoOifx7Mi5DauZ9UtzAlu9DYRFT0jeyZ0kAzYzPuLbtmWFc065/SArRnO6U5WuLAfoSLBnvizLAuqnxBS3ah4azO1+ZiqctrsJtjA2T5S8qtDTYZ994mM/9d9J6f+we2NFW+xQdwxLp4vHNCqiq0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682966; c=relaxed/simple;
	bh=Js8EE7ZHS9G60cdqqUwjPDnFmtgp21nKILvF8e5LANo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+UmEoxeiNZc18zolQK9YLFsfkTNqrMZSMXwwPSRbmIMci9XZA9V7NTAlc3uA5DoqrpDMiX1ZjMioB2syHA66iyP75svOLuRh1BFE13/0ZDI5vMFEDj69KM8xvvAEw4RpqeBSxxiB8gEojuh+8arfz3QxjrsX0ZA46AO7waAUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGnqickd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQ1ndNHNeoiyV90JjgbZyG68tyV9jF8afWehzUhxtFs=;
	b=MGnqickd6eZsOyXlESifVmyoSEf9nmxsWusxQSfZBac9pBkRFN0Hpm9ydC0X3X1jziPgbW
	efM0h1RNr7GTpWdXfV8hk75/hOF/hUHXO+r+tQngUmNdQfGt5hP8o7w9YkgFRjM0uOJsyD
	x5fct9gm0k2Xb2/G55D2yKoDeCz+U0k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-LrnKw8piMA-GmU4Aaxdd5A-1; Mon,
 23 Jun 2025 08:49:22 -0400
X-MC-Unique: LrnKw8piMA-GmU4Aaxdd5A-1
X-Mimecast-MFC-AGG-ID: LrnKw8piMA-GmU4Aaxdd5A_1750682960
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7708519560B0;
	Mon, 23 Jun 2025 12:49:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9DA619560A3;
	Mon, 23 Jun 2025 12:49:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 07/11] smb: client: set missing retry flag in smb2_writev_callback()
Date: Mon, 23 Jun 2025 13:48:27 +0100
Message-ID: <20250623124835.1106414-8-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Paulo Alcantara <pc@manguebit.org>

Set NETFS_SREQ_NEED_RETRY flag to tell netfslib that the subreq needs
to be retried.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
Cc: netfs@lists.linux.dev
---
 fs/smb/client/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a717be1626a3..084ee66e73fd 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4862,6 +4862,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:


