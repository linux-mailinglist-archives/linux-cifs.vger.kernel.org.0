Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0C32487E
	for <lists+linux-cifs@lfdr.de>; Thu, 25 Feb 2021 02:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYBYL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 24 Feb 2021 20:24:11 -0500
Received: from mx.cjr.nz ([51.158.111.142]:26676 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhBYBYK (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:24:10 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 28C6C7FF6A;
        Thu, 25 Feb 2021 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1614216202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+ufJqsdWLy6nxmQFl6g6OjNQLfyPn1zTkhwh7F2qQ8=;
        b=Uxjzq7biDSJhL0G+vSUmLjcvW4vQsa6nUa+k8D0R489No1swpY0GxEVfSYNzFVbn6FUm7O
        XURoOqE25NRaGZszVaaHUMIG6xngIW2pz+UiTuI1DsVAXOGdQ6iTeVXaw4vzUYoGFPMbYy
        yeOSwmiGnpxxxUqPW2eWxuQkEfV8r1vPI8RQ8EBgsKAQembJL1q1aELvCPiQ9aEjeyKwK6
        vtF5cCYRl2WhR2+j8Po1lA+QDyqAipGe7O4HRCn4HOY0Md1AJtESIzcDVDLBg9VOk3VK0I
        B0Cj8faq68Q27QM4wz/iSaaic95/BNOmEGzqGz5nfHRBKQWNC/BHb+vkEccI8Q==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 1/4] cifs: fix DFS failover
In-Reply-To: <CAH2r5muMt3gmmtLOBxaOqqh-KfccSDDuta6ob218_w9WQZdmbA@mail.gmail.com>
References: <20210224235924.29931-1-pc@cjr.nz>
 <CAH2r5muMt3gmmtLOBxaOqqh-KfccSDDuta6ob218_w9WQZdmbA@mail.gmail.com>
Date:   Wed, 24 Feb 2021 22:23:16 -0300
Message-ID: <87y2fdszy3.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:

> is this series of 4 identical with
>    https://git.cjr.nz/linux.git/commit/?h=dfs-fixes-v2

Nope.  Please pull from git://git.cjr.nz/linux.git dfs-fixes
