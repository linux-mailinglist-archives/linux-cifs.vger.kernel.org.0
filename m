Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DE496854
	for <lists+linux-cifs@lfdr.de>; Sat, 22 Jan 2022 00:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiAUXx4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 21 Jan 2022 18:53:56 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41818 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiAUXxz (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 21 Jan 2022 18:53:55 -0500
Received: by mail-pf1-f179.google.com with SMTP id x37so6281452pfh.8;
        Fri, 21 Jan 2022 15:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/aXQZ68RTanxH11FEnoBmUV0EdbBxwAc8bXGd6VfMY=;
        b=iCbXevdcNCVRL1uDFHSt/z690JA5h85F5nRDUzgUvqiGMLWjh79h85SkJknD7y+XIK
         d3OrisQurdHdE8lpMAqNPzRVU6TbDXdfSY9x0mlX4m8bT4YF1UrALPGdcNl8C+f+JB55
         13TkOk3BUzlcyDkqJJ78bEoSh7qGWZ9JLoWvPTUTivIv3+6sKGlmEObqvrjOB9WL/B43
         89FfzCHlC62fD8TyDGaXM/RzicK2JOVenZ3xox8xCyYxgs/BlJLKTNCoxh2jhWqCUuJ4
         q74ADG9dFyJM/XG2vQyunDYc+Sdo2pOBz3KF/AKW+d8CXKHj10w2wwYI7zMZXs/1FL21
         P7gw==
X-Gm-Message-State: AOAM531Vzu8qQOl/Tw3jJXWBWMvKJfhUxJWBoQRRkB0/rIggSPeDslhY
        2k0YymcriLbJO8V6bBm9l9A=
X-Google-Smtp-Source: ABdhPJyX4EVNerqXGcdrAms7gZqrIXGQpY73l3zyZebDzZmrut1PBF735MHyiYcItMXumCtOhIAs2g==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr4341759pgj.563.1642809235362;
        Fri, 21 Jan 2022 15:53:55 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id nn14sm6076356pjb.26.2022.01.21.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:53:55 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, smfrench@gmail.com,
        linux-cifs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 0/4] ksmbd stable patches for 5.15.y
Date:   Sat, 22 Jan 2022 08:53:36 +0900
Message-Id: <20220121235340.10269-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

These patches include 2 patches to run the recently updated
ksmbd.mountd(3.4.4) and 2 other patches to fix issues to avoid out of
memory issues caused by many outstanding smb2 locks. These are
important patches applied to linux-5.17-rc1, but they cannot be applied
to the stable kernel, so they are sent as separately backported patches.

Namjae Jeon (4):
  ksmbd: add support for smb2 max credit parameter
  ksmbd: move credit charge deduction under processing request
  ksmbd: limits exceeding the maximum allowable outstanding requests
  ksmbd: add reserved room in ipc request/response

 fs/ksmbd/connection.c    |  1 +
 fs/ksmbd/connection.h    |  4 ++--
 fs/ksmbd/ksmbd_netlink.h | 12 +++++++++++-
 fs/ksmbd/smb2misc.c      | 18 ++++++++++++------
 fs/ksmbd/smb2ops.c       | 16 ++++++++++++----
 fs/ksmbd/smb2pdu.c       | 25 +++++++++++++++----------
 fs/ksmbd/smb2pdu.h       |  1 +
 fs/ksmbd/smb_common.h    |  1 +
 fs/ksmbd/transport_ipc.c |  2 ++
 9 files changed, 57 insertions(+), 23 deletions(-)

-- 
2.25.1

