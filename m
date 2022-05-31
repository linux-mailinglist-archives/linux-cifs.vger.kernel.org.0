Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C533538B21
	for <lists+linux-cifs@lfdr.de>; Tue, 31 May 2022 08:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiEaGB4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 31 May 2022 02:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiEaGBz (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 31 May 2022 02:01:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BB6401
        for <linux-cifs@vger.kernel.org>; Mon, 30 May 2022 23:01:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 199so2268833qkk.0
        for <linux-cifs@vger.kernel.org>; Mon, 30 May 2022 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RypKbNDeXCWqLxEbYPM0W13Ul8igrqF7djJW72uTfX0=;
        b=IaNwZZT2DelZf3ciyMr9KI3Mismoz67057TRifrQO/+qc1Mv9q2Y5VzHnrdt5FspcK
         QA9kjAV9+3hItEvI1RW566MKLaXR1p4jswxI9dk7jB5eh3vAgmNWO42Z2VVGY5mK390T
         LJzQbRdUB6DtiCT6DZtgVDTrPS6evJykK3Nyc6C2F41nBvdKVa7pmAFV9/Bbyb2a1Fry
         4PsysaDTkQlzwZftx+iMq89JnGtL9PirM3r3S7ItY+aUq/pXNLEg8JhFnDhwsbfpzliF
         Ox5/lQQE1uTCVOOp5o3kQ0jxlvqJyC6EQQBUgHExCzNwOATGADx9lyuNMH7pTtevpkiz
         2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=RypKbNDeXCWqLxEbYPM0W13Ul8igrqF7djJW72uTfX0=;
        b=TVe855D77M2F/4X8t438z2QvFEuqENaYj3aZ9lXoVmvZUP/CKmIq5TPNYEEuKIS1Vl
         Sf/Xbp9T9kQIVL9DalTeGGapEtktEdV+ko1Gb1KZOETeT3K797jbIY31BBDTCqPHwoej
         r4XDvUqYJC7eb7AjHFKKVn1evAGKBNah9GcWdmuCcdTaZTOqTeVAEVyiZhEEExg1OXKG
         A/hNETaD0c9B7Np9usDashcp98+cv81cvCe7HvmxxVfKHAcqhrqVl5wVyLEuBEMhWzbW
         8DIKlsLha9hJ3RwTKW/NS7fmFHpe92FhvSJk6bblir1SaoyD0eHZFzAEE+kvndIDYnyX
         aw9w==
X-Gm-Message-State: AOAM530YOxA/RvPjUk0BbW2jY6nOi4HhlLPBANbaNShbNdxp34ipo+L/
        y9U90V8KT5k+/CNIphtOdOg6EMILfhbMKzMvnQg=
X-Google-Smtp-Source: ABdhPJyh9RY9NVe/r3xxERFt1a4hvr+vCbpqZ4MEgclVsNMomUWKLu5/RY0lqTnaAum9lBUlAPx9Wc4rKsZBU29Gkpg=
X-Received: by 2002:a05:620a:16d9:b0:6a3:75ae:b39d with SMTP id
 a25-20020a05620a16d900b006a375aeb39dmr30373657qkn.274.1653976913174; Mon, 30
 May 2022 23:01:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:54ca:b0:42e:7706:c632 with HTTP; Mon, 30 May 2022
 23:01:52 -0700 (PDT)
Reply-To: josephinefortin143@gmail.com
From:   JOSEPHINE FORTIN <duponta727@gmail.com>
Date:   Mon, 30 May 2022 18:01:52 -1200
Message-ID: <CADr16W4gOK9sisLrT2jim9SX8XBW5hpFL6sVBv3a65Mk2fMAVQ@mail.gmail.com>
Subject: BONJOUR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:733 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [duponta727[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [josephinefortin143[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [duponta727[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--=20
Je m'appelle  Mme FORTIN Josephine de nationalit=C3=A9 fran=C3=A7aise. Je v=
ous
envoie ce pr=C3=A9sent message afin de solliciter votre accord pour la
r=C3=A9alisation d'un projet de donation. Ayant perdu mon =C3=A9poux et mon
enfant de 18 ans au cours d'un accident tragique et mortel Il y a
quelques ann=C3=A9es, je n'ai ni famille ni enfant qui pourra b=C3=A9n=C3=
=A9ficier de
ma fortune.
Actuellement hospitalis=C3=A9e en Am=C3=A9rique pour un cancer en phase ter=
minale,
je d=C3=A9cid=C3=A9 de faire don de ma fortune afin que vous puissiez r=C3=
=A9aliser
les =C5=93uvres de charit=C3=A9 de votre choix.
Pour cela je vous l=C3=A8gue =C3=A0 titre de donation.une somme de DEUX MIL=
LION
CENT MILLE EUROS ( 2.100.000  en banque en
Afrique de l=E2=80=99ouest o=C3=B9
je m=E2=80=99=C3=A9tais install=C3=A9e apr=C3=A8s la mort de mon mari et de=
 mon enfant.
Merci me de r=C3=A9pondre pour plus de d=C3=A9tails. E-mail /
josephinefortin143@gmail.com
