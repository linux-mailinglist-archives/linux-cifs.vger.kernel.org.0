Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8662BBBA65
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Sep 2019 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbfIWR0Q (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 23 Sep 2019 13:26:16 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:33278 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407415AbfIWR0Q (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 23 Sep 2019 13:26:16 -0400
Received: by mail-lj1-f172.google.com with SMTP id a22so14562240ljd.0
        for <linux-cifs@vger.kernel.org>; Mon, 23 Sep 2019 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sawFjO6GeUX+hor58uXM45KeNpmJ64YpddOSCWdEqZs=;
        b=A3woHyaGB15e3841VARQNnl5abCgqGp7uT/lvhFrWzqejIrXhVPaX7K6xuwP96/5MW
         N/kG8zzJhSoaI1CtNEQP2wR+cf89xv6Y5XiPwIJ8fBzugdjZLNFIFzuL6S04vilymVyj
         3Srz72PxZhinRV2OY+t0TzDL/TYkzY6me48rhrJthHeZwC47YpFCfPvwdDPm60GUiI7g
         ErURFO6yi6qEesMYgw2VlfSKtbqY8tVsCRYaB7YpUMzQN1CIUuBmkZxsOFCKw7nhNGhp
         qq8TbQzomn9D4FGECtB4Zp0VvdHQLoRkhVvFVReLWIeZ4SG+oQxInzF1hyzFrFmE0y5h
         Szug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sawFjO6GeUX+hor58uXM45KeNpmJ64YpddOSCWdEqZs=;
        b=Ag+BXuDnLlUutVO+ugEUBdOasvji4WrplkPOZ7RvDwQ+OVrkolM30fwtCoLtkHUek0
         IWJR3WXSn9uvX1lDeGnTESwJvvT+tZNTJb3SXpjlIC2vFqaq+uXlbBiJ4dwFuXl02rTE
         WlQUI3gtAxoNQxRE/IC8fIDyhSsC1/ZDq3vTPazmIu/LjA0F541mkCem8byGQeBRLyzB
         ghVPQ4ME6DIvBCliDJd1jyQM01UbBPnRAiB/QQxvDRIl/sChlSwLCGLp0UWxd/Af3UAa
         WLHZ5fmO9rIaZjCWZcbKwmDNkrx7g5yCK1hn0XyadLGRIE0M04Zleg14wyjI59a8Cmmp
         PFsQ==
X-Gm-Message-State: APjAAAXHPqGPllxjYaSVwhcY5OenaIQaGG1RU4x6SCAEcw+Mo5UCimby
        2QK9bw0I9crsd8vu0ZwMqIhYajHUMZcR56WHhH6G
X-Google-Smtp-Source: APXvYqx+BVfmHot/SY18iOAQwo4lFgQ8i4ewhzl2tS8vdn/D7ailL8nDL+jx1m/0bEBvbJal7xGpgtrb6fSy65DPTFk=
X-Received: by 2002:a2e:8846:: with SMTP id z6mr295418ljj.77.1569259574426;
 Mon, 23 Sep 2019 10:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv6x_aJQJ_N9f+9zYFgFN7FkmpR1=sNzCR8Ln5m=kGL-Q@mail.gmail.com>
In-Reply-To: <CAH2r5mv6x_aJQJ_N9f+9zYFgFN7FkmpR1=sNzCR8Ln5m=kGL-Q@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Mon, 23 Sep 2019 10:26:03 -0700
Message-ID: <CAKywueSQGT13QQZtWz9t8vQPpukZ8cydXnT43kRyWv9scHOivw@mail.gmail.com>
Subject: Re: Fix for "requests in flight" showing negative
To:     Steve French <smfrench@gmail.com>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I guess it should be "open files" instead of "requests in flight" in
the title and the description of the patch.

Other than that looks good:

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>

--
Best regards,
Pavel Shilovsky

=D1=81=D0=B1, 21 =D1=81=D0=B5=D0=BD=D1=82. 2019 =D0=B3. =D0=B2 22:58, Steve=
 French <smfrench@gmail.com>:

>
> Requests in flight could display as negative when should be zero
>
> --
> Thanks,
>
> Steve
