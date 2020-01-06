Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD04131612
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Jan 2020 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFQb0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Jan 2020 11:31:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44867 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgAFQb0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 6 Jan 2020 11:31:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so39909774qkb.11
        for <linux-cifs@vger.kernel.org>; Mon, 06 Jan 2020 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkfa5x78Jkq1S3G19eOeCV4/s74GQk+h4IclOxcbIXw=;
        b=Ay2ypHHQCw5OM45qxOgJt4lQBnqdj2k4btZswWT7oJkOSSulzoK7KJDwKQiWuyophL
         xGYUinRF1efow7+jRrTjycJQIWNFaiovjSTNyNvhQ7u3fhcKn1J3urU1q/GOSUNNfQmY
         8YZwiCjIMYMAnVYBB0tc6LJA12o2PfEjseCXVkuZsYd24n1vdL+t90eCZqHtjJb2/rZk
         UdP/InagQnVch1wCjOWLZMNq2W/2HgV2bf9n4/YcUmT6cqaZeUT3dGIA/TZVLNt2BZ3g
         gvLyQRoAO2tXH0nAwWYQyA7XhdhijMvUfmoLB60qEUliEYU2ah2cQiuhC7j7hZVMk9Wa
         aubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkfa5x78Jkq1S3G19eOeCV4/s74GQk+h4IclOxcbIXw=;
        b=NK4PM/7syGDGpBun5Yqc1+rD+fJ5AqLKR7eQ1qU5eO85bznxMElWDBB8/bRYQdnlKN
         lajWHLSmXQNsuKm30iZJU30JFeelr8QoxvAPOvrA+2lYI5v+0JLPoMCIqY2O43DHnZ4/
         L8/ZZKr9wwPyLX+5BN6eoToxIsHhP8prk6D2Ia/GA+thEcpSnPud+Z+gVj6MRxB/+PVf
         vu95Gaq9swFPNIYJchkpZIE7FwfHc1WlRpajn5QQb2ut93SdIm3+7Fx0AfFLfaXjAivN
         aKoEu8n3kYRmFrlWin7V0wGVfEJEmg43ssKsHAIucCcimpIud+yC0fnNqtb+0Jwgn5wz
         Blbg==
X-Gm-Message-State: APjAAAWjuzHLDYXHIxa4DWwQDG1FAcf4qrKzNCfh9t/hj/SmOuTLKmOb
        jkq5ThDRX2af/hXuSo1YBp2LXymH
X-Google-Smtp-Source: APXvYqxyjU7/0WmK5gKPcdj3oGnynT7bQ/pOta7Sh03zE8dx8WgpBxz6mZLSd9T7J5vGpwhyzyp1HA==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr82139014qkk.423.1578328285349;
        Mon, 06 Jan 2020 08:31:25 -0800 (PST)
Received: from ip-172-31-1-121.ec2.internal (ec2-3-231-202-5.compute-1.amazonaws.com. [3.231.202.5])
        by smtp.gmail.com with ESMTPSA id f26sm23434195qtv.77.2020.01.06.08.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:31:25 -0800 (PST)
From:   Boris Protopopov <boris.v.protopopov@gmail.com>
To:     linux-cifs@vger.kernel.org
Cc:     sfrench@samba.org, samba-technical@lists.samba.org,
        sblbir@amazon.com, boris.v.protopopov@gmail.com
Subject: [PATCH 1/2] Convert owner and group SID offsets to LE format
Date:   Mon,  6 Jan 2020 16:31:18 +0000
Message-Id: <20200106163119.9083-1-boris.v.protopopov@gmail.com>
X-Mailer: git-send-email 2.24.1.485.gad05a3d8e5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Convert owner and group SID offsets to LE format
when writing to ntsd

Signed-off-by: Boris Protopopov <boris.v.protopopov@gmail.com>
---
 setcifsacl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setcifsacl.c b/setcifsacl.c
index f3d0189..9a301e2 100644
--- a/setcifsacl.c
+++ b/setcifsacl.c
@@ -114,12 +114,14 @@ copy_sec_desc(const struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 	if (dacloffset <= osidsoffset) {
 		/* owners placed at end of ACL */
 		nowner_sid_ptr = (struct cifs_sid *)((char *)pnntsd + dacloffset + size);
-		pnntsd->osidoffset = dacloffset + size;
+		osidsoffset = dacloffset + size;
+		pnntsd->osidoffset = htole32(osidsoffset);
 		size = copy_cifs_sid(nowner_sid_ptr, owner_sid_ptr);
 		bufsize += size;
 		/* put group SID after owner SID */
 		ngroup_sid_ptr = (struct cifs_sid *)((char *)nowner_sid_ptr + size);
-		pnntsd->gsidoffset = pnntsd->osidoffset + size;
+		gsidsoffset = osidsoffset + size;
+		pnntsd->gsidoffset = htole32(gsidsoffset);
 	} else {
 		/*
 		 * Most servers put the owner information at the beginning,
-- 
2.14.5

