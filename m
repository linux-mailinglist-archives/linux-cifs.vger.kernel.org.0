Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19CE9E558
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2019 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfH0KG4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 27 Aug 2019 06:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfH0KG4 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 27 Aug 2019 06:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2CE6AE91;
        Tue, 27 Aug 2019 10:06:54 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: Re: [PATCH] cifs: replace various strncpy with memcpy and similar
In-Reply-To: <20190826233014.11539-1-lsahlber@redhat.com>
References: <20190826233014.11539-1-lsahlber@redhat.com>
Date:   Tue, 27 Aug 2019 12:06:53 +0200
Message-ID: <87woeyly6a.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
