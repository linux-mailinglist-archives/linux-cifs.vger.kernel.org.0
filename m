Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E141A7F80
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Apr 2020 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbgDNOU0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 Apr 2020 10:20:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49162 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389708AbgDNOUW (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 14 Apr 2020 10:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NYWOZo6GSM1gl5Dpdc7Qc14rRCkPfmWgzyLfnqiKprc=;
        b=BnfJ/DtfIeeqI8s7n4VHOK8Agoyvguo9NoQfwQcB8bdhA3ZScLTCJRmDQ9rLVJWCb2yA/Y
        tCVwiEc641VQx024ULI5NKaElEoSU5LqtCqabb/nYTwRFncYIMcNjdCqZvyze9ygg7W8T8
        PhHKuN+f4+EiMltlgGgsQcm2K5K3EL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-95ZOvXX8MsyxzBYsrtgbiQ-1; Tue, 14 Apr 2020 10:20:14 -0400
X-MC-Unique: 95ZOvXX8MsyxzBYsrtgbiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FA47801A12;
        Tue, 14 Apr 2020 14:20:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B89C260BE1;
        Tue, 14 Apr 2020 14:20:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org
cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        fweimer@redhat.com
Subject: What's a good default TTL for DNS keys in the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3865907.1586874010.1@warthog.procyon.org.uk>
Date:   Tue, 14 Apr 2020 15:20:10 +0100
Message-ID: <3865908.1586874010@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Since key.dns_resolver isn't given a TTL for the address information obtained
for getaddrinfo(), no expiry is set on dns_resolver keys in the kernel for
NFS, CIFS or Ceph.  AFS gets one if it looks up a cell SRV or AFSDB record
because that is looked up in the DNS directly, but it doesn't look up A or
AAAA records, so doesn't get an expiry for the addresses themselves.

I've previously asked the libc folks if there's a way to get this information
exposed in struct addrinfo, but I don't think that ended up going anywhere -
and, in any case, would take a few years to work through the system.

For the moment, I think I should put a default on any dns_resolver keys and
have it applied either by the kernel (configurable with a /proc/sys/ setting)
or by the key.dnf_resolver program (configurable with an /etc file).

Any suggestion as to the preferred default TTL?  10 minutes?

David

