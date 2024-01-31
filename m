Return-Path: <linux-cifs+bounces-1025-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657F84376E
	for <lists+linux-cifs@lfdr.de>; Wed, 31 Jan 2024 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312C3281540
	for <lists+linux-cifs@lfdr.de>; Wed, 31 Jan 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE455C04;
	Wed, 31 Jan 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPs80czN"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBA78683
	for <linux-cifs@vger.kernel.org>; Wed, 31 Jan 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685024; cv=none; b=m63B7TQfIEJXmKHktn2S/UTAdcMNu6dJcuK+iPKZmTB6trwkXFlGZSPO9YKdXof/UjoG/jLiFLDcQA11yJMKSsunagBGggnUOKs6Js4jr3Z+8n8hRtE7BrF8CY+7e7CrsH9P1IVjzC99Wb2vcr+22iHFu5C8U0KCQI8DDUKFSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685024; c=relaxed/simple;
	bh=64+50SEu7bMaznhj+tfj6rGm3p7Mn6Ou6pGwTLtkJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hBVbOSKhfDzNA5ctm6NGMXWjnYUSyPHy8j2LSmsFjvjTX/leUkz0RzsWsqoNJduubT8uObBoidjnr8KrWE97YJl0xTHwtoo+kIN+Js6cM2JxDwcjnhDqHMtkTNgJQDjAhcPIQmMdQtNlpEgle4DC4KGD9YVBE8H2L5abgLZwsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPs80czN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40f02b8d150so12379745e9.2
        for <linux-cifs@vger.kernel.org>; Tue, 30 Jan 2024 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706685021; x=1707289821; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vc7Ay37ay3645f2H/l3hoUbCFFGpLA9KuX/mQOmWXIA=;
        b=JPs80czNPh/LAg6Y6gi4RQkBT1BcxdCf5ZzhL92x/FA+1RjPC6qFmVrHLe3O9sK5wU
         oAlfIJHBMzHP5apviTANB2P3t/3ctHOlKernQZiZY45ItPHqLYXhPYgdzsXkYtQ+dSPO
         naU5rccvkGCjrXlWi52NrwlzrwjkrE+/CixDEpBC8II1l5NcjSBoYUw2P/0uXmaMDmsg
         D4rWoyoAFuhJmqytAgmYxTmLMN1KNER3pKjjhAqG/yciLSI24Fl8Br2ZFghcf0yHoVIM
         b5HzawekLeohOLaahuLy25SuJTqbtcpt/VUczpWBpmc0mqGyK/xpvmODRH2z90TE3S+4
         SCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685021; x=1707289821;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc7Ay37ay3645f2H/l3hoUbCFFGpLA9KuX/mQOmWXIA=;
        b=k8Vf5Gy7uuKyp14u/XL0KF2JcAaICK+O9/vKMUdoVkPrtkMODKQZKxBucV1266DjqV
         WlYZvDmPShAbLRLS7TLlut6GRqUnOWQVPGzcUnisqFpGAm2FjfgsI/lLHcXNV0X+eS80
         +VvZNhnuP7RqEdkNxMjapXXA7E/Wwy/c1ocP1WD31uFhSkdVEu6TaHRC0WWMjPSQwJ0d
         mNZkT46smcL8+7ec+dY5y6G0LbsVzt6vxOpoxY1rnSoVz6B2UgP/r/H9ntOUT0YN0efV
         6T4Kt4E1qUzNZ8dgF0AlBnrxt0Nr2dyALVpxKwdVQXlzlXPTcmDLvK0tpK7/DbPj7b5C
         QHgw==
X-Gm-Message-State: AOJu0Yw8fPCNfYZTevp3UabeghqiIHCfcExH69MmqWhvaAh8tF3V+THq
	LACXSyz/mrC99R9GoK3wFaVpKdPQzbst3WAztpG6ncB3IEFG2FMamiA8MGoZoZaP0OIblUJABmu
	I
X-Google-Smtp-Source: AGHT+IFXo2HcWmvuyG4b6xsYseqZ6xdR/0xrJoLYo/RaHcbhl9ESjeisij6PH95V7cr1Hrpo3n4U7Q==
X-Received: by 2002:a05:600c:4749:b0:40e:545b:80bc with SMTP id w9-20020a05600c474900b0040e545b80bcmr619945wmo.29.1706685021366;
        Tue, 30 Jan 2024 23:10:21 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040fb30f17e8sm650884wmo.38.2024.01.30.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:10:21 -0800 (PST)
Date: Wed, 31 Jan 2024 10:10:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Steve French <sfrench@samba.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] smb: client: Fix a NULL vs IS_ERR() check in wsl_set_xattrs()
Message-ID: <571c33b3-8378-49fd-84e1-57f622ef6db5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was intended to be an IS_ERR() check.  The ea_create_context()
function doesn't return NULL.

Fixes: 1eab17fe485c ("smb: client: add support for WSL reparse points")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/reparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index ce69d67feefa..d4d2555ebd38 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -225,7 +225,7 @@ static int wsl_set_xattrs(struct inode *inode, umode_t mode,
 	}
 
 	cc = ea_create_context(dlen, &cc_len);
-	if (!cc)
+	if (IS_ERR(cc))
 		return PTR_ERR(cc);
 
 	ea = &cc->ea;
-- 
2.43.0


