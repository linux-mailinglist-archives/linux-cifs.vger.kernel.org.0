Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0450021A273
	for <lists+linux-cifs@lfdr.de>; Thu,  9 Jul 2020 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGIOt1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Thu, 9 Jul 2020 10:49:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:43584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgGIOtZ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 9 Jul 2020 10:49:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA5A8AD26;
        Thu,  9 Jul 2020 14:49:23 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Paulo Alcantara <pc@cjr.nz>, linux-cifs@vger.kernel.org,
        smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: Re: [PATCH v2 7/7] cifs: document and cleanup dfs mount
In-Reply-To: <20200706181609.19480-8-pc@cjr.nz>
References: <20200706181609.19480-1-pc@cjr.nz>
 <20200706181609.19480-8-pc@cjr.nz>
Date:   Thu, 09 Jul 2020 16:49:20 +0200
Message-ID: <87h7ug68wf.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Paulo Alcantara <pc@cjr.nz> writes:
> +	/* Store DFS full path in both superblock and tree connect structures.

line with /* should be empty

> +	 *
> +	 * For DFS root mounts, the prefix path (cifs_sb->prepath) is preversed during reconnect so
                                                                     ^^^^^^^^^^
                                                                      preserved

> +	 * only the root path is set in cifs_sb->origin_fullpath and tcon->dfs_path. And for DFS
> +	 * links, the prefix path is included in both and may be changed during reconnect.  See
> +	 * cifs_tree_connect().
> +	 */
> +	cifs_sb->origin_fullpath = kstrndup(full_path, strlen(full_path), GFP_KERNEL);



-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
