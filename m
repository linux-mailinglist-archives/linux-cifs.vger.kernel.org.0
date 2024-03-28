Return-Path: <linux-cifs+bounces-1676-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35B890CA2
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 22:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627921C294AA
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011940852;
	Thu, 28 Mar 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C87+PYin"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF707F467
	for <linux-cifs@vger.kernel.org>; Thu, 28 Mar 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662290; cv=none; b=mxAaVxmQZA1s3c4DqVg65yZjS9WJWB902CkY5s+s216FZUQljssV+yjzLWDBG2iOb/vTJdGOnPPCtf/QwTW8xugfQM469vOHB05ZQdLJ7LUOpSfyb1KgLqz3UrGsz+LRJzg//VxY/PCvb5Hw758T7tneS22p6ZJl2VUqwAXi0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662290; c=relaxed/simple;
	bh=k417LjfbcYWy0JXyEndKeFzdq4t+prtqtds4CmFz9lE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b2vvxMrJ3atr4UutZ7g7irHt8clUU3CylC3GajNfUtVI4xLmw4spLWOE1tJe87WVKQraRCyvUxb/UZJdkk9tOzYhYHp7bq4192LbBbtEvC5flAjCcwb0GfehGdLYTNJIUq5SQxDCaIvmjE6GMXm0D8gixXGBq+P3ZtRBznmMWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C87+PYin; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so109092939f.0
        for <linux-cifs@vger.kernel.org>; Thu, 28 Mar 2024 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711662288; x=1712267088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8BVyTkvcpkdc/ycYElDg1m9Vq8tBHX5OsniS3ei5tA=;
        b=C87+PYinwTUxSG3O4WrFydQ9PYWRDKSDVy3mgH1X2/khg6p+I19wYXY+rsKwMMpR+K
         ScJsj3l8hJAlkhU8WbTanrBTuY7cO37qF05nmBvjlnZ0cv2CKgUgiS4mp2gAZnjijdiT
         8k72Ksm2g2V+ndriDDK1WvHzXyMf/D6tSe7Ob2XZ3VptH716JUiUHLuhy6edf2TcrN0w
         gZ4l2EPbZ+RcIfxYaxkJspq9znv7cpYGbBiiuW4vs1OniMMgFFREj3x/4pBPQDB4bmq6
         W5qnb9p988Qvwy9b9QZQrkGbNkhIV475uig4r7tpwJ0vNC3bow5UFJepE363xp2lfyQp
         UkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662288; x=1712267088;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8BVyTkvcpkdc/ycYElDg1m9Vq8tBHX5OsniS3ei5tA=;
        b=gvdypY8Q0UcNaw9yfBBCJDFAjJVD5kuuN/H/Tbrs7dpIxd9nn8O0OAyg44WqrwiTCF
         RtW7K1ql/7qd67y+1ibugpuTIjQl56LPjpFBvgBc697MrVxFu5hiWt8T/+OoMNngybP0
         ek4mfCP0TEsbmxnc1odDq7twlLHkd5wUrg45z9hzF5W2y6DMQfs1kw+BjY4MARDqbIZf
         YU9j6UQ9i/a6ZGZNH/aiPLkZ+Bz9P7i+KFHEMSM0fKkPnQKJ7v0k8xSgSIUe5z+NHM00
         jGLNZhYlh21KJxfCThZhnMnYr5XIUka3J16+w6AfSkKQaiwFEB/e9GZjbMaMW0Nnwb1v
         /T7A==
X-Gm-Message-State: AOJu0Yy/jqBMB3PI3rOQpRVTUeqmFQQqWpLDW4clrJr5EX8JyS3toz+l
	EJRdQ+BUxt9A1xmp3EB60n4oezYFRAabyo8N+flPppEYKGuX6JEt2srozV51Rw/Sp/jtmhUwU+P
	3DrMRPJNrwcp5P5ok7GGhtA==
X-Google-Smtp-Source: AGHT+IGt8XSLYloCCppsDFqJ6G9dM4iBlGVghi+slCBAPOgnEl+xOyRUg/wCIxYaj1VgEnfBPy7G2XJRgzqDI/LHZQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:641c:b0:7c8:264d:5e98 with
 SMTP id gn28-20020a056602641c00b007c8264d5e98mr23317iob.0.1711662288634; Thu,
 28 Mar 2024 14:44:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:44:48 +0000
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM/kBWYC/x3NTQ5AMBBA4avIrE1S9RNcRSxop0xCSUeEiLtrL
 L/New8IBSaBNnkg0MnCm4/I0gTMPPiJkG00aKULlesa5Qje7Dc6QVlHNAuTP9Cwk5/YlNoW+eB UZWuIlT2Q4+s/dP37fr5tDypxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711662288; l=3778;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=k417LjfbcYWy0JXyEndKeFzdq4t+prtqtds4CmFz9lE=; b=bUcsODvsW82HxT9AF59CYkfSTLvtdhYAG5vjykdkAa5z+oe8P7sr0n7b1jPq1t6KP4WOaNtpP
 7pqRhlsI2tvAWt+TDwXo1Bb97u3nl2QZdF+inSPrhT9m62JS+221OM8
X-Mailer: b4 0.12.3
Message-ID: <20240328-strncpy-fs-smb-client-cifssmb-c-v1-1-30d12bcf500d@google.com>
Subject: [PATCH] smb: client: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

In cifssmb.c:
Using strncpy with a length argument equal to strlen(src) is generally
dangerous because it can cause string buffers to not be NUL-terminated.
In this case, however, there was extra effort made to ensure the buffer
was NUL-terminated via a manual NUL-byte assignment. In an effort to rid
the kernel of strncpy() use, let's swap over to using strscpy() which
guarantees NUL-termination on the destination buffer.

To handle the case where ea_name is NULL, let's use the ?: operator to
substitute in an empty string, thereby allowing strscpy to still
NUL-terminate the destintation string.

Interesting note: this flex array buffer may go on to also have some
value encoded after the NUL-termination:
|	if (ea_value_len)
|		memcpy(parm_data->list.name + name_len + 1,
|			ea_value, ea_value_len);

Now for smb2ops.c and smb2transport.c:
Both of these cases are simple, strncpy() is used to copy string
literals which have a length less than the destination buffer's size. We
can simply swap in the new 2-argument version of strscpy() introduced in
Commit e6584c3964f2f ("string: Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 fs/smb/client/cifssmb.c       | 6 ++----
 fs/smb/client/smb2ops.c       | 2 +-
 fs/smb/client/smb2transport.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 5aee55551573..23b5709ddc31 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -5854,10 +5854,8 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	parm_data->list.EA_flags = 0;
 	/* we checked above that name len is less than 255 */
 	parm_data->list.name_len = (__u8)name_len;
-	/* EA names are always ASCII */
-	if (ea_name)
-		strncpy(parm_data->list.name, ea_name, name_len);
-	parm_data->list.name[name_len] = '\0';
+	/* EA names are always ASCII and NUL-terminated */
+	strscpy(parm_data->list.name, ea_name ?: "", name_len + 1);
 	parm_data->list.value_len = cpu_to_le16(ea_value_len);
 	/* caller ensures that ea_value_len is less than 64K but
 	we need to ensure that it fits within the smb */
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2ed456948f34..35bf7eb315cd 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3913,7 +3913,7 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 		strcat(message, "W");
 	}
 	if (!new_oplock)
-		strncpy(message, "None", sizeof(message));
+		strscpy(message, "None");
 
 	cinode->oplock = new_oplock;
 	cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 5a3ca62d2f07..1d6e54f7879e 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -659,7 +659,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 	}
 	spin_unlock(&server->srv_lock);
 	if (!is_binding && !server->session_estab) {
-		strncpy(shdr->Signature, "BSRSPYL", 8);
+		strscpy(shdr->Signature, "BSRSPYL");
 		return 0;
 	}
 

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240328-strncpy-fs-smb-client-cifssmb-c-952d43af06d8

Best regards,
--
Justin Stitt <justinstitt@google.com>


