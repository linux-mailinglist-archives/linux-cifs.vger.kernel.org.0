Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0538B446631
	for <lists+linux-cifs@lfdr.de>; Fri,  5 Nov 2021 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhKEPse (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 5 Nov 2021 11:48:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55356
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232110AbhKEPse (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 5 Nov 2021 11:48:34 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C39440029
        for <linux-cifs@vger.kernel.org>; Fri,  5 Nov 2021 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127153;
        bh=RNobqhWtnsfIoxXaYIoZpBxYqqusSLJy7zau+vw4CD8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TZu1bZFfonmNRtp+lLLb27l2nbvyrUrt+aU96cVtuvRVa1qFwVcU64Hf72LaEZ8Ul
         lLNcoNWtED/y3QgX/7zgftL2+ArdH/bpS9DAQqr3d6lLtxtCpQwmvlrMWf97A3obeP
         YYaHzJ8hXFMHp9Yp6aDMO/kImkpmYQJ09Kn/3hozbb3OkWSIyzV4BniUsuZPUnIV2C
         IQbb3lvVCMwRwSYLLmYk+k2VcSaEXw+J9QpVrImK1gaxgxvg3mR/+YB9iZAIL3dbZ4
         Sr6ehwYlUCOsX4OOVXg3eGxgIMBvw2zyaVyKdLaq9yjuI+iakBnrpbwQtMGP2B79ln
         fqyAmcVEuPGyg==
Received: by mail-lf1-f71.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso2340291lfv.7
        for <linux-cifs@vger.kernel.org>; Fri, 05 Nov 2021 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNobqhWtnsfIoxXaYIoZpBxYqqusSLJy7zau+vw4CD8=;
        b=UPeZa5WqdWmKwP2VRkbFvbBp0/Zg9PNEPbRHYEA7OU1WE56WIWmqHeX6naa6zgFUec
         MFqcGElmJAEczYccj+otoOxvl8AA++sKDlKwDA+l3l2YcoLLoTa7CvEuQQQNtc/1vn4n
         S5Sas7CKB+DjtdxYFaz2yy7dRrjLNY8D1/u0295OXNmSIhWQ3rh20OEvJbyDEetDaFXv
         cRjY31PkV0MDNaaF7RQjE8jwumoG9r0wjKpcykMT7SJ2iviVRzci9B5F/QRhm8CwDkIy
         TFB2hTDDsIdjV55ahuTmzDd0I8OBAHXUlKWN8vpfdFUgTAYenLMxGBFAf3j6S3r1vUiW
         dJ0A==
X-Gm-Message-State: AOAM5318iGwZFcGowsgVrwUO+ehe1MSrOPx7/XVHwWjDHIJwNHAAKtLx
        0Tx+bm5BynMQkjxIyyWv0ziGkfisjAQLRiZa1b0mcr9yYYQsjuyW23jg7DeZeFzbVe71MVWFOpr
        UbJyyVk5KRA2rZk9iqKMR2XEo4nztHmarQArOvS8=
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr55189851wrz.404.1636127142093;
        Fri, 05 Nov 2021 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZywTZdfrBqjkrXUHT6HtmWD9YVAJ3iwmoe2pIrt2a1HLvL+5pBL/kHDbOZs7Oh5iYcqB87Q==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr55189804wrz.404.1636127141914;
        Fri, 05 Nov 2021 08:45:41 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id z5sm15339353wmp.26.2021.11.05.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:41 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 2/7] Documentation, arch: Remove leftovers from raw device
Date:   Fri,  5 Nov 2021 16:43:29 +0100
Message-Id: <20211105154334.1841927-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Raw device interface was removed so remove all references to configs
related to it.

Fixes: 603e4922f1c8 ("remove the raw driver")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/admin-guide/devices.txt  | 8 +-------
 arch/arm/configs/spear13xx_defconfig   | 1 -
 arch/arm/configs/spear3xx_defconfig    | 1 -
 arch/arm/configs/spear6xx_defconfig    | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 5 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 922c23bb4372..c07dc0ee860e 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2339,13 +2339,7 @@
 		disks (see major number 3) except that the limit on
 		partitions is 31.
 
- 162 char	Raw block device interface
-		  0 = /dev/rawctl	Raw I/O control device
-		  1 = /dev/raw/raw1	First raw I/O device
-		  2 = /dev/raw/raw2	Second raw I/O device
-		    ...
-		 max minor number of raw device is set by kernel config
-		 MAX_RAW_DEVS or raw module parameter 'max_raw_devs'
+ 162 char	Used for (now removed) raw block device interface
 
  163 char
 
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 3b206a31902f..065553326b39 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -61,7 +61,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index fc5f71c765ed..afca722d6605 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -41,7 +41,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 52a56b8ce6a7..bc32c02cb86b 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -36,7 +36,6 @@ CONFIG_INPUT_FF_MEMLESS=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index b183629f1bcf..d0494fbb4961 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -190,7 +190,6 @@ CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=1024
 CONFIG_I2C_CHARDEV=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
-- 
2.32.0

