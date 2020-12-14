Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C02D9788
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Dec 2020 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392388AbgLNLj6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 14 Dec 2020 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbgLNLjj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 14 Dec 2020 06:39:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BBC0613D6;
        Mon, 14 Dec 2020 03:38:59 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id o19so3722417lfo.1;
        Mon, 14 Dec 2020 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyanV3OD/vmZQFo0fBeUL6ZC0A4CxUv9H3iKrx2fgN0=;
        b=GUzMGcUabkpWvZceMy2irnTVWGX1IbJQtr8dAkOwo214EcGn4KxrFc/vVBWbx9DLO4
         K02Z0IPrQv54EHXhZf7Szd4jP3D4oH+QMm+9NkCjz8Gtne8Jy8nycGZrnozR8MJLW/Sb
         Z5pfGn2zlK2yF2F1cGDYLznLOUH37kV3ZCV726UsyyEHfx7wuVgtGuCHf6Uuq8BtiL2l
         6MtIK1VjfOkFfbHjfZtMeql7abfpaYqGfhsg2YSRgo9bI+THbK77N9pgUUigeQE0PWYo
         UKr2yxc7bvJU55JboF9QpPakSIylJsfYmTv/BLtCui8nr4bIIJopz3iuQINcnr9tqxNN
         hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyanV3OD/vmZQFo0fBeUL6ZC0A4CxUv9H3iKrx2fgN0=;
        b=QFHdI+bEVQ1rsrgNjuGZNR3gM9f3B31CjLVVeB3WfB5IytAY8sdtNYOEzEx78JdSYi
         Q2Lh6yb7PEwfupFVaWPu1cs0ti8kTZiKmb2eBBn8E1AbsSP26ZJFg0EJIikdHPyemF3c
         dPOuZaq0gdsj219cngrfT/zC+5qBL8tQe7LDqSTKnzAHGUfyxCkaredOWT0qlItHCv2/
         74w67n+omaU59q2AW6D0Cd9i7XhaR0abs5jTzYPsC+N/Xn5rlXCWR1qP4vfPv8WrsE9J
         9qq7C3eQodrWSfm6oJq5Zj+tlRN/caVx4ekHbIrglrkkcrsdBMK8HnRiKQSBgmT0Ptu0
         2Ciw==
X-Gm-Message-State: AOAM5332YVBV29cwaw9xRKc7gGpqTvhvv0bpoUt6Qlx42anbSaQcBwFm
        Soz4W/izYPl/AbgRBGk62VoD1Rgnqzo=
X-Google-Smtp-Source: ABdhPJw9goUNMusTW3LnjziUAi8F9Dn2a3gvhLw5Phy451txKKGJx4E2IkdyuIFfKQJd58CHpH6GNg==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr10248999ljg.268.1607945937902;
        Mon, 14 Dec 2020 03:38:57 -0800 (PST)
Received: from localhost.localdomain (109-252-193-205.dynamic.spd-mgts.ru. [109.252.193.205])
        by smtp.gmail.com with ESMTPSA id t21sm1031686lfl.124.2020.12.14.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:38:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] cifs: Add missing sentinel to smb3_fs_parameters
Date:   Mon, 14 Dec 2020 14:37:45 +0300
Message-Id: <20201214113745.7909-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add missing sentinel to smb3_fs_parameters. This fixes ARM32 kernel
crashing once CIFS is registered.

 Unable to handle kernel paging request at virtual address 33626d73
...
 (strcmp) from (fs_validate_description)
 (fs_validate_description) from (register_filesystem)
 (register_filesystem) from (init_cifs [cifs])
 (init_cifs [cifs]) from (do_one_initcall)
 (do_one_initcall) from (do_init_module)
 (do_init_module) from (load_module)
 (load_module) from (sys_finit_module)
 (sys_finit_module) from (ret_fast_syscal)

Fixes: e07724d1cf38 ("cifs: switch to new mount api")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 fs/cifs/fs_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index fe5cc60f4393..c41e87af77b6 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -173,6 +173,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_flag_no("mand", Opt_ignore),
 	fsparam_string("cred", Opt_ignore),
 	fsparam_string("credentials", Opt_ignore),
+	{}
 };
 
 int
-- 
2.29.2

