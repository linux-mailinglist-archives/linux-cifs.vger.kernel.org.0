Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64C747B08E
	for <lists+linux-cifs@lfdr.de>; Mon, 20 Dec 2021 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhLTPrM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Dec 2021 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhLTPrL (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 20 Dec 2021 10:47:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAFC061574
        for <linux-cifs@vger.kernel.org>; Mon, 20 Dec 2021 07:47:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so20931035wrw.10
        for <linux-cifs@vger.kernel.org>; Mon, 20 Dec 2021 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=m5YI+CoGZsoiWIuJtMcGKOlmLoukiFWhka3FxO3p04TDtfb05dFevQZimm+ZRztkii
         E8b2UsfaTAcVv3RD8Ek2hV9k0HI/rPQ+VOcqoLf1ZFg5hpYfktbioZPAuzPivvUqnQAA
         i3a+PC0IpVzMrO8WwBilMCI903yHay0u2zs4oDz+zZklhI8H5mrh/xb8fQyPcyIL4ee9
         u816H1my0a7LjO8P0XHHoXn/a5znB7LdOxDOeU+sHZ/VUz8Of+UD5La0Bz399RvynrOD
         NeVbvU4rHgv2/4X9oK6q+M2K+ypUo3PJ0wXg3Yni67BhGe3gG5xLb9iHmLy4E2SVUo9O
         uqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=k4X+JmGgYgaUNcUc8/MNHRxYrhOXLM5bIryhIs2rumJRBcZybkLtbZQhKCaIM++keN
         r8K23QtKJFPBmT3Fsi8j1MYUB5Lfv88fulkdV7usPpTB+J4ENUC8vlGTXjrdOb6YaF+6
         QlN/DzD1b/CGBf87Yj578jJEX7YBE70/seEM39eIxV5dIXqpwDponch9+07cA1fqz7Hg
         hzkRioNSIDTMOVR9WivwalcBQHh2MhiZDS3BIErEFtcndjF26s4W2Lg6czCYmNcTyN8Z
         Wh4agYlPLgOdjxxO+kZYGkR5W5wFdL0fpUDugzUY454Qs1t8+w8EgFiqZOPQBIIKSygc
         t2xA==
X-Gm-Message-State: AOAM530DYbPpRD2eD2sDED69uE9Ztz1l8j37Iy0e9SMgoOQPh/9hb0tS
        G+YPa8BdU94RQWhn1rphz8csJb/pmMooJw==
X-Google-Smtp-Source: ABdhPJy43GRDz1tsk2eX9dOicT69RO4VfYM8P1wAJP3oM+UZcJyKhWzb1/Lcuo39ldVyI9L1aiwrRw==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr12750744wrc.371.1640015230139;
        Mon, 20 Dec 2021 07:47:10 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id r11sm15647287wrw.5.2021.12.20.07.47.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 07:47:09 -0800 (PST)
Message-ID: <61c0a57d.1c69fb81.382c9.d677@mx.google.com>
From:   Margaret Leung KO May-yee <agenejoseph1@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 16:47:02 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
