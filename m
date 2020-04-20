Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0841E1B1986
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Apr 2020 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTWap (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Apr 2020 18:30:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgDTWan (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 20 Apr 2020 18:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587421841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9q6YhDfeioGYYNbOwoNDtbd8XWXwGnM98df6kx4/308=;
        b=M9K+Ce0pFPTIUPMmsJa/84tA2++gzQV2giT50alI0titPuGjK4zvuhG12ohwkZ4D2mbODb
        55NO65uVc3NxVaZQm75EdMdhocDXmJ+EKK+wUH90MO81UGXpoZQwwSSqTb0kVcD5WT5Tyn
        j0xhA7UqH0DNtzVKeLQHnsocxS1JvdU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-xQ-oqcAmMuCM7wkTtMO0Zg-1; Mon, 20 Apr 2020 18:30:39 -0400
X-MC-Unique: xQ-oqcAmMuCM7wkTtMO0Zg-1
Received: by mail-qv1-f71.google.com with SMTP id m20so11880929qvy.13
        for <linux-cifs@vger.kernel.org>; Mon, 20 Apr 2020 15:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9q6YhDfeioGYYNbOwoNDtbd8XWXwGnM98df6kx4/308=;
        b=XrnjTbbE3A9QqPAFYKWHzTEozVIefN347rtnRRZwiBoYNHjc66z2kGE+ToovQDxa7v
         MfXurw5XHyT0NeRHKOBE85kzhN3/XAnsZiiYE4xwlUYqDa+BJr7KJDt/5IcXD3FMauRq
         wk2KuqCT0IseIwJgqjnOeR4JxCLmo5np8sGiebFKaBYaO/55LA8SJAvmVv+pS92U80Yr
         C114nfkNh7cZqkADfwaRUWBhgqILWZrGIQO7TL0bNyQexK5kDkc7ai/XNpYIgz8gv2qc
         ktW/A6RMGQh8wl0WJb2zqLUIG4H25BpsTYD8cJW8K2D/YglW3jn7sW24Y03l7qlWwMTP
         0PSg==
X-Gm-Message-State: AGi0Pua4r5fg8Bxo88gITfchD1PqjKR7a5OLRmflOtnUtwvv7GUIBrbY
        JzoZUQVqrP/npPFSt07r9kUYoRwBt0Y+E3qZMvF3X0FnWwpbZ0rj9R+nUFNF6BFg6KbmTechDpb
        U/ADJFUcJZ/oE6VGmegJMhw==
X-Received: by 2002:ac8:1a8a:: with SMTP id x10mr18266937qtj.154.1587421839478;
        Mon, 20 Apr 2020 15:30:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1XEhHKfWJ4L3lMwmFDzE2+TBxLfE0ulmEwOUTO4o7oVPQ7Klu15FdcDd0dnvjj9vSaCf+vQ==
X-Received: by 2002:ac8:1a8a:: with SMTP id x10mr18266910qtj.154.1587421839193;
        Mon, 20 Apr 2020 15:30:39 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id m40sm545368qtc.33.2020.04.20.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:30:38 -0700 (PDT)
Message-ID: <93e1141d15e44a7490d756b0a00060660306fadc.camel@redhat.com>
Subject: Re: cifs - Race between IP address change and sget()?
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@cjr.nz>
Cc:     viro@zeniv.linux.org.uk, Steve French <smfrench@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
Date:   Mon, 20 Apr 2020 18:30:37 -0400
In-Reply-To: <1986040.1587420879@warthog.procyon.org.uk>
References: <878siq587w.fsf@cjr.nz> <87imhvj7m6.fsf@cjr.nz>
         <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
         <3865908.1586874010@warthog.procyon.org.uk>
         <927453.1587285472@warthog.procyon.org.uk>
         <1136024.1587388420@warthog.procyon.org.uk>
         <1986040.1587420879@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, 2020-04-20 at 23:14 +0100, David Howells wrote:
> Paulo Alcantara <pc@cjr.nz> wrote:
> 
> > > > > What happens if the IP address the superblock is going to changes, then
> > > > > another mount is made back to the original IP address?  Does the second
> > > > > mount just pick the original superblock?
> > > > 
> > > > It is going to transparently reconnect to the new ip address, SMB share,
> > > > and cifs superblock is kept unchanged.  We, however, update internal
> > > > TCP_Server_Info structure to reflect new destination ip address.
> > > > 
> > > > For the second mount, since the hostname (extracted out of the UNC path
> > > > at mount time) resolves to a new ip address and that address was saved
> > > > earlier in TCP_Server_Info structure during reconnect, we will end up
> > > > reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super().
> > > 
> > > Would that be a bug?
> > 
> > Probably.
> > 
> > I'm not sure how that code is supposed to work, TBH.
> 
> Hmmm...  I think there may be a race here then - but I'm not sure it can be
> avoided or if it matters.
> 
> Since the address is part of the primary key to sget() for cifs, changing the
> IP address will change the primary key.  Jeff tells me that this is governed
> by a spinlock taken by cifs_match_super().  However, sget() may be busy
> attaching a new mount to the old superblock under the sb_lock core vfs lock,
> having already found a match.
> 

Not exactly. Both places that match TCP_Server_Info objects by address
hold the cifs_tcp_ses_lock. The address looks like it gets changed in
reconn_set_ipaddr, and the lock is not currently taken there, AFAICT. I
think it probably should be (at least around the cifs_convert_address
call).

> Should the change of parameters made by cifs be effected with sb_lock held to
> try and avoid ending up using the wrong superblock?
> 
> However, because the TCP_Server_Info is apparently updated, it looks like my
> original concern is not actually a problem (the idea that if a mounted server
> changes its IP address and then a new server comes online at the old IP
> address, it might end up sharing superblocks because the IP address is part of
> the key).
> 

I'm not sure we should concern ourselves with much more than just not
allowing addresses to change while matching/searching. If you're
standing up new servers at old addresses while you still have clients
are migrating, then you are probably Doing it Wrong.

-- 
Jeff Layton <jlayton@redhat.com>

