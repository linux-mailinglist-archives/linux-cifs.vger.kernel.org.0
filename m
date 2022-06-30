Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78065620C6
	for <lists+linux-cifs@lfdr.de>; Thu, 30 Jun 2022 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiF3RDB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 30 Jun 2022 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiF3RDA (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 30 Jun 2022 13:03:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85ED25E82
        for <linux-cifs@vger.kernel.org>; Thu, 30 Jun 2022 10:02:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a2so34860144lfg.5
        for <linux-cifs@vger.kernel.org>; Thu, 30 Jun 2022 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jS/Cz+fUX/o36nQdvoTPwjRe7hBmv/VVAWFDzy79Z84=;
        b=QjrKPS/ht2kIleIPk7V0LQRWNsrYVvJz/ZPGWXv9B/cr0BdhNB76XV5+p4k6F6x/K3
         gli7P4HkQyPWo+Kk9MhUTX3YC0n8l0gmVlPLmP8sC0pEG3cGoqsHOCGVaJR3Z5yWWStR
         VwbjFeWiBlk4lzr8Ui8HKwXifNIzP1DUpaWlPGWfEt3On539NdrgTHfp/CoM9F2gRrb2
         GDY9Y01YX9VasIPTyzXBzsKPCyMb/jJKqQVVBPIAQUjAhX+gtQcRd4o+advKv6boeTqB
         vHZ9mMVUq0oxR1siBn/ilzTvT1meT6+Dst8zuyYF74M33iTiDkr5+9AeTdvnOZLxQMJu
         V/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jS/Cz+fUX/o36nQdvoTPwjRe7hBmv/VVAWFDzy79Z84=;
        b=rHQkRu56dTjMsIDlBjmz6+s/6u2flbytvXcxFdKV1uKAAmW2HN9QMmHtbwiHswtb+E
         LjPnoXFMsCWBDaKiOD+GctEshTyHZZF8ZW6FGNlmD2Sd75xjNYr0fjBmi/KCYn0RBTIS
         jmEDDxvb8qNI2AZK8mQNDoBxBX88nbXMA4aFSXiv42P1BU/kIrC8H3Otqo6xDeoSs+6X
         GFBLCdtvRPxSN/Sj/QYVW1NSRfgmRVhuiLMpphy2fVMzHGqUd3zQYIh/t/5NuJzyoIjl
         KC5sNLBwWwny7j1nB1Yl/jwz0wbdXNG+eB7miJAY/yRdSCmvSZsuG05FOEVYuXwT5Qk5
         2sjA==
X-Gm-Message-State: AJIora/CsXBurmTiYkKahVWfud1iVlQii/5D1bg6+0VMEIlXAYN638Yx
        hN26xyLoCBbtyg0kuE/NbLIRdk09X54WqTBXbe9mvGIEsSU=
X-Google-Smtp-Source: AGRyM1ve60VrC114RBnc52PeIb6X4atBVpzF/kIlQ9shghhU8a/K4jEfk61gBL7ZLfoy2dfHSZ7jRv+GPIEvpX3Ofig=
X-Received: by 2002:a05:6512:314e:b0:47f:8341:2099 with SMTP id
 s14-20020a056512314e00b0047f83412099mr6106162lfi.367.1656608577977; Thu, 30
 Jun 2022 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <211885e7-1823-9118-836b-169c7163d7c2@gmail.com>
In-Reply-To: <211885e7-1823-9118-836b-169c7163d7c2@gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 1 Jul 2022 03:02:45 +1000
Message-ID: <CAN05THTbuBSF6HXh5TAThchJZycU1AwiQkA0W7hDwCwKOF+4kw@mail.gmail.com>
Subject: Re: kernel-5.18.8 breaks cifs mounts
To:     Julian Sikorski <belegdol@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, 1 Jul 2022 at 03:00, Julian Sikorski <belegdol@gmail.com> wrote:
>
> Hi list,
>
> it appears that kernel 5.18.8 breaks cifs mounts on my machine. With
> 5.18.7, everything works fine. With 5.18.8, I am getting:
>
> $ sudo mount /mnt/openmediavault/
> mount error(22): Invalid argument
> Refer to the mount.cifs(8) manual page (e.g. man mount.cifs) and kernel
> log messages (dmesg)
>
> The relevant /etc/fstab line is:
>
> //odroidxu4.local/julian /mnt/openmediavault    cifs
> credentials=/home/julas/.credentials,uid=julas,gid=julas,vers=3.1.1,nobrl,_netdev,auto
> 0 0
>
> Is this a known problem?

What is the output in dmesg ?

>
> Best regards,
> Julian
