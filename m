Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3514EB407
	for <lists+linux-cifs@lfdr.de>; Tue, 29 Mar 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiC2TWK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 29 Mar 2022 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2TWK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 29 Mar 2022 15:22:10 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742543A727
        for <linux-cifs@vger.kernel.org>; Tue, 29 Mar 2022 12:20:26 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 705337FC3F;
        Tue, 29 Mar 2022 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1648581625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZ2FJdcVyc0eSXdcrrlzHcNvWizdcp5Mq1TxSxC9BpY=;
        b=rvKo2h+PbjMezLslWOu0s7Ub3mv4h4dxqt4uMLM/es6euIV/A1Q2ndtRSrDbQCmhYroPFo
        y8ejnHwFxg9nCsMBnlG3wLlV3AP4SJOkBfjBBGGnSoMSTlfdKa4P5aZu+xDkyvO+9+jUHO
        7rwpWpQYlt+cjqMloiOOMN68YSOMsFS5mcPc54e6iZERBRTJ3vZWTus/mmWJwBuhoNSKhG
        +LFG1HL1tSyPADRxDbw2pnBkp6I/MGat7E/XzMBZ6NK4AOOcwLBx4UAJq7VnLOPnUc2Rp6
        ejhpJP7qilt1NnSFZEnq3f/3W8s917Od9/S1odPHzRJW19BsmzwAxJYPTWghVg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>, stable@vger.kernel.org
Subject: [PATCH 2/2] cifs: fix NULL ptr dereference in smb2_ioctl_query_info()
Date:   Tue, 29 Mar 2022 16:20:06 -0300
Message-Id: <20220329192006.16750-2-pc@cjr.nz>
In-Reply-To: <20220329192006.16750-1-pc@cjr.nz>
References: <20220329192006.16750-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When calling smb2_ioctl_query_info() with invalid
smb_query_info::flags, a NULL ptr dereference is triggered when trying
to kfree() uninitialised rqst[n].rq_iov array.

This also fixes leaked paths that are created in SMB2_open_init()
which required SMB2_open_free() to properly free them.

Here is a small C reproducer that triggers it

	#include <stdio.h>
	#include <stdlib.h>
	#include <stdint.h>
	#include <unistd.h>
	#include <fcntl.h>
	#include <sys/ioctl.h>

	#define die(s) perror(s), exit(1)
	#define QUERY_INFO 0xc018cf07

	int main(int argc, char *argv[])
	{
		int fd;

		if (argc < 2)
			exit(1);
		fd = open(argv[1], O_RDONLY);
		if (fd == -1)
			die("open");
		if (ioctl(fd, QUERY_INFO, (uint32_t[]) { 0, 0, 0, 4, 0, 0}) == -1)
			die("ioctl");
		close(fd);
		return 0;
	}

	mount.cifs //srv/share /mnt -o ...
	gcc repro.c && ./a.out /mnt/f0

	[ 1832.124468] CIFS: VFS: \\w22-dc.zelda.test\test Invalid passthru query flags: 0x4
	[ 1832.125043] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
	[ 1832.125764] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
	[ 1832.126241] CPU: 3 PID: 1133 Comm: a.out Not tainted 5.17.0-rc8 #2
	[ 1832.126630] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
	[ 1832.127322] RIP: 0010:smb2_ioctl_query_info+0x7a3/0xe30 [cifs]
	[ 1832.127749] Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 6c 05 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 74 24 28 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 cb 04 00 00 49 8b 3e e8 bb fc fa ff 48 89 da 48
	[ 1832.128911] RSP: 0018:ffffc90000957b08 EFLAGS: 00010256
	[ 1832.129243] RAX: dffffc0000000000 RBX: ffff888117e9b850 RCX: ffffffffa020580d
	[ 1832.129691] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffa043a2c0
	[ 1832.130137] RBP: ffff888117e9b878 R08: 0000000000000001 R09: 0000000000000003
	[ 1832.130585] R10: fffffbfff4087458 R11: 0000000000000001 R12: ffff888117e9b800
	[ 1832.131037] R13: 00000000ffffffea R14: 0000000000000000 R15: ffff888117e9b8a8
	[ 1832.131485] FS:  00007fcee9900740(0000) GS:ffff888151a00000(0000) knlGS:0000000000000000
	[ 1832.131993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 1832.132354] CR2: 00007fcee9a1ef5e CR3: 0000000114cd2000 CR4: 0000000000350ee0
	[ 1832.132801] Call Trace:
	[ 1832.132962]  <TASK>
	[ 1832.133104]  ? smb2_query_reparse_tag+0x890/0x890 [cifs]
	[ 1832.133489]  ? cifs_mapchar+0x460/0x460 [cifs]
	[ 1832.133822]  ? rcu_read_lock_sched_held+0x3f/0x70
	[ 1832.134125]  ? cifs_strndup_to_utf16+0x15b/0x250 [cifs]
	[ 1832.134502]  ? lock_downgrade+0x6f0/0x6f0
	[ 1832.134760]  ? cifs_convert_path_to_utf16+0x198/0x220 [cifs]
	[ 1832.135170]  ? smb2_check_message+0x1080/0x1080 [cifs]
	[ 1832.135545]  cifs_ioctl+0x1577/0x3320 [cifs]
	[ 1832.135864]  ? lock_downgrade+0x6f0/0x6f0
	[ 1832.136125]  ? cifs_readdir+0x2e60/0x2e60 [cifs]
	[ 1832.136468]  ? rcu_read_lock_sched_held+0x3f/0x70
	[ 1832.136769]  ? __rseq_handle_notify_resume+0x80b/0xbe0
	[ 1832.137096]  ? __up_read+0x192/0x710
	[ 1832.137327]  ? __ia32_sys_rseq+0xf0/0xf0
	[ 1832.137578]  ? __x64_sys_openat+0x11f/0x1d0
	[ 1832.137850]  __x64_sys_ioctl+0x127/0x190
	[ 1832.138103]  do_syscall_64+0x3b/0x90
	[ 1832.138378]  entry_SYSCALL_64_after_hwframe+0x44/0xae
	[ 1832.138702] RIP: 0033:0x7fcee9a253df
	[ 1832.138937] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
	[ 1832.140107] RSP: 002b:00007ffeba94a8a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[ 1832.140606] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcee9a253df
	[ 1832.141058] RDX: 00007ffeba94a910 RSI: 00000000c018cf07 RDI: 0000000000000003
	[ 1832.141503] RBP: 00007ffeba94a930 R08: 00007fcee9b24db0 R09: 00007fcee9b45c4e
	[ 1832.141948] R10: 00007fcee9918d40 R11: 0000000000000246 R12: 00007ffeba94aa48
	[ 1832.142396] R13: 0000000000401176 R14: 0000000000403df8 R15: 00007fcee9b78000
	[ 1832.142851]  </TASK>
	[ 1832.142994] Modules linked in: cifs cifs_arc4 cifs_md4 bpf_preload [last unloaded: cifs]

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@cjr.nz>
---
 fs/cifs/smb2ops.c | 120 ++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 57 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 600a5be3ccd0..c59489a2247a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1637,6 +1637,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	unsigned int size[2];
 	void *data[2];
 	int create_options = is_dir ? CREATE_NOT_FILE : CREATE_NOT_DIR;
+	void (*free_req1_func)(struct smb_rqst *r);
 
 	vars = kzalloc(sizeof(*vars), GFP_ATOMIC);
 	if (vars == NULL)
@@ -1646,17 +1647,18 @@ smb2_ioctl_query_info(const unsigned int xid,
 
 	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;
 
-	if (copy_from_user(&qi, arg, sizeof(struct smb_query_info)))
-		goto e_fault;
-
+	if (copy_from_user(&qi, arg, sizeof(struct smb_query_info))) {
+		rc = -EFAULT;
+		goto free_vars;
+	}
 	if (qi.output_buffer_length > 1024) {
-		kfree(vars);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto free_vars;
 	}
 
 	if (!ses || !server) {
-		kfree(vars);
-		return -EIO;
+		rc = -EIO;
+		goto free_vars;
 	}
 
 	if (smb3_encryption_required(tcon))
@@ -1665,8 +1667,8 @@ smb2_ioctl_query_info(const unsigned int xid,
 	if (qi.output_buffer_length) {
 		buffer = memdup_user(arg + sizeof(struct smb_query_info), qi.output_buffer_length);
 		if (IS_ERR(buffer)) {
-			kfree(vars);
-			return PTR_ERR(buffer);
+			rc = PTR_ERR(buffer);
+			goto free_vars;
 		}
 	}
 
@@ -1705,48 +1707,45 @@ smb2_ioctl_query_info(const unsigned int xid,
 	rc = SMB2_open_init(tcon, server,
 			    &rqst[0], &oplock, &oparms, path);
 	if (rc)
-		goto iqinf_exit;
+		goto free_output_buffer;
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	/* Query */
 	if (qi.flags & PASSTHRU_FSCTL) {
 		/* Can eventually relax perm check since server enforces too */
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable(CAP_SYS_ADMIN)) {
 			rc = -EPERM;
-		else  {
-			rqst[1].rq_iov = &vars->io_iov[0];
-			rqst[1].rq_nvec = SMB2_IOCTL_IOV_SIZE;
-
-			rc = SMB2_ioctl_init(tcon, server,
-					     &rqst[1],
-					     COMPOUND_FID, COMPOUND_FID,
-					     qi.info_type, true, buffer,
-					     qi.output_buffer_length,
-					     CIFSMaxBufSize -
-					     MAX_SMB2_CREATE_RESPONSE_SIZE -
-					     MAX_SMB2_CLOSE_RESPONSE_SIZE);
+			goto free_open_req;
 		}
+		rqst[1].rq_iov = &vars->io_iov[0];
+		rqst[1].rq_nvec = SMB2_IOCTL_IOV_SIZE;
+
+		rc = SMB2_ioctl_init(tcon, server, &rqst[1], COMPOUND_FID, COMPOUND_FID,
+				     qi.info_type, true, buffer, qi.output_buffer_length,
+				     CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+				     MAX_SMB2_CLOSE_RESPONSE_SIZE);
+		free_req1_func = SMB2_ioctl_free;
 	} else if (qi.flags == PASSTHRU_SET_INFO) {
 		/* Can eventually relax perm check since server enforces too */
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable(CAP_SYS_ADMIN)) {
 			rc = -EPERM;
-		else if (qi.output_buffer_length < 8)
+			goto free_open_req;
+		}
+		if (qi.output_buffer_length < 8) {
 			rc = -EINVAL;
-		else {
-			rqst[1].rq_iov = &vars->si_iov[0];
-			rqst[1].rq_nvec = 1;
+			goto free_open_req;
+		}
+		rqst[1].rq_iov = &vars->si_iov[0];
+		rqst[1].rq_nvec = 1;
 
-			/* MS-FSCC 2.4.13 FileEndOfFileInformation */
-			size[0] = 8;
-			data[0] = buffer;
+		/* MS-FSCC 2.4.13 FileEndOfFileInformation */
+		size[0] = 8;
+		data[0] = buffer;
 
-			rc = SMB2_set_info_init(tcon, server,
-					&rqst[1],
-					COMPOUND_FID, COMPOUND_FID,
-					current->tgid,
-					FILE_END_OF_FILE_INFORMATION,
+		rc = SMB2_set_info_init(tcon, server, &rqst[1], COMPOUND_FID, COMPOUND_FID,
+					current->tgid, FILE_END_OF_FILE_INFORMATION,
 					SMB2_O_INFO_FILE, 0, data, size);
-		}
+		free_req1_func = SMB2_set_info_free;
 	} else if (qi.flags == PASSTHRU_QUERY_INFO) {
 		rqst[1].rq_iov = &vars->qi_iov[0];
 		rqst[1].rq_nvec = 1;
@@ -1757,6 +1756,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 				  qi.info_type, qi.additional_information,
 				  qi.input_buffer_length,
 				  qi.output_buffer_length, buffer);
+		free_req1_func = SMB2_query_info_free;
 	} else { /* unknown flags */
 		cifs_tcon_dbg(VFS, "Invalid passthru query flags: 0x%x\n",
 			      qi.flags);
@@ -1764,7 +1764,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	}
 
 	if (rc)
-		goto iqinf_exit;
+		goto free_open_req;
 	smb2_set_next_command(tcon, &rqst[1]);
 	smb2_set_related(&rqst[1]);
 
@@ -1775,14 +1775,14 @@ smb2_ioctl_query_info(const unsigned int xid,
 	rc = SMB2_close_init(tcon, server,
 			     &rqst[2], COMPOUND_FID, COMPOUND_FID, false);
 	if (rc)
-		goto iqinf_exit;
+		goto free_req_1;
 	smb2_set_related(&rqst[2]);
 
 	rc = compound_send_recv(xid, ses, server,
 				flags, 3, rqst,
 				resp_buftype, rsp_iov);
 	if (rc)
-		goto iqinf_exit;
+		goto out;
 
 	/* No need to bump num_remote_opens since handle immediately closed */
 	if (qi.flags & PASSTHRU_FSCTL) {
@@ -1792,18 +1792,22 @@ smb2_ioctl_query_info(const unsigned int xid,
 			qi.input_buffer_length = le32_to_cpu(io_rsp->OutputCount);
 		if (qi.input_buffer_length > 0 &&
 		    le32_to_cpu(io_rsp->OutputOffset) + qi.input_buffer_length
-		    > rsp_iov[1].iov_len)
-			goto e_fault;
+		    > rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
-				 sizeof(qi.input_buffer_length)))
-			goto e_fault;
+				 sizeof(qi.input_buffer_length))) {
+			rc = -EFAULT;
+			goto out;
+		}
 
 		if (copy_to_user((void __user *)pqi + sizeof(struct smb_query_info),
 				 (const void *)io_rsp + le32_to_cpu(io_rsp->OutputOffset),
 				 qi.input_buffer_length))
-			goto e_fault;
+			rc = -EFAULT;
 	} else {
 		pqi = (struct smb_query_info __user *)arg;
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
@@ -1811,28 +1815,30 @@ smb2_ioctl_query_info(const unsigned int xid,
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
-				 sizeof(qi.input_buffer_length)))
-			goto e_fault;
+				 sizeof(qi.input_buffer_length))) {
+			rc = -EFAULT;
+			goto out;
+		}
 
 		if (copy_to_user(pqi + 1, qi_rsp->Buffer,
 				 qi.input_buffer_length))
-			goto e_fault;
+			rc = -EFAULT;
 	}
 
- iqinf_exit:
-	cifs_small_buf_release(rqst[0].rq_iov[0].iov_base);
-	cifs_small_buf_release(rqst[1].rq_iov[0].iov_base);
-	cifs_small_buf_release(rqst[2].rq_iov[0].iov_base);
+out:
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
 	free_rsp_buf(resp_buftype[2], rsp_iov[2].iov_base);
-	kfree(vars);
+	SMB2_close_free(&rqst[2]);
+free_req_1:
+	free_req1_func(&rqst[1]);
+free_open_req:
+	SMB2_open_free(&rqst[0]);
+free_output_buffer:
 	kfree(buffer);
+free_vars:
+	kfree(vars);
 	return rc;
-
-e_fault:
-	rc = -EFAULT;
-	goto iqinf_exit;
 }
 
 static ssize_t
-- 
2.35.1

