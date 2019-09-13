Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF4B1C6E
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Sep 2019 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfIMLe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Fri, 13 Sep 2019 07:34:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:37442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727997AbfIMLe6 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 13 Sep 2019 07:34:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CED2AED5;
        Fri, 13 Sep 2019 11:34:56 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Pavel Shilovsky <piastryyy@gmail.com>
Subject: Re: [PATCH] smb3: fix unmount hang in open_shroot
In-Reply-To: <CAH2r5mtpx88bvKPDZs24ipxH+pm_82ug_w2QPKpB+9Z0xjAYiA@mail.gmail.com>
References: <CAH2r5mtpx88bvKPDZs24ipxH+pm_82ug_w2QPKpB+9Z0xjAYiA@mail.gmail.com>
Date:   Fri, 13 Sep 2019 13:34:42 +0200
Message-ID: <875zlwig4t.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

"Steve French" <smfrench@gmail.com> writes:
> + /*
> + * We do not hold the lock for the open because in case
> + * SMB2_open needs to reconnect, it will end up calling
> + * cifs_mark_open_files_invalid() which takes the lock again
> + * thus causing a deadlock
> + */
> +
> + mutex_unlock(&tcon->crfid.fid_mutex);
> +

Good catch. Since the compounding changes it is SMB2_open_init() that is
triggering the reconnect -> mark_open_files_invalid() code path so it
looks good to me. Might be worth updating the comment to
s/SMB2_open/SMB2_open_init/ before you commit.

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
