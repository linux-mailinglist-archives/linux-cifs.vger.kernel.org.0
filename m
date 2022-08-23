Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4859EB45
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Aug 2022 20:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiHWSnn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 23 Aug 2022 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHWSn0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 23 Aug 2022 14:43:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282AA3456
        for <linux-cifs@vger.kernel.org>; Tue, 23 Aug 2022 10:07:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bx38so14092025ljb.10
        for <linux-cifs@vger.kernel.org>; Tue, 23 Aug 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=XKPjnTfiFmb3bwUJcntr+ptwjaPu0S/8czQGmiZfat8=;
        b=EonjHWP5QG8gEuK2tWlb3pBWa3bSDqoQNs4K5cuJjoHNzpTfifkK82v1nU9qV35bed
         3uny3glycufZukidDkjV8n6Gb83iPK4IaTT/ZxG47zdmzbU9VgPqQunD9kc6F6SXWG9u
         wa2w1W67d5tluH5GxzprQniDfUdFliyiM/EsvPu4p3W3pv2y1qvrMdl2tLBtF7IRUWee
         W3DJM9BiWteu4SpJW1cyBje/G8qPjwDd1bIp6KQq+0HV+C9eZcN7RBymnw3ML3dWlzUi
         EdG4+MjbloAzymfa7yu4tz8Wd+xFHLKXZKYrhgOeXXyyUDVNrmFDYPi6GQFVKZPU6Swh
         L7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XKPjnTfiFmb3bwUJcntr+ptwjaPu0S/8czQGmiZfat8=;
        b=miGK6/wloQ2/LSd4oHbwCIrsFr3pKx4VivspCm/LSJseCBDnVhtIt5k0XpeTxiG7SM
         5CM/dxGgZLqX9hUtaMxbJhIMQLOc+VF5LmOC2fu2in1rW3/Y599ofzvAFb+1MWW5BuaN
         uVHa7U9a84llbKTQCMjfk0Q9ypoqKz7HOvAdRv2xJZPpSTnnwBeiyCl1fg+DhWwHCbPA
         leWUYhQaJhpGamL0Cai+aMUxOs8hndItpjiQRNSB/TLi1LjuaFOh5R7H+ksl5Aeq6kSe
         3x80nHZ3J9LwZgxk1f0bwoSzSQduptJA0dSkbn/S0fBZsmiAP9khf0bE6eFT0c1jVFuB
         0K+g==
X-Gm-Message-State: ACgBeo3Y3k6oeKqpDSN3jUFqK1yiofb2z88FhFYfnY5TBGAiQlwV33GD
        +S2MB/20fc9UrCmMDlPTTa9UrM0YmExM6VjDgAU=
X-Google-Smtp-Source: AA6agR6hl4E0kPZgeqXFf+HQWwOEPkTf7rWF9NICPcEtVyv+WhQeOXuDlXmjZ+uaApE5CxGc5RYeX+bXWnTgK54Z3cg=
X-Received: by 2002:a2e:9205:0:b0:261:b4c7:5a7 with SMTP id
 k5-20020a2e9205000000b00261b4c705a7mr6877432ljg.247.1661274433785; Tue, 23
 Aug 2022 10:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:178e:b0:154:c304:b3fb with HTTP; Tue, 23 Aug 2022
 10:07:13 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL <musasaniimamkademi@gmail.com>
Date:   Tue, 23 Aug 2022 10:07:13 -0700
Message-ID: <CAE0v3Nh23SLby_fQbOzFZw130ETs1xuvudKPmC63ddFG3FEU6A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--=20
h Guten Tag,
Ben=C3=B6tigen Sie dringend einen Kredit f=C3=BCr den Hauskauf? oder ben=C3=
=B6tigen
Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um zu investieren? ein neues
Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Zahlen Sie uns die
Installationen zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen.
Wir bieten Privatpersonen und Unternehmen Kredite an. Wir bieten
zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz von 2 %. F=C3=BC=
r
weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com........
