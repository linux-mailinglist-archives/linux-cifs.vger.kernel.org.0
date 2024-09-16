Return-Path: <linux-cifs+bounces-2809-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C197A3BC
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Sep 2024 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AFF1C27B47
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Sep 2024 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08A158853;
	Mon, 16 Sep 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO0yEmDS"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D4158858
	for <linux-cifs@vger.kernel.org>; Mon, 16 Sep 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495356; cv=none; b=k+GR0isFNaMg+7i0FLAfSesews2e8JRo1X3/vyULLWbCAZ57UEBgqmER03WztCWHBeX7tRoyAGmFk/L6x7RUX3z1EcgZpusRlK57ujT8WtVZWQP0OV25Khg1/pJ8ZXpWay4a8yDWBPFbIl2HsVfoPV6LpatbFc0NIjML5wGj45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495356; c=relaxed/simple;
	bh=jRmoMLzJDRmAiB+MllfoXeztQ21k50HP3WqcoMN0Xtk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hTibIIxdBLYHR6LlpUeFIxe7u5XV4PsLO8/cNBt0fEzFLyJ7ILFFln1CdrGD//lNpj42U2yJ6CITkxAyEDFu+poja+r+A7g1QGV5xq35fJyxxTLx/9sqxwmdigTVDJd3BJMoF/5cdtGnrj3+23Xu1lcWjhlwwyNXK2uxBeY/fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FO0yEmDS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726495354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+mprIRV46hMblWx82Pdc4iP4AoNlwhtFb8YLRZUAS0=;
	b=FO0yEmDSDkZe9hQJJeBNsz8wXYzSKenxiJ1risXdASVCVcE+CC/Jcb5ufuK5Ck/KoFyzJX
	rXwJTokKyYwP3RmfnOCyUErVQXSYdtKnLi5h547P3J64VTwjd0GYa9A6Yt+UBm17VfVVGu
	SdIh64LEKqBVsIOhnLckCUKzits3Pzs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-2u-LM4ykO8GB2_b7iC0xqg-1; Mon,
 16 Sep 2024 10:02:33 -0400
X-MC-Unique: 2u-LM4ykO8GB2_b7iC0xqg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB4D1903085;
	Mon, 16 Sep 2024 14:02:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 015C319560AB;
	Mon, 16 Sep 2024 14:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
References: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com> <20240913-vfs-netfs-39ef6f974061@brauner>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <stfrench@microsoft.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Remove redundant setting of NETFS_SREQ_HIT_EOF
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1948330.1726495326.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2024 15:02:06 +0100
Message-ID: <1948331.1726495326@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix an upstream merge resolution issue[1].  The NETFS_SREQ_HIT_EOF flag,
and code to set it, got added via two different paths.  The original path
saw it added in the netfslib read improvements[2], but it was also added,
and slightly differently, in a fix that was committed before v6.11:

        1da29f2c39b67b846b74205c81bf0ccd96d34727
        netfs, cifs: Fix handling of short DIO read

However, the code added to smb2_readv_callback() to set the flag in didn't
get removed when the netfs read improvements series was rebased to take
account of the cifs fixes.  The proposed merge resolution[2] deleted it
rather than rebase the patches.

Fix this by removing the redundant lines.  Code to set the bit that derive=
s
from the fix patch is still there, a few lines above in the source.

Fixes: 35219bc5c71f ("Merge tag 'vfs-6.12.netfs' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/vfs/vfs")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/CAHk-=3Dwjr8fxk20-wx=3D63mZruW1LTvBvAKya1G=
Q1EhyzXb-okMA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/linux-fsdevel/20240913-vfs-netfs-39ef6f97406=
1@brauner/ [2]
---
 fs/smb/client/smb2pdu.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 95377bb91950..bb8ecbbe78af 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4614,8 +4614,6 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value =3D 0;
 	rdata->subreq.transferred +=3D rdata->got_bytes;
-	if (rdata->subreq.start + rdata->subreq.transferred >=3D rdata->subreq.r=
req->i_size)
-		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);


