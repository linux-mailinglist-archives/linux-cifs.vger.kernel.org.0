Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984D42DD095
	for <lists+linux-cifs@lfdr.de>; Thu, 17 Dec 2020 12:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLQLlB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Dec 2020 06:41:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:45242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgLQLlB (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 17 Dec 2020 06:41:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 527A2AC7B;
        Thu, 17 Dec 2020 11:40:20 +0000 (UTC)
Message-ID: <f7dfcf49dbfebeaf49e2f36d8c72e34c74a32fb5.camel@suse.de>
Subject: Re: [PATCH 1/3] cifs: Delete a stray unlock in cifs_swn_reconnect()
From:   Samuel Cabrero <scabrero@suse.de>
Reply-To: scabrero@suse.com
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <sfrench@samba.org>
Cc:     Aurelien Aptel <aaptel@suse.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 17 Dec 2020 12:40:18 +0100
In-Reply-To: <X9s6nGDLt4xreaYN@mwanda>
References: <X9s6nGDLt4xreaYN@mwanda>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, 2020-12-17 at 14:01 +0300, Dan Carpenter wrote:
> The unlock is done in the caller, this is a stray which leads to a
> double unlock bug.
> 

Indeed.

Reviewed-by: Samuel Cabrero <scabrero@suse.de>

-- 
Samuel Cabrero / SUSE Labs Samba Team
GPG: D7D6 E259 F91C F0B3 2E61 1239 3655 6EC9 7051 0856
scabrero@suse.com
scabrero@suse.de

