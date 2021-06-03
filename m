Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80615399A09
	for <lists+linux-cifs@lfdr.de>; Thu,  3 Jun 2021 07:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCFc5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 3 Jun 2021 01:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFCFc5 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 3 Jun 2021 01:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622698272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ESfQI7/UpAR3qAbz2RW1SxlZCSZQqeJlhScqmh3QeB0=;
        b=QfjVd1oECAddf3z/7eudZXQ2rooHeGuWmj5ax7eFQH1+4X8AH87DfLrD/D6+2njhWqpYby
        Uq+1EmBlcTgm/A1IRyIrrBmjGA4BQUpgPFSiC+VJigY/8IyZof1YXkN/MqgFwGL686BYoP
        +XQxITrXS053V2wRVeiA0H8L0ImJ4p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-OLA3R9jTPIaT21tKUtkBBg-1; Thu, 03 Jun 2021 01:31:11 -0400
X-MC-Unique: OLA3R9jTPIaT21tKUtkBBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86068801817;
        Thu,  3 Jun 2021 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-178.bne.redhat.com [10.64.54.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 205BF60BE5;
        Thu,  3 Jun 2021 05:31:09 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: 
Date:   Thu,  3 Jun 2021 15:31:00 +1000
Message-Id: <20210603053101.1229297-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve, list

Resending the final fallocate patch that was not merged from the previous series.
It passes generic/013 for me now when rebased ontop of current for-next



