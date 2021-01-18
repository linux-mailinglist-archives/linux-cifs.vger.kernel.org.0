Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA732F967C
	for <lists+linux-cifs@lfdr.de>; Mon, 18 Jan 2021 01:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhARAC6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 17 Jan 2021 19:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhARACv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 17 Jan 2021 19:02:51 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49BFC061573;
        Sun, 17 Jan 2021 16:02:10 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1HzU-00BADM-Tn; Mon, 18 Jan 2021 00:01:53 +0000
Date:   Mon, 18 Jan 2021 00:01:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/cifs: Replace one-element array with flexible-array
 member.
Message-ID: <20210118000152.GH3579531@ZenIV.linux.org.uk>
References: <1610615171-68296-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <87czy7lvjy.fsf@suse.com>
 <CAH2r5mvjDAgB6-kE=AOAwrETVk+R79z6Gd8gMnOTWqG-6Mnybw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvjDAgB6-kE=AOAwrETVk+R79z6Gd8gMnOTWqG-6Mnybw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sun, Jan 17, 2021 at 03:58:23PM -0600, Steve French wrote:
> Jiapeng,
> Aurelien is correct, you should respin this patch and correct for
> where it breaks the sizeof calculation.  For example your change:
> 
> struct smb2_lock_rsp {
> @@ -1434,7 +1434,7 @@ struct smb2_query_directory_req {
>         __le16 FileNameOffset;
>         __le16 FileNameLength;
>         __le32 OutputBufferLength;
> -       __u8   Buffer[1];
> +       __u8   Buffer[];
>  } __packed;
> 
> would have the side effect of making the file name off by one:
> 
> smb2pdu.c-4654- req->FileNameOffset =
> smb2pdu.c:4655:         cpu_to_le16(sizeof(struct
> smb2_query_directory_req) - 1);

FWIW, that sizeof() - 1 should've been offsetof()...
