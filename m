Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6626C687228
	for <lists+linux-cifs@lfdr.de>; Thu,  2 Feb 2023 01:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBBAFv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 1 Feb 2023 19:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAFv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 1 Feb 2023 19:05:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AE646A1
        for <linux-cifs@vger.kernel.org>; Wed,  1 Feb 2023 16:05:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f34so512059lfv.10
        for <linux-cifs@vger.kernel.org>; Wed, 01 Feb 2023 16:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4ayPMBmFEoBPiefQTVC8OlYFhtxrMD/0ygEuAv8+0E=;
        b=M7msfNgSO38QfdgaGa+Ny/0/LcXytKX0S5dccxuXt0KbLpVhxJBu7pjSSxkkgw+wv6
         Ef9tUDWyQrtVWCWt0j32ByQr+HW9U8E0DW2ip3rzjmDG4aX4t4KeL6hFfvSNiTxkMCei
         30PEnhV9eTHjX69dVd6pziCou3+OJPQpNEAAEkP1MVRunER6qYrrppE7qgcZpqkC3Ceh
         ABeGHHPB8AnTvLiz+livLi5+nW7ZfBI0skQ6qXnYFzqZjfhw6MyONueLDI6Cj+/O18lD
         aQorz1qTsHqcLqu3+yyHnDaPqLf+UJD31yGQeVh+inuykgsM2euj+LePUHNVfL/yginK
         R7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4ayPMBmFEoBPiefQTVC8OlYFhtxrMD/0ygEuAv8+0E=;
        b=Cltxce+yN0cCWq7zvQtaj7+xo010wfNuhob0cRBU6zQDsofKstpfDdFkp+bC6JSsPN
         RXcidAvDp9g32LWEgJAiNqfGMDLVe7xqf6RvdxG1XI7bHlZwF0SgHyZtZud7OJBHUwls
         GfPDmPWid3kJRwhty4GoRXUnzPGNEj/QwqE3NGZtxh+1tvYcXWZ33vaC6ByYaj0fQFss
         Yb5aUG38KL3buiPmUzeIhHNTJsvT8mZNj0m89c4iGw6OVzlmxSWTsjtLEFO8PlvhDfJn
         sHoJZvTRodZJqloQvPVVjPGm/z+fVz7HJzybFWaLJxVVwQDJUUXCJnsKp2iRcACjYVEH
         SjYg==
X-Gm-Message-State: AO0yUKXX9w3oAQYKPzqIT2TZZGYvnUaYWDSrYXGFpcqFyu+zj6rDilHX
        jYxt1luTkjX108GByLqrT8NiiRGzQkLoptrh+E33AYsGZjE=
X-Google-Smtp-Source: AK7set9GQbeQZOnBSnEcRnFM0WPXn/Go0fM1g8aeZhbayr7DhSYyl913TeS4uzltQCIic6jLj/LMdQRhRtroT5EwcwU=
X-Received: by 2002:a05:6512:1145:b0:4cb:20b3:e7f4 with SMTP id
 m5-20020a056512114500b004cb20b3e7f4mr770866lfg.194.1675296347273; Wed, 01 Feb
 2023 16:05:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675264648.git.metze@samba.org>
In-Reply-To: <cover.1675264648.git.metze@samba.org>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Feb 2023 18:05:36 -0600
Message-ID: <CAH2r5mvNh+_ctF2xhOtK3y=eFJkN3T2cnUiA9Sbg+o9536Gx=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] avoid plaintext rdma offload if encryption is required
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Tentatively merged into cifs-2.6.git for-next pending review and testing

On Wed, Feb 1, 2023 at 9:21 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> I think it is a security problem to send confidential data in plaintext
> over the wire, so we should avoid doing that even if rdma is in use.
>
> We already have a similar check to prevent data integrity problems
> for rdma offload.
>
> Modern Windows servers support signed and encrypted rdma offload,
> but we don't support this yet...
>
> Changes v2:
> - Added missing Cc: list on commit 2/3
>
> Stefan Metzmacher (3):
>   cifs: introduce cifs_io_parms in smb2_async_writev()
>   cifs: split out smb3_use_rdma_offload() helper
>   cifs: don't try to use rdma offload on encrypted connections
>
>  fs/cifs/smb2pdu.c | 89 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 70 insertions(+), 19 deletions(-)
>
> --
> 2.34.1
>


-- 
Thanks,

Steve
