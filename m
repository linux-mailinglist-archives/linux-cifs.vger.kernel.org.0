Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F21C2CAB0B
	for <lists+linux-cifs@lfdr.de>; Tue,  1 Dec 2020 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLASuo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 1 Dec 2020 13:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLASuo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 1 Dec 2020 13:50:44 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42260C0613CF;
        Tue,  1 Dec 2020 10:50:04 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id k65so2816522ybk.5;
        Tue, 01 Dec 2020 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGr7B3b8DeP993hMQ3OSckfFWP96IL5H7+E6KOBqmc4=;
        b=Pe6qYyWqQ52B+MT7HDPNuMu5JlBMxGeq5xL4xRkkEgLh4FhMA+AhY/1slkQN5yfoMl
         hHZ+krW4GXWrICaxlyF1Ub8WEl7aTMCzZyHnb0U6meU3sWMD8AktVehsUmBnV31bPKRc
         ppzO1YPnyj2aQpauw9uzNL8zw0wTmhM6Z9h9tbT2m1lNLp3t4ovHHXVz/iLex6nOxN7s
         w10UR4ZDXyOcnuFm1jfcSLS/Dfh5Y4PaXE4OmgLGBWLKQYnbW/9VrV1IumKC1yA7qZKn
         IybrALOzL8xFkXQtjZ8SgebKoBa/VNF5xGIovuvlxkhFDEwwokoHkzNlnSzZ/20GVHc6
         6k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGr7B3b8DeP993hMQ3OSckfFWP96IL5H7+E6KOBqmc4=;
        b=Y/k2jchMxiTOz2VpYc0pKGn6+kws5gxa7VHe3yoUC51KrdF2Whx4y3bPBdycswAQyq
         yyWq/wpnj3B55MQTff68IKsu9AxURxKoAqRMAOf5MLr8IUKs+CpC8Gz7lcFy6JVmJ7Pu
         KKU5HqZI6ocnUQaBeLmMFg6d9FjQk0h1NXNXZrXmvkvbSbOurTcfZ8QAO9HrsGVjJ4f+
         Wgmew9TAUraUnI7zE+m5fWZTMsE9sCum+2qwMrpzcUYx3L+rN42+N0bBPBcwJAmkBZGS
         Z5o0KtszA1RiQ/IFaytxmCVDB5wSAGagkqZFss3H3iWlaDPR5KQQZMapb/wUkusmH+58
         fGSA==
X-Gm-Message-State: AOAM531Qvob11Dia7syszCxic1SMrtUJMg/jeF2feBcCyarkODvuGec8
        LaEhg60EtRpc/kCLljq6qV+veib0qRY5FO2LWa2OoMvT4yA=
X-Google-Smtp-Source: ABdhPJwplPV0pIGEtbWrgJyTO5o9A7cSZJTkdAUuG8zT0w5Xbp+1VhfJlRCdokS9NrceBWrkDVGuHHPDm3p7o+1LLeQ=
X-Received: by 2002:a25:c68c:: with SMTP id k134mr5901241ybf.451.1606848603259;
 Tue, 01 Dec 2020 10:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20201027204226.26906-1-pboris@amazon.com>
In-Reply-To: <20201027204226.26906-1-pboris@amazon.com>
From:   Boris Protopopov <boris.v.protopopov@gmail.com>
Date:   Tue, 1 Dec 2020 13:49:52 -0500
Message-ID: <CAHhKpQ7v_nPwBx2czk7rVXK3ZrmsZrAkcxDFOgq0ABTOVc7iSA@mail.gmail.com>
Subject: Re: [PATCH] Add support for getting and setting SACLs
To:     Boris Protopopov <pboris@amazon.com>
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hello,
I am checking in to see if anyone had a chance to take a look at this
patch. I would appreciate any feedback.
Thanks!

On Tue, Oct 27, 2020 at 5:01 PM Boris Protopopov via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Add SYSTEM_SECURITY access flag and use with smb2 when opening
> files for getting/setting SACLs. Add "system.cifs_ntsd_full"
> extended attribute to allow user-space access to the functionality.
> Avoid multiple server calls when setting owner, DACL, and SACL.
>
> Signed-off-by: Boris Protopopov <pboris@amazon.com>
> ---
...
