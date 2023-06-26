Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778073D695
	for <lists+linux-cifs@lfdr.de>; Mon, 26 Jun 2023 05:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFZDna (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 25 Jun 2023 23:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFZDn3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 25 Jun 2023 23:43:29 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABD189
        for <linux-cifs@vger.kernel.org>; Sun, 25 Jun 2023 20:43:25 -0700 (PDT)
X-QQ-mid: bizesmtp77t1687750991t98fphgg
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 11:43:10 +0800 (CST)
X-QQ-SSF: 01400000000000F0H000000A0000000
X-QQ-FEAT: 4g9JbZ7lBbEdxKiVdvUE0lRRUtKekc3NXg7csNxZN/HgbCBLhq542jT6pD8UV
        80FxoqNQ2OaC1aRA5GHeLEGLJNqLCpOOO2f5sLbNArtzEL/uL8rpndnZkyABOCnpflMBpwj
        SVKkYY0MFviFPH6fUzvXfvrBeRG6D+7HoG59ocxuc+ZSf6PiPz6yZL96tS7jPdk5Z6jC8qw
        i20hSpHK7ZSyg37SzaVEF+ZQ51cKbA21VN1I/nKatNPdiBZH/U914NY8BYNg8zgKm+xlCZ8
        Jo++CoqNRveIfvmm/mcWBdm6NYHTAI7KrtcrP59SnRyIHkBHffwWL3vCbjAgf0n9Rypya6D
        UHVy1ZoywrgDPkWW9tgSrHg2LqqW+3KxRH6dd4THJ05Bud3qhJa2ZqSGqEdJT9VJ/gKJTXC
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 204597781179879045
From:   Winston Wen <wentao@uniontech.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org, pc@manguebit.com,
        sprasad@microsoft.com
Subject: [PATCH 0/3] cifs: fix session state checks to avoid use-after-free issues
Date:   Mon, 26 Jun 2023 11:42:54 +0800
Message-Id: <20230626034257.2078391-1-wentao@uniontech.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The patchset has 3 patches that fix some problems related to session state check/transition to avoid use-after-free issues.

Winston Wen (3):
      cifs: fix session state transition to avoid use-after-free issue
      cifs: fix session state check in reconnect to avoid use-after-free issue
      cifs: fix session state check in smb2_find_smb_ses

 fs/smb/client/connect.c       | 7 ++++---
 fs/smb/client/smb2pdu.c       | 6 ++++++
 fs/smb/client/smb2transport.c | 7 +++++++
 3 files changed, 17 insertions(+), 3 deletions(-)


