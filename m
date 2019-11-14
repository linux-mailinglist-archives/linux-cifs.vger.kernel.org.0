Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E01FC01F
	for <lists+linux-cifs@lfdr.de>; Thu, 14 Nov 2019 07:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfKNGQ7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 14 Nov 2019 01:16:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfKNGQ7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 14 Nov 2019 01:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573712218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRm5vJVeG6xuzO6X2C1D7bCmSL5NkYafWYfuCH/HrKI=;
        b=NBn1RMv9LRzQEzxlHQ2RRRJI83e8cc11v2FootNk4wyuOfXcjgTxV6p3TagGn4e63sFsBt
        5qYTbMOSyKUhlNoVTqeVY7jTN9fT+92u5xPZY3yInBLbRx3arpFiptlqHTZC05l+geyTGi
        FUrzOEKWuAYacqrEtMGoIe4cmlOXKII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-En-7x3m-OqaGkCuRO0QUew-1; Thu, 14 Nov 2019 01:16:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF5CE1802CE1
        for <linux-cifs@vger.kernel.org>; Thu, 14 Nov 2019 06:16:55 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-39.bne.redhat.com [10.64.54.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65ADF5458E;
        Thu, 14 Nov 2019 06:16:55 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: fix race between compound_send_recv() and the demultiplex thread
Date:   Thu, 14 Nov 2019 16:16:46 +1000
Message-Id: <20191114061646.22122-2-lsahlber@redhat.com>
In-Reply-To: <20191114061646.22122-1-lsahlber@redhat.com>
References: <20191114061646.22122-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: En-7x3m-OqaGkCuRO0QUew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

There is a race where the open() may be interrupted between when we receive=
 the reply
but before we have invoked the callback in which case we never end up calli=
ng
handle_cancelled_mid() and thus leak an open handle on the server.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/connect.c   | 1 -
 fs/cifs/transport.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index ccaa8bad336f..802604a7e692 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1223,7 +1223,6 @@ cifs_demultiplex_thread(void *p)
 =09=09=09if (mids[i] !=3D NULL) {
 =09=09=09=09mids[i]->resp_buf_size =3D server->pdu_size;
 =09=09=09=09if ((mids[i]->mid_flags & MID_WAIT_CANCELLED) &&
-=09=09=09=09    mids[i]->mid_state =3D=3D MID_RESPONSE_RECEIVED &&
 =09=09=09=09    server->ops->handle_cancelled_mid)
 =09=09=09=09=09server->ops->handle_cancelled_mid(
 =09=09=09=09=09=09=09mids[i]->resp_buf,
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index ca3de62688d6..0f219f7653f3 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1119,7 +1119,7 @@ compound_send_recv(const unsigned int xid, struct cif=
s_ses *ses,
 =09=09=09=09 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
 =09=09=09send_cancel(server, &rqst[i], midQ[i]);
 =09=09=09spin_lock(&GlobalMid_Lock);
-=09=09=09if (midQ[i]->mid_state =3D=3D MID_REQUEST_SUBMITTED) {
+=09=09=09if (is_interrupt_error(rc)) {
 =09=09=09=09midQ[i]->mid_flags |=3D MID_WAIT_CANCELLED;
 =09=09=09=09midQ[i]->callback =3D cifs_cancelled_callback;
 =09=09=09=09cancelled_mid[i] =3D true;
--=20
2.13.6

