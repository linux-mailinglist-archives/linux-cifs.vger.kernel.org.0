Return-Path: <linux-cifs+bounces-7092-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD88C10F67
	for <lists+linux-cifs@lfdr.de>; Mon, 27 Oct 2025 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730E0188072D
	for <lists+linux-cifs@lfdr.de>; Mon, 27 Oct 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC031C584;
	Mon, 27 Oct 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2MCPM5p"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9E30147E;
	Mon, 27 Oct 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592906; cv=none; b=T98uIbWoH5wB9hKklelxx7lq1wV86ud2AVrJEAkG1t/1lR4VvwqzdwC1JVQoSjF0ayhJILZweu4+W3CZCu/+X1mwgmumTmp9qU1AzGxptyYslZDqMgNxJ98YyAjbXrqQRkQ95v8sLxeIRl6Dk9qka5UCmSlFKmfvtK/+yDNovUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592906; c=relaxed/simple;
	bh=yKscy3qWjd4C5ImZlPftKLgAGOz+4A6JohXtXu3n9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJy60O9wGrIG/BsLRPH8l4Q71ce7DJG1UqKwvFSopjF3q1zk/05aN2ao2ksN6xNysFmEGeykRoOvibO3si7ArlkoDXTo3udxp03Z2S0R2KUU29pZTAT8hejQNfBuXwpt3xvy3yLJh9GLSSPIIuDKwNpNL5HX8yl4Dz8UScUM4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2MCPM5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D8C4CEF1;
	Mon, 27 Oct 2025 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592906;
	bh=yKscy3qWjd4C5ImZlPftKLgAGOz+4A6JohXtXu3n9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2MCPM5pYrgBLoA6NbNWdbhsNPWNy38wKWYUM1cwMvK3zElS1d5PLldHvl4DxHqTZ
	 T0Hrn6tFU2tuhkzaxtcpjYr5QfF0f5Y7ja5VVERpKlOv+yuYUeLeZAsP+MZ5DsIa6p
	 UHfpvw4py+WvXDOEr6bPulOl+HmI29IuUnIrTTgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Pavel Shilovskiy <pshilovskiy@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 057/117] cifs: Fix TCP_Server_Info::credits to be signed
Date: Mon, 27 Oct 2025 19:36:23 +0100
Message-ID: <20251027183455.558391985@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 5b2ff4873aeab972f919d5aea11c51393322bf58 upstream.

Fix TCP_Server_Info::credits to be signed, just as echo_credits and
oplock_credits are.  This also fixes what ought to get at least a
compilation warning if not an outright error in *get_credits_field() as a
pointer to the unsigned server->credits field is passed back as a pointer
to a signed int.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Acked-by: Pavel Shilovskiy <pshilovskiy@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsglob.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -703,7 +703,7 @@ struct TCP_Server_Info {
 	bool nosharesock;
 	bool tcp_nodelay;
 	bool terminate;
-	unsigned int credits;  /* send no more requests at once */
+	int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
 	unsigned int max_in_flight; /* max number of requests that were on wire */



