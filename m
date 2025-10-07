Return-Path: <linux-cifs+bounces-6617-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57EBC2472
	for <lists+linux-cifs@lfdr.de>; Tue, 07 Oct 2025 19:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106DC40125A
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Oct 2025 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B642E8E19;
	Tue,  7 Oct 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hk4SpwP1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lxgy55OS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hk4SpwP1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lxgy55OS"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54A2E8E03
	for <linux-cifs@vger.kernel.org>; Tue,  7 Oct 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859014; cv=none; b=S+k1nxHsSZ0Ane+nS6bKp0zNhDAYeHUgnQ14DsVSAN7LwUMymCBkSOsFDyw63gX5rfWrl114XpJk8yHfjbQSM0TBWp6hltvqHZYr/HOq8Rh4K2FEZ0WJFzi5aR//s0mZO+DW5ssDxdkyJucxoF78GO0CH0YsVpCCUhV8QDxWk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859014; c=relaxed/simple;
	bh=yNDdjFkI6JzNqOe5BJVOvx0v7xwJ5Tr1yZ8atWYBYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMQ+ob/XXNcmW5Mtg5IDvqDqXr4LPdlGVPFlBdGE7yA7Nb8o2FUlDIfqaOnN12N6lWCmAZzBo00dGGi9mX9+5UDWktHfgep1pe38vGIZdeAFJFa1ZJ2DZ11Ux4WKJS/RMHMusKPJ2rxp7y7j7tE+DPVqP9eo6V65CEeyM+mVmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hk4SpwP1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lxgy55OS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hk4SpwP1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lxgy55OS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 631F334213;
	Tue,  7 Oct 2025 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759859009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N33GyY12pio2MGXzJCdZbOB8xCPhSsKeSiEhLwvuzz8=;
	b=hk4SpwP1QiyLkIWjClOs3IH9SSdjemZakH69UmKFHxPIFeUFRSpkIEwyszxmrR98Jssguc
	+nGVTcjx6OF7kNRfrooeHr1Mr6Ts62k3/SrVp24Aefx1+j6NpIobXJQ+BxZP7dPF/R4TWc
	ZAYQX/NlgT9MFe4xAzKPm+FK0SJOzzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759859009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N33GyY12pio2MGXzJCdZbOB8xCPhSsKeSiEhLwvuzz8=;
	b=lxgy55OS4TOlrHRcuBk1+R3XRpvaNlmwZetp1g6nccibZ53YJgcDmIBd97yWHCCyeeUVpg
	ewGsMC233UCidQAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759859009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N33GyY12pio2MGXzJCdZbOB8xCPhSsKeSiEhLwvuzz8=;
	b=hk4SpwP1QiyLkIWjClOs3IH9SSdjemZakH69UmKFHxPIFeUFRSpkIEwyszxmrR98Jssguc
	+nGVTcjx6OF7kNRfrooeHr1Mr6Ts62k3/SrVp24Aefx1+j6NpIobXJQ+BxZP7dPF/R4TWc
	ZAYQX/NlgT9MFe4xAzKPm+FK0SJOzzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759859009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N33GyY12pio2MGXzJCdZbOB8xCPhSsKeSiEhLwvuzz8=;
	b=lxgy55OS4TOlrHRcuBk1+R3XRpvaNlmwZetp1g6nccibZ53YJgcDmIBd97yWHCCyeeUVpg
	ewGsMC233UCidQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4CB213693;
	Tue,  7 Oct 2025 17:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lh6fKkBR5WjxdwAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Tue, 07 Oct 2025 17:43:28 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-cifs@vger.kernel.org
Cc: smfrench@gmail.com,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	henrique.carvalho@suse.com
Subject: [PATCH v2 04/20] smb: client: remove cached_fids->dying list
Date: Tue,  7 Oct 2025 14:42:48 -0300
Message-ID: <20251007174304.1755251-5-ematsumiya@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007174304.1755251-1-ematsumiya@suse.de>
References: <20251007174304.1755251-1-ematsumiya@suse.de>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,manguebit.com,microsoft.com,talpey.com,suse.com];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLfjfk8uratp77wzttmx99usr3)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Since any cleanup is now done on the local list in laundromat, the
dying list can be removed.

- entries stays on the main list until they're scheduled for cleanup
  (->last_access_time == 1)
- cached_fids->num_entries is decremented only when cfid transitions
  from on_list true -> false

cached_fid lifecycle on the list becomes:

- list_add() on find_or_create_cached_dir()
- list_move() to local list on laundromat
- list_del() on release callback, if on_list == true (unlikely, see
  comment in the function)

Other changes:
- add invalidate_cfid() helper

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/smb/client/cached_dir.c | 104 +++++++++++++++++--------------------
 fs/smb/client/cached_dir.h |   3 +-
 2 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 0f259461a746..a8e467d38200 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -22,16 +22,26 @@ struct cached_dir_dentry {
 	struct dentry *dentry;
 };
 
+static inline void invalidate_cfid(struct cached_fid *cfid)
+{
+	/* callers must hold the list lock and do any list operations (del/move) themselves */
+	lockdep_assert_held(&cfid->cfids->cfid_list_lock);
+
+	if (cfid->on_list)
+		cfid->cfids->num_entries--;
+
+	/* do not change other fields here! */
+	cfid->on_list = false;
+	cfid->time = 0;
+	cfid->last_access_time = 1;
+}
+
 static inline void drop_cfid(struct cached_fid *cfid)
 {
 	struct dentry *dentry = NULL;
 
 	spin_lock(&cfid->cfids->cfid_list_lock);
-	if (cfid->on_list) {
-		list_del(&cfid->entry);
-		cfid->on_list = false;
-		cfid->cfids->num_entries--;
-	}
+	invalidate_cfid(cfid);
 
 	swap(cfid->dentry, dentry);
 	spin_unlock(&cfid->cfids->cfid_list_lock);
@@ -469,6 +479,25 @@ smb2_close_cached_fid(struct kref *ref)
 {
 	struct cached_fid *cfid = container_of(ref, struct cached_fid, refcount);
 
+	/*
+	 * There's no way a cfid can reach here with ->on_list == true.
+	 *
+	 * This is because we hould our own ref, and whenever we put it, we invalidate the cfid
+	 * (which sets ->on_list to false).
+	 *
+	 * So even if an external caller puts the last ref, ->on_list will already have been set to
+	 * false by then by one of the invalidations that can happen concurrently, e.g. lease break,
+	 * invalidate_all_cached_dirs().
+	 *
+	 * So this check is mostly for precaution, but since we can still take the correct actions
+	 * if it's the case, do so.
+	 */
+	if (WARN_ON(cfid->on_list)) {
+		list_del(&cfid->entry);
+		cfid->on_list = false;
+		cfid->cfids->num_entries--;
+	}
+
 	drop_cfid(cfid);
 	free_cached_dir(cfid);
 }
@@ -484,15 +513,10 @@ void drop_cached_dir_by_name(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "no cached dir found for rmdir(%s)\n", name);
 		return;
 	}
-	spin_lock(&cfid->cfids->cfid_list_lock);
-	if (cfid->has_lease) {
-		cfid->has_lease = false;
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
-	}
-	spin_unlock(&cfid->cfids->cfid_list_lock);
-	close_cached_dir(cfid);
-}
 
+	drop_cfid(cfid);
+	kref_put(&cfid->refcount, smb2_close_cached_fid);
+}
 
 void close_cached_dir(struct cached_fid *cfid)
 {
@@ -524,6 +548,8 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
 			continue;
 		spin_lock(&cfids->cfid_list_lock);
 		list_for_each_entry(cfid, &cfids->entries, entry) {
+			invalidate_cfid(cfid);
+
 			tmp_list = kmalloc(sizeof(*tmp_list), GFP_ATOMIC);
 			if (tmp_list == NULL) {
 				/*
@@ -572,25 +598,11 @@ void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 	if (!cfids)
 		return;
 
-	/*
-	 * Mark all the cfids as closed, and move them to the cfids->dying list.
-	 * They'll be cleaned up by laundromat.  Take a reference to each cfid
-	 * during this process.
-	 */
+	/* mark all the cfids as closed and invalidate them for laundromat cleanup */
 	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
-		list_move(&cfid->entry, &cfids->dying);
-		cfids->num_entries--;
+		invalidate_cfid(cfid);
 		cfid->is_open = false;
-		cfid->on_list = false;
-		if (cfid->has_lease) {
-			/*
-			 * The lease was never cancelled from the server,
-			 * so steal that reference.
-			 */
-			cfid->has_lease = false;
-		} else
-			kref_get(&cfid->refcount);
 	}
 	spin_unlock(&cfids->cfid_list_lock);
 
@@ -614,17 +626,13 @@ bool cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 		    !memcmp(lease_key,
 			    cfid->fid.lease_key,
 			    SMB2_LEASE_KEY_SIZE)) {
-			cfid->has_lease = false;
-			cfid->time = 0;
-
 			/*
-			 * We found a lease, move it to the dying list and schedule immediate
-			 * cleanup on laundromat.
+			 * We found a lease, invalidate cfid and schedule immediate cleanup on
+			 * laundromat.
 			 * No need to take a ref here, as we still hold our initial one.
 			 */
-			list_move(&cfid->entry, &cfids->dying);
-			cfids->num_entries--;
-			cfid->on_list = false;
+			invalidate_cfid(cfid);
+			cfid->has_lease = false;
 			found = true;
 			break;
 		}
@@ -700,23 +708,11 @@ static void cfids_laundromat_worker(struct work_struct *work)
 	cfids = container_of(work, struct cached_fids, laundromat_work.work);
 
 	spin_lock(&cfids->cfid_list_lock);
-	/* move cfids->dying to the local list */
-	list_cut_before(&entry, &cfids->dying, &cfids->dying);
-
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
 		if (cfid->last_access_time &&
 		    time_after(jiffies, cfid->last_access_time + HZ * dir_cache_timeout)) {
-			cfid->on_list = false;
+			invalidate_cfid(cfid);
 			list_move(&cfid->entry, &entry);
-			cfids->num_entries--;
-			if (cfid->has_lease) {
-				/*
-				 * Our lease has not yet been cancelled from the
-				 * server. Steal that reference.
-				 */
-				cfid->has_lease = false;
-			} else
-				kref_get(&cfid->refcount);
 		}
 	}
 	spin_unlock(&cfids->cfid_list_lock);
@@ -751,7 +747,6 @@ struct cached_fids *init_cached_dirs(void)
 		return NULL;
 	spin_lock_init(&cfids->cfid_list_lock);
 	INIT_LIST_HEAD(&cfids->entries);
-	INIT_LIST_HEAD(&cfids->dying);
 
 	INIT_DELAYED_WORK(&cfids->laundromat_work, cfids_laundromat_worker);
 	queue_delayed_work(cfid_put_wq, &cfids->laundromat_work,
@@ -779,12 +774,7 @@ void free_cached_dirs(struct cached_fids *cfids)
 
 	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
-		cfid->on_list = false;
-		cfid->is_open = false;
-		list_move(&cfid->entry, &entry);
-	}
-	list_for_each_entry_safe(cfid, q, &cfids->dying, entry) {
-		cfid->on_list = false;
+		invalidate_cfid(cfid);
 		cfid->is_open = false;
 		list_move(&cfid->entry, &entry);
 	}
diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index 51cfdb81ec53..7614af617243 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -54,12 +54,11 @@ struct cached_fid {
 struct cached_fids {
 	/* Must be held when:
 	 * - accessing the cfids->entries list
-	 * - accessing the cfids->dying list
+	 * - accessing cfids->num_entries
 	 */
 	spinlock_t cfid_list_lock;
 	int num_entries;
 	struct list_head entries;
-	struct list_head dying;
 	struct delayed_work laundromat_work;
 	/* aggregate accounting for all cached dirents under this tcon */
 	atomic_long_t total_dirents_entries;
-- 
2.51.0


