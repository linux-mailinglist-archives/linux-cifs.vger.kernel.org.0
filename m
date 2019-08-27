Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509949DB9A
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2019 04:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfH0CUx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 26 Aug 2019 22:20:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34199 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0CUx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 26 Aug 2019 22:20:53 -0400
Received: by mail-io1-f66.google.com with SMTP id s21so42617749ioa.1
        for <linux-cifs@vger.kernel.org>; Mon, 26 Aug 2019 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQAj7VT1XegMCJO7UpJuVrWHdVy2bs1NgRK/gINtqdM=;
        b=NyPS6W2a2Tmw2Aa2t0fjxcS0Hp1gJaJP3IyqlA/SA4qJclyJteZwT2IrisKaC2UEie
         DvvV1cQhV01js4XSBC8oXXUjUttcpe7RtlymcoPUlslKNACZGXlwfFhTMU923+Sa9i9g
         5hy9LrCufcOldh1DRnyOGEqmjyFRt+dfnBkCZ36Qv2QzJ7wz4xS20u8nb7WKA/EHfg1x
         f+imDq5ExHXIaBCxOLSaPJ+Togw10fy/t291WaWJ4fRtgQhbH+W2102xgSyHlg+acm+J
         qrMyWSMb90LHK/RPDtxGKgIU6/3bmSsIMSUQijo4+aPiUNyvf9pSzyGZxVVwI7C+DC8B
         IFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQAj7VT1XegMCJO7UpJuVrWHdVy2bs1NgRK/gINtqdM=;
        b=EbN5bPMnDeBWlkWQMZD3g3a92esfq6t0c/Y6Q+4s3GTMGfgX+Y3UGbbylJknDIKxC0
         JtkDk8SXm8L2z4q15Ea+lU2GmdU9G0lfPuGVdNvj/gkIaLH42Qx2wfnFMdcaotyytSVj
         1wDiBMGXgLKtrZIKakek43eypLDww3kEFwsVZH1mBa/6Uf7PpqfEcktn8j/pgv6ta7vy
         Vsz/PntCN7Syz8DZyeH1cuqs8XCbURx0uCT9Mpp4Z0u3LDt0HtreGOBb2nVQesxWu4xJ
         MfyrgYHY8d+sa8QjwBK+T7iqtDsYFMM7yfZvjTU+1URhft6LMic9rOEhLP3nrOJv/vM/
         lbwg==
X-Gm-Message-State: APjAAAXF0n2esOGdeJ/qU0FrdwVKlvore9sf8YpMFtM1atXSIVudNwe2
        XaXeqXf7BD6yhM70ogPqDHatrqHrJl36MMLtboo=
X-Google-Smtp-Source: APXvYqxJifQcYTRdkqMeLXa361GysNwfino4fJIm4Uerw2e/iBvCilgruU2Zd3K7T4jZU9mBGwD4mvClnbijmL7pCug=
X-Received: by 2002:a5e:c104:: with SMTP id v4mr395102iol.209.1566872452677;
 Mon, 26 Aug 2019 19:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190827013558.18281-1-lsahlber@redhat.com> <20190827013558.18281-2-lsahlber@redhat.com>
 <CAH2r5mvSjf1vXnoan1vasH=CoOLjQ7se-M5_HaULC=rZSFWFvA@mail.gmail.com>
In-Reply-To: <CAH2r5mvSjf1vXnoan1vasH=CoOLjQ7se-M5_HaULC=rZSFWFvA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 27 Aug 2019 12:20:40 +1000
Message-ID: <CAN05THRiEV0=zY5Q04CV7-gUQHs5NYyO4t7N_zQZbwdpcSZi8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: fix incorrect error return in build_unc_path_to_root
To:     Steve French <smfrench@gmail.com>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Aug 27, 2019 at 12:15 PM Steve French <smfrench@gmail.com> wrote:
>
> Do you have a simple repro for this one that would lead us to want to cc:stable

I don't have a reproducer.

>
> On Mon, Aug 26, 2019 at 8:36 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
> >
> > Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > ---
> >  fs/cifs/connect.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > index 1ed449f4a8ec..c5dc8265b671 100644
> > --- a/fs/cifs/connect.c
> > +++ b/fs/cifs/connect.c
> > @@ -4232,7 +4232,7 @@ build_unc_path_to_root(const struct smb_vol *vol,
> >         unsigned int unc_len = strnlen(vol->UNC, MAX_TREE_SIZE + 1);
> >
> >         if (unc_len > MAX_TREE_SIZE)
> > -               return -EINVAL;
> > +               return ERR_PTR(-EINVAL);
> >
> >         full_path = kmalloc(unc_len + pplen + 1, GFP_KERNEL);
> >         if (full_path == NULL)
> > --
> > 2.13.6
> >
>
>
> --
> Thanks,
>
> Steve
