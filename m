Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF761EE954
	for <lists+linux-cifs@lfdr.de>; Thu,  4 Jun 2020 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgFDRVq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Thu, 4 Jun 2020 13:21:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbgFDRVo (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 4 Jun 2020 13:21:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9576AC24;
        Thu,  4 Jun 2020 17:21:45 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Kenneth D'souza <kdsouza@redhat.com>, linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, kdsouza@redhat.com, rbergant@redhat.com
Subject: Re: [PATCH v2] cifs: dump Security Type info in DebugData
In-Reply-To: <20200604154441.23822-1-kdsouza@redhat.com>
References: <20200604154441.23822-1-kdsouza@redhat.com>
Date:   Thu, 04 Jun 2020 19:21:40 +0200
Message-ID: <878sh2iw63.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Kenneth D'souza <kdsouza@redhat.com> writes:
> Currently the end user is unaware with what sec type the
> cifs share is mounted if no sec=<type> option is parsed.
> With this patch one can easily check from DebugData.

LGTM but I would move the security_types next to the enum definition in
cifsglob.h somehow, so that it will be harder to forget to update one if
the other changes.

Since it is in a header, maybe via an inline func with a
switch... simple but more verbose. Or X-macros [1] magic (might be
overkill).

1: https://www.geeksforgeeks.org/x-macros-in-c/

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
