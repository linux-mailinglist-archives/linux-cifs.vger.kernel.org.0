Return-Path: <linux-cifs+bounces-1379-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DDF86DDE0
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Mar 2024 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B19A1C223DB
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Mar 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356C69D04;
	Fri,  1 Mar 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNjnXFpb"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB36996B
	for <linux-cifs@vger.kernel.org>; Fri,  1 Mar 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284197; cv=none; b=bHEgqeUNXHw4jSpMuLhGuOuuEL0aMtFRPn5xHYbieDv1jAwpAKBh5isf+O6VZjjlDgQNBSHGsC/wohykhR7HGYpkUKuNVoRP4voAvomira7unTnZyEBeq8m3eT9bzua9yQcmcW9AXyJUKzW/nyllKrPBLKc7gpBI/q7isUHsLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284197; c=relaxed/simple;
	bh=PhGNPnWWc1gQGvtAnKJe9lUR4nuRgDa9nbC8r9svJeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY7zMFshqSh3UCMwnqVm54DwavIKJs0Bw9zK0NUgVTip+OSYlUN4g5S+Ox81dM0DePEkRj5zya4mAHzfyNiRWBp4kSgMsL5u4hQTShcLKPej0EoQrrpzMh8+C8OAk0s5uH4sdJUAVT3tlNsQy+M/+v4Ho1cjsilckBxXd/7Hrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNjnXFpb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4417fa396fso263863166b.1
        for <linux-cifs@vger.kernel.org>; Fri, 01 Mar 2024 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709284193; x=1709888993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjDAhbCr6ZXnCnGupv825v6MaCOp5Kenvu1bUCMbMJs=;
        b=SNjnXFpbT4csAVrUci6txFoqGeK0pPvUWit/u8gC0uyCDk8ZiA4+IxIn7368b2Lh2u
         bNcu7EciMRAL40FH8wHojyk+x28DX0PKVsEUYxfYOHSAtvpXRgmYfWy5mO+f8EXj3Bgk
         6wCpSkWqMeGxDdd3es3//37ftRDAI0F49oa3Pk2qh0CeGE7+biLyeWLJt0DZvXLtka4s
         rHu75qkhrHhigj56faVjGLdMx+VBhJzfQEHDXBdLkwTCITsp6NnZVHSJmLNBlI29wOFD
         Oua6DUVuuFsjkUrBpdx4vEDR2oSEOM2/betX+O+KBTygJXXLpjjSCjYWU2zCLwSr74Y3
         +6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284193; x=1709888993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjDAhbCr6ZXnCnGupv825v6MaCOp5Kenvu1bUCMbMJs=;
        b=uM0rXRqzfoMww84nz/mr7aCqSDpnKw1bBwUykTfNAY3qjQCEWQ+MzdNryJJ3ugQWMn
         tt/xC2f4ndVMytEPCMimL3OQovTexYtPNETnXnfkdP0S8H5rU6dTzgozaT24Xnm0vQcF
         p5o1u6+BnJORsXyoG3gz4fw3ehSLCHwG5jzB2iwOu8YNVbL1qNjL20UScnhZkOb7Tmjy
         2MELtoABGNa6MVoeQIsgXSnKGNDWeK4ClRfQX8u0Obohz8S6c7GuBVUDrgSxL86t5vEN
         owOrsBRyy5oLHuHs89uoBd66dex14CHzxuIcZP+pU6wfKG3obgAVZWmmH32pH7VBO4ir
         afdA==
X-Gm-Message-State: AOJu0Yy/XhwRQ3rJ6NFQXusKaj9YeLZiFgi++DQTky1u1zJZd2JXklnx
	/MjpUqVbsDj4PLnhOD1Qbpy79RDf2nWtaGaO1fQHcOAfPmI1F5HoT7uqCpE=
X-Google-Smtp-Source: AGHT+IGjtoPD+pLmyS1+m2QEj2Dma5dfulPdMV1mnZTmju+fNu042hzIxaEirqsiEJKfDi07n2jZoQ==
X-Received: by 2002:a17:906:344b:b0:a44:9ca7:27f0 with SMTP id d11-20020a170906344b00b00a449ca727f0mr508911ejb.23.1709284192920;
        Fri, 01 Mar 2024 01:09:52 -0800 (PST)
Received: from torus.fritz.box ([2a02:810d:b83f:e400:16a0:2f96:e202:fd52])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709063c1100b00a42da3b6518sm1515737ejg.18.2024.03.01.01.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:09:52 -0800 (PST)
From: David Voit <david.voit@gmail.com>
To: linux-cifs@vger.kernel.org
Cc: David Voit <david.voit@gmail.com>
Subject: [PATCH 1/1] Implement CLDAP Ping to find the closest site
Date: Fri,  1 Mar 2024 10:09:21 +0100
Message-ID: <20240301090921.37353-2-david.voit@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301090921.37353-1-david.voit@gmail.com>
References: <20240301090921.37353-1-david.voit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For domain based DFS we always need to contact the domain controllers.
On setups, which are using bigger AD installations you could get random dc on the other side of the world,
if you don't have site support. This can lead to network timeouts and other problems.

Sometimes Microsoft likes to implement crazy and custom ways of doing basic tasks.
Rather than using a weight and priority of DNS to find the closest DC, they all weighted the same.
Instead, they implement their own custom protocol, which uses ASN.1 + UDP (CLDAP) and
custom-DCE encoding including DName compressions without field seperation.
Finally after finding the sitename we now need to do a DNS SRV lookups to find the correct IPs
to our closest site and fill up the remaining IPs from the global list.
---
 Makefile.am    |  15 ++-
 cldap_ping.c   | 331 +++++++++++++++++++++++++++++++++++++++++++++++++
 cldap_ping.h   |   9 ++
 mount.cifs.c   |   5 +-
 resolve_host.c | 270 +++++++++++++++++++++++++++++++++++-----
 resolve_host.h |   6 +-
 6 files changed, 598 insertions(+), 38 deletions(-)
 create mode 100644 cldap_ping.c
 create mode 100644 cldap_ping.h

diff --git a/Makefile.am b/Makefile.am
index a15392d..572d380 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,8 +3,8 @@ ACLOCAL_AMFLAGS = -I aclocal
 
 root_sbindir = $(ROOTSBINDIR)
 root_sbin_PROGRAMS = mount.cifs
-mount_cifs_SOURCES = mount.cifs.c mtab.c resolve_host.c util.c
-mount_cifs_LDADD = $(LIBCAP) $(CAPNG_LDADD) $(RT_LDADD)
+mount_cifs_SOURCES = mount.cifs.c mtab.c $(resolve_hosts_SOURCES) util.c
+mount_cifs_LDADD = $(LIBCAP) $(CAPNG_LDADD) $(RT_LDADD) $(resolve_hosts_LDADD)
 include_HEADERS = cifsidmap.h
 rst_man_pages = mount.cifs.8
 
@@ -28,6 +28,9 @@ bin_PROGRAMS =
 bin_SCRIPTS =
 sbin_PROGRAMS =
 
+resolve_hosts_SOURCES = data_blob.c asn1.c cldap_ping.c resolve_host.c
+resolve_hosts_LDADD = -ltalloc -lresolv
+
 if CONFIG_CIFSUPCALL
 sbin_PROGRAMS += cifs.upcall
 cifs_upcall_SOURCES = cifs.upcall.c data_blob.c asn1.c spnego.c
@@ -43,8 +46,8 @@ endif
 
 if CONFIG_CIFSCREDS
 bin_PROGRAMS += cifscreds
-cifscreds_SOURCES = cifscreds.c cifskey.c resolve_host.c util.c
-cifscreds_LDADD = -lkeyutils
+cifscreds_SOURCES = cifscreds.c cifskey.c $(resolve_hosts_SOURCES) util.c
+cifscreds_LDADD = -lkeyutils $(resolve_hosts_LDADD)
 
 rst_man_pages += cifscreds.1
 
@@ -105,8 +108,8 @@ endif
 if CONFIG_PAM
 pam_PROGRAMS = pam_cifscreds.so
 rst_man_pages += pam_cifscreds.8
-pam_cifscreds.so: pam_cifscreds.c cifskey.c resolve_host.c util.c
-	$(CC) $(DEFS) $(CFLAGS) $(AM_CFLAGS) $(LDFLAGS) -shared -fpic -o $@ $+ -lpam -lkeyutils
+pam_cifscreds.so: pam_cifscreds.c cifskey.c $(resolve_hosts_SOURCES) util.c
+	$(CC) $(DEFS) $(CFLAGS) $(AM_CFLAGS) $(LDFLAGS) -shared -fpic -o $@ $+ -lpam -lkeyutils $(resolve_hosts_LDADD)
 
 endif
 
diff --git a/cldap_ping.c b/cldap_ping.c
new file mode 100644
index 0000000..e259663
--- /dev/null
+++ b/cldap_ping.c
@@ -0,0 +1,331 @@
+/*
+ * CLDAP Ping to find closest ClientSiteName
+ *
+ * Copyright (C) 2024 David Voit (david.voit@gmail.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+#define _GNU_SOURCE
+#include <talloc.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <resolv.h>
+#include "data_blob.h"
+#include "asn1.h"
+
+#define LDAP_DNS_DOMAIN "DnsDomain"
+#define LDAP_DNS_DOMAIN_LEN strlen(LDAP_DNS_DOMAIN)
+#define LDAP_NT_VERSION "NtVer"
+#define LDAP_NT_VERSION_LEN strlen(LDAP_NT_VERSION)
+#define LDAP_ATTRIBUTE_NETLOGON "NetLogon"
+#define LDAP_ATTRIBUTE_NETLOGON_LEN strlen(LDAP_ATTRIBUTE_NETLOGON)
+
+#define NETLOGON_STR_AND_ASN1_SET "NetLogon\x31"
+#define NETLOGON_STR_AND_ASN1_SET_LEN strlen(NETLOGON_STR_AND_ASN1_SET)
+
+// Parse a ASN.1 BER tag size-field, returns start of payload of tag
+char *parse_ber_size(char *buf, size_t *tag_size) {
+	size_t size = *buf & 0xff;
+	char *ret = (buf + 1);
+	if (size >= 0x81) {
+		switch (size) {
+			case 0x81:
+				size = *ret & 0xff;
+				ret += 1;
+				break;
+			case 0x82:
+				size = (*ret << 8) | (*(ret + 1) & 0xff);
+				ret += 2;
+				break;
+			case 0x83:
+				size = (*ret << 16) | (*(ret + 1) << 8) | (*(ret + 2) & 0xff);
+				ret += 3;
+				break;
+			case 0x84:
+				size = (*ret << 24) | (*(ret + 1) << 16) | (*(ret + 2) << 8) | (*(ret + 3) & 0xff);
+				ret += 4;
+				break;
+			default:
+				return NULL;
+		}
+	}
+
+	*tag_size = size;
+	return ret;
+}
+
+// this is similar to dn_expand, but also returns the offset to the next compressed section
+int read_dns_string(char *buf, size_t buf_size, char *dest, size_t dest_size, size_t *offset) {
+	if (*offset > buf_size)
+		return -1;
+	char *pdest = dest;
+	size_t o = *offset;
+	size_t max_offset = o;
+	size_t length = (size_t)buf[o];
+	char *position = buf + o + 1;
+	int loop_detection = 0;
+
+	while (length != 0) {
+		// endless loop detection and overflow check
+		if (loop_detection > 255 || (size_t)(position - buf) >= buf_size)
+			return -1;
+
+		if ((length & 0xc0) != 0) {
+			// DNS text compression
+			size_t old_offset = o;
+			o = ((length & 0x3F) << 8) | *position;
+
+			if (o > old_offset) {
+				// we only allow jumping back not forward
+				return -1;
+			}
+
+			position = buf + o;
+			length = (size_t)*position;
+			position++;
+			max_offset = MAX(max_offset, old_offset + 1);
+		} else {
+			// Do we have bytes left in dest?
+			if (length + 1 > (dest_size - (pdest - dest))) {
+				return -1;
+			}
+			memcpy(pdest, position, length);
+			pdest = pdest + length;
+			*pdest = '.';
+			pdest++;
+			o = o + 1 + length;
+			max_offset = MAX(max_offset, o);
+			position = buf + o;
+			length = (size_t)*position;
+			position++;
+		}
+
+		loop_detection++;
+	}
+
+	// No data to return
+	if (max_offset == *offset) {
+		*offset = *offset + 1;
+		*dest = '\0';
+		return 0;
+	}
+
+	*(pdest - 1) = '\0';
+	*offset = max_offset + 1;
+
+	return 0;
+}
+
+// LDAP request for: (&(DnsDomain=DOMAIN_HERE)(NtVer=\\06\\00\\00\\00))
+ASN1_DATA *generate_cldap_query(char *domain) {
+	ASN1_DATA *data;
+	TALLOC_CTX *mem_ctx = talloc_init("cldap");
+
+	data = asn1_init(mem_ctx);
+	asn1_push_tag(data, ASN1_SEQUENCE(0));
+
+	// Message id
+	asn1_push_tag(data, ASN1_INTEGER);
+	asn1_write_uint8(data, 1);
+	asn1_pop_tag(data);
+
+	// SearchRequest
+	asn1_push_tag(data, ASN1_APPLICATION(3));
+
+	// empty baseObject
+	asn1_push_tag(data, ASN1_OCTET_STRING);
+	asn1_pop_tag(data);
+
+	// scope 0 = baseObject
+	asn1_push_tag(data, ASN1_ENUMERATED);
+	asn1_write_uint8(data, 0);
+	asn1_pop_tag(data);
+
+	// derefAliasses 0=neverDerefAlias
+	asn1_push_tag(data, ASN1_ENUMERATED);
+	asn1_write_uint8(data, 0);
+	asn1_pop_tag(data);
+
+	// sizeLimit
+	asn1_push_tag(data, ASN1_INTEGER);
+	asn1_write_uint8(data, 0);
+	asn1_pop_tag(data);
+
+	// timeLimit
+	asn1_push_tag(data, ASN1_INTEGER);
+	asn1_write_uint8(data, 0);
+	asn1_pop_tag(data);
+
+	// typesOnly
+	asn1_push_tag(data, ASN1_BOOLEAN);
+	asn1_write_uint8(data, 0);
+	asn1_pop_tag(data);
+
+	// AND
+	asn1_push_tag(data, ASN1_CONTEXT(0));
+	// equalityMatch
+	asn1_push_tag(data, ASN1_CONTEXT(3));
+	asn1_write_OctetString(data, LDAP_DNS_DOMAIN, LDAP_DNS_DOMAIN_LEN);
+	asn1_write_OctetString(data, domain, strlen(domain));
+	asn1_pop_tag(data);
+
+	// equalityMatch
+	asn1_push_tag(data, ASN1_CONTEXT(3));
+	asn1_write_OctetString(data, LDAP_NT_VERSION, LDAP_NT_VERSION_LEN);
+	// Bitmask NETLOGON_NT_VERSION_5 & NETLOGON_NT_VERSION_5EX -> To get NETLOGON_SAM_LOGON_RESPONSE_EX as response
+	asn1_write_OctetString(data, "\x06\x00\x00\x00", 4);
+	asn1_pop_tag(data);
+
+	// End AND
+	asn1_pop_tag(data);
+
+	asn1_push_tag(data, ASN1_SEQUENCE(0));
+	asn1_write_OctetString(data, LDAP_ATTRIBUTE_NETLOGON, LDAP_ATTRIBUTE_NETLOGON_LEN);
+	asn1_pop_tag(data);
+
+	// End SearchRequest
+	asn1_pop_tag(data);
+	// End Sequence
+	asn1_pop_tag(data);
+
+	return data;
+}
+
+// Input is a cldap response, output is a pointer to the NETLOGON_SAM_LOGON_RESPONSE_EX payload
+ssize_t extract_netlogon_section(char *buffer, size_t buffer_size, char **netlogon_payload) {
+	size_t ber_size;
+	size_t netlogon_payload_size;
+	// Not enough space to read initial sequence - not an correct cldap response
+	if (buffer_size < 7) {
+		return -1;
+	}
+
+	// Sequence tag
+	if (*buffer != 0x30) {
+		return -1;
+	}
+
+	parse_ber_size(buffer + 1, &ber_size);
+
+	if (ber_size > buffer_size) {
+		return -1;
+	}
+
+	// This is not a full ldap response parser, we are searching for the Octect String 'NetLogon'
+	// follow by the 'SET' (0x31) Tag
+	char *start_of_attributes =
+			memmem(buffer, buffer_size, NETLOGON_STR_AND_ASN1_SET,
+				   NETLOGON_STR_AND_ASN1_SET_LEN);
+
+	if (start_of_attributes == NULL) {
+		return -1;
+	}
+
+	char *start_of_data = parse_ber_size(start_of_attributes + NETLOGON_STR_AND_ASN1_SET_LEN, &ber_size);
+	if (start_of_data == NULL) {
+		return -1;
+	}
+
+	// octat-string of NetLogon data
+	if (*start_of_data != '\x04') {
+		return -1;
+	}
+
+	*netlogon_payload = parse_ber_size(start_of_data + 1, &netlogon_payload_size);
+
+	if (*netlogon_payload == NULL) {
+		*netlogon_payload = NULL;
+		return -1;
+	}
+
+	return (ssize_t)netlogon_payload_size;
+}
+
+int netlogon_get_client_site(char *netlogon_response, size_t netlogon_size, char *sitename) {
+	int rc;
+	// NETLOGON_SAM_LOGON_RESPONSE_EX Opcode: 0x17
+	if (*netlogon_response != 0x17 || *(netlogon_response + 1) != 0x00) {
+		return -1;
+	}
+
+	// skip over sbz, ds_flags and domain_guid
+	// and start directly at Variable string portion of NETLOGON_SAM_LOGON_RESPONSE_EX
+	size_t offset = 24;
+
+	for (int i=0; i < 8; i++) {
+		// iterate over DnsForestName, DnsDomainName, NetbiosDomainName, NetbiosComputerName, UserName, DcSiteName
+		// to finally get to our desired ClientSiteName field
+		rc = read_dns_string(netlogon_response, netlogon_size, sitename, MAXCDNAME, &offset);
+		if (rc < 0) {
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+// returns -1 of fatal errors, and -2 on network errors
+// if we get one of those retry do the cldap ping again on a another dc
+// site_name must be of MAXCDNAME size!
+int cldap_ping(char *domain, struct sockaddr **addr, char *site_name) {
+	char buffer[8196];
+	ssize_t response_size;
+	char *netlogon_response;
+	ssize_t netlogon_size;
+
+	ASN1_DATA *data = generate_cldap_query(domain);
+
+	int sock = socket((*addr)->sa_family, SOCK_DGRAM, 0);
+
+	if (sock < 0) {
+		return -1;
+	}
+
+	struct timeval timeout = {.tv_sec = 2, .tv_usec = 0};
+	if (setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(timeout)) < 0) {
+		return -1;
+	}
+	if (setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) < 0) {
+		return -1;
+	}
+
+	size_t addr_size = (*addr)->sa_family == AF_INET6 ? sizeof(struct sockaddr_in6) : sizeof(struct sockaddr_in);
+
+	if (sendto(sock, data->data, data->length, 0, *addr, addr_size) < 0) {
+		close(sock);
+		return -2;
+	}
+
+	asn1_free(data);
+
+	response_size = recv(sock, buffer, sizeof(buffer), 0);
+	close(sock);
+
+	if (response_size < 0) {
+		return -2;
+	}
+
+	netlogon_size = extract_netlogon_section(buffer, response_size, &netlogon_response);
+	if (netlogon_size < 0) {
+		return -1;
+	}
+
+	return netlogon_get_client_site(netlogon_response, netlogon_size, site_name);
+}
+
diff --git a/cldap_ping.h b/cldap_ping.h
new file mode 100644
index 0000000..e48ad0e
--- /dev/null
+++ b/cldap_ping.h
@@ -0,0 +1,9 @@
+#ifndef _CLDAP_PING_H_
+#define _CLDAP_PING_H_
+
+// returns -1 of fatal errors, and -2 on network errors
+// if we get one of those retry do the cldap ping again on a another dc
+// site_name must be of MAXCDNAME size!
+int cldap_ping(char *domain, struct sockaddr **addr, char *site_name);
+
+#endif /* _CLDAP_PING_H_ */
diff --git a/mount.cifs.c b/mount.cifs.c
index 2278995..3b7a6b3 100644
--- a/mount.cifs.c
+++ b/mount.cifs.c
@@ -1889,8 +1889,11 @@ assemble_mountinfo(struct parsed_mount_info *parsed_info,
 	if (rc)
 		goto assemble_exit;
 
-	if (parsed_info->addrlist[0] == '\0')
+	if (parsed_info->addrlist[0] == '\0') {
 		rc = resolve_host(parsed_info->host, parsed_info->addrlist);
+		if (rc == 0 && parsed_info->verboseflag)
+			fprintf(stderr, "Host \"%s\" resolved to the following IP addresses: %s\n", parsed_info->host, parsed_info->addrlist);
+	}
 
 	switch (rc) {
 	case EX_USAGE:
diff --git a/resolve_host.c b/resolve_host.c
index 17cbd10..4e63861 100644
--- a/resolve_host.c
+++ b/resolve_host.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2010 Jeff Layton (jlayton@samba.org)
  * Copyright (C) 2010 Igor Druzhinin (jaxbrigs@gmail.com)
+ * Copyright (C) 2024 David Voit (david.voit@gmail.com)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,15 +28,16 @@
 #include <sys/socket.h>
 #include <arpa/inet.h>
 #include <netdb.h>
+#include <resolv.h>
 #include "mount.h"
 #include "util.h"
+#include "cldap_ping.h"
 #include "resolve_host.h"
 
 /*
  * resolve hostname to comma-separated list of address(es)
  */
-int resolve_host(const char *host, char *addrstr)
-{
+int resolve_host(const char *host, char *addrstr) {
 	int rc;
 	/* 10 for max width of decimal scopeid */
 	char tmpbuf[NI_MAXHOST + 1 + 10 + 1];
@@ -44,6 +46,7 @@ int resolve_host(const char *host, char *addrstr)
 	struct addrinfo *addrlist, *addr;
 	struct sockaddr_in *sin;
 	struct sockaddr_in6 *sin6;
+	size_t count_v4 = 0, count_v6 = 0;
 
 	rc = getaddrinfo(host, NULL, NULL, &addrlist);
 	if (rc != 0)
@@ -53,40 +56,51 @@ int resolve_host(const char *host, char *addrstr)
 	while (addr) {
 		/* skip non-TCP entries */
 		if (addr->ai_socktype != SOCK_STREAM ||
-		    addr->ai_protocol != IPPROTO_TCP) {
+			addr->ai_protocol != IPPROTO_TCP) {
 			addr = addr->ai_next;
 			continue;
 		}
 
 		switch (addr->ai_addr->sa_family) {
-		case AF_INET6:
-			sin6 = (struct sockaddr_in6 *)addr->ai_addr;
-			ipaddr = inet_ntop(AF_INET6, &sin6->sin6_addr, tmpbuf,
-					   sizeof(tmpbuf));
-			if (!ipaddr) {
-				rc = EX_SYSERR;
-				goto resolve_host_out;
-			}
+			case AF_INET6:
+				count_v6++;
+				if (count_v6 + count_v4 > MAX_ADDRESSES) {
+					addr = addr->ai_next;
+					continue;
+				}
 
-			if (sin6->sin6_scope_id) {
-				len = strnlen(tmpbuf, sizeof(tmpbuf));
-				snprintf(tmpbuf + len, sizeof(tmpbuf) - len, "%%%u",
-					 sin6->sin6_scope_id);
-			}
-			break;
-		case AF_INET:
-			sin = (struct sockaddr_in *)addr->ai_addr;
-			ipaddr = inet_ntop(AF_INET, &sin->sin_addr, tmpbuf,
-					   sizeof(tmpbuf));
-			if (!ipaddr) {
-				rc = EX_SYSERR;
-				goto resolve_host_out;
-			}
+				sin6 = (struct sockaddr_in6 *) addr->ai_addr;
+				ipaddr = inet_ntop(AF_INET6, &sin6->sin6_addr, tmpbuf,
+								   sizeof(tmpbuf));
+				if (!ipaddr) {
+					rc = EX_SYSERR;
+					goto resolve_host_out;
+				}
 
-			break;
-		default:
-			addr = addr->ai_next;
-			continue;
+
+				if (sin6->sin6_scope_id) {
+					len = strnlen(tmpbuf, sizeof(tmpbuf));
+					snprintf(tmpbuf + len, sizeof(tmpbuf) - len, "%%%u",
+							 sin6->sin6_scope_id);
+				}
+				break;
+			case AF_INET:
+				count_v4++;
+				if (count_v6 + count_v4 > MAX_ADDRESSES) {
+					addr = addr->ai_next;
+					continue;
+				}
+				sin = (struct sockaddr_in *) addr->ai_addr;
+				ipaddr = inet_ntop(AF_INET, &sin->sin_addr, tmpbuf,
+								   sizeof(tmpbuf));
+				if (!ipaddr) {
+					rc = EX_SYSERR;
+					goto resolve_host_out;
+				}
+				break;
+			default:
+				addr = addr->ai_next;
+				continue;
 		}
 
 		if (addr == addrlist)
@@ -98,6 +112,204 @@ int resolve_host(const char *host, char *addrstr)
 		addr = addr->ai_next;
 	}
 
+
+	// Is this a DFS domain where we need to do a cldap ping to find the closest node?
+	if (count_v4 > 1 || count_v6 > 1) {
+		int res;
+		ns_msg global_domain_handle;
+		unsigned char global_domain_lookup[4096];
+		ns_msg site_domain_handle;
+		unsigned char site_domain_lookup[4096];
+		char dname[MAXCDNAME];
+		int srv_cnt;
+
+		res = res_init();
+		if (res != 0)
+			goto resolve_host_out;
+
+
+		res = snprintf(dname, MAXCDNAME, "_ldap._tcp.dc._msdcs.%s", host);
+		if (res < 0)
+			goto resolve_host_out;
+
+		res = res_query(dname, C_IN, ns_t_srv, global_domain_lookup, sizeof(global_domain_lookup));
+		if (res < 0)
+			goto resolve_host_out;
+
+		// res is also the size of the response_buffer
+		res = ns_initparse(global_domain_lookup, res, &global_domain_handle);
+		if (res < 0)
+			goto resolve_host_out;
+
+		srv_cnt = ns_msg_count (global_domain_handle, ns_s_an);
+
+		// No or just one DC we are done
+		if (srv_cnt < 2)
+			goto resolve_host_out;
+
+		char site_name[MAXCDNAME];
+		// We assume that AD always sends the ip addresses in the addtional data block
+		for (int i = 0; i < ns_msg_count(global_domain_handle, ns_s_ar); i++) {
+			ns_rr rr;
+			res = ns_parserr(&global_domain_handle, ns_s_ar, i, &rr);
+			if (res < 0)
+				goto resolve_host_out;
+
+			struct sockaddr *s_addr;
+			struct sockaddr_in ipv4_endpoint;
+			struct sockaddr_in6 ipv6_endpoint;
+
+			switch (ns_rr_type(rr)) {
+				case ns_t_aaaa:
+					if (ns_rr_rdlen(rr) != NS_IN6ADDRSZ)
+						continue;
+					bzero((void *) &ipv6_endpoint, sizeof(ipv6_endpoint));
+					ipv6_endpoint.sin6_family = AF_INET6;
+					memcpy(&ipv6_endpoint.sin6_addr, ns_rr_rdata(rr), NS_IN6ADDRSZ);
+					ipv6_endpoint.sin6_port = htons(389);
+					s_addr = (struct sockaddr *) &ipv6_endpoint;
+					break;
+				case ns_t_a:
+					if (ns_rr_rdlen(rr) != NS_INADDRSZ)
+						continue;
+					bzero((void *) &ipv4_endpoint, sizeof(ipv4_endpoint));
+					ipv4_endpoint.sin_family = AF_INET;
+					memcpy(&ipv4_endpoint.sin_addr, ns_rr_rdata(rr), NS_INADDRSZ);
+					ipv4_endpoint.sin_port = htons(389);
+					s_addr = (struct sockaddr *) &ipv4_endpoint;
+					break;
+				default:
+					continue;
+			}
+
+			res = cldap_ping((char *) host, &s_addr, site_name);
+
+			if (res == -2) {
+				continue;
+			}
+
+			if (res < 0) {
+				goto resolve_host_out;
+			}
+
+			if (site_name[0] == '\0') {
+				goto resolve_host_out;
+			} else {
+				// site found - leave loop
+				break;
+			}
+		}
+
+		res = snprintf(dname, MAXCDNAME, "_ldap._tcp.%s._sites.dc._msdcs.%s", site_name, host);
+		if (res < 0) {
+			goto resolve_host_out;
+		}
+
+		res = res_query(dname, C_IN, ns_t_srv, site_domain_lookup, sizeof(site_domain_lookup));
+		if (res < 0)
+			goto resolve_host_out;
+
+		// res is also the size of the response_buffer
+		res = ns_initparse(site_domain_lookup, res, &site_domain_handle);
+		if (res < 0)
+			goto resolve_host_out;
+
+		int number_addresses = 0;
+		for (int i = 0; i < ns_msg_count(site_domain_handle, ns_s_ar); i++) {
+			if (i > MAX_ADDRESSES)
+				break;
+
+			ns_rr rr;
+			res = ns_parserr(&site_domain_handle, ns_s_ar, i, &rr);
+			if (res < 0)
+				goto resolve_host_out;
+
+			switch (ns_rr_type(rr)) {
+				case ns_t_aaaa:
+					if (ns_rr_rdlen(rr) != NS_IN6ADDRSZ)
+						continue;
+					ipaddr = inet_ntop(AF_INET6, ns_rr_rdata(rr), tmpbuf,
+									   sizeof(tmpbuf));
+					if (!ipaddr) {
+						rc = EX_SYSERR;
+						goto resolve_host_out;
+					}
+					break;
+				case ns_t_a:
+					if (ns_rr_rdlen(rr) != NS_INADDRSZ)
+						continue;
+					ipaddr = inet_ntop(AF_INET, ns_rr_rdata(rr), tmpbuf,
+									   sizeof(tmpbuf));
+					if (!ipaddr) {
+						rc = EX_SYSERR;
+						goto resolve_host_out;
+					}
+					break;
+				default:
+					continue;
+			}
+
+			number_addresses++;
+
+			if (i == 0)
+				*addrstr = '\0';
+			else
+				strlcat(addrstr, ",", MAX_ADDR_LIST_LEN);
+
+			strlcat(addrstr, tmpbuf, MAX_ADDR_LIST_LEN);
+		}
+
+		// Preferred site ips is now the first entry in addrstr, fill up with other sites till MAX_ADDRESS
+		for (int i = 0; i < ns_msg_count(global_domain_handle, ns_s_ar); i++) {
+			if (number_addresses > MAX_ADDRESSES)
+				break;
+
+			ns_rr rr;
+			res = ns_parserr(&global_domain_handle, ns_s_ar, i, &rr);
+			if (res < 0)
+				goto resolve_host_out;
+
+			switch (ns_rr_type(rr)) {
+				case ns_t_aaaa:
+					if (ns_rr_rdlen(rr) != NS_IN6ADDRSZ)
+						continue;
+					ipaddr = inet_ntop(AF_INET6, ns_rr_rdata(rr), tmpbuf,
+									   sizeof(tmpbuf));
+					if (!ipaddr) {
+						rc = EX_SYSERR;
+						goto resolve_host_out;
+					}
+					break;
+				case ns_t_a:
+					if (ns_rr_rdlen(rr) != NS_INADDRSZ)
+						continue;
+					ipaddr = inet_ntop(AF_INET, ns_rr_rdata(rr), tmpbuf,
+									   sizeof(tmpbuf));
+					if (!ipaddr) {
+						rc = EX_SYSERR;
+						goto resolve_host_out;
+					}
+					break;
+				default:
+					continue;
+			}
+
+			char *found = strstr(addrstr, tmpbuf);
+
+			if (found) {
+				// We only have a real match if the substring is terminated by an ',' or it's the last entry in the list
+				char seperator = *(found+strlen(tmpbuf)+1);
+				if (seperator == ',' || seperator == '\0') {
+					continue;
+				}
+			}
+
+			number_addresses++;
+			strlcat(addrstr, ",", MAX_ADDR_LIST_LEN);
+			strlcat(addrstr, tmpbuf, MAX_ADDR_LIST_LEN);
+		}
+	}
+
 resolve_host_out:
 	freeaddrinfo(addrlist);
 	return rc;
diff --git a/resolve_host.h b/resolve_host.h
index b949245..f2b19e6 100644
--- a/resolve_host.h
+++ b/resolve_host.h
@@ -26,8 +26,10 @@
 /* currently maximum length of IPv6 address string */
 #define MAX_ADDRESS_LEN INET6_ADDRSTRLEN
 
-/* limit list of addresses to 16 max-size addrs */
-#define MAX_ADDR_LIST_LEN ((MAX_ADDRESS_LEN + 1) * 16)
+#define MAX_ADDRESSES 16
+
+/* limit list of addresses to MAX_ADDRESSES max-size addrs */
+#define MAX_ADDR_LIST_LEN ((MAX_ADDRESS_LEN + 1) * MAX_ADDRESSES)
 
 extern int resolve_host(const char *host, char *addrstr);
 
-- 
2.44.0


