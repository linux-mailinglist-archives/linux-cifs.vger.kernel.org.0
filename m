Return-Path: <linux-cifs+bounces-10118-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBMfNd7uqmmOYAEAu9opvQ
	(envelope-from <linux-cifs+bounces-10118-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 16:12:30 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B52238D8
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6494F3069674
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Mar 2026 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C4169AD2;
	Fri,  6 Mar 2026 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCDlE5/n"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA33AE6FB;
	Fri,  6 Mar 2026 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809643; cv=none; b=R6ayD/zWFAoQyPowHGGJW7D7GlFXDQ+L+78DV9d8IfQH4RqMW3xYFCR+P1RJBKA7Ct7VsegMsSviItj3rlNHcsoZ/4f4UQ18oOvI2I8YvrSEKZX9dhNqmjz9JQZ8TjiZYA65qHW7kH0MnjzSiX+LBMgeQFEFi5M+BH0qbIzJzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809643; c=relaxed/simple;
	bh=R9XKo9285+GpqM2kJZOdMgVCKfgVx4a7DQ+vWx5vbz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZpdUgxjmRDNpcBEXwl+4A8CD103iXAnuvMrPCqIPDNu5knZBUAvgwk1PTgTM9JdH5QUzkOhjlq9XUlGKNfa+JStoJXelkv9jeYMiGtdMHNgDerHpDZLNedYWcGHjvjE714eVBDnS3ZaQHZAZxygWODC8/+zWzATTMZ6ZPrvKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCDlE5/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F14AC4CEF7;
	Fri,  6 Mar 2026 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809643;
	bh=R9XKo9285+GpqM2kJZOdMgVCKfgVx4a7DQ+vWx5vbz8=;
	h=From:To:Cc:Subject:Date:From;
	b=sCDlE5/ngbq6l7SZUpJA0b3Ir1+o/T/cTpo9mv2pJkmrg7kq2/KrqMRWjuN5B+N6w
	 agDwyqJFYGE2B0jY0cu1TuxmdpN1rkygvIkT9PSPMFf26EZzEIpxWWUvOOHO6bMg+y
	 2pqAFcLdhEcScgQiFfXJ7vWCWQ+KlNlj2TjUj//ljqLDX8ig5FH2WMSaP5DLTTaklU
	 wCUpI3km4Tfu9NR58gSjPABZzyImAfSYolkIYMC2Nh32RscXMEp+FWyaBK6R7t4wgD
	 kNEsjefM27WV6QhD2MvEBcyETnKrwq9ViE7Ag/OeULWc+Nua53LvT/ni85P5iy9ZvD
	 eHvzSdGOD3F+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smb: client: fix sbflags initialization
Date: Fri,  6 Mar 2026 16:07:13 +0100
Message-Id: <20260306150717.483742-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 971B52238D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,microsoft.com,talpey.com,suse.com,users.sourceforge.net,zeniv.linux.org.uk,vger.kernel.org,lists.samba.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10118-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced variable is initialized in an #ifdef block
but used outside of it, leading to undefined behavior when
CONFIG_CIFS_ALLOW_INSECURE_LEGACY is disabled:

fs/smb/client/dir.c:417:9: error: variable 'sbflags' is uninitialized when used here [-Werror,-Wuninitialized]
  417 |                                 if (sbflags & CIFS_MOUNT_DYNPERM)
      |                                     ^~~~~~~

Move the initialization into the declaration, the same way as the
other similar function do it.

Fixes: 4fc3a433c139 ("smb: client: use atomic_t for mnt_cifs_flags")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/smb/client/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 953f1fee8cb8..55ffbdc17c8a 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -187,7 +187,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	const char *full_path;
 	void *page = alloc_dentry_path();
 	struct inode *newinode = NULL;
-	unsigned int sbflags;
+	unsigned int sbflags = cifs_sb_flags(cifs_sb);
 	int disposition;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
@@ -367,7 +367,6 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	 * If Open reported that we actually created a file then we now have to
 	 * set the mode if possible.
 	 */
-	sbflags = cifs_sb_flags(cifs_sb);
 	if ((tcon->unix_ext) && (*oplock & CIFS_CREATE_ACTION)) {
 		struct cifs_unix_set_info_args args = {
 				.mode	= mode,
-- 
2.39.5


