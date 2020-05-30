Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE64C1E91C4
	for <lists+linux-cifs@lfdr.de>; Sat, 30 May 2020 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgE3NiV (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 30 May 2020 09:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgE3NiU (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 30 May 2020 09:38:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D56C03E969
        for <linux-cifs@vger.kernel.org>; Sat, 30 May 2020 06:38:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u23so4176319otq.10
        for <linux-cifs@vger.kernel.org>; Sat, 30 May 2020 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bDUUTxPkBJMvAjdz7jhxo6WKrfE2gACIVEtBlGY7vyw=;
        b=a6iLMxlRxlxyX4rMcbgXsDPLxZWGxVqwjb9+DmabA+gWXS0P5azoWKQ9/Ec88QyHLz
         F7TvHAEkePFm603MSl7rCnAVWkATVxKqlexJe9yWXY0nd6ygHd1xtcxTXEI7co4D8EBj
         iXKIPnsskD6ruzGIXYVnOt6RdRhVtHai/AG/ai7I6cbWyQH09qLJ39lo7SDYYW7X+Vcd
         vagPyI+e0VJaEVezSLB7uaqMJJkAUmyRajRx7wL3bAEx/0/FtPvUfbb96kaPkAlWLCY0
         mi8wN3P/B84PqG9bJXuwe6Y/uPvFxlspGOwFglGKuLTJUInxb97V5L9lkbFFfRDkJdF/
         FTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bDUUTxPkBJMvAjdz7jhxo6WKrfE2gACIVEtBlGY7vyw=;
        b=JCJ/+89h/KwwMkUcOZv5j1JVa8fvljm56U4RAl1Yx+dqQmZT7WPhHe2wXnOpBgEXji
         v4iElK1D4kfae4jLm2S9h7gyE8m9xvQOrUV2l1+1SR9UfHedxVLJ8DaHvQSZOq5Hmh7r
         4QmoTvJvq3TjRV+apniY1ccHFDauQ8Gk9fmnhxCCQvAAJujwGnaFg+gJDbyCFxu8/fc1
         pSqqP5O3nfEdwPOdPb2JEV4iTS2W7uiFWNyAHFj8gA6rhdFp8AOmJzlEL4ywXeWWc1G+
         gvXbNWoNK/zaIjFL5YeqtC+TGyJeXjP9GexEExFCxaiDxf7kT7wV8JzXmIrPHHorreZC
         Ivpw==
X-Gm-Message-State: AOAM533R7AXnctScZZYgx/5nQmt3q/s+S6sn8T3RRaxDXJqUfASO21ju
        jNNRH7/pUG20JFuoP/4rvlUsM/220mXotpORx/fRcMBiwiHNGA==
X-Google-Smtp-Source: ABdhPJzTVOaW/4j55Sq1qERj2WyFXS7UGJ308W2VGe2LCJRG6BerKxekDFK+QXsnegVXYcPrwPu6hC3YKO+mqnywGOA=
X-Received: by 2002:a9d:6245:: with SMTP id i5mr5441912otk.111.1590845899907;
 Sat, 30 May 2020 06:38:19 -0700 (PDT)
MIME-Version: 1.0
From:   Cong Zhang <congzhangzh@gmail.com>
Date:   Sat, 30 May 2020 21:38:07 +0800
Message-ID: <CAOXDmPpr1AWdeW9h1qwcmE93jwhZKoZmvr4ReG52Lrocisz-eQ@mail.gmail.com>
Subject: 
To:     linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

unsubscribe linux-cifs
