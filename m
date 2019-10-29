Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002A2E7ECC
	for <lists+linux-cifs@lfdr.de>; Tue, 29 Oct 2019 04:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJ2DOE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 28 Oct 2019 23:14:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727936AbfJ2DOE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 28 Oct 2019 23:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572318843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4vxv3ZdxUERDmH8ch9tMI7weHdL5/lykh7TVSMkPkOY=;
        b=ORmcKnKd6j7PoTNoggWd5PSAci8E/t4x8+8eWzkdFdirtffSQnF5SkizZxupJsvjw36Wrg
        OPbka4Ui/e/eGsCyb2+22Mb8YRQaTeCbnMfmIHoMokvh6sqwokl1g1my4ek9tSRKjiMHNy
        tooo8yMJTlOIeALFMM9pGnqMlNkBLoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-1lHOq7nVP8O4bK8u8vv8UA-1; Mon, 28 Oct 2019 23:14:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A4D107AD28
        for <linux-cifs@vger.kernel.org>; Tue, 29 Oct 2019 03:14:01 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-48.bne.redhat.com [10.64.54.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E38976085E
        for <linux-cifs@vger.kernel.org>; Tue, 29 Oct 2019 03:14:00 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: [PATCH 0/1] cifs: move cifsFileInfo_put logic into a work-queue
Date:   Tue, 29 Oct 2019 13:13:47 +1000
Message-Id: <20191029031348.13357-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1lHOq7nVP8O4bK8u8vv8UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Pavel,

Please see version 2 addressing your review comments.


