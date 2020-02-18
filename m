Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84C51625BD
	for <lists+linux-cifs@lfdr.de>; Tue, 18 Feb 2020 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRLr1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 18 Feb 2020 06:47:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:60542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgBRLr0 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 18 Feb 2020 06:47:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BDBFAD08;
        Tue, 18 Feb 2020 11:47:25 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH] cifs: don't leak -EAGAIN for stat() during reconnect
In-Reply-To: <20200218044829.15629-1-lsahlber@redhat.com>
References: <20200218044829.15629-1-lsahlber@redhat.com>
Date:   Tue, 18 Feb 2020 12:47:24 +0100
Message-ID: <878sl0azhv.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Ronnie,

Ronnie Sahlberg <lsahlber@redhat.com> writes:
> Fix this by re-trying the operation from within cifs_revalidate_dentry_attr()
> if cifs_get_inode_info*() returns -EAGAIN.

Would it make sense to use is_retryable_error() instead of checking for
just EAGAIN? It also checks for interruption errors.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
