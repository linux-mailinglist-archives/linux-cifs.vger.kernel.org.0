Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827CB13B6C5
	for <lists+linux-cifs@lfdr.de>; Wed, 15 Jan 2020 02:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgAOBZt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 Jan 2020 20:25:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45539 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgAOBZt (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 14 Jan 2020 20:25:49 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so16018384ioi.12
        for <linux-cifs@vger.kernel.org>; Tue, 14 Jan 2020 17:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uo/aU4XHXOLAG2IKjm7sO4w4wsRKoT9bCTC+AgYlf/4=;
        b=rPMA6P1pYB1HrYWju4SPClMxODFwJp7ANykG0xqwJ2UCAkNSQnsbPBt8oe8CvImdpi
         Rr/CvlpQJOYFC6y4rmgATb5hZ7c6D9kwBP+oJmwTNFoazBt8AB3sIjqVJPI0eXfbAJ4R
         K82sOewp+eUhgrbmrL2emZWPyUwIjITcUw6+Fnn8LtR3Mzews98HzzilkyB3RxlBn3SV
         j0YQQc6yCGPqyE71ZDyZaW8YJkMi8DmIIE/5vXeOxIJjzgid1K7h3HDLNsXDB31/VaJO
         mSlhrgKMf1sNML5idIrph9Ef08054TCuF17huGc5rhBtAEut9/e27U6O5gFmBHWy29DP
         NCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uo/aU4XHXOLAG2IKjm7sO4w4wsRKoT9bCTC+AgYlf/4=;
        b=C3VXo+IEl+1IPa8Xdjl5pZQcpMy+ujqRlWOIAPNgmHIF4S+7Hj7Rx3gzkZKKFwRVMW
         F54HmXasZ4L88TuIKmbw/yAHFezaiOngB5zlem0ZRFPVwp3ycsjcI+wSF4Xov6SMf2A7
         Y5b6biJdjunYL4+R4wNNNMlE6qUIhr0GkmLJW9tBnpY+vYEYceWFbxHaIb7jDesJMIln
         abISuPMkLaaj7HNqV9sMVNeGXYSnKVu1qYR4XhA/DU9/EtIpmvvYnTTB4fNcIvY7e+Hg
         6lw2aOKsIaKHEavoSuN7oo3SVtkwCsbXtLFWBWX00qWHihfmwVyU0SDNow55CwIsoiFw
         AH9w==
X-Gm-Message-State: APjAAAVr+foAHJIknwq5+VAraqdL38wDo+PzDiApC54PZfg2VoCl5mDH
        9YsAjQ98NLnlgLpz1hc/xiGbAv0J8/4F5M/LzkQ=
X-Google-Smtp-Source: APXvYqxL93ISshjGIE4cTYRJaA4qQMCggbSDiO01vsM3bqWwqPDJ2LaJ6HbuYj5uFM85pF6rTjgiwwMCiJNgHk/OHbU=
X-Received: by 2002:a02:c951:: with SMTP id u17mr22374490jao.27.1579051548794;
 Tue, 14 Jan 2020 17:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20200115012321.6780-1-lsahlber@redhat.com> <20200115012321.6780-2-lsahlber@redhat.com>
In-Reply-To: <20200115012321.6780-2-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:37 -0600
Message-ID: <CAH2r5mst8zDCachJMZC-BgtJs2M7c1F+1VCf-Hfe68Qz0vQ8aQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: add support for fallocate mode 0 for non-sparse files
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Does it affect (or enable) any xfstests?

On Tue, Jan 14, 2020 at 7:23 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> RHBZ 1336264
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/smb2ops.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 6250370c1170..91818f7c1b9c 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -3106,9 +3106,13 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
>                 else if (i_size_read(inode) >= off + len)
>                         /* not extending file and already not sparse */
>                         rc = 0;
> -               /* BB: in future add else clause to extend file */
> -               else
> -                       rc = -EOPNOTSUPP;
> +               /* extend file */
> +               else {
> +                       eof = cpu_to_le64(off + len);
> +                       rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
> +                                         cfile->fid.volatile_fid, cfile->pid,
> +                                         &eof);
> +               }
>                 if (rc)
>                         trace_smb3_falloc_err(xid, cfile->fid.persistent_fid,
>                                 tcon->tid, tcon->ses->Suid, off, len, rc);
> --
> 2.13.6
>


-- 
Thanks,

Steve
