Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE71A6439BE
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Dec 2022 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiLFABO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 5 Dec 2022 19:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLFABN (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 5 Dec 2022 19:01:13 -0500
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 16:01:12 PST
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E399EF029
        for <linux-cifs@vger.kernel.org>; Mon,  5 Dec 2022 16:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670283944; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M7uP12WajbP+jO5MSBT8kI3uQueg94eE4KGafD+V0CnvtDKCtGjUlbQ+F+VzxjLzEuEa1b7h6NHMAkVxEICfs/e1RAeyXcBYG5E3gIzfprLBHQf1c/lnEyzydTKmisvYMe1DnrY9KnAUDXq9bAxvtytzUitWnJtf2t2g7abzN7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670283944; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=AGiFRxdZLW6juIrUoq64NLI4cQyBdJI/u7NhEzTeBC4=; 
        b=njUaLxzb8NCptfjO4oa6qHjUSM/6E3yHCD3hSQ7fV42PbeuDQPfMgpkFUe24jOIUjIRA5nIC5uI1x1EmBHVAeBpSuEmTng1XdrML6Mow8qEnZcGq7tI5WYR0S0ySuDa3bGpdjXLr9Ma6Yg6zhFLADEgy2ttrkSbh66kfsmKgVb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1670283942325782.359895905616; Mon, 5 Dec 2022 15:45:42 -0800 (PST)
Date:   Mon, 05 Dec 2022 15:45:42 -0800
From:   Elijah Conners <business@elijahpepe.com>
To:     "samba-technical" <samba-technical@lists.samba.org>,
        "linux-cifs" <linux-cifs@vger.kernel.org>
Cc:     "lsahlber" <lsahlber@redhat.com>, "sfrench" <sfrench@samba.org>,
        "pc" <pc@cjr.nz>, "sprasad" <sprasad@microsoft.com>,
        "tom" <tom@talpey.com>
Message-ID: <184e4ae599e.dafedd623365931.2204914765704117230@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] cifs: add ipv6 parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

CIFS currently lacks IPv6 parsing, presenting complications for CIFS
over IPv6.

To parse both IPv4 and IPv6 addresses, the parse_srvaddr() function
was altered; parse_srvaddr() now returns void. To retrieve the IP
address from parse_srvaddr(), the parameters *out6 and *out32, an
in6_addr and a __be32 respectively, are provided. The value of
root_server_addr is determined by if those parameters are set or not.

The parsing in parse_srvaddr() was updated slightly. The character addr
can hold up to 46 characters, the longest a possible IPv6 address can
be. In the while loop, isdigit() has been replaced with isxdigit() to
account for letters present in IPv6 addresses, and *start is also
checked for being a colon. Finally, the function uses inet_pton() to
determine if the address is an IPv6 address; if so, *out6 is equal to
in6, set by inet_pton, otherwise, *out32 is set to in_aton(addr).

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 fs/cifs/cifsroot.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifsroot.c b/fs/cifs/cifsroot.c
index 9e91a5a40aae..f0aba7c824dc 100644
--- a/fs/cifs/cifsroot.c
+++ b/fs/cifs/cifsroot.c
@@ -14,6 +14,7 @@
 #include <linux/in.h>
 #include <linux/inet.h>
 #include <net/ipconfig.h>
+#include <arpa/inet.h>
 
 #define DEFAULT_MNT_OPTS \
 	"vers=1.0,cifsacl,mfsymlinks,rsize=1048576,wsize=65536,uid=0,gid=0," \
@@ -22,19 +23,24 @@
 static char root_dev[2048] __initdata = "";
 static char root_opts[1024] __initdata = DEFAULT_MNT_OPTS;
 
-static __be32 __init parse_srvaddr(char *start, char *end)
-{
-	/* TODO: ipv6 support */
-	char addr[sizeof("aaa.bbb.ccc.ddd")];
+static void __init parse_srvaddr(char *start, char *end, struct in6_addr *out6, __be32 *out32)
+{
+	char addr[INET6_ADDRSTRLEN];
+	struct in6_addr in6;
 	int i = 0;
 
 	while (start < end && i < sizeof(addr) - 1) {
-		if (isdigit(*start) || *start == '.')
+		if (isxdigit(*start) || *start == '.' || *start == ':')
			addr[i++] = *start;
 		start++;
 	}
 	addr[i] = '\0';
-	return in_aton(addr);
+
+ if (inet_pton(AF_INET6, addr, &in6) > 0) {
+ 	*out6 = in6;
+ } else {
+ 	*out32 = in_aton(addr);
+ }
 }
 
 /* cifsroot=//<server-ip>/<share>[,options] */
@@ -42,7 +48,8 @@ static int __init cifs_root_setup(char *line)
 {
 	char *s;
 	int len;
-	__be32 srvaddr = htonl(INADDR_NONE);
+	struct in6_addr addr6;
+	__be32 addr32;
 
 	ROOT_DEV = Root_CIFS;
 
@@ -60,7 +67,7 @@ static int __init cifs_root_setup(char *line)
 			return 1;
 		}
 		strlcpy(root_dev, line, len);
-		srvaddr = parse_srvaddr(&line[2], s);
+		parse_srvaddr(&line[2], s, &addr6, &addr32);
 		if (*s) {
 			int n = snprintf(root_opts,
 					 sizeof(root_opts), "%s,%s",
@@ -73,7 +80,11 @@ static int __init cifs_root_setup(char *line)
 		}
 	}
 
-	root_server_addr = srvaddr;
+	if (addr6.is_set) {
+		root_server_addr = addr6;
+	} else if (addr32.is_set) {
+		root_server_addr = addr32;
+	}
 
 	return 1;
 }
-- 
2.29.2.windows.2


