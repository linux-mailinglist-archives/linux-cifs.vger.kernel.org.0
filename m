Return-Path: <linux-cifs+bounces-10117-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AqDAHjqqmmOYAEAu9opvQ
	(envelope-from <linux-cifs+bounces-10117-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 15:53:44 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05222322B
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 15:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444A4300693E
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Mar 2026 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF033B960;
	Fri,  6 Mar 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGFn56Mv"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08271DB34C;
	Fri,  6 Mar 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808262; cv=none; b=F9F9mVPT8g3xiubbfSaP/9lydhnpdsk8xwemKMvPmk5+4Zc52XTL/Qf2SJ+iA6fCUPOV8VsBdBisUvhDecDWesTixRMmdnzZ7N9YC0+5vMmJvFbl14bAzAUaiXWHGUfLOfEGlkkYEanVwFlWWsaqdpVOMs/gZfftdz5O4yC8peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808262; c=relaxed/simple;
	bh=ZGPtDGflxVXaLv/Im+7RyCuN89PJnqdeRWSK94mUN58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uiXk5IWMmEL3O/qZcOPUNEplhCehndgonmT9nd5MlQI9kqZtquU5vUWup+G3Udq43I+uVYUwUJtDbY0Nbnj94h4732qqjFPUlOL3rIx9v42tK4ZKx58C0RV2L4dOIHW2GEibrwcyPuC9ugu9C40Q2KDCkbRHC0ce2ma11umNkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGFn56Mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64827C4CEF7;
	Fri,  6 Mar 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772808261;
	bh=ZGPtDGflxVXaLv/Im+7RyCuN89PJnqdeRWSK94mUN58=;
	h=From:To:Cc:Subject:Date:From;
	b=oGFn56MvGkTBsRW/8Q+rf2GlmJiOTqhyIqD5JoKFpax6bxPhCxrMBDheGLEy71Bty
	 4LsLoooZnMKlOVrhMvIdt0OpiMhD7eiy/wdEIdiOe5xRjtiSi6fPMBuzuKMtTpqVBd
	 MDwWBbf5m1RellQU6YA4TF2HYxrTx6aQUGzP5E8RucG1AeiccHj2fO+dCyLFh4h4Bh
	 kwIY1krTA9XAPu7O7Gq5zLadZOrVJygqQj81K3zMU+l4e9CQZX3kWwMotZecIGHLH6
	 ZCrdND5Gvm1qet3haNZEUkG9yJPMFaIkTiEiPoQMTaiTbAmv/3n9tC7UTbPabkfcZn
	 jcsJvpBH08HUA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Stefan Metzmacher <metze@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smb: fix smbdirect link failure
Date: Fri,  6 Mar 2026 15:44:04 +0100
Message-Id: <20260306144415.3402532-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D05222322B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,kernel.org,vger.kernel.org,lists.samba.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10117-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_INFINIBAND is set to =m, it is not possible to have SMBDIRECT
built-in, and it turns into a loadable module, but this does not prevent
CIFS and SMB_SERVER from being built-in, which in turn causes this
link error:

ld.lld-22: error: undefined symbol: smbdirect_socket_release
>>> referenced by smbdirect.c:212 (fs/smb/client/smbdirect.c:212)
>>>               fs/smb/client/smbdirect.o:(smbd_destroy) in archive vmlinux.a
>>> referenced by smbdirect.c:212 (fs/smb/client/smbdirect.c:212)
>>>               fs/smb/client/smbdirect.o:(smbd_reconnect) in archive vmlinux.a
>>> referenced by smbdirect.c:338 (fs/smb/client/smbdirect.c:338)
>>>               fs/smb/client/smbdirect.o:(smbd_get_connection) in archive vmlinux.a

Enforce the dependency at Kconfig level, so that the respective smpdirect
options are only offered if it's possible to link against the common
module and infiniband.

Fixes: 28504d6ee127 ("smb: client: make use of smbdirect.ko")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/smb/client/Kconfig | 1 +
 fs/smb/server/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
index 72f47669da0c..981b3b5be09b 100644
--- a/fs/smb/client/Kconfig
+++ b/fs/smb/client/Kconfig
@@ -182,6 +182,7 @@ if CIFS
 config CIFS_SMB_DIRECT
 	bool "SMB Direct support"
 	depends on CIFS && INFINIBAND && INFINIBAND_ADDR_TRANS
+	depends on CIFS=m || INFINIBAND=y
 	select SMB_COMMON_SMBDIRECT
 	help
 	  Enables SMB Direct support for SMB 3.0, 3.02 and 3.1.1.
diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index b084071d2442..5c77c5552ed8 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
@@ -49,6 +49,7 @@ if SMB_SERVER
 config SMB_SERVER_SMBDIRECT
 	bool "Support for SMB Direct protocol"
 	depends on SMB_SERVER && INFINIBAND && INFINIBAND_ADDR_TRANS
+	depends on SMB_SERVER=m || INFINIBAND=y
 	select SMB_COMMON_SMBDIRECT
 	default n
 
-- 
2.39.5


