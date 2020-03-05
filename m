Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79979179FD8
	for <lists+linux-cifs@lfdr.de>; Thu,  5 Mar 2020 07:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgCEGOv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 5 Mar 2020 01:14:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45708 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEGOv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 5 Mar 2020 01:14:51 -0500
Received: by mail-io1-f65.google.com with SMTP id w9so5171378iob.12
        for <linux-cifs@vger.kernel.org>; Wed, 04 Mar 2020 22:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YofGJwFrLrY2gJiH2YaegEN5Mu4rJFyBFcM/HTNfHy8=;
        b=lMNHED7FNS0887Lfgg+0QMw0K47ZK05YmCrzH0TGXv1BuSy4NEzXKRyL19XcRunhng
         wMgYCbSVdHW22HjbmEDPtFgIWWuRJvmzwlOzZL1WbP5ZMezIXkPA7hp3uDYTvHBhiiTk
         n5anaCCZSk0PCUG3YxAXomrhQQJu5Xifpu9k7bog4qQu1+VCDdDARHGEO3N2XQ17h0Kf
         GEMBOG4zOVw9PsFV6HZxtdZ+XrEkehbrSRUQsE53Y21+KMCatSyBwLZWg/n6G8wwNblO
         axQBA6kOPnQouPiyYa0nhFS62hFJhoYw2smr0hnZI1iWWi0/FX71lAabXnQkunfPI/9l
         QHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YofGJwFrLrY2gJiH2YaegEN5Mu4rJFyBFcM/HTNfHy8=;
        b=H7xxswcV1hpjrZomusTSJ4FhmDYe7X/BqN/eJOmEV6QqBkR6cOhUeXeaKLQxKCqYhr
         QtNtMzGblxjoZSWPP57TgLNvsNzprxlweGqyS550nX+qWqhat4ZCWdb0fIDnkrJXIgyz
         BvX7Nq0CbQEDDHmt2F7otLvPcQ5CaUwnY2rZF3VYu+MejN7qs+DXEdDprSrwXj8WbiMA
         mdDWwzurLL/RiJcs86I7AI3qP7Pku/gcW6STM3q2SQlyW4hU3DYQ61phifYBmtm05DYG
         JvULe4KO7A44J1FvbqxtU1R4SxP02/aH+KNfgLr9b1lrKmTmjHAPAEhcut45A7x4EM4t
         ekeg==
X-Gm-Message-State: ANhLgQ1eQh/9P2AAIl/vnZhTkOHflCcjQR61giwVPW3KFzlGIeQM/0PW
        vd5OYUl1NM6Hb87vyknZqn0DcuHaCKKg56bSp6E=
X-Google-Smtp-Source: ADFU+vtC9PIMu3SX4jJ4b95JF5ZsuJPzclJ56YJFeRfKT/dnBj4lofWg8WfbxcUO2QF15HXNFqjF8hJcWQOjR0pTubU=
X-Received: by 2002:a5e:d512:: with SMTP id e18mr4963545iom.209.1583388889112;
 Wed, 04 Mar 2020 22:14:49 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5msKRKFdpg16DE-HvEGDDMZQOw2=nhL3xbBJoYEvyzHwnQ@mail.gmail.com>
In-Reply-To: <CAH2r5msKRKFdpg16DE-HvEGDDMZQOw2=nhL3xbBJoYEvyzHwnQ@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 5 Mar 2020 16:14:37 +1000
Message-ID: <CAN05THQq5mfBue=d0_kK2PqtdedYFVx3gLaYRLgq+1FFGOWDKQ@mail.gmail.com>
Subject: Re: [CIFS][PATCH] Make warning when using default version (default
 mount) less noisy
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Acked-by me


On Thu, Mar 5, 2020 at 4:03 PM Steve French <smfrench@gmail.com> wrote:
>
>     The warning we print on mount about how to use less secure dialects
>     (when the user does not specify a version on mount) is useful
>     but is noisy to print on every default mount, and can be changed
>     to a warn_once.  Slightly updated the warning text as well to note
>     SMB3.1.1 which has been the default which is typically negotiated
>     (for a few years now) by most servers.
>
>           "No dialect specified on mount. Default has changed to a more
>            secure dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIFS
>            (SMB1). To use the less secure SMB1 dialect to access old
>            servers which do not support SMB3.1.1 (or even SMB3 or SMB2.1)
>            specify vers=1.0 on mount."
>
>
> --
> Thanks,
>
> Steve
