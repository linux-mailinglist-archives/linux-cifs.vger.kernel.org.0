Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD01D9BF7
	for <lists+linux-cifs@lfdr.de>; Tue, 19 May 2020 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgESQHD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 19 May 2020 12:07:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728953AbgESQHD (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 19 May 2020 12:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589904421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+1wIgatcNw+bs4bC4UVA93HHDhP2YXSs8RVpPtE368=;
        b=c6P3MmymPM42wThTkKOWdNV88ZKCpRxZ9tCG3nvr72but/kZBxT8WStDQ/4JljpUpSOESc
        sBUuyTx0EU89jB3+L6+3ZZOTfrn17Hqe5zt8Ya8QC7u1+Aqi/N4L1VHxs700aTl1i+DQn1
        cZSH3/PMofJXFm3h+RHWxsMTDsw8Gls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-KfD76cAVOHCMJEdCOgDVPQ-1; Tue, 19 May 2020 12:06:57 -0400
X-MC-Unique: KfD76cAVOHCMJEdCOgDVPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350021005510;
        Tue, 19 May 2020 16:06:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7730F5D9C5;
        Tue, 19 May 2020 16:06:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200519141432.GA2949457@erythro.dev.benboeckel.internal>
References: <20200519141432.GA2949457@erythro.dev.benboeckel.internal> <20200518155148.GA2595638@erythro.dev.benboeckel.internal> <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk> <1080378.1589895580@warthog.procyon.org.uk>
To:     me@benboeckel.net, fweimer@redhat.com
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dns: Apply a default TTL to records obtained from getaddrinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1512926.1589904409.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 May 2020 17:06:49 +0100
Message-ID: <1512927.1589904409@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Okay, how about this incremental change, then?  If fixes the typo, only pr=
ints
the "READ CONFIG" line in verbose mode, filters escape chars in the config
file and reduces the expiration time to 5s.

David
---
diff --git a/key.dns_resolver.c b/key.dns_resolver.c
index c241eda3..7a7ec424 100644
--- a/key.dns_resolver.c
+++ b/key.dns_resolver.c
@@ -52,7 +52,7 @@ key_serial_t key;
 static int verbose;
 int debug_mode;
 unsigned mask =3D INET_ALL;
-unsigned int key_expiry =3D 10 * 60;
+unsigned int key_expiry =3D 5;
 =

 =

 /*
@@ -109,7 +109,7 @@ void _error(const char *fmt, ...)
 }
 =

 /*
- * Pring a warning to stderr or the syslog
+ * Print a warning to stderr or the syslog
  */
 void warning(const char *fmt, ...)
 {
@@ -454,7 +454,7 @@ static void read_config(void)
 	unsigned int line =3D 0, u;
 	int n;
 =

-	printf("READ CONFIG %s\n", config_file);
+	info("READ CONFIG %s", config_file);
 =

 	f =3D fopen(config_file, "r");
 	if (!f) {
@@ -514,6 +514,16 @@ static void read_config(void)
 			v =3D p =3D b;
 			while (*b) {
 				if (esc) {
+					switch (*b) {
+					case ' ':
+					case '\t':
+					case '"':
+					case '\'':
+					case '\\':
+						break;
+					default:
+						goto invalid_escape_char;
+					}
 					esc =3D false;
 					*p++ =3D *b++;
 					continue;
@@ -563,6 +573,8 @@ static void read_config(void)
 =

 missing_value:
 	error("%s:%u: %s: Missing value", config_file, line, k);
+invalid_escape_char:
+	error("%s:%u: %s: Invalid char in escape", config_file, line, k);
 post_quote_data:
 	error("%s:%u: %s: Data after closing quote", config_file, line, k);
 bad_value:
diff --git a/man/key.dns_resolver.conf.5 b/man/key.dns_resolver.conf.5
index 03d04049..c944ad55 100644
--- a/man/key.dns_resolver.conf.5
+++ b/man/key.dns_resolver.conf.5
@@ -34,7 +34,7 @@ Available options include:
 The number of seconds to set as the expiration on a cached record.  This =
will
 be overridden if the program manages to retrieve TTL information along wi=
th
 the addresses (if, for example, it accesses the DNS directly).  The defau=
lt is
-600 seconds.  The value must be in the range 1 to INT_MAX.
+5 seconds.  The value must be in the range 1 to INT_MAX.
 .P
 The file can also include comments beginning with a '#' character unless
 otherwise suppressed by being inside a quoted value or being escaped with=
 a

