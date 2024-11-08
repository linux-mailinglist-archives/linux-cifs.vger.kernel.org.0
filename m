Return-Path: <linux-cifs+bounces-3341-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9E9C27B3
	for <lists+linux-cifs@lfdr.de>; Fri,  8 Nov 2024 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2698284629
	for <lists+linux-cifs@lfdr.de>; Fri,  8 Nov 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43E1D0F4F;
	Fri,  8 Nov 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b="uJ429Fc5";
	dkim=pass (2048-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b="piZEr7IV"
X-Original-To: linux-cifs@vger.kernel.org
Received: from o-chul.darkrain42.org (o-chul.darkrain42.org [74.207.241.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C11A9B5C
	for <linux-cifs@vger.kernel.org>; Fri,  8 Nov 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.207.241.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105887; cv=none; b=SWhTOpLOPlZEADfoiOE/KyWpRONUmynzqU3ailb22+++9890Iy6uZdefNbP8kag6/VGwS8EgRuJpyhOtrUDi6k2Zgd4xp4TwhZKgdUFyvEgbrvkjD992u9JboeZEn2jucRsscqcqXzMxMuJAvy/UUPB8KWmS+eZZTc7dQ3sHnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105887; c=relaxed/simple;
	bh=KDmLIYxpzNqG8EHfKBtZXjPvGjyZk6FW2kU+ZDINzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1GzYl6kJApbgXWRMZxjo/mIUtcKNwwOJfahaxB9kWHERqan1aAQlZIsxYDdSpUGYBcBCyMbcD/qe6LXs1Nv2BlhdKuJVFry9lwk8+oCTWy1jRGTwbEOIlEq4Qf/HPsDFejvleAg8FWNA3Nm4x/QcVaV+/5E8wP5OkCaTQUawag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=darkrain42.org; spf=pass smtp.mailfrom=darkrain42.org; dkim=permerror (0-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b=uJ429Fc5; dkim=pass (2048-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b=piZEr7IV; arc=none smtp.client-ip=74.207.241.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=darkrain42.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkrain42.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=darkrain42.org; i=@darkrain42.org; q=dns/txt; s=ed25519-2022-03;
 t=1731105885; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : content-transfer-encoding :
 in-reply-to : from; bh=7oI66vU6LFlmU7+4OiEVsQ+gFGxAtyNTbymD7R4y9eY=;
 b=uJ429Fc5PVgvAdeoWHIyeNLAOsKuab2LQwDgNCi9sHfd4P+iAPC1BejKGaG9echosIFS+
 0eobI2Uc8SzV2gdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=darkrain42.org;
 i=@darkrain42.org; q=dns/txt; s=rsa-2022-03; t=1731105885; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to : from;
 bh=7oI66vU6LFlmU7+4OiEVsQ+gFGxAtyNTbymD7R4y9eY=;
 b=piZEr7IVjfGexla2nmWPAWRNhOumC+l1yi8LtuuWvHml2OdVasITmTKoTzAkGeu5HzQP1
 LhIwvIs5QrBezp0gLlOqSKytoNiEQj9EnKdSlyLE4wzpzcrjXcYE4wvTUsuxLKZPqXxPc6q
 3kek9ft4QbNtZ/ze9eXgfmVo1YMmkYUzmiKKHm5NOndhlFPYr3rr/1uyHnR7hv60khbfBC+
 erJHtSIfBPAqZXJKfv/jjBcQ7QllaihgUipPRAxblpaLOajm2TOEUImRdb1UJFTDXgiv7AQ
 m7OAjRbqeiymrizkhrGu4pTAdPWtUHdLBRwTO/vanOSHPgdNxpzf+bYpCCbw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature ED25519)
	(Client CN "otters", Issuer "otters" (not verified))
	by o-chul.darkrain42.org (Postfix) with ESMTPS id 2DD9E8152;
	Fri,  8 Nov 2024 14:44:45 -0800 (PST)
Received: by haley.home.arpa (Postfix, from userid 1000)
	id 9108B35AB1; Fri, 08 Nov 2024 14:44:43 -0800 (PST)
Date: Fri, 8 Nov 2024 14:44:43 -0800
From: Paul Aurich <paul@darkrain42.org>
To: Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>
Subject: Re: [PATCH 0/5] SMB cached directory fixes around
 reconnection/unmounting
Message-ID: <Zy6UW5fuva5VdIWk@haley.home.arpa>
Mail-Followup-To: Steve French <smfrench@gmail.com>,
	linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>
References: <20241108222906.3257172-1-paul@darkrain42.org>
 <CAH2r5muDRhy2gsy7kz9GHC3maGxcxAcam8B3pgCmnS8xcEQX1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5muDRhy2gsy7kz9GHC3maGxcxAcam8B3pgCmnS8xcEQX1w@mail.gmail.com>

No, this series doesn't try to address that. I was just focused on the 
issues around the lifecycle of the cfids and the dentry:s.

~Paul

On 2024-11-08 16:39:03 -0600, Steve French wrote:
>The perf improvement allowing caching of directories (helping "ls"
>then "ls" again for same dir) not just the perf improvement with "ls
>"then "stat" could be very important.
>
>Did this series also address Ralph's point about missing requesting
>"H" (handle caching) flag when requesting directory leases from the
>server?
>
>On Fri, Nov 8, 2024 at 4:35 PM Paul Aurich <paul@darkrain42.org> wrote:
>>
>> The SMB client cached directory functionality has a few problems around
>> flaky/lost server connections, which manifest as a pair of BUGs when
>> eventually unmounting the server connection:
>>
>>     [18645.013550] BUG: Dentry ffff888140590ba0{i=1000000000080,n=/}  still in use (2) [unmount of cifs cifs]
>>     [18645.789274] VFS: Busy inodes after unmount of cifs (cifs)
>>
>> Based on bisection, these issues started with the lease directory cache
>> handling introduced in commit ebe98f1447bb ("cifs: enable caching of
>> directories for which a lease is held"), and go away if I mount with
>> 'nohandlecache'.  I started seeing these on Debian Bookworm stable kernel
>> (v6.1.x), but the issues persist even in current git versions.  I think the
>> situation was improved (occurrence frequency went down) with
>> commit 5c86919455c1 ("smb: client: fix use-after-free in
>> smb2_query_info_compound()").
>>
>>
>> I'm able to reproduce the "Dentry still in use" errors by connecting to an
>> actively-used SMB share (the server organically generates lease breaks) and
>> leaving these running for 'a while':
>>
>> - while true; do cd ~; sleep 1; for i in {1..3}; do cd /mnt/test/subdir; echo $PWD; sleep 1; cd ..; echo $PWD; sleep 1; done; echo ...; done
>> - while true; do iptables -F OUTPUT; mount -t cifs -a; for _ in {0..2}; do ls /mnt/test/subdir/ | wc -l; done; iptables -I OUTPUT -p tcp --dport 445 -j DROP; sleep 10; echo "unmounting"; umount -l -t cifs -a; echo "done unmounting"; sleep 20; echo "recovering"; iptables -F OUTPUT; sleep 10; done
>>
>> ('a while' is anywhere from 10 minutes to overnight. Also, it's not the
>> cleanest reproducer, but I stopped iterating once I had something that was
>> even remotely reliable for me...)
>>
>> This series attempts to fix these, as well as a use-after-free that could
>> occur because open_cached_dir() explicitly frees the cached_fid, rather than
>> relying on reference counting.
>>
>>
>> The last patch in this series (smb: During umount, flush any pending lease
>> breaks for cached dirs) is a work-in-progress, and should not be taken as-is.
>> The issue there:
>>
>> Unmounting an SMB share (cifs_kill_sb) can race with a queued lease break from
>> the server for a cached directory.  When this happens, the cfid is removed
>> from the linked list, so close_all_cached_dirs() cannot drop the dentry.  If
>> cifs_kill_sb continues on before the queued work puts the dentry, we trigger
>> the "Dentry still in use" BUG splat.  Flushing the cifsiod_wq seems to help
>> this, but some thoughts:
>>
>> 1. cifsiod_wq is a global workqueue, rather than per-mount.  Flushing the
>>    entire workqueue is potentially doing more work that necessary.  Should
>>    there be a workqueue that's more appropriately scoped?
>> 2. With an unresponsive server, this causes umount (even umount -l) to hang
>>    (waiting for SMB2_close calls), and when I test with backports on a 6.1
>>    kernel, appears to cause a deadlock between kill_sb and some cifs
>>    reconnection code calling iterate_supers_type.  (Pretty sure the deadlock
>>    was addressed by changes to fs/super.c, so not really an SMB problem, but
>>    just an indication that flush_waitqueue isn't the right solution).
>> 3. Should cached_dir_lease_break() drop the dentry before queueing work
>>    (and if so, is it OK to do this under the spinlock, or should the spinlock
>>    be dropped first)?
>> 4. Related to #3 -- shouldn't close_all_cached_dirs() be holding the spinlock
>>    while looping?
>>
>>
>> Lastly, patches 2, 3, and 5 (in its final form) are beneficial going back to
>> v6.1 for stable, but it's not a clean backport because some other important
>> fixes (commit 5c86919455c1 ("smb: client: fix use-after-free in
>> smb2_query_info_compound()") weren't picked up.
>>
>> Paul Aurich (5):
>>   smb: cached directories can be more than root file handle
>>   smb: Don't leak cfid when reconnect races with open_cached_dir
>>   smb: prevent use-after-free due to open_cached_dir error paths
>>   smb: No need to wait for work when cleaning up cached directories
>>   smb: During umount, flush any pending lease breaks for cached dirs
>>
>>  fs/smb/client/cached_dir.c | 106 ++++++++++++++++---------------------
>>  1 file changed, 47 insertions(+), 59 deletions(-)
>>
>> --
>> 2.45.2
>>
>>
>
>
>-- 
>Thanks,
>
>Steve


