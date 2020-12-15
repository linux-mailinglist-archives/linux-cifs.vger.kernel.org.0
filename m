Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6492DB46E
	for <lists+linux-cifs@lfdr.de>; Tue, 15 Dec 2020 20:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgLOTXo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 15 Dec 2020 14:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731252AbgLOTXe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 15 Dec 2020 14:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608060128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dujc0JpdIEYG0ems7VnWmElR3eg3nF8dJ1NAf7jtxFY=;
        b=OEhUejIs3pY4GiJ5BPJBN6se4iDxUCYrkJZbJZNfBOkVPMxza8Gb6vpRn3EBq08Q9DnnQW
        IELGV/w7ldPs3zaeUTAQOUOtMih5yIAUJ0bHAZGw525UfspalYA6e8LLmYlGvBX0aFocss
        GbmtNep8Gb8J58Zor65elihuCQ2jUwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-zlNP3-zPMJuiQANumgZz2w-1; Tue, 15 Dec 2020 14:22:06 -0500
X-MC-Unique: zlNP3-zPMJuiQANumgZz2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ABB659;
        Tue, 15 Dec 2020 19:22:05 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-107.bne.redhat.com [10.64.54.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3267760C79;
        Tue, 15 Dec 2020 19:22:05 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: fix for rsize/wsize regression in one of the for-next patches
Date:   Wed, 16 Dec 2020 05:21:55 +1000
Message-Id: <20201215192156.15384-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


Steve, 
here is an updated patch for the [brw]size patch in for-next

