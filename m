Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925531ECB09
	for <lists+linux-cifs@lfdr.de>; Wed,  3 Jun 2020 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCIHs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 3 Jun 2020 04:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIHr (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 3 Jun 2020 04:07:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77BC7AD5E;
        Wed,  3 Jun 2020 08:07:49 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH][SMB3] default to minimum of two channels when multichannel specified
In-Reply-To: <CAH2r5msvShbNa-X5-ZH-H66W2Kc_sZ3g+XDwns2_zR3P9ZCMtg@mail.gmail.com>
References: <CAH2r5msvShbNa-X5-ZH-H66W2Kc_sZ3g+XDwns2_zR3P9ZCMtg@mail.gmail.com>
Date:   Wed, 03 Jun 2020 10:07:45 +0200
Message-ID: <874krsk1wu.fsf@suse.com>
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
