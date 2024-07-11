Return-Path: <linux-cifs+bounces-2299-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53392DF13
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Jul 2024 06:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DA5281B60
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Jul 2024 04:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72322079;
	Thu, 11 Jul 2024 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="MTYK4Z77"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822763D
	for <linux-cifs@vger.kernel.org>; Thu, 11 Jul 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720671668; cv=none; b=ueaeiP6OfQq5wXC3it/zkuX+HJu4D3Z3LaNVSfFE84so08+w0nJu5tS9CbUWXbTj7bWxgC4ieMhXFJa8/ciglAEHcxWuPMr5NJmn61LbcVfgYGkSpCAFPff82XB7Taxj6zRK7wWE0jKxEuPiMsrSkYWu6gAAqmSckZoB7YVFlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720671668; c=relaxed/simple;
	bh=F/r9u3cXuFGz+U1ANbCj9EgpczAswVM6jXvZoaZtDKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cyRGuLSRgXVpFWYfeVJRZXvXPPzbaHjXbsz9n6Vjmq38HDVsDA4zRLzSrBcMdHjIkH8orLQEebMLZPKXVGR6SLMA2ZQntYDa1dD1S/OosYHpGpms3F0rAMQKSJOlHNqZEHIpDkadGBmiET6yzrWBaOJJLBr/YwYz3/OH5q5+TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=MTYK4Z77; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Date:Cc:To:From:Message-ID;
	bh=aO8k2PjAqRmYSQPrW2oKP7z9FPJgVckBWCsSl3Zrqeg=; b=MTYK4Z77M+cvjumvL4g/yQWZFh
	AZsAURMaKLJIhOcB0yWYBQeHFoH/pJ4ctzDpd/6isX2zzFh86jBMMsped5c+nt12ICZVLDN9WxRcl
	PDkAEdMjUvsigTj8EFqyC2Qv/9AjokQTTdd7DWeEehUEeTc3zhNsvtFnpDTNdkp19WywcrgEWwOH2
	P9BcSqflVztHwRPL07Rd/fsQ+PsZQFAnjvIDQ5N9ugq+voWgVtqc8ck4w1ITcdar5/kV7OatnQkDu
	99YubZdYlCHi0whS9/9J0jeuXyjuCTu9YhKnkGfp71QuHKK6qJ0taGGTxD67Jh76pwfjGZHJ08LMF
	r4d3xpDeShTZld47K5rSK8pOovXB1ltJigLGHMJ5kD3p2pr+kt0YreXBmcnPdR2Xtkjg4taFYiL+g
	7hzfNQCptRXymBc6OGUvKcBDS5DnEA3r394lrVWThVADycJ7dL8xuJUQw95AwRU2QaZK3Mqpm6VfN
	3V5xUELWIcqJGnPWMoFz5XvG;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1sRlIj-000p3c-36;
	Thu, 11 Jul 2024 04:21:02 +0000
Message-ID: <55ce7f6c1b68cf066bd957a11d5e5988b557d8e2.camel@samba.org>
Subject: Re: Different behavior of POSIX file locks depending on cache mode
From: Andrew Bartlett <abartlet@samba.org>
To: Steve French <smfrench@gmail.com>
Cc: Kevin Ottens <kevin.ottens@enioka.com>, linux-cifs@vger.kernel.org, 
	Pavel Shilovsky <piastryyy@gmail.com>, Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 16:20:56 +1200
In-Reply-To: <CAH2r5mu-TXypF+5u4r=WzsbtmC2Xxk-LvNNwwhpPskC36cWm5Q@mail.gmail.com>
References: <5659539.ZASKD2KPVS@wintermute>
	 <0ed85d03cfc698093e649394739c1379443ab0c8.camel@samba.org>
	 <2162098.9o76ZdvQCi@wintermute> <2693651.lGaqSPkdTl@wintermute>
	 <db9229639fe476ca743294ae013864b2470d81a4.camel@samba.org>
	 <CAH2r5mu-TXypF+5u4r=WzsbtmC2Xxk-LvNNwwhpPskC36cWm5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks so much for the update, we do really appreciate it. 

Please do CC us when it starts moving as I'm not on the linux-cifs list
and Kevin may also not be.

Andrew Bartlett

On Wed, 2024-07-10 at 21:03 -0500, Steve French wrote:
> I haven't had a chance to look at it again this week (trying to deal
> with the 6.10-rc regression in netfs/folios changes causing the
> "add_credits" error) - but do plan to look at it later this week
> 
> On Wed, Jul 10, 2024 at 4:28 AM Andrew Bartlett <
> abartlet@samba.org
> > wrote:
> > Kia Ora Steve,
> > 
> > Just wanting to know if there is anything more Kevin or I can
> > usefully
> > do to nudge this along, or do you have this in hand?
> > 
> > It would be very good to get this consistent.
> > 
> > Thanks,
> > 
> > Andrew Bartlett
> > 
> > On Thu, 2024-06-27 at 17:04 +0200, Kevin Ottens wrote:
> > > Hello,
> > > 
> > > Is there anyone working on a patch for this since you narrowed it
> > > down a bit?
> > > We can probably test the changes if that's the case.
> > > 
> > > Regards.
> > > 
> > > On Tuesday 25 June 2024 09:41:48 CEST Kevin Ottens wrote:
> > > > Hello,
> > > > 
> > > > On Tuesday 25 June 2024 08:00:11 CEST Andrew Bartlett wrote:
> > > > > Thanks so much Steve.
> > > > 
> > > > Thanks indeed!
> > > > 
> > > > > Kevin can give more info, but no, my understanding is that
> > > > > this
> > > > > was
> > > > > "always" problematic, the reason it came up now is
> > > > > LibreOffice
> > > > > changed
> > > > > how it handled file saves, rather than a kernel change.
> > > > 
> > > > I confirm. It's been here for a long time AFAIK, but
> > > > Libreoffice
> > > > recently
> > > > enabled some code path by default (it was previously disabled
> > > > by
> > > > default).
> > > > 
> > > > > Even if the fix is to be in the direction that 'breaks'
> > > > > LibreOffice,
> > > > > that is OK, I have given Kevin a suggestion on using locks
> > > > > ranges
> > > > > towards the end of the file as a way to regain the desired
> > > > > 'advisory'
> > > > > semantics, but we wanted to be working on solid ground with
> > > > > consistent,
> > > > > reliable semantics that don't depend on cache modes.
> > > > 
> > > > Yes, the consistency is important. Once we have a solid and
> > > > reliable
> > > > behavior we can always get things adjusted higher in the stack.
> > > > 
> > > > Regards.
> > > > 
> > > > > On Sun, 2024-06-23 at 23:54 -0500, Steve French wrote:
> > > > > > This was interesting to dig through (and netfs caching
> > > > > > changes
> > > > > > made
> > > > > > it
> > > > > > a little harder to trace the original code) but it looks
> > > > > > fixable. See
> > > > > > cifs_find_fid_lock_conflict() in fs/smb/client/file.c.   It
> > > > > > does not
> > > > > > look new though - so let me know if you noticed that the
> > > > > > behavior in
> > > > > > earlier kernels was different for the default case
> > > > > > (smb3.1.1
> > > > > > mounts
> > > > > > with caching enabled).
> > > > > > 
> > > > > > The problem seems to be that locking is enforced only in
> > > > > > some
> > > > > > write
> > > > > > paths, but these places where we do write vs. byte range
> > > > > > locking
> > > > > > checks (although at first glance may seem logical)
> > > > > > obviously do
> > > > > > not
> > > > > > follow POSIX semantics which would allow a write to a
> > > > > > locked
> > > > > > range
> > > > > > (even if POSIX behavior is counter-intuitive and different
> > > > > > from
> > > > > > Windows semantics).  Two obvious things to fix that I see
> > > > > > so
> > > > > > far:
> > > > > > 
> > > > > > 1) It was harder than expected to trace since looks like we
> > > > > > don't
> > > > > > have
> > > > > > good dynamic (or static for that matter) tracepoints for
> > > > > > the
> > > > > > write
> > > > > > and
> > > > > > write error paths (although netfs fortunately has a few) -
> > > > > > so
> > > > > > obviously should add a few tracepoints to make it easier to
> > > > > > narrow
> > > > > > this kind of thing down in the future
> > > > > > 2) We need to make changes to how we check lock
> > > > > > conflicts.  See
> > > > > > cifs_writev() and its call to cifs_find_lock_conflict(). It
> > > > > > looks
> > > > > > like
> > > > > > this is the original commit that may have caused the
> > > > > > problem:
> > > > > > commit 85160e03a79e0d7f9082e61f6a784abc6f402701
> > > > > > Author: Pavel Shilovsky <
> > > > > > piastry@etersoft.ru
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Date:   Sat Oct 22 15:33:29 2011 +0400
> > > > > > 
> > > > > >     CIFS: Implement caching mechanism for mandatory brlocks
> > > > > > 
> > > > > >     If we have an oplock and negotiate mandatory locking
> > > > > > style
> > > > > > we
> > > > > > 
> > > > > > handle
> > > > > > 
> > > > > >     all brlock requests on the client.
> > > > > > 
> > > > > > On Sun, Jun 9, 2024 at 11:41 PM Andrew Bartlett <
> > > > > > abartlet@samba.org
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > wrote:
> > > > > > > (resend due spam rules on list)
> > > > > > > 
> > > > > > > Kia Ora Steve,
> > > > > > > 
> > > > > > > I'm working with Kevin on this, and I set up a clean
> > > > > > > environment
> > > > > > > with
> > > > > > > the latest software to make sure this is all still an
> > > > > > > issue
> > > > > > > on
> > > > > > > current
> > > > > > > software:
> > > > > > > 
> > > > > > > I was hoping to include the old SMB1 unix extensions in
> > > > > > > this
> > > > > > > test
> > > > > > > also,
> > > > > > > but these seem unsupported in current kernels.  When did
> > > > > > > they
> > > > > > > go
> > > > > > > away?
> > > > > > > 
> > > > > > > Anyway, here is the data.  It certainly looks like an
> > > > > > > issue
> > > > > > > with
> > > > > > > the
> > > > > > > SMB3 client, as only the client changes with the
> > > > > > > cache=none
> > > > > > > 
> > > > > > > Server is Samba 4.20.1 from Debian Sid.  Kernel is
> > > > > > > Linux debian-sid-cifs-client 6.7.9-amd64 #1 SMP
> > > > > > > PREEMPT_DYNAMIC
> > > > > > > Debian
> > > > > > > 6.7.9-2 (2024-03-13) x86_64 GNU/Linux
> > > > > > > 
> > > > > > > With SMB1 but not unix extensions (seems unsupported):
> > > > > > > 
> > > > > > > root@debian-sid-cifs-client:~# mount.cifs
> > > > > > > //192.168.122.234/testuser
> > > > > > > mnt -o user=testuser,pass=pass,vers=1.0
> > > > > > > root@debian-sid-cifs-client:~# cd mnt/
> > > > > > > root@debian-sid-cifs-client:~/mnt# ../lock_test foo
> > > > > > > Testing with foo
> > > > > > > Got new file descriptor 3
> > > > > > > Lock set: 1
> > > > > > > Second file descriptor 4
> > > > > > > Read from second fd: x count: 0
> > > > > > > Third file descriptor 5
> > > > > > > Wrote to third fd: 1
> > > > > > > 
> > > > > > > root@debian-sid-cifs-client:~# mount.cifs
> > > > > > > //192.168.122.234/testuser
> > > > > > > mnt -o user=testuser,pass=penguin12#,vers=3.1.1,posix
> > > > > > > root@debian-sid-cifs-client:~# cd mnt/
> > > > > > > root@debian-sid-cifs-client:~/mnt# ../lock_test foo
> > > > > > > Testing with foo
> > > > > > > Got new file descriptor 3
> > > > > > > Lock set: 1
> > > > > > > Second file descriptor 4
> > > > > > > Read from second fd: x count: -1
> > > > > > > Third file descriptor 5
> > > > > > > Wrote to third fd: -1
> > > > > > > root@debian-sid-cifs-client:~# mount.cifs
> > > > > > > //192.168.122.234/testuser
> > > > > > > mnt -o user=testuser,pass=penguin12#,vers=3.1.1,unix
> > > > > > > 
> > > > > > > root@debian-sid-cifs-client:~# mount.cifs
> > > > > > > //192.168.122.234/testuser
> > > > > > > mnt -o
> > > > > > > user=testuser,pass=penguin12#,vers=3.1.1,unix,nobrl
> > > > > > > root@debian-sid-cifs-client:~# cd mnt/
> > > > > > > root@debian-sid-cifs-client:~/mnt# ../lock_test foo
> > > > > > > Testing with foo
> > > > > > > Got new file descriptor 3
> > > > > > > Lock set: 1
> > > > > > > Second file descriptor 4
> > > > > > > Read from second fd: o count: 1
> > > > > > > Third file descriptor 5
> > > > > > > Wrote to third fd: 1
> > > > > > > 
> > > > > > > And with cache=none
> > > > > > > 
> > > > > > > root@debian-sid-cifs-client:~# mount.cifs
> > > > > > > //192.168.122.234/testuser
> > > > > > > mnt -o
> > > > > > > user=testuser,pass=penguin12#,vers=3.1.1,posix,cache=none
> > > > > > > root@debian-sid-cifs-client:~# cd mnt/
> > > > > > > root@debian-sid-cifs-client:~/mnt# ../lock_test foo
> > > > > > > Testing with foo
> > > > > > > Got new file descriptor 3
> > > > > > > Lock set: 1
> > > > > > > Second file descriptor 4
> > > > > > > Read from second fd: o count: 1
> > > > > > > Third file descriptor 5
> > > > > > > Wrote to third fd: 1
> > > > > > > 
> > > > > > > On Thu, 2024-05-23 at 11:12 -0500, Steve French wrote:
> > > > > > > > What is the behavior with "nobrl" mount option? and
> > > > > > > > what is
> > > > > > > > the
> > > > > > > > behavior when running with the POSIX extensions enabled
> > > > > > > > (e.g. to
> > > > > > > > current Samba or ksmbd adding "posix" to the mount
> > > > > > > > options)
> > > > > > > > 
> > > > > > > > On Thu, May 23, 2024 at 11:08 AM Kevin Ottens <
> > > > > > > > kevin.ottens@enioka.com
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > wrote:
> > > > > > > > > Hello,
> > > > > > > > > 
> > > > > > > > > I've been hunting down a bug exhibited by Libreoffice
> > > > > > > > > regarding
> > > > > > > > > POSIX file
> > > > > > > > > locks in conjunction with CIFS mounts. In short: just
> > > > > > > > > before
> > > > > > > > > saving, it
> > > > > > > > > reopens a file on which it already holds a file lock
> > > > > > > > > (via
> > > > > > > > > another
> > > > > > > > > file
> > > > > > > > > descriptor in the same process) in order to read from
> > > > > > > > > it
> > > > > > > > > to
> > > > > > > > > create
> > > > > > > > > a backup
> > > > > > > > > copy... but the read call fails.
> > > > > > > > > 
> > > > > > > > > I've been in discussion with Andrew Bartlett for a
> > > > > > > > > little
> > > > > > > > > while
> > > > > > > > > regarding this
> > > > > > > > > issue and, after exploring several venues, he advised
> > > > > > > > > me
> > > > > > > > > to
> > > > > > > > > send an
> > > > > > > > > email to
> > > > > > > > > this list in order to get more opinions about it.
> > > > > > > > > 
> > > > > > > > > The latest discovery we did was that the cache option
> > > > > > > > > on
> > > > > > > > > the
> > > > > > > > > mountpoint seems
> > > > > > > > > to impact the behavior of the POSIX file locks. I
> > > > > > > > > made a
> > > > > > > > > minimal
> > > > > > > > > test
> > > > > > > > > application (attached to this email) which basically
> > > > > > > > > does
> > > > > > > > > the
> > > > > > > > > 
> > > > > > > > > following:
> > > > > > > > >  * open a file for read/write
> > > > > > > > >  * set a POSIX write lock on the whole file
> > > > > > > > >  * open the file a second time and try to read from
> > > > > > > > > it
> > > > > > > > >  * open the file a third time and try to write to it
> > > > > > > > > 
> > > > > > > > > It assumes there is already some text in the file.
> > > > > > > > > Also,
> > > > > > > > > as it
> > > > > > > > > goes
> > > > > > > > > it outputs
> > > > > > > > > information about the calls.
> > > > > > > > > 
> > > > > > > > > The output I get is the following with cache=strict
> > > > > > > > > on
> > > > > > > > > the
> > > > > > > > > mount:
> > > > > > > > > ---
> > > > > > > > > Testing with /mnt/foo
> > > > > > > > > Got new file descriptor 3
> > > > > > > > > Lock set: 1
> > > > > > > > > Second file descriptor 4
> > > > > > > > > Read from second fd: x count: -1
> > > > > > > > > Third file descriptor 5
> > > > > > > > > Wrote to third fd: -1
> > > > > > > > > ---
> > > > > > > > > 
> > > > > > > > > If I'm using cache=none:
> > > > > > > > > ---
> > > > > > > > > Testing with /mnt/foo
> > > > > > > > > Got new file descriptor 3
> > > > > > > > > Lock set: 1
> > > > > > > > > Second file descriptor 4
> > > > > > > > > Read from second fd: b count: 1
> > > > > > > > > Third file descriptor 5
> > > > > > > > > Wrote to third fd: 1
> > > > > > > > > ---
> > > > > > > > > 
> > > > > > > > > That's the surprising behavior which prompted the
> > > > > > > > > email
> > > > > > > > > on this
> > > > > > > > > list. Is it
> > > > > > > > > somehow intended that the cache option would impact
> > > > > > > > > the
> > > > > > > > > semantic of
> > > > > > > > > the file
> > > > > > > > > locks? At least it caught me by surprise and I
> > > > > > > > > wouldn't
> > > > > > > > > expect
> > > > > > > > > such
> > > > > > > > > a
> > > > > > > > > difference in behavior.
> > > > > > > > > 
> > > > > > > > > Now, since the POSIX locks are process wide, I would
> > > > > > > > > have
> > > > > > > > > expected
> > > > > > > > > to have the
> > > > > > > > > output I'm getting for the "cache=none" case to be
> > > > > > > > > also
> > > > > > > > > the one
> > > > > > > > > I'm
> > > > > > > > > getting
> > > > > > > > > for the "cache=strict" case.
> > > > > > > > > 
> > > > > > > > > I'm looking forward to feedback on this one. I really
> > > > > > > > > wonder if
> > > > > > > > > we
> > > > > > > > > missed
> > > > > > > > > something obvious or if there is some kind of bug in
> > > > > > > > > the
> > > > > > > > > cifs
> > > > > > > > > driver.
> > > > > > > > > 
> > > > > > > > > Regards.
> > > > > > > > > --
> > > > > > > > > Kévin Ottens
> > > > > > > > > kevin.ottens@enioka.com
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > +33 7 57 08 95 13
> > > > > > > 
> > > > > > > --
> > > > > > > 
> > > > > > > Andrew Bartlett (he/him)
> > > > > > > https://samba.org/~abartlet/
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Samba Team Member (since 2001)
> > > > > > > https://samba.org
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Samba Team Lead
> > > > > > > https://catalyst.net.nz/services/samba
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Catalyst.Net Ltd
> > > > > > > 
> > > > > > > Proudly developing Samba for Catalyst.Net Ltd - a
> > > > > > > Catalyst IT
> > > > > > > group
> > > > > > > company
> > > > > > > 
> > > > > > > Samba Development and Support:
> > > > > > > https://catalyst.net.nz/services/samba
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Catalyst IT - Expert Open Source Solutions
> > > > > > > 
> > > > > > > --
> > > > > > > Andrew Bartlett (he/him)
> > > > > > > https://samba.org/~abartlet/
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Samba Team Member (since 2001)
> > > > > > > https://samba.org
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Samba Team Lead
> > > > > > > https://catalyst.net.nz/services/samba
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Catalyst.Net Ltd
> > > > > > > 
> > > > > > > Proudly developing Samba for Catalyst.Net Ltd - a
> > > > > > > Catalyst IT
> > > > > > > group
> > > > > > > company
> > > > > > > 
> > > > > > > Samba Development and Support:
> > > > > > > https://catalyst.net.nz/services/samba
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Catalyst IT - Expert Open Source Solutions
> > > 
> > > 
> > > 
> > 
> > --
> > Andrew Bartlett (he/him)       
> > https://samba.org/~abartlet/
> > 
> > Samba Team Member (since 2001) 
> > https://samba.org
> > 
> > Samba Team Lead                
> > https://catalyst.net.nz/services/samba
> > 
> > Catalyst.Net Ltd
> > 
> > Proudly developing Samba for Catalyst.Net Ltd - a Catalyst IT group
> > company
> > 
> > Samba Development and Support: 
> > https://catalyst.net.nz/services/samba
> > 
> > 
> > Catalyst IT - Expert Open Source Solutions
> > 
> 
> 
-- 
Andrew Bartlett (he/him)       https://samba.org/~abartlet/
Samba Team Member (since 2001) https://samba.org
Samba Team Lead                https://catalyst.net.nz/services/samba
Catalyst.Net Ltd

Proudly developing Samba for Catalyst.Net Ltd - a Catalyst IT group
company

Samba Development and Support: https://catalyst.net.nz/services/samba

Catalyst IT - Expert Open Source Solutions


