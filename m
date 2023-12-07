Return-Path: <linux-cifs+bounces-301-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D67808FA4
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D52F1F21073
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189714B14E;
	Thu,  7 Dec 2023 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="lM/NEk+j"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B781710
	for <linux-cifs@vger.kernel.org>; Thu,  7 Dec 2023 10:12:06 -0800 (PST)
Message-ID: <2c1db0b4bfc23db7e1f2a70ec7ce32dc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701972724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Nqs8UVnWo0Vs+ARTXh48J1b7B08lcg4/Yr5AclakK4=;
	b=lM/NEk+jqkgjLsqctH6f+raDQ4iVihU6VY5cHFHon4HhG4eVE5dECuNWZZkhnDTOwDz9gD
	zznGsA4qiij/ebN1p+gW0WbnyVo87filoy5jNR8asXvd6/nW9psOEav9voWKNcQBUxojkE
	TwCCS4HqrtVJkBXB+9eDEhgbU/t0+l58B6sykYmqFkQtZNrY88Dn5rUc6OptAkCedFqnHy
	cjlkaF67HYjD5FTHbc6JcjTfbzrgZXogfBAoTGxkaocXdpgw6hufr26AJOptcGB9cbyTut
	jn2o01oWe2bpaiGmrbFdyNBped3gVWU91Aja3hqHeGuiKF87ZoRqRQTwDrhc6Q==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1701972724; a=rsa-sha256;
	cv=none;
	b=BE/6o2kW2U2DO20Tha4+4ToHFMkq1K0wKIbqfUZnoE/BaXQ99VsjvOGmxQnuVhW+MkKebm
	vQ5QSYPXU91d3zkhbBHmhAf04byyxkL8DAB4IwpeDcVau8dAud82O3y4YSHziMY9dRjcz4
	sK4pgA0OI+CwgNCNNFF/ELFIeo9Nvi64bmPq0pmbtP4I90pp5uW72CFhV4Hcbjr3jcbQ4N
	jEIPG47gYKkflbokLsskg1buY91P+lHfDRV0IgscT94js6trcmfAQBZ8hanhr18mUqy4et
	RMWeZzpdMcYKhtGWzXxuVjO7sIGF2/YJ8lguAm6PIhP61D1ZINejw/o5iT6cOA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701972724; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Nqs8UVnWo0Vs+ARTXh48J1b7B08lcg4/Yr5AclakK4=;
	b=UTlRAfp65YpX02QY8qExgum4fzElwCTlBm+GbOOvAMLCRtaRhutdp4uOaJRRpqgcka4OoT
	1yt1guxS9NeugLTEZWl1TBBkFL/MzZuc8nxLj3sWiEQPH3mYXEA2JSSsGiHURz0o4CLQaY
	eA0DG1Nzbx3kB5XDXeypAiquJSXy5zeCxvdczvsPlJkpvAQglLLyTBYUbBDk/crwurkQxH
	Ns8blTmRrsjZAffRdn2AsbQF1+JTdtxuXWfpqzaZKbovyL/Vri5fLeEiUkmBZFeol5gbLw
	GVD3VRmxRmt8TWDa/62RrPXTpYWJ8ZRlP8Zpy985FNt3XjGLJCy5gUVDoF66kw==
From: Paulo Alcantara <pc@manguebit.com>
To: Jeremy Allison <jra@samba.org>, David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 ronniesahlberg@gmail.com, Tom Talpey <tom@talpey.com>, Stefan Metzmacher
 <metze@samba.org>, jlayton@kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
Subject: Re: Can fallocate() ops be emulated better using SMB request
 compounding?
In-Reply-To: <ZXIDgvZ8/iBhYXwy@jeremy-HP-Z840-Workstation>
References: <700923.1701964726@warthog.procyon.org.uk>
 <ZXIDgvZ8/iBhYXwy@jeremy-HP-Z840-Workstation>
Date: Thu, 07 Dec 2023 15:12:00 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeremy Allison <jra@samba.org> writes:

> On Thu, Dec 07, 2023 at 03:58:46PM +0000, David Howells wrote:
>>Hi Steve, Namjae, Jeremy,
>>
>>At the moment certain fallocate() operations aren't very well implemented in
>>the cifs filesystem on Linux, either because the protocol doesn't fully
>>support them or because the ops being used don't also set the EOF marker at
>>the same time and a separate RPC must be made to do that.
>>
>>For instance:
>>
>> - FALLOC_FL_ZERO_RANGE does some zeroing and then sets the EOF as two
>>   distinctly separate operations.  The code prevents you from doing this op
>>   under some circumstances as it doesn't have an oplock and doesn't want to
>>   race with a third party (note that smb3_punch_hole() doesn't have this
>>   check).
>>
>> - FALLOC_FL_COLLAPSE_RANGE uses COPYCHUNK to move the file down and then sets
>>   the EOF as two separate operations as there is no protocol op for this.
>>   However, the copy will likely fail if the ranges overlap and it's
>>   non-atomic with respect to a third party.
>>
>> - FALLOC_FL_INSERT_RANGE has the same issues as FALLOC_FL_COLLAPSE_RANGE.
>>
>>Question: Would it be possible to do all of these better by using compounding
>>with SMB2_FLAGS_RELATED_OPERATIONS?  In particular, if two components of a
>>compound are marked related, does the second get skipped if the first fails?
>
> Yes:
>
> https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/46dd4182-62d3-4e30-9fe5-e2ec124edca1
>
> "When the current operation requires a FileId and the previous operation
> either contains or generates a FileId, if the previous operation fails
> with an error, the server SHOULD<253> fail the current operation with
> the same error code returned by the previous operation."

David, you could extend smb2_compound_op() like I did for compound
create+{get,set}_reparse+getinfo+close in [1][2][3].

[1] https://lore.kernel.org/r/20231126025510.28147-2-pc@manguebit.com
[2] https://lore.kernel.org/r/20231126025510.28147-3-pc@manguebit.com
[3] https://lore.kernel.org/r/20231126025510.28147-8-pc@manguebit.com

