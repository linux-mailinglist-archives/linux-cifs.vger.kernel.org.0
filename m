Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549C73293E
	for <lists+linux-cifs@lfdr.de>; Fri, 16 Jun 2023 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbjFPHus (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 16 Jun 2023 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbjFPHur (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 16 Jun 2023 03:50:47 -0400
Received: from mail.durme.pl (mail.durme.pl [217.182.69.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BB2728
        for <linux-cifs@vger.kernel.org>; Fri, 16 Jun 2023 00:50:44 -0700 (PDT)
Received: by mail.durme.pl (Postfix, from userid 1002)
        id 1E6C14D78D; Fri, 16 Jun 2023 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=durme.pl; s=mail;
        t=1686901631; bh=hFxZwVw4rIL+JwfEOGI47p+fdoVOAeqVswP6NWoHSHQ=;
        h=Date:From:To:Subject:From;
        b=Lkx+kXfUbyd7IWvjMRxEgNloZS4blGdr+rgjP/16sAmogbUxm5jrNPfzcg2faV24R
         LDWui97rhhYrnL3Xeo2QYd9k1/hm6QjUMfAHwVGpmNwqWTKFKSmn+zmyuyWCm9fxFT
         SmwDtG60kBAk65nbzTyh2uVdxEfsZ85e3avCH23CUiRz2NFrT6FvIO+zYIqTtMUSYV
         rQ6k5SnVNuOpi6ph6Pgn8sD7BWn4SXzLcb4X7/LgRLGddyfz4n9QkM3Anac2rdweBs
         f5hvZRyz9F6mh0nLVp8Rs4Nzi/AK91LdDLJDyjwdHbAkvsv3kxt19benb6wLFLgj0F
         0xx7WDtW796Lg==
Received: by mail.durme.pl for <linux-cifs@vger.kernel.org>; Fri, 16 Jun 2023 07:46:04 GMT
Message-ID: <20230616064502-0.1.2j.aygn.0.0i9wn4maq3@durme.pl>
Date:   Fri, 16 Jun 2023 07:46:04 GMT
From:   "Krystian Wieczorek" <krystian.wieczorek@durme.pl>
To:     <linux-cifs@vger.kernel.org>
Subject: W sprawie samochodu
X-Mailer: mail.durme.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: durme.pl]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: durme.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [217.182.69.186 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: durme.pl]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [217.182.69.186 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Dzie=C5=84 dobry,

chcieliby=C5=9Bmy zapewni=C4=87 Pa=C5=84stwu kompleksowe rozwi=C4=85zania=
, je=C5=9Bli chodzi o system monitoringu GPS.

Precyzyjne monitorowanie pojazd=C3=B3w na mapach cyfrowych, =C5=9Bledzeni=
e ich parametr=C3=B3w eksploatacyjnych w czasie rzeczywistym oraz kontrol=
a paliwa to kluczowe funkcjonalno=C5=9Bci naszego systemu.=20

Organizowanie pracy pracownik=C3=B3w jest dzi=C4=99ki temu prostsze i bar=
dziej efektywne, a oszcz=C4=99dno=C5=9Bci i optymalizacja w zakresie pono=
szonych koszt=C3=B3w, maj=C4=85 dla ka=C5=BCdego przedsi=C4=99biorcy ogro=
mne znaczenie.

Dopasujemy nasz=C4=85 ofert=C4=99 do Pa=C5=84stwa oczekiwa=C5=84 i potrze=
b organizacji. Czy mogliby=C5=9Bmy porozmawia=C4=87 o naszej propozycji?


Pozdrawiam
Krystian Wieczorek
