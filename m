Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6515289E
	for <lists+linux-cifs@lfdr.de>; Wed,  5 Feb 2020 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBEJpX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 5 Feb 2020 04:45:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45070 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJpW (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 5 Feb 2020 04:45:22 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so1370008ioi.12
        for <linux-cifs@vger.kernel.org>; Wed, 05 Feb 2020 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=478vKmS9LNYU0WFZ9n2myjzmrU0U68OxGaHi8DhUXAM=;
        b=s7cDFIoIeJz25ZotMRWjwZ+QAt5UWsCozdp6GL1PsvF0Ty00MhbaIvYd0K/IQWCZNX
         mLdNhGbmlVhsb57Tg75c/twgdMkWD9jQHh4k+NRZKFwKlGWSwQi5QxSHiJB1DnXkFPcK
         XKhdPMx+11omst6qY2iUQBtqy8ZttkRS+AV0cw/5up+RjgkGjTyCmZXZzrvBRDe0jTBI
         aYAUHTi1gsIS/dSu80WQIsSv5zcUhBDLoWQ67fXwxX/mJma7tcz/0COQW5QBJ8dZJxCG
         zpAJJs/nItdCeG1G0NE66jv0EkzaGo32IO1c/iQpAH2F63iZgWL0F/x44muExWB9Blyp
         0cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=478vKmS9LNYU0WFZ9n2myjzmrU0U68OxGaHi8DhUXAM=;
        b=A3rALRL8AtlOtFTmKhypcoRjd/A9O3W2gimLPzPdkS5JZyzQwndz9CDxaq09+2pTky
         0e7tBd6UKWgCYMT30mCIqY/vmxO5nR9kxfTbBRp/wD0MlQNpYMH5Z4tJ+/haJPcSldNs
         LgnMYckjfd0s7+AZitbTZW/vijnRnQvDI3RmT36O8X+GxZTvGzDoxnfFFQ4vNd2srks1
         7dqaVjiLkdkzHZi5qieM300vBGNrDQ+gEKiGmV71Bgqh30NidmXbzfHaK9+RSqwFmZfR
         utGbJifxFYHx8beDamp/0gb6kAdKAR1MUngzE/aRHZfbJFdgzeYZ3iQ7ASZP+7rsUahq
         VuUA==
X-Gm-Message-State: APjAAAX6lP6XFuqqsvok2+JlDd6FKZtvo1IdOi3YAKPakirSHlMWK9xi
        U3p/9yTGbM6HnOEJv0gwzzLfJBESi/Y/fKMiALg=
X-Google-Smtp-Source: APXvYqw1zKezaMsHFWKaXktxc0gugA5jxI3XqjqjEbjDEo10Cap07VZqM1Cg4EQT1hiCU0QtVqueeXF+urvloxlGgDo=
X-Received: by 2002:a05:6602:2282:: with SMTP id d2mr13343237iod.173.1580895922195;
 Wed, 05 Feb 2020 01:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200205010801.27759-1-lsahlber@redhat.com>
In-Reply-To: <20200205010801.27759-1-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Feb 2020 03:45:11 -0600
Message-ID: <CAH2r5mt+d_NTaA40-4nKRSdr3qXdtLjhPPLos99azYyK8hde5g@mail.gmail.com>
Subject: Re: [PATCH] cifs: fail i/o on soft mounts if sessionsetup errors out
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Added cc:stable and merged into cifs-2.6.git for-next

On Tue, Feb 4, 2020 at 7:08 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> RHBZ: 1579050
>
> If we have a soft mount we should fail commands for session-setup
> failures (such as the password having changed/ account being deleted/ ...)
> and return an error back to the application.
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/smb2pdu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 14f209f7376f..7996d81230aa 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -350,9 +350,14 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
>         }
>
>         rc = cifs_negotiate_protocol(0, tcon->ses);
> -       if (!rc && tcon->ses->need_reconnect)
> +       if (!rc && tcon->ses->need_reconnect) {
>                 rc = cifs_setup_session(0, tcon->ses, nls_codepage);
> -
> +               if ((rc == -EACCES) && !tcon->retry) {
> +                       rc = -EHOSTDOWN;
> +                       mutex_unlock(&tcon->ses->session_mutex);
> +                       goto failed;
> +               }
> +       }
>         if (rc || !tcon->need_reconnect) {
>                 mutex_unlock(&tcon->ses->session_mutex);
>                 goto out;
> @@ -397,6 +402,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
>         case SMB2_SET_INFO:
>                 rc = -EAGAIN;
>         }
> +failed:
>         unload_nls(nls_codepage);
>         return rc;
>  }
> --
> 2.13.6
>


-- 
Thanks,

Steve
