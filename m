Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FED296BF4
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Oct 2020 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461333AbgJWJTn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Fri, 23 Oct 2020 05:19:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461317AbgJWJTl (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 23 Oct 2020 05:19:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96FE0ABF4
        for <linux-cifs@vger.kernel.org>; Fri, 23 Oct 2020 09:19:40 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.de>
To:     Samuel Cabrero <scabrero@suse.de>, linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: Re: [PATCH 04/11] cifs: add witness mount option and data structs
In-Reply-To: <20201022181339.30771-5-scabrero@suse.de>
References: <20201022181339.30771-1-scabrero@suse.de>
 <20201022181339.30771-5-scabrero@suse.de>
Date:   Fri, 23 Oct 2020 11:19:40 +0200
Message-ID: <87lffxuwnn.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Samuel Cabrero <scabrero@suse.de> writes:
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 8111d0109a2e..c2bbc444b463 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -637,6 +637,11 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
>  		seq_printf(s, ",multichannel,max_channels=%zu",
>  			   tcon->ses->chan_max);
>  
> +#ifdef CONFIG_CIFS_SWN_UPCALL
> +	if (tcon->use_witness)
> +		seq_puts(s, ",witness");
> +#endif
> +

You should print it in cifs_debug_tcon() and print the KConfig option in
cifs_debug_data_proc_show().

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
