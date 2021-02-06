Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B79311DB8
	for <lists+linux-cifs@lfdr.de>; Sat,  6 Feb 2021 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBFOh1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 6 Feb 2021 09:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBFOh0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 6 Feb 2021 09:37:26 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA861C061788
        for <linux-cifs@vger.kernel.org>; Sat,  6 Feb 2021 06:36:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m7so10730816oiw.12
        for <linux-cifs@vger.kernel.org>; Sat, 06 Feb 2021 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=p+t4/+MvfgaC6xRKtfrE3YLnqtmJg3MOQZR/UItVg1wCiBizAuPimkXqN5AuU5wwkD
         r6ZVA68dkjDg/IpRldSm6Liq/2eKO3SIPRuWTQGm0PwU2yDNiHtsEcm9dWUFYaX0d4u0
         LwZl2ooP22M1bDeEz1ehaP/77ipCZZ527sAJgVaT+SyiIJtj8QAzI3JNdp+ABPeGa6vW
         37LQCKTaO3J5QUsDoA8BqGhGLXdJyApwnici7l/Q1UQMHZrrNr3G10X007ulaHi4A1w/
         om8WFEwfqgGqpXp94JXWIbsteQaktSSFniiBCOjjL0U1oW4XihLr4SlpbcUrDKxVnmVv
         ICYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=mIstMWNuRQG+VWltVMqw8ICsJc3d0DBCP+o66hcW5wMkJeWWhGwJGt+fudZgXXnxqd
         gl//1ekzN4M+q15SQ6rRflIYwGWFfpGrHDFH/n+vJVQt0Tf35YhLBA9IgiEWUtEcXqen
         Ll+hAG3zK2d6zeMxfTJyl4zBSqRCHBXYADQzPIKSL3DRToY9EkXsJ35JQ5RfVEM3c+JN
         gTBxN41QgHigNXO5n9Z2MiQL00ecbRdkk2LxDr5DY6XD2cBotmrRo0KcpNyooOxGmZVk
         c9u7TBiVmPBRiGHh4zKjcj22zLHIov5lYig36VjHLfuq02nXwkqLg4PfEu5xK8qTPzQP
         bYtg==
X-Gm-Message-State: AOAM530Dmd6AA8MWAnjMMsGGNIdhPwX5uYQEssQcAO4r/pa3VrHLPdgM
        i3aIu8f0YQ+E/eycfGh7F8r9N2gCO8j1PvJKK7Q=
X-Google-Smtp-Source: ABdhPJz55x9yuDty8zfLGT1MaMflxj/xVXVRtic8MCDIPZe12zsMM9AuBm3kFPYfsMCalzegFYLTpWlVqREw+1RLVxo=
X-Received: by 2002:aca:d4ce:: with SMTP id l197mr6048372oig.36.1612622206208;
 Sat, 06 Feb 2021 06:36:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:36:45 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:36:45 +0100
Message-ID: <CAO_fDi-kuTCDy2D5hsg1mfX_qecK9WsfDoUw4r2HmgfGfBenjw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
