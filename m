Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5212A5CC
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Dec 2019 04:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLYDXK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 24 Dec 2019 22:23:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLYDXK (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 24 Dec 2019 22:23:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F156D85CCCA33EADA07;
        Wed, 25 Dec 2019 11:23:08 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 11:23:00 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <sfrench@samba.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/2] fs/cifs: use true,false for bool variable
Date:   Wed, 25 Dec 2019 11:30:19 +0800
Message-ID: <1577244621-117474-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

zhengbin (2):
  fs/cifs/smb2ops.c: use true,false for bool variable
  fs/cifs/cifssmb.c: use true,false for bool variable

 fs/cifs/cifssmb.c | 4 ++--
 fs/cifs/smb2ops.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--
2.7.4

