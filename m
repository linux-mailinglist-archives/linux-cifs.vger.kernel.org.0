Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1385E76768F
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Jul 2023 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjG1TuY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 28 Jul 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjG1TuX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 28 Jul 2023 15:50:23 -0400
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410A3C07
        for <linux-cifs@vger.kernel.org>; Fri, 28 Jul 2023 12:50:21 -0700 (PDT)
From:   Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1690573819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2C3J9Tk0XRUlrb5yZy7WpiLI7CrUDLjmpi4rmr4xPI=;
        b=qmKugTYsolR7iA43mUN+X0r0indjJBhNkiftkIpD1EC2F4nJ4m1tjHvLW8FPkMdAdJogRm
        MfnQRegUtp8Jf1+ZFYyp7MQqeXgUU3h/jFYM10fbOpkceSvRVdR8N+JKPIpiLKfvmkimVJ
        L1ltIviTT+H1tdLbxr7DTFMa5nWeOOveTFunRsy/CNW1FbTWhvZDx5Ln4Hr3Qq4aXIqqfF
        QzoFETfM3IAXVDJDcFtl6SR+4Jp74EAOrI5sGsgqnqonX28HDAyxY6MhrPcfXRK9OFdt2a
        4S92ITjseau9jxA/gFZmZWrn1daldUGAFI2Lgd2PvITDtCrvS6+KKLCjUNco7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1690573819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j2C3J9Tk0XRUlrb5yZy7WpiLI7CrUDLjmpi4rmr4xPI=;
        b=dTguExKjj5oTst43aeaV9mNaw3HyLlONil8MsLsGAZd8PiNe8+I40di+cT+dQ++CWRsc/c
        ZG9PZX6PydFVQmhTI9/xuCLw2JgaBpy3b/voIpSP21/1NhB8gOWFVB496BfzOd4NacfkCL
        L8S3/CxnXvV7IPeHc+6pFl3EPYff2q0p9uEEqQXg9toOOnF6TfhnIFZquyRyGpAIL6+2HI
        07oCbVRWaH63NiTiseOslPRfiVygAD990d/2ZkbbrqEOz+hK8nFg8RAQ0lIkV0VjeEn6TL
        +x+75VYArPQhz5rgq4qXpX4tSRqSEQzxWnWZpnRVFswAQEMM0PZMFMIdGvjexg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1690573819; a=rsa-sha256;
        cv=none;
        b=k6WW7fzQ000tUnyJRnBYrf3bwlTW1lXa9tuFVLn7o6408uxqS76hD+x6iw7JxR0srg3jVD
        pE9DuLc+mChaR/3GiReakaLsx+LN1zhzgqR6hAAsKFM/7Jy4mrkh+gHQM1jHGpsIXmj/Ha
        smN3KPq2XukDPwkLtqK4wqMnXg9zLw++jeBkcPC1Jk1u7a6aJnerkyN5IgGMz5Po10uVvo
        yTRAO/ET8VxNf9CP2t4YfBxTfsdk2TNl7JzOQ0QaRtxGQHtafweYqnO1e6FO+oNg7iRFLK
        s5fLn3DtLD02v8w6PWB1SWS+GnyD1MesOLz204b5GRTzNpsAekbyaBl6nWtCfw==
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/8] smb: client: reduce stack usage in cifs_try_adding_channels()
Date:   Fri, 28 Jul 2023 16:50:03 -0300
Message-ID: <20230728195010.19122-1-pc@manguebit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Clang warns about exceeded stack frame size

  fs/smb/client/sess.c:160:5: warning: stack frame size (1368) exceeds
  limit (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]

It turns out that cifs_ses_add_channel() got inlined into
cifs_try_adding_channels() which had a stack-allocated variable @ctx
of 624 bytes in size.  Fix this by making it heap-allocated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307270640.5ODmPwDl-lkp@intel.com/
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/sess.c | 68 ++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index c57ca2050b73..5292216d9947 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -360,11 +360,11 @@ cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 {
 	struct TCP_Server_Info *chan_server;
 	struct cifs_chan *chan;
-	struct smb3_fs_context ctx = {NULL};
+	struct smb3_fs_context *ctx;
 	static const char unc_fmt[] = "\\%s\\foo";
-	char unc[sizeof(unc_fmt)+SERVER_NAME_LEN_WITH_NULL] = {0};
 	struct sockaddr_in *ipv4 = (struct sockaddr_in *)&iface->sockaddr;
 	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)&iface->sockaddr;
+	size_t len;
 	int rc;
 	unsigned int xid = get_xid();
 
@@ -388,54 +388,64 @@ cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 	 * the session and server without caring about memory
 	 * management.
 	 */
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto out_free_xid;
+	}
 
 	/* Always make new connection for now (TODO?) */
-	ctx.nosharesock = true;
+	ctx->nosharesock = true;
 
 	/* Auth */
-	ctx.domainauto = ses->domainAuto;
-	ctx.domainname = ses->domainName;
+	ctx->domainauto = ses->domainAuto;
+	ctx->domainname = ses->domainName;
 
 	/* no hostname for extra channels */
-	ctx.server_hostname = "";
+	ctx->server_hostname = "";
 
-	ctx.username = ses->user_name;
-	ctx.password = ses->password;
-	ctx.sectype = ses->sectype;
-	ctx.sign = ses->sign;
+	ctx->username = ses->user_name;
+	ctx->password = ses->password;
+	ctx->sectype = ses->sectype;
+	ctx->sign = ses->sign;
 
 	/* UNC and paths */
 	/* XXX: Use ses->server->hostname? */
-	sprintf(unc, unc_fmt, ses->ip_addr);
-	ctx.UNC = unc;
-	ctx.prepath = "";
+	len = sizeof(unc_fmt) + SERVER_NAME_LEN_WITH_NULL;
+	ctx->UNC = kzalloc(len, GFP_KERNEL);
+	if (!ctx->UNC) {
+		rc = -ENOMEM;
+		goto out_free_ctx;
+	}
+	scnprintf(ctx->UNC, len, unc_fmt, ses->ip_addr);
+	ctx->prepath = "";
 
 	/* Reuse same version as master connection */
-	ctx.vals = ses->server->vals;
-	ctx.ops = ses->server->ops;
+	ctx->vals = ses->server->vals;
+	ctx->ops = ses->server->ops;
 
-	ctx.noblocksnd = ses->server->noblocksnd;
-	ctx.noautotune = ses->server->noautotune;
-	ctx.sockopt_tcp_nodelay = ses->server->tcp_nodelay;
-	ctx.echo_interval = ses->server->echo_interval / HZ;
-	ctx.max_credits = ses->server->max_credits;
+	ctx->noblocksnd = ses->server->noblocksnd;
+	ctx->noautotune = ses->server->noautotune;
+	ctx->sockopt_tcp_nodelay = ses->server->tcp_nodelay;
+	ctx->echo_interval = ses->server->echo_interval / HZ;
+	ctx->max_credits = ses->server->max_credits;
 
 	/*
 	 * This will be used for encoding/decoding user/domain/pw
 	 * during sess setup auth.
 	 */
-	ctx.local_nls = cifs_sb->local_nls;
+	ctx->local_nls = cifs_sb->local_nls;
 
 	/* Use RDMA if possible */
-	ctx.rdma = iface->rdma_capable;
-	memcpy(&ctx.dstaddr, &iface->sockaddr, sizeof(struct sockaddr_storage));
+	ctx->rdma = iface->rdma_capable;
+	memcpy(&ctx->dstaddr, &iface->sockaddr, sizeof(ctx->dstaddr));
 
 	/* reuse master con client guid */
-	memcpy(&ctx.client_guid, ses->server->client_guid,
-	       SMB2_CLIENT_GUID_SIZE);
-	ctx.use_client_guid = true;
+	memcpy(&ctx->client_guid, ses->server->client_guid,
+	       sizeof(ctx->client_guid));
+	ctx->use_client_guid = true;
 
-	chan_server = cifs_get_tcp_session(&ctx, ses->server);
+	chan_server = cifs_get_tcp_session(ctx, ses->server);
 
 	spin_lock(&ses->chan_lock);
 	chan = &ses->chans[ses->chan_count];
@@ -497,6 +507,10 @@ cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 		cifs_put_tcp_session(chan->server, 0);
 	}
 
+	kfree(ctx->UNC);
+out_free_ctx:
+	kfree(ctx);
+out_free_xid:
 	free_xid(xid);
 	return rc;
 }
-- 
2.41.0

