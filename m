Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CF608523
	for <lists+linux-cifs@lfdr.de>; Sat, 22 Oct 2022 08:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJVGcM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 22 Oct 2022 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJVGcK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 22 Oct 2022 02:32:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2134719
        for <linux-cifs@vger.kernel.org>; Fri, 21 Oct 2022 23:32:07 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MvWb82Z5zz15M0G;
        Sat, 22 Oct 2022 14:27:16 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 14:32:03 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>,
        <longli@microsoft.com>
Subject: [PATCH 0/2] Fix memory and page leak when writedata alloc failed
Date:   Sat, 22 Oct 2022 15:35:19 +0800
Message-ID: <20221022073521.1660841-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Zhang Xiaoxu (2):
  cifs: Fix pages leak when writedata alloc failed in
    cifs_write_from_iter()
  cifs: Fix pages array leak when writedata alloc failed in
    cifs_writedata_alloc()

 fs/cifs/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.31.1

