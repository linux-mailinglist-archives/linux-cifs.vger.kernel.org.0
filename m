Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3ECFBD95
	for <lists+linux-cifs@lfdr.de>; Thu, 14 Nov 2019 02:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfKNBmk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 13 Nov 2019 20:42:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbfKNBmk (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 13 Nov 2019 20:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573695759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rCRmwhofqx9xYZINzCAbA3OLXy1pcBgTY3JbrKGPXZ0=;
        b=MTOTVmayWttOTWKXFiDENDrJYwYwX0HR1ey1P4HcYwqMP5fLYrioq0RnkiicajDiMpOTjW
        A1wB1Td4qnyXKKTRDZTyQgqS+kIzxN2lQQczmkLS5cTELKQ44rE+GvlL+GjhQe327mtOtN
        4pEwxhk0699wvUCWJTtQe9elK3qKuRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-1GX0I788Mtq1IyvZkAw0gA-1; Wed, 13 Nov 2019 20:42:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C801005500
        for <linux-cifs@vger.kernel.org>; Thu, 14 Nov 2019 01:42:37 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-39.bne.redhat.com [10.64.54.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE29560BFB
        for <linux-cifs@vger.kernel.org>; Thu, 14 Nov 2019 01:42:36 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: [PATCH 0/1] cifs: fix race between compound_send_recv() and the demultiplex thread
Date:   Thu, 14 Nov 2019 11:42:25 +1000
Message-Id: <20191114014226.26461-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1GX0I788Mtq1IyvZkAw0gA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

List, Pavel

Here is a small patch that fixes another race where we leak a handle on an =
interrupted open()
Please review.

