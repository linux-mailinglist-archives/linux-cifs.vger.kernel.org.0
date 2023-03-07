Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598046AEC0C
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Mar 2023 18:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjCGRvw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Mar 2023 12:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjCGRv3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Mar 2023 12:51:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CF584A3;
        Tue,  7 Mar 2023 09:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A23B819B4;
        Tue,  7 Mar 2023 17:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF78C433D2;
        Tue,  7 Mar 2023 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678211163;
        bh=RWAImVFas2It3Rt5Glwm6asNoUdBBRXVmcsw/fEkPH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgTOLRIVgQ856Leb8kAD/fAvza6+B7946ycAShjfMw6VHSJwNTOmwzEi2CUn/nlO5
         SsxlGNuI19rS+9t5OrhLELIcGlRDh2FBF9UzmBCALVTjYRDljIDY1OZszOPqNDqQhA
         m43cqr4sjoLbb0A2jXDhIgArVdA3WL3RsrktNYAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Metzmacher <metze@samba.org>,
        Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-cifs@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.2 0774/1001] cifs: introduce cifs_io_parms in smb2_async_writev()
Date:   Tue,  7 Mar 2023 17:59:06 +0100
Message-Id: <20230307170055.341925106@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307170022.094103862@linuxfoundation.org>
References: <20230307170022.094103862@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Stefan Metzmacher <metze@samba.org>

commit d643a8a446fc46c06837d08a056f69da2ff16025 upstream.

This will simplify the following changes and makes it easy to get
in passed in from the caller in future.

Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2pdu.c |   53 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 14 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4504,10 +4504,27 @@ smb2_async_writev(struct cifs_writedata
 	struct kvec iov[1];
 	struct smb_rqst rqst = { };
 	unsigned int total_len;
+	struct cifs_io_parms _io_parms;
+	struct cifs_io_parms *io_parms = NULL;
 
 	if (!wdata->server)
 		server = wdata->server = cifs_pick_channel(tcon->ses);
 
+	/*
+	 * in future we may get cifs_io_parms passed in from the caller,
+	 * but for now we construct it here...
+	 */
+	_io_parms = (struct cifs_io_parms) {
+		.tcon = tcon,
+		.server = server,
+		.offset = wdata->offset,
+		.length = wdata->bytes,
+		.persistent_fid = wdata->cfile->fid.persistent_fid,
+		.volatile_fid = wdata->cfile->fid.volatile_fid,
+		.pid = wdata->pid,
+	};
+	io_parms = &_io_parms;
+
 	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
@@ -4517,26 +4534,31 @@ smb2_async_writev(struct cifs_writedata
 		flags |= CIFS_TRANSFORM_REQ;
 
 	shdr = (struct smb2_hdr *)req;
-	shdr->Id.SyncId.ProcessId = cpu_to_le32(wdata->cfile->pid);
+	shdr->Id.SyncId.ProcessId = cpu_to_le32(io_parms->pid);
 
-	req->PersistentFileId = wdata->cfile->fid.persistent_fid;
-	req->VolatileFileId = wdata->cfile->fid.volatile_fid;
+	req->PersistentFileId = io_parms->persistent_fid;
+	req->VolatileFileId = io_parms->volatile_fid;
 	req->WriteChannelInfoOffset = 0;
 	req->WriteChannelInfoLength = 0;
 	req->Channel = 0;
-	req->Offset = cpu_to_le64(wdata->offset);
+	req->Offset = cpu_to_le64(io_parms->offset);
 	req->DataOffset = cpu_to_le16(
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes = 0;
 
-	trace_smb3_write_enter(0 /* xid */, wdata->cfile->fid.persistent_fid,
-		tcon->tid, tcon->ses->Suid, wdata->offset, wdata->bytes);
+	trace_smb3_write_enter(0 /* xid */,
+			       io_parms->persistent_fid,
+			       io_parms->tcon->tid,
+			       io_parms->tcon->ses->Suid,
+			       io_parms->offset,
+			       io_parms->length);
+
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/*
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of write request
 	 */
-	if (server->rdma && !server->sign && wdata->bytes >=
+	if (server->rdma && !server->sign && io_parms->length >=
 		server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
@@ -4590,14 +4612,14 @@ smb2_async_writev(struct cifs_writedata
 	}
 #endif
 	cifs_dbg(FYI, "async write at %llu %u bytes\n",
-		 wdata->offset, wdata->bytes);
+		 io_parms->offset, io_parms->length);
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/* For RDMA read, I/O size is in RemainingBytes not in Length */
 	if (!wdata->mr)
-		req->Length = cpu_to_le32(wdata->bytes);
+		req->Length = cpu_to_le32(io_parms->length);
 #else
-	req->Length = cpu_to_le32(wdata->bytes);
+	req->Length = cpu_to_le32(io_parms->length);
 #endif
 
 	if (wdata->credits.value > 0) {
@@ -4605,7 +4627,7 @@ smb2_async_writev(struct cifs_writedata
 						    SMB2_MAX_BUFFER_SIZE));
 		shdr->CreditRequest = cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 8);
 
-		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
+		rc = adjust_credits(server, &wdata->credits, io_parms->length);
 		if (rc)
 			goto async_writev_out;
 
@@ -4618,9 +4640,12 @@ smb2_async_writev(struct cifs_writedata
 
 	if (rc) {
 		trace_smb3_write_err(0 /* no xid */,
-				     req->PersistentFileId,
-				     tcon->tid, tcon->ses->Suid, wdata->offset,
-				     wdata->bytes, rc);
+				     io_parms->persistent_fid,
+				     io_parms->tcon->tid,
+				     io_parms->tcon->ses->Suid,
+				     io_parms->offset,
+				     io_parms->length,
+				     rc);
 		kref_put(&wdata->refcount, release);
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
 	}


