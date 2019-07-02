Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784675C811
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Jul 2019 06:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfGBEOK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 2 Jul 2019 00:14:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35016 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEOJ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 2 Jul 2019 00:14:09 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so34016303ioo.2
        for <linux-cifs@vger.kernel.org>; Mon, 01 Jul 2019 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvyC1HAsfspuGWI1MQIFNxvtoap7aPJB8mQBnJGSplg=;
        b=ARaZvEQEn1txEdSGKliFsESWO3veKRXDHOoUrAkjYDpPdosgEdaVM5+xEFqaMftGrL
         J5BUvc3XeOKLdmmaxM1i4cjiKMU4CtI83/MnU/DdZx8zvTYJit6XpVMigqzv8vIHn76y
         g/bTZXrQuvUPa62vtNE9OiF6BOmJ41KJ9mAooGgS846Mf74NE5BjCSUqyicjKCL5QayA
         BIocZ9OtDmCT/Mp0eSNFFM0T8Xp9TbY/tCAQi/gpZ43IQyoowl+rYt4hWsvfSd7m3k0r
         3REIUHRrPC9yW2nkB5E4/eEanP90ttWl130Hrq0IIlm1CVBDng9/vrpH6rNVtS69YpR9
         oF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvyC1HAsfspuGWI1MQIFNxvtoap7aPJB8mQBnJGSplg=;
        b=l0dJqeVxxdybP5y8WSn6m1THuSuwM017GfJy4j+cvh7IEyc0ZmOFLautulrq4sTywT
         Z91kYfkoXt2vG9ZdEx+UcXITGhe0reiZxhj1YSXGyXOBOG8G10H5txe5YL+yjfaWmdYP
         Bb9Uh5GY2dZcIeaIKnr8HArVMyc12jVKgV0pXIliVuiqTQg7UpnB7E2Dk8IRPeoMZLUQ
         ZaP0Vnjo0kpJO6IOMWmDkznue215UfTuWWJSkHTy4MYDzfvyI7rbzoZ0nsfALiX3uwhd
         4ZqmJTVta3t+U3Evf04G1GShTEyqGZTWBwAwzw1mBRq5IjR816aDil0c3zppwRCH33TI
         sutw==
X-Gm-Message-State: APjAAAWaTBxHO4fjCGZt1yETWsH7LYH+RZGMMatxqyYgEmM0pHy5FBuw
        4Nihbz+b+qU3hfQXR333noIXvXeuEn9Go5bSJeeHPejP
X-Google-Smtp-Source: APXvYqxLGxHR9UPNtiYxtDdXyuP1AP+AzXuWVm6GX6NFO+DhfWSrrconKtEHOc+wjc+Bd4On7fSzM+WuxNZjJoX7R4o=
X-Received: by 2002:a6b:dc08:: with SMTP id s8mr6214012ioc.209.1562040849158;
 Mon, 01 Jul 2019 21:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msqF-Cvq=q7ae1XmnOi6DbB3UKSDSDvZbT8MNscLH3XTA@mail.gmail.com>
In-Reply-To: <CAH2r5msqF-Cvq=q7ae1XmnOi6DbB3UKSDSDvZbT8MNscLH3XTA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 2 Jul 2019 14:13:57 +1000
Message-ID: <CAN05THQnBWYehEO4YXV71FtZB2Q4umpn0T74patTjQ=jbwRrJg@mail.gmail.com>
Subject: Re: [PATCH]Fix querying symlinks
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Jun 28, 2019 at 5:09 PM Steve French <smfrench@gmail.com> wrote:
>
> Querying of symlinks to the Samba server with POSIX extensions works!
>
> (Also would work for querying symlinks generated in Windows NFS server)
>
> # stat /mnt1/symlink-source
>   File: /mnt1/symlink-source -> symlink-target
>   Size: 14            Blocks: 2048       IO Block: 16384  symbolic link
> Device: 39h/57d    Inode: 10354691    Links: 1
> Access: (0000/l---------)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2019-06-28 01:43:37.145324400 -0500
> Modify: 2019-06-28 01:43:37.145324400 -0500
> Change: 2019-06-28 01:43:37.145324400 -0500
>  Birth: -
>
>

Very nice.

Change parse_reparse_point() to take a struct reparse_data_buffer as
argument, not a reparse_symlink_data_buffer.
i.e.
parse_reparse_point(struct reparse_data_buffer *reparse_buf,

Then this check should probably be in parse_reparse_point() and not in
parse_reparse_posix() since we will need this check for every type of
reparse point:
  + if (len + sizeof(struct reparse_data_buffer) > plen) {
  + cifs_dbg(VFS, "srv returned malformed symlink buffer\n");
  + return -EINVAL;
  + }

If you do that, then you can remove the equivalent check in
smb2_query_symlink() :
if (plen < le16_to_cpu(reparse_buf->ReparseDataLength) + 8) {
...



> --
> Thanks,
>
> Steve
