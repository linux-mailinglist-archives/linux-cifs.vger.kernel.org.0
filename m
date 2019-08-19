Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4BF9506E
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Aug 2019 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfHSWDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 19 Aug 2019 18:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbfHSWDu (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 19 Aug 2019 18:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4F25B01E;
        Mon, 19 Aug 2019 22:03:49 +0000 (UTC)
Date:   Tue, 20 Aug 2019 00:03:48 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: FSCTL_QUERY_ALLOCATED_RANGES issue with Windows2016
Message-ID: <20190820000348.440ee8ce@suse.de>
In-Reply-To: <20190819183151.15642e8f@suse.de>
References: <CAN05THT0OkbAoNu8ZVSHF-xY7w0ZW4q4i-jTxjNManrnz0OMfg@mail.gmail.com>
        <20190815174854.05661672@suse.de>
        <CAN05THThHLkSF=oVBezJQBsre7QoH6eS=SLbxo3Z=w8M+fa=RQ@mail.gmail.com>
        <CAN05THT3NF+eAd=H+gpmZQp0SWBQ0iFe32TT0VB5_rmibcN2Cw@mail.gmail.com>
        <20190819183151.15642e8f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, 19 Aug 2019 18:31:51 +0200, David Disseldorp wrote:

> Nothing stands out in the captures to me, but I'd be curious whether you
> see any differences in behaviour if you set write-through on open or
> explicitly FLUSH after the SET-SPARSE call.

Hmm actually it looks like there's already a FLUSH shortly after the
mtime update following the SetInfo(EOF). One thing that does look a
little weird is the AllocationSize field before that FLUSH - in
seek_bad.cap.gz it's 2M, whereas it's ~6M in seek_good.cap.gz.

This'd be a good case to use Aurélien's smbcmp utility :)

Cheers, David
