Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8DE4069
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Oct 2019 01:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfJXXvf (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 24 Oct 2019 19:51:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32132 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbfJXXvf (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 24 Oct 2019 19:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571961094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RzNQNuxYFicXZBHZkOw/AmjnjFAblFj9qz0PySuZpGQ=;
        b=YhgFp5kyz+DSXVB4Hz4iwXflhGwozpY3k21DWQfyECM9kUsP2ZRDkkIZYzUgedzHR1QCsr
        imUDZl2Sd2bMpTBv9xN4mJHnk2cYh3iIHUILSWPxhhR3MRwT2aUEzViwOdiLkTPdN4iBcg
        vFiqVz0P+6Cdv6vXehcA2+zjKL03Rh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-NGrIvZwGPIaXjMxiAj7Pag-1; Thu, 24 Oct 2019 19:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA2A1800D6B
        for <linux-cifs@vger.kernel.org>; Thu, 24 Oct 2019 23:51:31 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-48.bne.redhat.com [10.64.54.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99EA6450A
        for <linux-cifs@vger.kernel.org>; Thu, 24 Oct 2019 23:51:30 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: Updated patch for the the lock_sem deadlock
Date:   Fri, 25 Oct 2019 09:51:19 +1000
Message-Id: <20191024235120.8059-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NGrIvZwGPIaXjMxiAj7Pag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve, Pavel, Dave

This is a small update to Dave's patch to address Pavels recommendation
that we use a helper function for the trylock/sleep loop.

