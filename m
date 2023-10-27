Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7F7D9A3F
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Oct 2023 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJ0Nm3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 27 Oct 2023 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Nm2 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 27 Oct 2023 09:42:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623CD6
        for <linux-cifs@vger.kernel.org>; Fri, 27 Oct 2023 06:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqQZC6UJ9PZIVVANQS26LXXQ1UB9k4Q4jt5bObLB6gNoiBB4Vj7ImU8IeqIB/NswcPIX1N5Um6yp/j7OmPFfTsqTAi6+m9qLH5PUFozpVs8PioDawHs3xtlnwpkeE95cmhdScabKSNm0BMHSbYhgag5dbfkmCHsMtFSkv2qcdIpM6NuNkSo1qhMPcX7mDwdNy89u+xuJOqxCaPR28OTrwMMvvvhz9cDwCSfGHctxYMIx2Bmr2Iq1DitHL3flm/5jEtFeqJmJFPHrJRwICqWdndGHMXobUV0IePxbnz0/g8eo+twwLImqxqrW9/iUrMuikvXw1i1wITP+GLd5bqrlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwItY7dW1ns5evhgi2v692XbXRoZ3/bXLSkJfJQ4JDQ=;
 b=VujnyEB1DdQXOf6xRte3oC4X4tpJZv7UoEd+L6n7mWkkDXM1LNTlPb6jGdgCQQOWRQVgjr0B3v7BeC4n3NQzCqcPuLyNXJSA+F99X11Tyuz1XWMzg2cMHh6C4wZI6MdxHIVmoD1e7s+0NKTKmdNFO6WCzZ8/p/wOEFl/UyFp8prEJYSedpJiBAiHFtOdfgAvExMSb7yIgB4oMQzZME+Q/pXgRM6y2kLWO3ttzyF5hw9h0M5Pjb/uCw9gBFLWlRvIk5HuhDLHKjn1VpLrkUeNw8+xUkFZlCSgI54YxDVLOggpSdXyTY1y4Lg0HyQeMj1cSmL23IksTvYGWu0FP9pWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwItY7dW1ns5evhgi2v692XbXRoZ3/bXLSkJfJQ4JDQ=;
 b=rxExeKVODoNT8Z7KdsVchMsPazZg3yNawGPuJ6PjG3zHwhVf+agjcFi/hpLzbSAlKHZiSKmGDzuWMQtZTrULQ/AyigJxG6FDZvwIXhg47shQ1/iGjTNloKsL8LUa3jWcSogO9L0PzqE8axyCfyGQ0iYqKuaup555HAtrpqdWW9s=
Received: from AS9PR06CA0332.eurprd06.prod.outlook.com (2603:10a6:20b:466::11)
 by GV1PR02MB8884.eurprd02.prod.outlook.com (2603:10a6:150:87::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 13:42:22 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::55) by AS9PR06CA0332.outlook.office365.com
 (2603:10a6:20b:466::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 13:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 13:42:22 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Oct
 2023 15:42:21 +0200
From:   Rickard Andersson <rickaran@axis.com>
To:     <linux-cifs@vger.kernel.org>, <tom@talpey.com>,
        <sprasad@microsoft.com>, <lsahlber@redhat.com>, <pc@cjr.nz>,
        <sfrench@samba.org>, <rickard314.andersson@gmail.com>
CC:     <rickaran@axis.com>
Subject: [PATCH 1/1] smb: client: Fix hang in smb2_reconnect
Date:   Fri, 27 Oct 2023 15:42:01 +0200
Message-ID: <20231027134201.2595724-2-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231027134201.2595724-1-rickaran@axis.com>
References: <20231027134201.2595724-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|GV1PR02MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a1eceb-8de6-4d69-f08f-08dbd6f28bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6o+7BrvFxEuNYRjsXQMXb2UfXXVhsRtvZ4tuJiIV6AcX1BIb6mmUJBAkYF/JLYfF59Ii1GIHRPMgpmcSEb3gWKvaP3Mi5QxuG/qr+pOKJIU4tvBfOix60jxD8aosuQLHYBp9ZL5354DvSh3t7uYgfToZLRa+D84xHi4AEIm4oXPiENJ6nk5nNm7f55v1HMvA77Kg+DKf7/qYUCs28CRAVzlr3ftolZO4NiJLaeeGcmZRs+HlQAt90T2DLh4eNZMFeczLakAxh6t5OVEUl8ec46QWkn6wNAmYOwakx+FOaI0kei2pnZPPQiPA82AjxcRkW1kGOUo01NsIxB80CqozU8VX3qdcJBQ/okYsiaBmbZnnbi/B1jf7hemfWVOWf1kyg4hkpionUY/cU2pZgU/SV4vmf3UG9np8rNn6t+7m0qiIXJbo5kxDJ9bAjen1PGWyigqrVQ5UqAVDxGHuvB2+yhamMnwAqFzYpnZUTPBAcDtVFC+qxXYbVnFDF2D3Hb2jBKEb+WN4k6bxfgY9ulUCWi7V2dyqBj1fHhbSp4N3wh0De8kg7Xb3TPerimax51/hpVFj7ZhKQXtBrcud4HtL/Zzm2RsckTolJOBXlgOF9tUCFLlSWOthTGwBQm/cQAzNdhz3LZC+zQnnE8q0r8evuVK2x1/7QzTUdG9P0PqBpcuboS7L9KbB7L6tPII/7hY62b9Gfu+apQJRIbFKuKRof43pJwFo6nE8hjVCYLOGJXnD1IAPGvA1BPwbfuBqBLvzGcMCdUpbI+8/0HTyNXExA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(8936002)(2906002)(8676002)(41300700001)(4326008)(5660300002)(316002)(70206006)(70586007)(110136005)(40460700003)(36860700001)(40480700001)(26005)(336012)(426003)(1076003)(107886003)(478600001)(2616005)(16526019)(36756003)(7696005)(6666004)(81166007)(82740400003)(83380400001)(47076005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:42:22.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a1eceb-8de6-4d69-f08f-08dbd6f28bf2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

Test case:
mount -t cifs //192.168.0.1/test y -o port=19999,ro,vers=2.1,sec=none,
      echo_interval=1
kill smbd with SIGSTOP
umount /tmp/y

Gives the following error:
INFO: task umount:1470 blocked for more than 122 seconds.
Not tainted 6.1.36-axis9-devel #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:umount          state:D stack:0     pid:1470  ppid:1468
__schedule from schedule+0x60/0x100
schedule from schedule_preempt_disabled+0x24/0x34
schedule_preempt_disabled from __mutex_lock.constprop.0+0x2bc/0x8e0
__mutex_lock.constprop.0 from smb2_reconnect+0x120/0x4e0 [cifs]
smb2_reconnect [cifs] from SMB2_open_init+0x58/0xb1c [cifs]
SMB2_open_init [cifs] from smb2_compound_op+0x1b8/0x1b10 [cifs]
smb2_compound_op [cifs] from smb2_query_path_info+0xf4/0x25c [cifs]
smb2_query_path_info [cifs] from cifs_get_inode_info+0x3d8/0x948 [cifs]
cifs_get_inode_info [cifs] from cifs_revalidate_dentry_attr+0x214/0x3d4
cifs_revalidate_dentry_attr [cifs] from cifs_getattr+0xb4/0x250 [cifs]
cifs_getattr [cifs] from vfs_getattr_nosec+0xac/0xcc
vfs_getattr_nosec from vfs_statx+0x9c/0x140
vfs_statx from do_statx+0x5c/0x80
do_statx from sys_statx+0x64/0x7c
sys_statx from ret_fast_syscall+0x0/0x64

Stack trace for kworker holding mutex:
wait_for_response+0x74/0xb0 [cifs]
compound_send_recv+0x3cc/0xa80 [cifs]
cifs_send_recv+0x34/0x3c [cifs]
SMB2_negotiate+0x428/0x13d4 [cifs]
smb2_negotiate+0x4c/0x58 [cifs]
cifs_negotiate_protocol+0x9c/0x100 [cifs]
smb2_reconnect+0x370/0x598 [cifs]
smb2_reconnect_server+0x210/0x674 [cifs]
process_one_work+0x188/0x490
worker_thread+0x50/0x4f4
kthread+0xf0/0x124
ret_from_fork+0x14/0x2c

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 fs/smb/client/transport.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 87aea456ee90..2fbb9de2d099 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -759,13 +759,14 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 static int
 wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 {
-	int error;
+	int ret;
 
-	error = wait_event_state(server->response_q,
-				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
-				 midQ->mid_state != MID_RESPONSE_RECEIVED,
-				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
-	if (error < 0)
+	ret = wait_event_killable_timeout(server->response_q,
+					  midQ->mid_state != MID_REQUEST_SUBMITTED &&
+					  midQ->mid_state != MID_RESPONSE_RECEIVED,
+					  10*HZ);
+
+	if ((ret < 0) || (ret == 0))
 		return -ERESTARTSYS;
 
 	return 0;
-- 
2.30.2

