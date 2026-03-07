Return-Path: <linux-cifs+bounces-10139-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLI6GIgxrGkemwEAu9opvQ
	(envelope-from <linux-cifs+bounces-10139-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Sat, 07 Mar 2026 15:09:12 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34822C12D
	for <lists+linux-cifs@lfdr.de>; Sat, 07 Mar 2026 15:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15EFE3011537
	for <lists+linux-cifs@lfdr.de>; Sat,  7 Mar 2026 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2A2DA77F;
	Sat,  7 Mar 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb4wDDw+"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F72DEA75
	for <linux-cifs@vger.kernel.org>; Sat,  7 Mar 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892540; cv=none; b=bf6lJhF0ZvxV54Vr2TY1MmUV4TnnEau55Holw0XGjOOz9vO2dPyLYCOAXGfSrexpVOI9ejAePc75Sz/SVK48kbucfc9CD9z+kHih8PFI5kCvXn9dxRiw9EiSozFxeM0nW99J5CDD5spxt3cEvmdGM0tjXodsZzAzATab95mplU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892540; c=relaxed/simple;
	bh=EKC+gjybz5QCo3/A2SoLkAdJ9dHzP8glwvLLU31BmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+Gq394CNx+fqYDWW3Mx8ztrpVostCRLEnrv+lfk0A4kKIOdP/MX9ImT4dryjP/Gxsl5tsZsooPlHDXm+irfpbnbP91wb0+OT8D92uzTtRNxhKhMnq7W98rTZgkchwpCx6ihRdhWLBBmYK0aesfaUJEc3cYk8k9abk9C7FSLQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb4wDDw+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a568f3ccso738084b3a.0
        for <linux-cifs@vger.kernel.org>; Sat, 07 Mar 2026 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892538; x=1773497338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=Wb4wDDw+bHkQ4QFzd7CHYDyzuX9Cl9DuRHEoFHcFXRQBaG189KJfreVVIKpg0El3ca
         Yuse00bqCOE7lUV8ol5l8BttdYmXWtdgfInJa2s4lr7KWXKlPikHYp9gToDd23z/uFPX
         U+TjbjA09cEMI7QhrOSNztXQQVqWppg93HTKILs6u4qdZ5V720HMM9ubv/3AkShDxd9+
         HRuqnQAn4xWwYR1PHOJdWmJCGECsOSGBGhYLHsia68y4sZd5DPJY4F2d+2aJsGGMLRsr
         F0HGQMF39Ct7hJv9fyZjDVmFUDKFQybmZJkVqkcXWPKPr5N6RY0roySeVDzrZld+y9WG
         fo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892538; x=1773497338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cE+gTqS6Acm3OjdFoCwcpAog50aFpqNiNU85af164dY=;
        b=PYmHLlnZ14Ug8/vRrkGrviYMjZLfRd9/bEQ8Loa9F6hctjn/y/E/PP0vus8waqfPVe
         Ly1vPE6TJuEmgiPdyiVfCeV8OmyZWTbJdFPq46zPYPrzW9tCUc8Nb6jIld4Z7jPfkXFq
         Wd8PM10kBu3KbCSSHBGAQLBuDCk2bZlPLiEZgBXaKj61+qLBBMQPQv64Ec/Fju74pvtP
         PyiCTAm7yrIEAt+WpHQc+5/xvrtCBelWWU5Ip7ic4gxx2FI/DSiqmvpKn+ANbKT+ywW4
         rupl6lbP8d/08j9cq/TTsvKyp5HCG5dCTTw5B3dejLvqopVwS6Ux7C5vL0y0UGRAScX1
         bY8w==
X-Forwarded-Encrypted: i=1; AJvYcCWUskFUUS/Pnw598QHE0xANL7iSjR/fcuV/ZfVKR8ZXEJ0aBUaH+HNwdP/5/9xvMrgeacTIPTCZhWqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUlmSI7BUjocKIuS/8bvX/FyD7u2qDrTPSxqOf43pRNi4dYOU
	gVhD/mgQUxfAa81O0khOra1zFMUjQkbGKJvQICwMxoEjZGmeunqlrY5T
X-Gm-Gg: ATEYQzzdtnKfCCkVn9hYXNYuP+Up5S2r5iQq7rDxAViB90S5gksIUPwfghqlVaGqdVN
	ur/aFOhvAXhvyScehloL4j7wY4k+PdkyQ0m/c6AoxF4bLQBttOnxbKQXCop6qdZaDkd3S0vP036
	YMilQbSitAS72ZVRSa4uaipnNuz+4duWCP3WQKKA1LrlmM+Wy8ZaHNhzMBrr9sehdVLGycr9EQk
	f+BoaVo4vEQ6GSkqYpAPjwoTgcjwD4M/c8p0GoV9b31VJ5EPHwMcbUIXv875Op4BgMbT3lWSbsb
	mCpuZ7P5odl+P7HKTexGOdgijz++3ujXg5GNPSO8ARlKeJ2ljFEomNZqcJWtwn97ibbklonFNmJ
	RTHs7xKI56G8ySVNRpSsTD6g3f5rTxl1vRkYIYWxB1Z1rfKc3HRhslYFslT91nvOHPqXJBBjp4E
	Nia9nzsvWRy7GwD8WyFdpdG1mGC5eUtbIZ5JTtnouTKop2ElfV86GBA+c=
X-Received: by 2002:a05:6a21:700c:b0:366:14ac:e20a with SMTP id adf61e73a8af0-398591082a4mr5640721637.72.1772892538431;
        Sat, 07 Mar 2026 06:08:58 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:58 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v5 4/4] mips/fcntl.h: convert O_* flag macros from hex to octal
Date: Sat,  7 Mar 2026 20:06:46 +0600
Message-ID: <20260307140726.70219-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F34822C12D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10139-lists,linux-cifs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Following the convention in include/uapi/asm-generic/fcntl.h and other
architecture specific arch/*/include/uapi/asm/fcntl.h files.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/mips/include/uapi/asm/fcntl.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..6aa3f49df17e 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	0000010
+#define O_DSYNC		0000020	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	0000200
+#define O_CREAT		0000400	/* not fcntl */
+#define O_TRUNC		0001000	/* not fcntl */
+#define O_EXCL		0002000	/* not fcntl */
+#define O_NOCTTY	0004000	/* not fcntl */
+#define FASYNC		0010000	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	0020000	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	0040000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	0100000	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
-- 
2.53.0


