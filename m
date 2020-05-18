Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9A1D7077
	for <lists+linux-cifs@lfdr.de>; Mon, 18 May 2020 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgERFqh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 18 May 2020 01:46:37 -0400
Received: from sonic317-40.consmr.mail.ne1.yahoo.com ([66.163.184.51]:37744
        "EHLO sonic317-40.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbgERFqh (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 18 May 2020 01:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589780796; bh=k/oTgQ5W9vrPYh5U8kvmjj55YKMnaFv4ukLTEmZOhdQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=AijXo3VL4bTrYTOOIDVwVR/D9T2pLw5YP9Ye1vD/wKrKjbHd6X8xh8P+JAZGJ1HdxLTlVmAomMJw6Xp/r7lsCwGaBkH7xJ0C0Im/MRAlbqMF7henMECZuV3tr6Ef6KCEk2pnnRaYzE2fEW4vQOBz+SCQnGapYE9xFMeKlOKR+F5D08RvuUuBrOZjHOadXP1UcUy9jOmEuNC5FApMsIYZVPi4LmaLKx4hAC0hxY+7xsEtrGNK7JcOg3Kun23jYUFETJLwJM3DOzh9K3nJauBKbOMZRGzYVsfn7NHT0wocTTUfyvj6x5miPAZ45S5kY+vg6iera55BxausFlu7k+UIBg==
X-YMail-OSG: Fpraf7gVM1k1v01goETk27YZ5FpMAafQ3kUBwFz6NvSnVSmI18tT5mUKCBImu.U
 rOhgTEZmOR848okn8uSVzcdGRjr1ER2TtqAxYz7Ht.F87WtIDSicmOajojxDZjQ7hGrdShW9.PUH
 TR1x_KWVotxJrKWvKjcZKnlO2QS015V5G2eLYmWvsfeRaDv9OX_QwqLWn7C4of6dLjuAbzY6xpeV
 wVZRvtlhhWYY1bsd00D9MZNaQYpbzyBj.3tEyUJhSLt_u4JqgEB3vGoqc3alYFfUhM4afSyX.kSm
 ECxdLtCBu4R8Ivb.rBGuHHdQzT2xFJLpMbvVDOt1wV5LacyJhDTZJZb9lJRYUx2Jtc5aVu_x4T6_
 4t5cx59JapJbJCLkuXpbJX9v3yxvsw8SgLkSbbWBaDZ51S0FhZh9GlCLmCLVS4ZJNu4KjvxnEUX3
 AHcxFrJyid0OeZYQdgqaEy505b038.EsGrL1t3Eyqs5CUDXnASwUSe.GEjO3pbuB5kFa936JcC1H
 OGvhjdDdAZZgx5VXnjDdgX7tnYF4.bakSd7hRXStLFjqV6Ht0EfChuOkjhmj7X_qFEv48hZLxU9H
 6cUESZhLwvJvdcJso2OOM0DcPZyVNTacMHtGPXRbKis.pyfoScBq3bfapMAulTHk5CSlxdfsItOk
 QGsn8K_671l6dCScN9BOsQUnGnsZCrmH1NqurbtcIKSrVcwrURF4WEPt9lupQqTlPsePfG2UByTY
 TGLkVcoyMvKVtWkdeOJvJCIxbzaF7rN.6QXWHg5gHyA0Ms_vgHaK6H1E.3Q4eRlb9faBYzUfw3J_
 JOuf90V1SbnbJ7vzhMWHag88kLNEjPswjSTE0MC99J_5Dk.hMDdc4oDH7c8RYwm16BupiD4__mDK
 JJcw_HNCe4Cvuy3gCCbzH71WvuR0GLBimBw_QEjdWeMoZfSZX7193nBdg309xPcLh_1.TquWfKob
 5XmAb5XNJUIbv0hypQbXS5ctJJJn64.WudacIVfHBvBPe1hBmdnaNOVTBuEDH9Kxc1r75XqNaqLp
 88fHqnRHO0TKp9eddLIZh5RCdg.pGI5zQjHAn_JK_iTPSAN.b487evEas0AXG8VsMDZs2bIrNBCd
 bGmqjyTfOIViBle8IfrRnXDMdZBlTIzYm04Afur1WVuu96mWN6yqch67.EiLxy7Hg4Sn4z2__JjW
 OywEV9fleFqF4GpyanVNtb6TLrBKNtzFY.GF5LcGrPci0L_MRJ4qGaqgzL3Xn7MWfBXDr_P1d_wN
 GDHaHLWXCQmVmbzuKwziCRCLhaS5ziogiDzFykgogZg0PEm8xe6mqhg2i5MssAzw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 May 2020 05:46:36 +0000
Date:   Mon, 18 May 2020 05:46:31 +0000 (UTC)
From:   Maureen Hinckley <as2@bcutm.com>
Reply-To: maureenhinck0@gmail.com
Message-ID: <2030550404.679210.1589780791503@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2030550404.679210.1589780791503.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maureenhinck0@gmail.com)=
 for further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
