Return-Path: <linux-cifs+bounces-238-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF780121E
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Dec 2023 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23ED1C20942
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Dec 2023 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50934E61B;
	Fri,  1 Dec 2023 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="iDCfBRUH"
X-Original-To: linux-cifs@vger.kernel.org
X-Greylist: delayed 688 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 09:55:14 PST
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7CDF
	for <linux-cifs@vger.kernel.org>; Fri,  1 Dec 2023 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=11VZc+oDdxscNRNOt8IygiFX5V3jVI4b4cAL76uHZ4Q=; b=iDCfBRUH7OUmNFevKNueOtdY+e
	ZZgSCmlsuKhg2WMfjcQz7TAVW87cuPRBsnFJXNI7uA4YWOzxxxcZKuRORWRbtQnc5SfDMP1j3qyG1
	Qh0tKxhf8QPIrclfWDQLRzYRwJKBu1xDIOrsWxgXobPmS0V/jIXKXuVomuNJn3MEBPFCWuu+usXum
	KyE1FYZFWnCdQN2bm0FwY5ZBRXSonu/fklG8xu9fAJGRjJ0EBjininlEeRlL83Iil7vqlrHaz78lp
	0VVKoDMqRuCw1DOLFzQklB84CWOaWZ5+vjVVG3jzbP/TpLCkrNFMCDPnZ00B4TZ1t+lxAwiORGOE6
	FzaBk7Uxbux+wn8yZfqkIFF1iFwct1iUKoAbvEclP6bH2XvSsfTdSOJG/1qsf+lz7M1vCrX2fE/la
	HV99bifenl6FiPC+5wtipvy7HmeoD/Ct+VnpZ4MdNRiQV9kiFPx2lENt2h6AeRlpv+qJtAITeO0tp
	OrfIfM1DMI9SPEiDuMZqAf/C;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1r97YG-001URH-0Q;
	Fri, 01 Dec 2023 17:43:44 +0000
Date: Fri, 1 Dec 2023 09:43:40 -0800
From: Jeremy Allison <jra@samba.org>
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
	ronniesahlberg@gmail.com, aaptel@samba.org,
	linux-cifs@vger.kernel.org
Subject: Re: cifs hardlink misbehaviour in generic/002?
Message-ID: <ZWobTKPFwuY1GNgi@jeremy-HP-Z840-Workstation>
Reply-To: Jeremy Allison <jra@samba.org>
References: <3755038.1701447306@warthog.procyon.org.uk>
 <d5c487188936f998eeedc2e2e3e726ba@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d5c487188936f998eeedc2e2e3e726ba@manguebit.com>

On Fri, Dec 01, 2023 at 02:29:41PM -0300, Paulo Alcantara wrote:
>David Howells <dhowells@redhat.com> writes:
>
>> I've seeing some weird behaviour in the upstream Linux cifs filesystem that's
>> causing generic/002 to fail.  The test case makes a file and creates a number
>> of hardlinks to it, then deletes those hardlinks in reverse order, checking
>> the link count on the original file each time it removes one.
>
>I could also reproduce it in ksmbd but not in Windows Server 2022 or
>samba v4.19.

Looks like a ksmbd bug where it's not checking for multiple
opens on close with DELETE_ON_CLOSE set, and just removing
the file.

