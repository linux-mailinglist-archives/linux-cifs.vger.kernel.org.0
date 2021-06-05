Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFF39CA56
	for <lists+linux-cifs@lfdr.de>; Sat,  5 Jun 2021 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFESAM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 5 Jun 2021 14:00:12 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:43924 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFESAM (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 5 Jun 2021 14:00:12 -0400
Received: by mail-lf1-f45.google.com with SMTP id n12so11989388lft.10
        for <linux-cifs@vger.kernel.org>; Sat, 05 Jun 2021 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfBXh6L25hGvFKETahdwq6z0If3LNxAc7EcS7T9lRTM=;
        b=S2+aGr8mj4EdvCmENZMkRKwP0qlp0BBC71t1lmEyk2aas4d2fMtQiZntyBHC/G37Ff
         iSo9OlJFbT9b6BUlI86TP+/3PdzastEO/tQ9E+dPvKb92fgzm2MrV6tR2DmJtiYWm3S2
         klxDnOXN+vLnPxBp/f5GjnCDenVaGZoH2KiTVVk0yj6T7Sr+ah9ylDRrPISYL/EklWTC
         e3SvOLKTkVdhgbtPLtPwMWjbp6+jywJ2ALg6WfCKITwP4eI3xnndSOeFaDNxwvQXXAsw
         pLna50QUoqaIFoQAMOyQ8SNYQt2589TFPKnCTFAulLt1lUBo7HtnJusg3/Jhgxa4DF8F
         zoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfBXh6L25hGvFKETahdwq6z0If3LNxAc7EcS7T9lRTM=;
        b=frtfFDQZdZdo6nn94CUj1wWbwjVOe61dB2L9xSh48M7rTT3X3Oe5zkCNHFkvmXI/8e
         bjD+GK4K2+ybtW4n9cDdAEHIgJJbHhG7brJs7pGjA0EWNZEMBAnCYqc2W85jHTdWiFr+
         +h5wKM+EXqK5q9YZNiDctEO2sVbhPZOH/qNyTvJOUzeQW8XGgRI00MesTudieX3GoT26
         2UKS4d+LpXSxMVSpZhgcS7/1pgClumB9zvtsorp1hhM047g+YA0gzKy1MqOXHHOxY78R
         PsSc/1wco7ur9GPeezVtB/8WPWJvEBZxOe3TIG7sLRFuI9Q2Ge2Qv+cdcAUeNYxO0oa5
         Dx3A==
X-Gm-Message-State: AOAM5327Fb6tEksQUIqYuSRyIr1+ZTsIyVts3MAW0MiguFi7oXJh82fy
        42HchZHj/CZzwYyR15abfSfbPJy5sOtqewIo+/8=
X-Google-Smtp-Source: ABdhPJwwdAHRtADDP6HIrPNRTNFk5a/sKzEfM+ApVavR5iueprlRk1jWe03uUICjkhtUv/KXICxSEjczYrtfPHEE8n4=
X-Received: by 2002:a05:6512:39cb:: with SMTP id k11mr6621480lfu.313.1622915842904;
 Sat, 05 Jun 2021 10:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=oMLZei+OhXZ-8Hr2NCx=pRYWF1zQ0vRQ5D_NkvLGwJDg@mail.gmail.com>
 <875yywp64t.fsf@cjr.nz> <CANT5p=o6Oq-27Xj4Z6-XzXKL45Dwg7JjGw2HA9jv5+YFQKpHUg@mail.gmail.com>
 <87y2bpk5xu.fsf@cjr.nz> <CANT5p=ro-sZfc8bPhh7COEp_KBHF6KNzbSV30WyRo2NHLneqAw@mail.gmail.com>
 <CAH2r5muZ_6Eg==AfPKtc4Jiz7kJg+wWDCPSt=7vcLSxwNFu+UA@mail.gmail.com>
In-Reply-To: <CAH2r5muZ_6Eg==AfPKtc4Jiz7kJg+wWDCPSt=7vcLSxwNFu+UA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 5 Jun 2021 12:57:11 -0500
Message-ID: <CAH2r5muW5Vgx93KrVOZqaueAw44p4sVtSZPLmFExtqRUg6Ufcw@mail.gmail.com>
Subject: Re: Multichannel patches
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Paulo Alcantara <pc@cjr.nz>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        CIFS <linux-cifs@vger.kernel.org>, sribhat.msa@outlook.com,
        rohiths msft <rohiths.msft@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

test run started with those 9 patches (8 multichannel, and Aurelien's
small patch)

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/11/builds/68

On Sat, Jun 5, 2021 at 12:43 PM Steve French <smfrench@gmail.com> wrote:
>
> Had to fix two things in those recently updated patches to get them to
> build.  You may want to fold those in as well to make the patches
> clearer to read and bisectable
>
> smfrench@smfrench-ThinkPad-P52:~/cifs-2.6/fs/cifs$ git diff -a
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 6e4934052159..f340b7d389ef 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -260,7 +260,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
>
>                 /* If all channels need reconnect, then tcon needs reconnect */
>                 if (!CIFS_ALL_CHANS_NEED_RECONNECT(ses))
> -                       goto skip_tcon_reconnect;
> +                       continue;
>
>                 list_for_each(tmp2, &ses->tcon_list) {
>                         tcon = list_entry(tmp2, struct cifs_tcon, tcon_list);
> @@ -268,8 +268,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                 }
>                 if (ses->tcon_ipc)
>                         ses->tcon_ipc->need_reconnect = true;
> -
> -skip_tcon_reconnect:
>         }
>         spin_unlock(&cifs_tcp_ses_lock);
>         mutex_unlock(&ses->session_mutex);
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index cdbd256be4e4..202d98d06606 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -92,10 +92,10 @@ unsigned long cifs_ses_get_chan_index(struct cifs_ses *ses,
>  void cifs_chan_set_need_reconnect(struct cifs_ses *ses,
>                                    struct TCP_Server_Info *server)
>  {
> -       size_t chan_index = cifs_ses_get_chan_index(ses, server);
> +       unsigned long chan_index = cifs_ses_get_chan_index(ses, server);
>
>         set_bit(chan_index, &ses->chans_need_reconnect);
> -       cifs_dbg(FYI, "Set reconnect bitmask for chan %u; now 0x%lx\n",
> +       cifs_dbg(FYI, "Set reconnect bitmask for chan %lu; now 0x%lx\n",
>                  chan_index, ses->chans_need_reconnect);
>
> On Sat, Jun 5, 2021 at 9:08 AM Shyam Prasad N <nspmangalore@gmail.com> wrote:
> >
> > The buildbot testing once hit a deadlock when running with the above patches.
> > I found one possibility during cifs_reconnect, where a deadlock can occur.
> >
> > I've fixed that and some warnings that kernel bots have identified in
> > the below two patches:
> > https://github.com/sprasad-microsoft/smb-kernel-client/pull/5/commits/f3e65f72b03b03bc4b301e8e04e9babb0e9582cf.patch
> > https://github.com/sprasad-microsoft/smb-kernel-client/pull/5/commits/7b3e867e994a7cbc88efe85c95167ae49d4b7a9d.patch
> >
> > Regards,
> > Shyam
> >
> > On Fri, Jun 4, 2021 at 8:55 PM Paulo Alcantara <pc@cjr.nz> wrote:
> > >
> > > Shyam Prasad N <nspmangalore@gmail.com> writes:
> > >
> > > > @Paulo Alcantara That would be great if you can help testing my
> > > > changes. Please test with these new changes.
> > >
> > > OK.
> > >
> > > >> The super is only used for providing cifs_sb_info::origin_fullpath as key to find the corresponding failover targets in referral cache.
> > > > I'm wondering what would happen if there are multiple tcons to the
> > > > same origin_fullpath (possibly in different sessions)?
> > >
> > > That is certainly a problem, indeed.  I'm waiting for the DFS tests to
> > > finish and then send a series that contains a potential fix for that --
> > > e.g. not sharing TCP servers when mounting DFS shares.  We used to not
> > > share tcons with DFS mounts because they might contain different prefix
> > > paths but connected to same share, however that wasn't enough because
> > > multiple DFS mounts may connect to same target servers, although they
> > > might failover to completely different servers.
> > >
> > > > Also, doesn't failover targets apply to each channel under a session?
> > > > Shouldn't we switch targets on reconnect of secondary channels too?
> > >
> > > That's a interesting question.  I recall discussing this with Aurelien
> > > some time ago while running a few DFS + multichannel tests.
> > >
> > > So yes, I agree with you that when we successfully reconnect to failover
> > > target (primary channel), then we should also update all secondary
> > > channels with the new server's ip address and reconnect them.
> >
> >
> >
> > --
> > Regards,
> > Shyam
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
