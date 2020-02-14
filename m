Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7915F651
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Feb 2020 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgBNTDN (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Feb 2020 14:03:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34849 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgBNTDN (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 14 Feb 2020 14:03:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so7463992lfe.2
        for <linux-cifs@vger.kernel.org>; Fri, 14 Feb 2020 11:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sXj9LaavzDAkZMwAsGdZtJTr3iAF55IZgFNKHMBeeAo=;
        b=kFZ+UBGYElxElgvIhbvYkdSLLMe0Avt5LMeem0XaRLvdSmtTYsmeB6ETymG86YLuYa
         RL7+1DjQouc2WnJt6QMvOdnXqaMq0qM7dcPoBHxlBQqLL0Z4nvPoPslRkIYiOzGrzZWQ
         WhO2a1LskSbDuXm8kkY4vNXEmP9zWglkJYdwlrOHZcrxk1CPcYyaG/6GCedCJ4EWMdJC
         cnF3F9YmrmTVrdBRs8/Ug1mS873k9sKHyRGYi4wv/Mb1Yn4yjUncV9hr6xADk9ZPwtXP
         SukvsuKkbtGV8P30NY7TmCFm514G5HaxhhFzWm18Ly1SaISM99BuHt5yXTZgqvEjrZx3
         vpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sXj9LaavzDAkZMwAsGdZtJTr3iAF55IZgFNKHMBeeAo=;
        b=m0QwI0AS5lEZfQh/AZfI750Xyj4vy2UcGiV5u/qnXnfDgiemVh94G3jhprogouPnFv
         OLBZPo9ZwpEx6mkIUpcoe7+Ze4lq0j+c03SC458YjF+a4b+zIUXkp7135W1nL/k2yYzT
         caiQyO2h56LeQwADTDzMRQTzbriiSuvfX7pYWi4tpCsbi8jLm1jDQI5sw/0CmqSW4xHR
         aEf+4IlLS4nPSErjI9NimOooarinSrcozoUto59a25rNbtnM2OaW3uuvgF7BUf6QyIMR
         7L2+CUey/tuKZjLPgr1x2YBBI8wBXPN4/EBlaaHpbPaaAdZg3VI9jS0KHnNMxXAHFrM0
         CTOA==
X-Gm-Message-State: APjAAAU/785VL1M2dcOkSkycc55thbCg+1rGSxdhkDqGi2anOXZaRwGl
        N5XU/gHmDfIjkVmJh5faLm/x7hMTxv8+S58PuA==
X-Google-Smtp-Source: APXvYqxQyh/9JFhcybQcsw1xRGOXPZg+Zedyaqpiwi50rCNML6ZxlGUnKP+29IV2nARyxBTlcSKIOfZ0YGfd9y1xSRw=
X-Received: by 2002:a05:6512:203b:: with SMTP id s27mr2345496lfs.87.1581706991631;
 Fri, 14 Feb 2020 11:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20200214043513.uh2jtb62qf54nmud@xzhoux.usersys.redhat.com>
 <370134c148a5f4d12df31a3a9020b66ef316a004.camel@kernel.org> <20200214142836.2rhitx3jfa5nxada@xzhoux.usersys.redhat.com>
In-Reply-To: <20200214142836.2rhitx3jfa5nxada@xzhoux.usersys.redhat.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Fri, 14 Feb 2020 11:03:00 -0800
Message-ID: <CAKywueRV8+8qVP6e5nsvbpMQtwDU5mQGw5h51w=5rOsCN+Oj0w@mail.gmail.com>
Subject: Re: [PATCH] CIFS: unlock file across process
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Also, please make sure that resulting patch works against Windows file
share since the locking semantics may be different there.

Depending on a kind of lease we have on a file, locks may be cached or
not. We probably don't want to have different behavior for cached and
non-cached locks. Especially given the fact that a lease may be broken
in the middle of app execution and the different behavior will be
applied immediately.

--
Best regards,
Pavel Shilovsky

=D0=BF=D1=82, 14 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 06:30, Murph=
y Zhou <jencce.kernel@gmail.com>:
>
> On Fri, Feb 14, 2020 at 07:26:46AM -0500, Jeff Layton wrote:
> > On Fri, 2020-02-14 at 12:35 +0800, Murphy Zhou wrote:
> > > Now child can't unlock the same file that has been locked by
> > > parent. Fix this by not skipping unlock if requesting from
> > > different process.
> > >
> > > Patch tested by LTP and xfstests using samba server.
> > >
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  fs/cifs/smb2file.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
> > > index afe1f03aabe3..b5bca0e13d51 100644
> > > --- a/fs/cifs/smb2file.c
> > > +++ b/fs/cifs/smb2file.c
> > > @@ -151,8 +151,6 @@ smb2_unlock_range(struct cifsFileInfo *cfile, str=
uct file_lock *flock,
> > >                 (flock->fl_start + length) <
> > >                 (li->offset + li->length))
> > >                     continue;
> > > -           if (current->tgid !=3D li->pid)
> > > -                   continue;
> > >             if (cinode->can_cache_brlcks) {
> > >                     /*
> > >                      * We can cache brlock requests - simply remove a=
 lock
> >
> > I'm not as familiar with this code as I once was, but...
> >
> > From fork(2) manpage:
> >
> >        *  The  child does not inherit process-associated record locks f=
rom its
> >           parent (fcntl(2)).  (On the other hand,  it  does  inherit  f=
cntl(2)
> >           open file description locks and flock(2) locks from its paren=
t.)
> >
> > It looks like cifs_setlk calls mand_unlock_range, and that gets called
> > from both fcntl and flock codepaths.
> >
> > So, I'm not sure about just removing this. It seems like the pid check
> > is probably correct for traditional posix locks, but probably not for
> > OFD and flock locks? What ensures that completely unrelated tasks can't
> > unlock your locks?
>
> You are right Jeff. Just removing this is not right. We need to handle
> at least 3 types of locks: posix, OFD and flock.
>
> Thanks very much for reviewing! I'll try to sort this out.
> > --
> > Jeff Layton <jlayton@kernel.org>
> >
