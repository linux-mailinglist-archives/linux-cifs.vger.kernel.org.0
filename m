Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE8638748
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Nov 2022 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKYKVX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 25 Nov 2022 05:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKYKVV (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 25 Nov 2022 05:21:21 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59442196
        for <linux-cifs@vger.kernel.org>; Fri, 25 Nov 2022 02:21:20 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id f6so1789234ilu.13
        for <linux-cifs@vger.kernel.org>; Fri, 25 Nov 2022 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jplKdfdeYWIX7pzSybqTEf5fvUK8WrIsCzBXWo2hg38=;
        b=Tt8D/Ke7rPLzFfkD48ofO4Zs8AYtxQnubZvxLQYjh9DlmSoxafYXa3jHOWIcyd9NpQ
         yP3id0nUXMtzswWZzdWxZlJ4RoxZ/yG8tWZkFD62pp4PTxWx/N0KG5JuFZB4zLQf1cTh
         MAzNAcI9wbj24YG53F6KL9SaahCY0QH5Rew1LYXs7Vl2r8R5aEI+UoVoXe8JUhCcYC6H
         gLgG/7p5ituPo2fJyG4FjRFe1oHxxFmCkE9cUxL5upWlf1AKpHABmAwScJPrZJm+uC6I
         EzEnQcJd/+1kzKGec3T0XmIrEv6v9i5Q62yDUzL5oeP7kTdBbEb40314QiwD0rHA5b7Z
         lRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jplKdfdeYWIX7pzSybqTEf5fvUK8WrIsCzBXWo2hg38=;
        b=ECnyPsWnlvKfyLesmbEAy97yYpBrF7Wt3q+WgRPD5E4EkO4EUdzFOE2br6gJWXtojw
         zJIuzk6BJr6bRweOMvXkzHhoRYIZgNZKbRbuuyzZnkcS96OB0HsYi0binn2JukNBGoSD
         w1plbN6YyW0eCfEgZqfxUkoYD6cFq3i+BYu7o1MIiE3xCx6RTRMId8mBOiRS1UQ48hhV
         0itr4rBP7wOMoekYBuQ6XP1XPStRY8qaA6a4U2cjU16F60iotad0/PEJ70z6Va4lE2dO
         nm6huq+ZBBixjKmzg3TrLZt1cPzpkBDjNHK+M8dNCzrd+CFupWv8ZpMnYIOgZQldFxDI
         ZzLg==
X-Gm-Message-State: ANoB5pm97M+K9ed/BNTpAi7VjkKX5bkYj619C6n6aNWmkWWHaLC4vPav
        g/ZO+z4S+5B2to8srqksEeBX0aZREWiqXNg++u0=
X-Google-Smtp-Source: AA0mqf5w6JSMtWkV0XA9RD68MjQNRKiSJhwsIl7sptA59Azr1Z33b3n/dt2BmgLm9v2zgUYspH//21/4acaMTwed5mk=
X-Received: by 2002:a92:d988:0:b0:302:d2e5:cc2a with SMTP id
 r8-20020a92d988000000b00302d2e5cc2amr7866949iln.146.1669371679876; Fri, 25
 Nov 2022 02:21:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:b43:0:0:0:0 with HTTP; Fri, 25 Nov 2022 02:21:19
 -0800 (PST)
Reply-To: cristinacampel@outlook.com
From:   "Mrs. Cristina Campbell" <michelleviratfoundation@gmail.com>
Date:   Fri, 25 Nov 2022 10:21:19 +0000
Message-ID: <CAHEFg23zGTmhmuNcpWST1VvwqE7fqojT7H95jTwa=3wsTcq5rA@mail.gmail.com>
Subject: Bent u distributeur van onze producten?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Geachte heer mevrouw


Mijn naam is dr. John Smith; een verkoopadviseur bij Diageo Company
Londen, Verenigd Koninkrijk, Diageo Company is op zoek naar een
betrouwbaar persoon in uw land om hun vertegenwoordiger te zijn als
distributeur van hun producten en merken.

Het Bedrijf zal u 50% Advance Upfront Product verstrekken, als zij
ervan overtuigd zijn dat u betrouwbaar bent en de capaciteit heeft om
de belangen van het Bedrijf te vertegenwoordigen en de producten van
het merk effectief te distribueren in en rond uw land voor
winstmaximalisatie.

Ik zal meer details geven nadat ik van u heb gehoord en als u
ge=C3=AFnteresseerd bent om distributeur en vertegenwoordiger van Diageo
Company in uw land te worden, kunt u mij antwoorden op mijn
persoonlijke e-mail die hieronder wordt vermeld.

Vriendelijke groeten
Dr John Smith
E-mail; johnoffic@hotmail.com
