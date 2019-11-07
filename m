Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6BF3844
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Nov 2019 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfKGTN3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 7 Nov 2019 14:13:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43910 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGTN3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 7 Nov 2019 14:13:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so3137940pfb.10
        for <linux-cifs@vger.kernel.org>; Thu, 07 Nov 2019 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=RCedkha/xYPeNMvSs7XKALrsQDHxA71LAh71d0XhW2A=;
        b=npzXzckgo3I1sbSymlCZ3ZlLR12FwsSaAhYfI5iwkqWPCAZshiNvX3oug7k6aQkxPT
         dlJn+LMYOpt3Po8UIPGgMEotb9v0OOCM94/drJmtWe/e81PnHDViQ2oaX3Ct+Ng3EYj8
         r3LAmg923PfEOE5gENX7KzKqpTiK3nqx/eHV9toipuPtpq3OLh2oUiKGgzIIkrU7fVpv
         iR8TBMsgGiTe3b/PVaQKXeK/IhfJZUt4LkX8ufL2bLMdSUt9G0xgBAYo1cmx0wVh/Ftv
         wH57KllE2Y7OB99dCmeZxrpLHsD6kZsZFjbIBTCccKQ5yoNOI9Kdp07E8LAJKIPCIMlS
         QJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=RCedkha/xYPeNMvSs7XKALrsQDHxA71LAh71d0XhW2A=;
        b=TxFxjl9dfcTkoWmo3M9IWKLHkPHhdaVvIH9G22NrmJSYZ40UTQy4H1Q8/ajCULY9oH
         VcXNZMGx1vHlQA1zyV7UwwLQFIzc+MKAXCfWs6/DQMmMH+66xgHR7wujGggHrENdqyiX
         GNd8Gxv4pEqQeiZ9un+cDtCRRXoPVUcV9ATup/tPM4pEh1YYLF1/Lrs2PDOzZsJ46hOU
         aT8IJ2jedzoJlqyCoFMwNqmoO2y0+OQ+dk5ytGZf6+08T507ZL7D8M28pidNIzDADeBt
         zVrlkr7nOTvL5pvmQKPDUQNxK8ghl/VCqRRwOB6wmmRcxOBUy9IYH48BNg0ncshgpHsx
         KdSQ==
X-Gm-Message-State: APjAAAXVBmlv0RR3sT3TPyfgVD7axM71MO6QJy2+OaoMgWxa3vseklAQ
        jLpzUZTmvVEKI8kdPD/fyXqzhNk=
X-Google-Smtp-Source: APXvYqxd/7bQly1WRy8jT3OZPSHTXejxujvDL2lTOGYE46uJ8ljx923fZjPYFteEgovEGjoAeIv/Vg==
X-Received: by 2002:a63:1f57:: with SMTP id q23mr6339738pgm.391.1573154008072;
        Thu, 07 Nov 2019 11:13:28 -0800 (PST)
Received: from ubuntu-vm.mshome.net ([131.107.174.106])
        by smtp.gmail.com with ESMTPSA id y80sm3160137pfc.28.2019.11.07.11.13.26
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:13:27 -0800 (PST)
From:   Pavel Shilovsky <piastryyy@gmail.com>
X-Google-Original-From: Pavel Shilovsky <pshilov@microsoft.com>
To:     linux-cifs@vger.kernel.org
Subject: [PATCH] SMB3: Fix persistent handles reconnect
Date:   Thu,  7 Nov 2019 11:13:22 -0800
Message-Id: <20191107191322.4360-1-pshilov@microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When the client hits a network reconnect, it re-opens every open
file with a create context to reconnect a persistent handle. All
create context types should be 8-bytes aligned but the padding
was missed for that one. As a result, the server doesn't allow
to reconnect handles and returns an error. The problem occurs
when the problematic context is not at the end of the create
request packet. Fix this by adding a proper padding at the end
of the reconnect persistent handle context.

Cc: Stable <stable@vger.kernel.org> # 4.19.x
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/smb2pdu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index ea735d59c36e..0abfde6d0b05 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -838,6 +838,7 @@ struct create_durable_handle_reconnect_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
 	struct durable_reconnect_context_v2 dcontext;
+	__u8   Pad[4];
 } __packed;
 
 /* See MS-SMB2 2.2.13.2.5 */
-- 
2.17.1

