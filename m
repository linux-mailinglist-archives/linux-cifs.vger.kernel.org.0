Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280751639DE
	for <lists+linux-cifs@lfdr.de>; Wed, 19 Feb 2020 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBSCKs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 18 Feb 2020 21:10:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgBSCKs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 18 Feb 2020 21:10:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so8874810pls.12
        for <linux-cifs@vger.kernel.org>; Tue, 18 Feb 2020 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BjaGgZGJAmDTIiDnp371K7iiX4AmSn1OmrU2wAEZ/d8=;
        b=FTOT5WcR6XFl8i3dZAFYexD/O51djHH2PKVWoFc1RXkln7h+F75PLSO2r+aqViARo6
         mIQKVlZDWJbbrfDV17QPOMLa+Ey3FMxXSlH1m8yr8YlA87bsE0jwcCt3YhNtV2iSpike
         dZNqzogJqcUZLo1BmnfBu54eciHamn5EpsC8TD90VFNvDDsMC4uRaZ+lfpbwR6LZZE1D
         dvKdj3Na+0rr+d1Ci5pe22I6hJdFES7BxqtZRhscidSVsJ71jKafngBkBuXwamPeuOCD
         nQpW5czgWA55VYBQslvVeD9sbAqljkNoC1gK5BeyUfDm8pZlib+T5iRxDtrj+qCX/A2m
         zgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BjaGgZGJAmDTIiDnp371K7iiX4AmSn1OmrU2wAEZ/d8=;
        b=tGS5lZnIggbnDxao7L3WeDt73JWvbZIuWGvE5Qxz6fDgpFaAl0w4F6akPx2U5VZfxi
         /txhmtPkyCpQBObMF83YMCr4pb1mXLQZgJ/J4rk9wQenjvFWmwW0Gn5PVjjuiDxHwMN6
         TjlEIXupAfc7HxILpZChcqJ/KQhvPU9suqRYwkTQ9HLLRT+TvLUzUWPIeewNLWEm1LGm
         kO/rUweU5bhXB3jl9D+7uEtA5kph+9blpvEh5zmHffwTQTOF0j476NEyCnekIxCAxhe0
         IjwzLYY8rObLD5AOE/Cjgn+5BsjfjUFjLl+Ol6ElEYxU5M+/e152p0FSSXg9OpQsRfeJ
         dmaw==
X-Gm-Message-State: APjAAAXQgWo8us+/3d8tbBWyPmfij4iopJy/ibYEGYZBy0IpdSX4Nv+V
        U0sqfial81uGB9uLnJ2wTSQ=
X-Google-Smtp-Source: APXvYqyodK+9kkS4acv4wWdswp65IBTU0pEHyXwG/BnS/bu1X6lEnbcoS/ng8BzxjVkC1dN4BzzelQ==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr23014284plo.94.1582078247542;
        Tue, 18 Feb 2020 18:10:47 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d3sm306985pfn.113.2020.02.18.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:10:46 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:10:39 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH] CIFS: unlock file across process
Message-ID: <20200219021039.3mpkrmvipd6z3wes@xzhoux.usersys.redhat.com>
References: <20200214043513.uh2jtb62qf54nmud@xzhoux.usersys.redhat.com>
 <370134c148a5f4d12df31a3a9020b66ef316a004.camel@kernel.org>
 <20200214142836.2rhitx3jfa5nxada@xzhoux.usersys.redhat.com>
 <CAKywueRV8+8qVP6e5nsvbpMQtwDU5mQGw5h51w=5rOsCN+Oj0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKywueRV8+8qVP6e5nsvbpMQtwDU5mQGw5h51w=5rOsCN+Oj0w@mail.gmail.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Feb 14, 2020 at 11:03:00AM -0800, Pavel Shilovsky wrote:
> Also, please make sure that resulting patch works against Windows file
> share since the locking semantics may be different there.

OK.

> 
> Depending on a kind of lease we have on a file, locks may be cached or
> not. We probably don't want to have different behavior for cached and
> non-cached locks. Especially given the fact that a lease may be broken
> in the middle of app execution and the different behavior will be
> applied immediately.

Testing new patch with and without cache=none option, both samba
and Win2019 server.

Thanks very much for reviewing!

Murphy
> 
> --
> Best regards,
> Pavel Shilovsky
> 
> пт, 14 февр. 2020 г. в 06:30, Murphy Zhou <jencce.kernel@gmail.com>:
> >
> > On Fri, Feb 14, 2020 at 07:26:46AM -0500, Jeff Layton wrote:
> > > On Fri, 2020-02-14 at 12:35 +0800, Murphy Zhou wrote:
> > > > Now child can't unlock the same file that has been locked by
> > > > parent. Fix this by not skipping unlock if requesting from
> > > > different process.
> > > >
> > > > Patch tested by LTP and xfstests using samba server.
> > > >
> > > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > > ---
> > > >  fs/cifs/smb2file.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
> > > > index afe1f03aabe3..b5bca0e13d51 100644
> > > > --- a/fs/cifs/smb2file.c
> > > > +++ b/fs/cifs/smb2file.c
> > > > @@ -151,8 +151,6 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
> > > >                 (flock->fl_start + length) <
> > > >                 (li->offset + li->length))
> > > >                     continue;
> > > > -           if (current->tgid != li->pid)
> > > > -                   continue;
> > > >             if (cinode->can_cache_brlcks) {
> > > >                     /*
> > > >                      * We can cache brlock requests - simply remove a lock
> > >
> > > I'm not as familiar with this code as I once was, but...
> > >
> > > From fork(2) manpage:
> > >
> > >        *  The  child does not inherit process-associated record locks from its
> > >           parent (fcntl(2)).  (On the other hand,  it  does  inherit  fcntl(2)
> > >           open file description locks and flock(2) locks from its parent.)
> > >
> > > It looks like cifs_setlk calls mand_unlock_range, and that gets called
> > > from both fcntl and flock codepaths.
> > >
> > > So, I'm not sure about just removing this. It seems like the pid check
> > > is probably correct for traditional posix locks, but probably not for
> > > OFD and flock locks? What ensures that completely unrelated tasks can't
> > > unlock your locks?
> >
> > You are right Jeff. Just removing this is not right. We need to handle
> > at least 3 types of locks: posix, OFD and flock.
> >
> > Thanks very much for reviewing! I'll try to sort this out.
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >
