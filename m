Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D962EE87
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Nov 2022 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiKRHhj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 18 Nov 2022 02:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbiKRHhe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 18 Nov 2022 02:37:34 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87F8B12D
        for <linux-cifs@vger.kernel.org>; Thu, 17 Nov 2022 23:37:31 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND7p30zCgzJnqW;
        Fri, 18 Nov 2022 15:34:19 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:37:29 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>,
        <longli@microsoft.com>
Subject: [PATCH 0/2] cifs: Fix resource leak when MR allocate failed
Date:   Fri, 18 Nov 2022 16:42:06 +0800
Message-ID: <20221118084208.3214951-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
  cifs: Fix lost destroy smbd connection when MR allocate failed
  cifs: Fix warning and UAF when destroy the MR list

 fs/cifs/smbdirect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.31.1

