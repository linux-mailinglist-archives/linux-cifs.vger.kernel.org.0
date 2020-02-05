Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8842915297A
	for <lists+linux-cifs@lfdr.de>; Wed,  5 Feb 2020 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBEK4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 5 Feb 2020 05:56:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgBEK4C (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 5 Feb 2020 05:56:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0F3FAE8A;
        Wed,  5 Feb 2020 10:56:00 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: Re: [SMB3][PATCH] Fix oops in cifs_create_options()
In-Reply-To: <CAH2r5mtu69KEWU94qZK32H_8cvyhVU8GyOKrZqbdjH0ZLd95Zg@mail.gmail.com>
References: <CAH2r5mtu69KEWU94qZK32H_8cvyhVU8GyOKrZqbdjH0ZLd95Zg@mail.gmail.com>
Date:   Wed, 05 Feb 2020 11:55:56 +0100
Message-ID: <878slhti9v.fsf@suse.com>
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
