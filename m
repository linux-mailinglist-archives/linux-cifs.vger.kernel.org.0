Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11E8FEA9
	for <lists+linux-cifs@lfdr.de>; Fri, 16 Aug 2019 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfHPJHU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 16 Aug 2019 05:07:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:53100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbfHPJHT (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 16 Aug 2019 05:07:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF141B64C;
        Fri, 16 Aug 2019 09:07:18 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:07:18 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: FSCTL_QUERY_ALLOCATED_RANGES issue with Windows2016
Message-ID: <20190816110718.385074fb@suse.de>
In-Reply-To: <CAN05THThHLkSF=oVBezJQBsre7QoH6eS=SLbxo3Z=w8M+fa=RQ@mail.gmail.com>
References: <CAN05THT0OkbAoNu8ZVSHF-xY7w0ZW4q4i-jTxjNManrnz0OMfg@mail.gmail.com>
        <20190815174854.05661672@suse.de>
        <CAN05THThHLkSF=oVBezJQBsre7QoH6eS=SLbxo3Z=w8M+fa=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, 16 Aug 2019 12:07:28 +1000, ronnie sahlberg wrote:

> I am happy to mail you the wireshark traces for this. Can I do that?
> Just so you can look at them and confirm I am not crazy :-)
> I cant send them to the list because they are 5Mb each and it is rude
> to send such big attachments to a mailinglist.

Sure, go for it. btw, you could also put them up at
https://www.samba.org/~sahlberg/

Cheers, David
