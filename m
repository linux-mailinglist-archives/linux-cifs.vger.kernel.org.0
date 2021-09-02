Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869783FF7F2
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Sep 2021 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbhIBXie (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 2 Sep 2021 19:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235909AbhIBXid (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 2 Sep 2021 19:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630625854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxNjOFjPgPrabhewjF4+wOwlcg4dPQoByEQHGr5NX8U=;
        b=fA7PbgA+sumVz1TcZa9fp3bsvpFmjQzYs0q4npppU3uaTViChNzclnt3VANhiVVjrMCo8A
        re/U/NCPXV3b60YJsf0Icx+A8FTHCJK6nXciQSO4V1nyqIy+SDnjxsbZujYYHh4urI7zVo
        YfWidCWRQHAFx8ZajHYllgz17LZQkJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-mbaGt4gaMcWu9r8zIThLDQ-1; Thu, 02 Sep 2021 19:37:33 -0400
X-MC-Unique: mbaGt4gaMcWu9r8zIThLDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EDBF801ADA;
        Thu,  2 Sep 2021 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7813D5B826;
        Thu,  2 Sep 2021 23:37:31 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 0/3] cifs: create a common smb2pdu.h for client and server
Date:   Fri,  3 Sep 2021 09:37:13 +1000
Message-Id: <20210902233716.1923306-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve,

Here is an initial set of patches that starts moving SMB2 PDU definitions
from the client/server into a shared smb2pd.h file.

It moves the command opcode values into cifs_common, 
it renames cifs smb2_sync_hdr to smb2_hdr to harmonize with ksmbd naming
and it moves the tree connect and disconnect PDU definitions to the shared
file.



