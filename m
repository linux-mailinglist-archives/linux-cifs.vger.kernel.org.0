Return-Path: <linux-cifs+bounces-3875-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CAA11214
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Jan 2025 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A69188AC7E
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Jan 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000E20DD51;
	Tue, 14 Jan 2025 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhsE9pXC"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EF20CCE1
	for <linux-cifs@vger.kernel.org>; Tue, 14 Jan 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886899; cv=none; b=NQOKuUZZ6DgvnLbZuJQIrJsFxrQXWxbZ44Au9PqkcAh83wKzVjERViQzq/Qzi3mP9zSzR+w/wM/h6MGFZMZpEPo7RHVKlA4UnkCl+H6xUX90qnCibmf7Oiha4XX1ggSARv/tIKnlcDMJuDV1UUaDGbFVdJ8mwsFtQOvpgjVsWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886899; c=relaxed/simple;
	bh=u6jH5bRTR69XYAizkVdoDqYIfNQKK04lPBdDXw/bGaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/ALoznzrReiK+JzVdZqu4x+lWTwZR+e5Vf3IXhgq/IddOV3GNV0f12NZgXvMtXzW9Je1aU77tp77GjqysDOslWpJzol3VlTFuvtk3vcajAFdT4pHRIsWo6vj6YdzuL4W9X85sg9dSIlrycWQJRyEQqTKwPS9fcQGhagv3pfsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhsE9pXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736886896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/eXHYx8Dg8d0wCYckixFBprtuklQDranC8cfWjItQY=;
	b=VhsE9pXCc2TLY9/8Zvj6tGCo/YsSZXypMWQC/7leeaisRx8vtaOkrOFP0aoqK9g9EejWGg
	+p8N9zXD8N8UOMgDsYQTtUzsD8IMyYvX2hwTvBSyuybL5EbCRb7hWkzDWQx+H/bGsCg8fx
	IQNBOiq12LgGtl1c4YiSJ+/MH+5yc4A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-hw4s3ZSvMj23p7OPSjTrDg-1; Tue,
 14 Jan 2025 15:34:55 -0500
X-MC-Unique: hw4s3ZSvMj23p7OPSjTrDg-1
X-Mimecast-MFC-AGG-ID: hw4s3ZSvMj23p7OPSjTrDg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64C4D1953951
	for <linux-cifs@vger.kernel.org>; Tue, 14 Jan 2025 20:34:54 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B49B19560A3;
	Tue, 14 Jan 2025 20:34:53 +0000 (UTC)
From: tbecker@redhat.com
To: linux-cifs@vger.kernel.org
Cc: Thiago Becker <tbecker@redhat.com>
Subject: [PATCH 1/2] cifscreds: use continue instead of break when matching commands
Date: Tue, 14 Jan 2025 17:34:49 -0300
Message-ID: <20250114203449.172749-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thiago Becker <tbecker@redhat.com>

While matching the commands in cifscreds, continue attempting to
match to detect ambiguous commands.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 cifscreds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cifscreds.c b/cifscreds.c
index 32f2ee4..c52f495 100644
--- a/cifscreds.c
+++ b/cifscreds.c
@@ -501,7 +501,7 @@ int main(int argc, char **argv)
 		if (cmd->name[n] == 0) {
 			/* exact match */
 			best = cmd;
-			break;
+			continue;
 		}
 
 		/* partial match */
-- 
2.47.1


