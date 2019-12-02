Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18E10E658
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Dec 2019 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBH3T (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 2 Dec 2019 02:29:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbfLBH3T (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 2 Dec 2019 02:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575271758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q+5P5snDeq0Hxm21oiUs00uYXPbhSqWHGmXunQR3J6o=;
        b=E91rDEnPuIwoO5GlMUGsp1YZ95sPYnvspAq6ptPAwp0wQN6209FybAH6ewfH1Ixpj9XGl8
        rtM/eIkMsoczI68JXp12HeEOSkxdS/qgYXWNzmFxho3IYWUQnJ5fwNuQXVJVGYjWaSwVLP
        Gd4feJukEvP+yn3Pi+ihYo+DhzDYekI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-P3bIdUbuNvuUy9FYz6-09w-1; Mon, 02 Dec 2019 02:29:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE45E10054E3
        for <linux-cifs@vger.kernel.org>; Mon,  2 Dec 2019 07:29:14 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CB4600C8
        for <linux-cifs@vger.kernel.org>; Mon,  2 Dec 2019 07:29:14 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: [PATCH 0/3] WIP start using compounding for readdir()
Date:   Mon,  2 Dec 2019 17:28:57 +1000
Message-Id: <20191202072900.21981-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: P3bIdUbuNvuUy9FYz6-09w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve, All

Please see a WIP for the initial steps of using compounds for readdir()
These patches only combine the initial open and the first query-dir
into a compound.
It cuts the number of roundtrips for small directories from 4 to 3
but can do better.

The patches need more work on how to clean up the handling of the response
vectors  but is an initial WIP for review/comments.

