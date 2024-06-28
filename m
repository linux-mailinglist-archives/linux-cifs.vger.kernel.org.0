Return-Path: <linux-cifs+bounces-2265-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D391B35B
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Jun 2024 02:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E50A284215
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Jun 2024 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8361860;
	Fri, 28 Jun 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqkCs1vE"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBE6FB6
	for <linux-cifs@vger.kernel.org>; Fri, 28 Jun 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534390; cv=none; b=k3Of/spC+hViLRSol5iya3BnlIICLomFtlemXpEx/n1OdRw7jDb8ngRgC5DZYpcC69Cb7bMRcfPQ0hH9MYKqzjqyO09uXZ1njMe4VfgDxmb+/xWW7v4afEduALnlGsE5NujVEntqrODtmYl9O2M9nDevMd/+4fKm467h04zMb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534390; c=relaxed/simple;
	bh=hh11G/iodh5iWE0DKtFfqmVHr22By8Ulh9rirP+ZYcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nc1BJTIANk9qFQzQYeOIPJQf9VyW/ji+0IjXk/5x5G/tdL6GUhHiEu280j/kzJnOFZ+oz13aPpMMOi2l++Kes3BYYx2iDLN49h955IxkkZWsxlpUDj6xCdPZEzJYJBPYVe7gYn24HD0vt5UAkfrdsRFWcU8Lrq4ra/kHtJs9NrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqkCs1vE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F920R5yaBE3PsuRdteKVNVN6MSLZBpfM90SMj8g8nmA=;
	b=MqkCs1vELpBXue/wzqbDkxiCkET4JDzLp+A0PCGAJ/eWIUog8Uv9BByus4U8hcydGZewNn
	J0U+dE/SeBwB8YUnQs2UAOgOPHDTDc3/imI6cm92A0jYtpmCJb/l+nRiXDPeq84G65oA/c
	Tcush1T+oKaqiX7WYCwwttQgqlqBzRY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-HGpKrjkKOka29xCulRgfQQ-1; Thu, 27 Jun 2024 20:26:26 -0400
X-MC-Unique: HGpKrjkKOka29xCulRgfQQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so3903139f.1
        for <linux-cifs@vger.kernel.org>; Thu, 27 Jun 2024 17:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534386; x=1720139186;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F920R5yaBE3PsuRdteKVNVN6MSLZBpfM90SMj8g8nmA=;
        b=t5X8XgBX+LQ7KXbpBqqYd7MtM5ub9ggeC2tLHRxCUdzYPd2A//drXLEKCN3TTQMv26
         TWJK82Y0Qf+HDqzKO+YglIIvgkr6zfupzZTlFd0S0PQBbfkk1b/w4t0dnQBPNbkNXQkZ
         vNRpKKqcR34ikcyJfiiLdxuuQ0ZW/8F4GS6juiZ0HzElxCCnhs2eu1COASuqhPX35kmj
         d32uUywwV1eY50jJaO/pS0YyCUj7aLevmvlJgcuF4ko+fODBfDAixgytoTA3DY0b0OkN
         idDosAPgzCh434UYTvdbb92gZlpCtgM86I4oDPboFHSxlfvsspYD+d+RnvzVn1aYS3DT
         vp7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9D0+CMRAb6Nm4OfQ8jJwofOWg40pKbaMU2oG0Qu2v7MVwYwhvQbiZ7Xg2gQgDtVzo3UjcHZGuzz+fGPMVPzJkUM4PBVKX541fqw==
X-Gm-Message-State: AOJu0YyYSnR14XZRF375TOzvqjBD4PQ866074vrJNCMfsUa0vb9+HbTw
	IM0Bos8wRcXQOu52RZ/uKCADGr2+fLCqA+mffggWXEiR398Y68LxugBwABNLVBD8MiiIkeCQou/
	P6sHrH7qu/WD7SyFGgt4C4aOh7uFgdymNAgahLdiHBVkZEbm//+77nFfOgu0=
X-Received: by 2002:a6b:730e:0:b0:7f3:d863:3cf8 with SMTP id ca18e2360f4ac-7f3d8634018mr415330539f.4.1719534385813;
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQ+evTqW23iP2xMhQPr9hw69BKkkeaSh3vRZVLP5nIJpjBkoHrAggDlvkHwnRujUOQkyNmA==
X-Received: by 2002:a6b:730e:0:b0:7f3:d863:3cf8 with SMTP id ca18e2360f4ac-7f3d8634018mr415329439f.4.1719534385516;
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd541dsm219330173.55.2024.06.27.17.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
Message-ID: <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
Date: Thu, 27 Jun 2024 19:26:24 -0500
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/14] fs_parse: add uid & gid option option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 linux-mm@kvack.org, Jan Kara <jack@suse.cz>, ntfs3@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Hans Caniullan <hcaniull@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Multiple filesystems take uid and gid as options, and the code to
create the ID from an integer and validate it is standard boilerplate
that can be moved into common helper functions, so do that for
consistency and less cut&paste.

This also helps avoid the buggy pattern noted by Seth Jenkins at
https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
because uid/gid parsing will fail before any assignment in most
filesystems.

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---
 Documentation/filesystems/mount_api.rst |  9 +++++--
 fs/fs_parser.c                          | 34 +++++++++++++++++++++++++
 include/linux/fs_parser.h               |  6 ++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 9aaf6ef75eb5..317934c9e8fc 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -645,6 +645,8 @@ The members are as follows:
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
 	fs_param_is_fd		File descriptor		result->int_32
+	fs_param_is_uid		User ID (u32)           result->uid
+	fs_param_is_gid		Group ID (u32)          result->gid
 	=======================	=======================	=====================
 
      Note that if the value is of fs_param_is_bool type, fs_parse() will try
@@ -678,6 +680,8 @@ The members are as follows:
 	fsparam_bdev()		fs_param_is_blockdev
 	fsparam_path()		fs_param_is_path
 	fsparam_fd()		fs_param_is_fd
+	fsparam_uid()		fs_param_is_uid
+	fsparam_gid()		fs_param_is_gid
 	=======================	===============================================
 
      all of which take two arguments, name string and option number - for
@@ -784,8 +788,9 @@ process the parameters it is given.
      option number (which it returns).
 
      If successful, and if the parameter type indicates the result is a
-     boolean, integer or enum type, the value is converted by this function and
-     the result stored in result->{boolean,int_32,uint_32,uint_64}.
+     boolean, integer, enum, uid, or gid type, the value is converted by this
+     function and the result stored in
+     result->{boolean,int_32,uint_32,uint_64,uid,gid}.
 
      If a match isn't initially made, the key is prefixed with "no" and no
      value is present then an attempt will be made to look up the key with the
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index a4d6ca0b8971..24727ec34e5a 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
+int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kuid_t uid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	uid = make_kuid(current_user_ns(), result->uint_32);
+	if (!uid_valid(uid))
+		return inval_plog(log, "Invalid uid '%s'", param->string);
+
+	result->uid = uid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_uid);
+
+int fs_param_is_gid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kgid_t gid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	gid = make_kgid(current_user_ns(), result->uint_32);
+	if (!gid_valid(gid))
+		return inval_plog(log, "Invalid gid '%s'", param->string);
+
+	result->gid = gid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_gid);
+
 int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index d3350979115f..6cf713a7e6c6 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -28,7 +28,7 @@ typedef int fs_param_type(struct p_log *,
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd;
+	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -57,6 +57,8 @@ struct fs_parse_result {
 		int		int_32;		/* For spec_s32/spec_enum */
 		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
 		u64		uint_64;	/* For spec_u64 */
+		kuid_t		uid;
+		kgid_t		gid;
 	};
 };
 
@@ -131,6 +133,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
+#define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 
 /* String parameter that allows empty argument */
 #define fsparam_string_empty(NAME, OPT) \
-- 
2.45.2


