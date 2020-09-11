Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8C2657CC
	for <lists+linux-cifs@lfdr.de>; Fri, 11 Sep 2020 05:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKD66 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 10 Sep 2020 23:58:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgIKD64 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 10 Sep 2020 23:58:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5CA0CFAF68D513454F8A;
        Fri, 11 Sep 2020 11:58:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 11:58:44 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <sfrench@samba.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 0/5] cifs: fix comparison to bool warning
Date:   Fri, 11 Sep 2020 12:05:34 +0800
Message-ID: <20200911040539.113307-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Zheng Bin (5):
  cifs: fix comparison to bool warning in cifsacl.c
  cifs: fix comparison to bool warning in file.c
  cifs: fix comparison to bool warning in smb2misc.c
  cifs: fix comparison to bool warning in connect.c
  cifs: fix comparison to bool warning in smb2ops.c

 fs/cifs/cifsacl.c  |  2 +-
 fs/cifs/connect.c  |  6 +++---
 fs/cifs/file.c     |  2 +-
 fs/cifs/smb2misc.c |  2 +-
 fs/cifs/smb2ops.c  | 10 +++++-----
 5 files changed, 11 insertions(+), 11 deletions(-)

--
2.26.0.106.g9fadedd

