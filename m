Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A77D9A3E
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Oct 2023 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjJ0Nm1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 27 Oct 2023 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0Nm1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 27 Oct 2023 09:42:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA720D6
        for <linux-cifs@vger.kernel.org>; Fri, 27 Oct 2023 06:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mItSuaFmNvGFKBZCOxk5vVCk90NZM1uEW437lbAh32YDhF9/85nihfmG6RC48g0+r/+0H2KH7zrpWAQAxrc9xQ+0PW7TvziIi3i/PPvNkNxpd8lxBI4NTQ2+LAqaSNKgU7G8Ho8xH551ffdTjVDEFXwLBgWn4wUJux7DjmCwv3AeWsZnyVSs8aNceeM3iOza7tF9jfI8LY3IOIs7E9PEVgCZCCnMfgQDvt/8/8sZNmwFFzcszwaiPJMj9hdSPI9D+4iSads7c+l5/8dxcn2YRipGjim5CaYbFmt3Vi7dSOnvd+5p5Kk5ko4JBp9pWLz3R4lP6k0mkDXp7iXwjPru3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKjqAHOt+rguy1PStl7KaCpZY2gChwik4N8sXX2kk/s=;
 b=WH22QYdsuyIotDoHmqxSUG4lkIoamCMh08Tb4UXEu3rGzHWjo1rxtOgp/soQ76KEqW22XkIsfdnPuAYh8bUGdY0bsUZqw0Pll/K4ulndiJp47f7Ym4qIQkWP9T5QSBcekr69OnuiH1KSI3q9+Z/PQlDnmuk/43N0g9y+K5J6VZknzwa22fOpSQCzJ/xAJUOjHBu1PNyu17h28g58iaXTYrAKw7UFPA9T+lCyEJzEiUV/QuRFQyvZmRrtYPqaMDFiacd+ySuywf6vjilsyt05sV71MX6pQXqBgHQLoZ8mteM1Kk8yRU6KDwHgDSGQbUKzfl1QU0QyxFUWEIehiHjtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKjqAHOt+rguy1PStl7KaCpZY2gChwik4N8sXX2kk/s=;
 b=g6jaFPMNNl2f8Cz3Y/cxJd4tTEbeHJEM1hcoRmoPcKPIrzWzL07OZkmNnBkNvZJC8TWZ4uxkSIjV9FdpIGmhw59aSF+WuozgWPEyibqE9iis9GHbj/rJ7Sv6GjmkhjwqoKE3yReqizUvfTwjOR5CbqDpNWlsycxibHiFqlW6M7I=
Received: from AS9PR06CA0356.eurprd06.prod.outlook.com (2603:10a6:20b:466::23)
 by DU5PR02MB10680.eurprd02.prod.outlook.com (2603:10a6:10:51d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 13:42:21 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::7) by AS9PR06CA0356.outlook.office365.com
 (2603:10a6:20b:466::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Fri, 27 Oct 2023 13:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 13:42:21 +0000
Received: from pc50632-2232.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Oct
 2023 15:42:21 +0200
From:   Rickard Andersson <rickaran@axis.com>
To:     <linux-cifs@vger.kernel.org>, <tom@talpey.com>,
        <sprasad@microsoft.com>, <lsahlber@redhat.com>, <pc@cjr.nz>,
        <sfrench@samba.org>, <rickard314.andersson@gmail.com>
CC:     <rickaran@axis.com>
Subject: [PATCH 0/1] Fix-hang-in-smb2_reconnect
Date:   Fri, 27 Oct 2023 15:42:00 +0200
Message-ID: <20231027134201.2595724-1-rickaran@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|DU5PR02MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: 498a8cfe-d446-463e-cc74-08dbd6f28bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywfSYPec9t5oPY2M4dFPlopALxPc8eIbPIUmeL/GUdqiQklIIevobx8DchzvlC6JWdvGiHrxeDjAawCLPJYKEGnvEsV2HS2R1wYGVynt467M5IOSnZ8SdleDr3jupeLmUA7WZdThPKhAZafg1mfXRDmCgNXC/MPwJ02fHexV7xLZmm1BvWQrRcokMBF03gBbuVxO2shSJGQZfqJ7XWhFDVV1eyh7aMujCVeeRVY0Dd40tpOHNXeXRKNEeMbrNw+RP7RvQUOdvFaiFOy+1CpECFkPFdl3n5EhSodWLIHvgiKTzo6Y2FHyIezw4rA/5TDijJF4OWLUPZ9Nx3Wc48G7ZE55bRPeM6ykTmcoLSYTxwUwNFOCK9kVzPNJwMgUOU7CD/16XRcfPcFozqUO8r91eEFO+Vd97WHG9PlWdLp8rRYzyw9Xqi1/ZtNbvxs4zl01FEDhUGnR7f5qZ9zA8jTVY3s5iLHFJCMLulSFVuEYMeDTbP4+lxpg09UZNJFs52dDNOXl+1tm+pp/PvzMK4sNcyzG6xblrTJHwqLP28GBPviwQG/OEPjbZlnOg8N+osRBIVL6MdU36xfYLv/DV4KvgJm+3W8DEGBJd/0MXjhkhFjKJ9M+LKMJCy4J1PzYdpVRcWTA6DCmTt/vW6t5VfnAYpKKoM+mQ5HTJMJQKjXXqSqH93zVkUxLDWBV+M0vR0KzESqnv698x/Vdog4L/uTg2OuUXhvWxUXggmjx9bODX4tFbBkKg1fEKmVyvwfS4siS8OcOoN7QggbFWD3LQIHWBA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(26005)(336012)(2616005)(16526019)(1076003)(107886003)(426003)(47076005)(356005)(82740400003)(36756003)(81166007)(36860700001)(83380400001)(40480700001)(40460700003)(8676002)(4326008)(8936002)(316002)(110136005)(41300700001)(5660300002)(4744005)(2906002)(7696005)(6666004)(70586007)(70206006)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:42:21.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498a8cfe-d446-463e-cc74-08dbd6f28bad
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10680
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

When applied to Linux 6.1 stable this patch makes one of our test cases
work. However I am not at all familiar with the fs/smb code base and might
have made some misstakes.

Rickard x Andersson (1):
  smb: client: Fix hang in smb2_reconnect

 fs/smb/client/transport.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.30.2

