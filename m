Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEB108D19
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Nov 2019 12:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKYLhc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 25 Nov 2019 06:37:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbfKYLhb (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 25 Nov 2019 06:37:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5DC0AAC2;
        Mon, 25 Nov 2019 11:37:30 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     "Paulo Alcantara \(SUSE\)" <pc@cjr.nz>, smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara \(SUSE\)" <pc@cjr.nz>
Subject: Re: [PATCH 2/7] cifs: Fix lookup of root ses in DFS referral cache
In-Reply-To: <20191122153057.6608-3-pc@cjr.nz>
References: <20191122153057.6608-1-pc@cjr.nz> <20191122153057.6608-3-pc@cjr.nz>
Date:   Mon, 25 Nov 2019 12:37:29 +0100
Message-ID: <87imn8w5ja.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

"Paulo Alcantara (SUSE)" <pc@cjr.nz> writes:
> We don't care about module aliasing validation in
> cifs_compose_mount_options(..., is_smb3) when finding the root SMB
> session of an DFS namespace in order to refresh DFS referral cache.

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
