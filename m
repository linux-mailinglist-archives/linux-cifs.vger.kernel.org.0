Return-Path: <linux-cifs+bounces-1166-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57A849C3B
	for <lists+linux-cifs@lfdr.de>; Mon,  5 Feb 2024 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611841F250B0
	for <lists+linux-cifs@lfdr.de>; Mon,  5 Feb 2024 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAA0210F0;
	Mon,  5 Feb 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NcuWp1nl"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74620DF6
	for <linux-cifs@vger.kernel.org>; Mon,  5 Feb 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141130; cv=none; b=qU7k2+CkYbU4B4SBOGyXbXEI8ldSslJ52gtNDN+/rGcIaD6S8uJ97wIMkNBKAiWiITK20QIj7ejp9EQ8JsxCfeChhNQgYkSpwU5MTq70KNG6NGan/3E++MJJ8eZ4wnU/mkGmtoEcuPbEQVx2EorbVngFgrCQeldSCIy3Ts1H/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141130; c=relaxed/simple;
	bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxISBcScBO/lR8Mw9FuH4om1A2z9TQWuHdC/FnViI83qPGzfekjc4n9/rmWUd3A5gL5BATgyHezcoH3QMccgMXgfqB3LWNi42zr9q/EsKRIu4Vk1djaFcEc3vLqniFEeNNh6oPHNJjnn8Fnp2TePQr0flCON5BRSDRqjU1ZwGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NcuWp1nl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51121637524so6641042e87.1
        for <linux-cifs@vger.kernel.org>; Mon, 05 Feb 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707141125; x=1707745925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=NcuWp1nlWvOmKDC+Us3xfB23YsW8RgUJlLlIRMYExr0fBNaaUQJBoDuLQn6Hzgd7ux
         5mS8g5eqer8E27aG2gtEBQlGEYw6eCfqtfGJ/JcpLxVKxlgtFL5dNs41yfVDg7eHBsN6
         ziM2eIdru4OyBQneL4aO4SU8i+lLz0z5AlCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141125; x=1707745925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xv/TMPnZ6ACI/uw5nCEWZWMTiYPSRlxi3KzNmIW+M8=;
        b=a5KnlCID+hVB47kk4BmWfh2gOYFZ8fET+TGN/JcSjjq8U2Bc2/39EWXuOAwbEe20As
         S+1d+BgWJwvu1Ggcw/vHnFefWX7MrGzLLB+wxUQBnmWbXpq0s5UW1iyd1a4xkCyGPoIH
         /0X8QoC+isp9sqKXbpZQwYwqUVWoExCoFqITe9Cf6qHzxL82RzV9HV8upq6u95WZMmrY
         afjy3xsx12eDZzTKg05YYe+/PvgIkQQvZPIV029xyy8QkeordZfRrPN/oN+8pEOc9t+N
         6FVvqaDLt2LXRVnI/3XUoxtRSy76TK+pi31oVHz0Vcmo1YsmShMYPCNywgINC4KQftAj
         nTYg==
X-Gm-Message-State: AOJu0YwK6LDlKMVj4WKOjPPkKoFCS3Yp1XFkCmtDorPiM6AlnFoZ1Ur3
	k5g8M+QIO53Lg9OwDHPMnIiHMkm6OEhtVrspjK7eYzYeRvZ3BqWbS4dBpQltsZ6675cE4jlb5we
	p2yVOnmKchVb/GpNchGFbnyD7t4CfUOfBLhgqgQ==
X-Google-Smtp-Source: AGHT+IGCaEVVe6GrK1mvmKbk8cfbvkS3XUvRFFWxmUF4PfOm8rDUxdDRR8CpRP+LOC3U4ed7OovlnHoRwjwU+gtFl6o=
X-Received: by 2002:a05:6512:3b8b:b0:511:3e58:3cff with SMTP id
 g11-20020a0565123b8b00b005113e583cffmr6188837lfv.16.1707141125271; Mon, 05
 Feb 2024 05:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
In-Reply-To: <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 Feb 2024 14:51:53 +0100
Message-ID: <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:31, Christian Brauner <brauner@kernel.org> wrote:
>
> On Sun, Feb 04, 2024 at 02:17:37AM +0000, Al Viro wrote:
> > ->permission(), ->get_link() and ->inode_get_acl() might dereference
> > ->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
> > as well) when called from rcu pathwalk.
> >
> > Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
> > and dropping ->user_ns rcu-delayed too.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

