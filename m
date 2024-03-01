Return-Path: <linux-cifs+bounces-1382-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA8B86E3C3
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Mar 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BF1287876
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Mar 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0939AC1;
	Fri,  1 Mar 2024 14:54:07 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC143987D;
	Fri,  1 Mar 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304847; cv=none; b=AVGOlTVGtKopB6VpGjx+qUdY3eQ5jdanPwySeyVUV8hDu1fCdOz7hSN/uYobmVcnRWC4vzJyEVKlHKrq1CtQg7Tf9zCT7ZJMeWqTV9JBx+1PFFyn0Ir1w2a8Ay722wbw6UpMQVZXvmngHQ1wuJChaMylFKAlYLbLMtJP1CAymKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304847; c=relaxed/simple;
	bh=hSEvV1uGXnbUmk4BJckyjC9QO5qiJ5UDBiW72C1lb3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tLEDj2Cw/5HOHi9qvRFNHmTzWaJDHnjz782m1fS5BinPnZPYLMp2e28ycv6r/ukkIvu7FCHQr1zuOFfFjFKExk5qZKVyXKotKbx+AL03pbU10E0aDS2lySObLfdGhzLwBXuqYuOOSRyT7KlWre9ThwaPEYznt4luIIfkSyAwrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from debian-BULLSEYE-live-builder-AMD64 (unknown [192.168.32.68])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TmWLl1X1bzlVv2;
	Fri,  1 Mar 2024 17:53:51 +0300 (MSK)
Date: Fri, 1 Mar 2024 17:53:44 +0300
From: Eugene Korenevsky <ekorenevsky@astralinux.ru>
To: linux-cifs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: open_cached_dir(): add FILE_READ_EA to desired access
Message-ID: <ZeHr+PH8spL5F+iZ@debian-BULLSEYE-live-builder-AMD64>
Mail-Followup-To: Eugene Korenevsky <ekorenevsky@astralinux.ru>,
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomhepgfhughgvnhgvucfmohhrvghnvghvshhkhicuoegvkhhorhgvnhgvvhhskhihsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeehteefudduuddtjeffffeigedutdekteffkeetieffueefudffhfdugfffleekudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduledvrdduieekrdefvddrieeknecurfgrrhgrmhephhgvlhhopeguvggsihgrnhdquegfnffnuffgjgfgqdhlihhvvgdqsghuihhluggvrhdqtefoffeigedpihhnvghtpeduledvrdduieekrdefvddrieekmeehkeeivdeipdhmrghilhhfrhhomhepvghkohhrvghnvghvshhkhiesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgtihhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12439106, Updated: 2024-Mar-01 12:56:39 UTC]

Since smb2_query_eas() reads EA and uses cached directory,
open_cached_dir() should request FILE_READ_EA access.

Otherwise listxattr() and getxattr() will fail with EACCES
(0xc0000022 STATUS_ACCESS_DENIED SMB status).

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=218543
Signed-off-by: Eugene Korenevsky <ekorenevsky@astralinux.ru>
---
 fs/smb/client/cached_dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 3de5047a7ff9..a0017724d523 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -239,7 +239,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		.tcon = tcon,
 		.path = path,
 		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE),
-		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES,
+		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES |
+				   FILE_READ_EA,
 		.disposition = FILE_OPEN,
 		.fid = pfid,
 		.replay = !!(retries),
-- 
2.30.2


