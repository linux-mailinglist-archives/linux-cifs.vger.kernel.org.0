Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05E058405C
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Jul 2022 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiG1NuU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 28 Jul 2022 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiG1NuR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 28 Jul 2022 09:50:17 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38700B85F;
        Thu, 28 Jul 2022 06:50:15 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2227076pjf.2;
        Thu, 28 Jul 2022 06:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzxl5AVZUU0BWCSbTL/IxSr102SIq7CcMiuBS+hinQU=;
        b=dJCidOMBegPtptYApTXPcKz+Ht6IZLWfStUi4Ab0oNN4l37T+A9UWRzfQZjls7MveE
         xizx3f+iwSDT32UhrUoEBDo2wKJCAVEvT67IDU4+3CjFuOjFtNPLXpqik5wiqCvv8Nk2
         GClIgj3fxTFmFiyA+dNhVcF2n+X5OEwQs5u/TNXXxMj8wW5tvOXq8H95q7HTphF9YG41
         KqAcvPNKk8KX4rNaeJNuRwf628ayL4DwV6V3eJE38PNi61Y3PWBbI6dIGagghqRaQT6E
         ErEgRScM9Jz1pnYVG7PsUF7A6oxHigJwr9pbjuIzR3Aujny9isJl1WTV0v0y+2Y3q6ix
         +mLA==
X-Gm-Message-State: AJIora+xmekmPAbWrJ1KsUk76xUfRPpNxQBYj0mSl+c63QXR8liYIjSZ
        QBe955vD8u6TMewcMNjqYOLbTi8SIRw=
X-Google-Smtp-Source: AGRyM1uchWhpz95PCWbAVaLhE6Wl/p/QLWyTUWvcGM5m/Mca/OYt/VxecReZoY+4Y+X5iDRhnX/MMQ==
X-Received: by 2002:a17:90b:3d04:b0:1f3:2c86:cccb with SMTP id pt4-20020a17090b3d0400b001f32c86cccbmr175087pjb.171.1659016214422;
        Thu, 28 Jul 2022 06:50:14 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902eb8800b0016cf985c0fcsm491712plg.124.2022.07.28.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:50:13 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        gregkh@linuxfoundation.org, Namjae Jeon <linkinjeon@kernel.org>,
        stable@vger.kernel.org, zdi-disclosures@trendmicro.com
Subject: [PATCH v2 5/5] ksmbd: fix heap-based overflow in set_ntacl_dacl()
Date:   Thu, 28 Jul 2022 22:49:46 +0900
Message-Id: <20220728134946.7603-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728134946.7603-1-linkinjeon@kernel.org>
References: <20220728134946.7603-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The testcase use SMB2_SET_INFO_HE command to set a malformed file attribute
under the label `security.NTACL`. SMB2_QUERY_INFO_HE command in testcase
trigger the following overflow.

[ 4712.003781] ==================================================================
[ 4712.003790] BUG: KASAN: slab-out-of-bounds in build_sec_desc+0x842/0x1dd0 [ksmbd]
[ 4712.003807] Write of size 1060 at addr ffff88801e34c068 by task kworker/0:0/4190

[ 4712.003813] CPU: 0 PID: 4190 Comm: kworker/0:0 Not tainted 5.19.0-rc5 #1
[ 4712.003850] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
[ 4712.003867] Call Trace:
[ 4712.003870]  <TASK>
[ 4712.003873]  dump_stack_lvl+0x49/0x5f
[ 4712.003935]  print_report.cold+0x5e/0x5cf
[ 4712.003972]  ? ksmbd_vfs_get_sd_xattr+0x16d/0x500 [ksmbd]
[ 4712.003984]  ? cmp_map_id+0x200/0x200
[ 4712.003988]  ? build_sec_desc+0x842/0x1dd0 [ksmbd]
[ 4712.004000]  kasan_report+0xaa/0x120
[ 4712.004045]  ? build_sec_desc+0x842/0x1dd0 [ksmbd]
[ 4712.004056]  kasan_check_range+0x100/0x1e0
[ 4712.004060]  memcpy+0x3c/0x60
[ 4712.004064]  build_sec_desc+0x842/0x1dd0 [ksmbd]
[ 4712.004076]  ? parse_sec_desc+0x580/0x580 [ksmbd]
[ 4712.004088]  ? ksmbd_acls_fattr+0x281/0x410 [ksmbd]
[ 4712.004099]  smb2_query_info+0xa8f/0x6110 [ksmbd]
[ 4712.004111]  ? psi_group_change+0x856/0xd70
[ 4712.004148]  ? update_load_avg+0x1c3/0x1af0
[ 4712.004152]  ? asym_cpu_capacity_scan+0x5d0/0x5d0
[ 4712.004157]  ? xas_load+0x23/0x300
[ 4712.004162]  ? smb2_query_dir+0x1530/0x1530 [ksmbd]
[ 4712.004173]  ? _raw_spin_lock_bh+0xe0/0xe0
[ 4712.004179]  handle_ksmbd_work+0x30e/0x1020 [ksmbd]
[ 4712.004192]  process_one_work+0x778/0x11c0
[ 4712.004227]  ? _raw_spin_lock_irq+0x8e/0xe0
[ 4712.004231]  worker_thread+0x544/0x1180
[ 4712.004234]  ? __cpuidle_text_end+0x4/0x4
[ 4712.004239]  kthread+0x282/0x320
[ 4712.004243]  ? process_one_work+0x11c0/0x11c0
[ 4712.004246]  ? kthread_complete_and_exit+0x30/0x30
[ 4712.004282]  ret_from_fork+0x1f/0x30

This patch add the buffer validation for security descriptor that is
stored by malformed SMB2_SET_INFO_HE command. and allocate large
response buffer about SMB2_O_INFO_SECURITY file info class.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-17771
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 v2:
   - add missing fixes and stable tags.

 fs/ksmbd/smb2pdu.c |  37 ++++++++-----
 fs/ksmbd/smbacl.c  | 130 ++++++++++++++++++++++++++++++---------------
 fs/ksmbd/smbacl.h  |   2 +-
 fs/ksmbd/vfs.c     |   5 ++
 4 files changed, 118 insertions(+), 56 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 1bad4f729160..71978ccbd4b3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -535,9 +535,10 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 		struct smb2_query_info_req *req;
 
 		req = smb2_get_msg(work->request_buf);
-		if (req->InfoType == SMB2_O_INFO_FILE &&
-		    (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
-		     req->FileInfoClass == FILE_ALL_INFORMATION))
+		if ((req->InfoType == SMB2_O_INFO_FILE &&
+		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
+		     req->FileInfoClass == FILE_ALL_INFORMATION)) ||
+		    req->InfoType == SMB2_O_INFO_SECURITY)
 			sz = large_sz;
 	}
 
@@ -2988,7 +2989,7 @@ int smb2_open(struct ksmbd_work *work)
 						goto err_out;
 
 					rc = build_sec_desc(user_ns,
-							    pntsd, NULL,
+							    pntsd, NULL, 0,
 							    OWNER_SECINFO |
 							    GROUP_SECINFO |
 							    DACL_SECINFO,
@@ -3833,6 +3834,15 @@ static int verify_info_level(int info_level)
 	return 0;
 }
 
+static int smb2_resp_buf_len(struct ksmbd_work *work, unsigned short hdr2_len)
+{
+	int free_len;
+
+	free_len = (int)(work->response_sz -
+		(get_rfc1002_len(work->response_buf) + 4)) - hdr2_len;
+	return free_len;
+}
+
 static int smb2_calc_max_out_buf_len(struct ksmbd_work *work,
 				     unsigned short hdr2_len,
 				     unsigned int out_buf_len)
@@ -3842,9 +3852,7 @@ static int smb2_calc_max_out_buf_len(struct ksmbd_work *work,
 	if (out_buf_len > work->conn->vals->max_trans_size)
 		return -EINVAL;
 
-	free_len = (int)(work->response_sz -
-			 (get_rfc1002_len(work->response_buf) + 4)) -
-		hdr2_len;
+	free_len = smb2_resp_buf_len(work, hdr2_len);
 	if (free_len < 0)
 		return -EINVAL;
 
@@ -5110,7 +5118,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 	__u32 secdesclen;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 	int addition_info = le32_to_cpu(req->AdditionalInformation);
-	int rc;
+	int rc = 0, ppntsd_size = 0;
 
 	if (addition_info & ~(OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO |
 			      PROTECTED_DACL_SECINFO |
@@ -5156,11 +5164,14 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_ACL_XATTR))
-		ksmbd_vfs_get_sd_xattr(work->conn, user_ns,
-				       fp->filp->f_path.dentry, &ppntsd);
-
-	rc = build_sec_desc(user_ns, pntsd, ppntsd, addition_info,
-			    &secdesclen, &fattr);
+		ppntsd_size = ksmbd_vfs_get_sd_xattr(work->conn, user_ns,
+						     fp->filp->f_path.dentry,
+						     &ppntsd);
+
+	/* Check if sd buffer size exceeds response buffer size */
+	if (smb2_resp_buf_len(work, 8) > ppntsd_size)
+		rc = build_sec_desc(user_ns, pntsd, ppntsd, ppntsd_size,
+				    addition_info, &secdesclen, &fattr);
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
 	kfree(ppntsd);
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 38f23bf981ac..d58816d274f5 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -690,6 +690,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 static void set_ntacl_dacl(struct user_namespace *user_ns,
 			   struct smb_acl *pndacl,
 			   struct smb_acl *nt_dacl,
+			   unsigned int aces_size,
 			   const struct smb_sid *pownersid,
 			   const struct smb_sid *pgrpsid,
 			   struct smb_fattr *fattr)
@@ -703,9 +704,19 @@ static void set_ntacl_dacl(struct user_namespace *user_ns,
 	if (nt_num_aces) {
 		ntace = (struct smb_ace *)((char *)nt_dacl + sizeof(struct smb_acl));
 		for (i = 0; i < nt_num_aces; i++) {
-			memcpy((char *)pndace + size, ntace, le16_to_cpu(ntace->size));
-			size += le16_to_cpu(ntace->size);
-			ntace = (struct smb_ace *)((char *)ntace + le16_to_cpu(ntace->size));
+			unsigned short nt_ace_size;
+
+			if (offsetof(struct smb_ace, access_req) > aces_size)
+				break;
+
+			nt_ace_size = le16_to_cpu(ntace->size);
+			if (nt_ace_size > aces_size)
+				break;
+
+			memcpy((char *)pndace + size, ntace, nt_ace_size);
+			size += nt_ace_size;
+			aces_size -= nt_ace_size;
+			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
 			num_aces++;
 		}
 	}
@@ -878,7 +889,7 @@ int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 /* Convert permission bits from mode to equivalent CIFS ACL */
 int build_sec_desc(struct user_namespace *user_ns,
 		   struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
-		   int addition_info, __u32 *secdesclen,
+		   int ppntsd_size, int addition_info, __u32 *secdesclen,
 		   struct smb_fattr *fattr)
 {
 	int rc = 0;
@@ -938,15 +949,25 @@ int build_sec_desc(struct user_namespace *user_ns,
 
 		if (!ppntsd) {
 			set_mode_dacl(user_ns, dacl_ptr, fattr);
-		} else if (!ppntsd->dacloffset) {
-			goto out;
 		} else {
 			struct smb_acl *ppdacl_ptr;
+			unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
+			int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;
+
+			if (!dacl_offset ||
+			    (dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
+				goto out;
+
+			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd + dacl_offset);
+			ppdacl_size = le16_to_cpu(ppdacl_ptr->size);
+			if (ppdacl_size > ntacl_size ||
+			    ppdacl_size < sizeof(struct smb_acl))
+				goto out;
 
-			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd +
-						le32_to_cpu(ppntsd->dacloffset));
 			set_ntacl_dacl(user_ns, dacl_ptr, ppdacl_ptr,
-				       nowner_sid_ptr, ngroup_sid_ptr, fattr);
+				       ntacl_size - sizeof(struct smb_acl),
+				       nowner_sid_ptr, ngroup_sid_ptr,
+				       fattr);
 		}
 		pntsd->dacloffset = cpu_to_le32(offset);
 		offset += le16_to_cpu(dacl_ptr->size);
@@ -980,24 +1001,31 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_sid owner_sid, group_sid;
 	struct dentry *parent = path->dentry->d_parent;
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
-	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0;
-	int rc = 0, num_aces, dacloffset, pntsd_type, acl_len;
+	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
+	int rc = 0, num_aces, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
-	acl_len = ksmbd_vfs_get_sd_xattr(conn, user_ns,
-					 parent, &parent_pntsd);
-	if (acl_len <= 0)
+	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+					    parent, &parent_pntsd);
+	if (pntsd_size <= 0)
 		return -ENOENT;
 	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
-	if (!dacloffset) {
+	if (!dacloffset || (dacloffset + sizeof(struct smb_acl) > pntsd_size)) {
 		rc = -EINVAL;
 		goto free_parent_pntsd;
 	}
 
 	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
+	acl_len = pntsd_size - dacloffset;
 	num_aces = le32_to_cpu(parent_pdacl->num_aces);
 	pntsd_type = le16_to_cpu(parent_pntsd->type);
+	pdacl_size = le16_to_cpu(parent_pdacl->size);
+
+	if (pdacl_size > acl_len || pdacl_size < sizeof(struct smb_acl)) {
+		rc = -EINVAL;
+		goto free_parent_pntsd;
+	}
 
 	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, GFP_KERNEL);
 	if (!aces_base) {
@@ -1008,11 +1036,23 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	aces = (struct smb_ace *)aces_base;
 	parent_aces = (struct smb_ace *)((char *)parent_pdacl +
 			sizeof(struct smb_acl));
+	aces_size = acl_len - sizeof(struct smb_acl);
 
 	if (pntsd_type & DACL_AUTO_INHERITED)
 		inherited_flags = INHERITED_ACE;
 
 	for (i = 0; i < num_aces; i++) {
+		int pace_size;
+
+		if (offsetof(struct smb_ace, access_req) > aces_size)
+			break;
+
+		pace_size = le16_to_cpu(parent_aces->size);
+		if (pace_size > aces_size)
+			break;
+
+		aces_size -= pace_size;
+
 		flags = parent_aces->flags;
 		if (!smb_inherit_flags(flags, is_dir))
 			goto pass;
@@ -1057,8 +1097,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
 		ace_cnt++;
 pass:
-		parent_aces =
-			(struct smb_ace *)((char *)parent_aces + le16_to_cpu(parent_aces->size));
+		parent_aces = (struct smb_ace *)((char *)parent_aces + pace_size);
 	}
 
 	if (nt_size > 0) {
@@ -1153,7 +1192,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 	struct smb_ntsd *pntsd = NULL;
 	struct smb_acl *pdacl;
 	struct posix_acl *posix_acls;
-	int rc = 0, acl_size;
+	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size, dacl_offset;
 	struct smb_sid sid;
 	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
 	struct smb_ace *ace;
@@ -1162,37 +1201,33 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 	struct smb_ace *others_ace = NULL;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
-	char *end_of_acl;
+	unsigned short ace_size;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
-	acl_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
-					  path->dentry, &pntsd);
-	if (acl_size <= 0 || !pntsd || !pntsd->dacloffset) {
-		kfree(pntsd);
-		return 0;
-	}
+	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+					    path->dentry, &pntsd);
+	if (pntsd_size <= 0)
+		goto err_out;
+
+	dacl_offset = le32_to_cpu(pntsd->dacloffset);
+	if (!pntsd || !pntsd->dacloffset ||
+	    (dacl_offset + sizeof(struct smb_acl) > pntsd_size))
+		goto err_out;
 
 	pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
-	end_of_acl = ((char *)pntsd) + acl_size;
-	if (end_of_acl <= (char *)pdacl) {
-		kfree(pntsd);
-		return 0;
-	}
+	acl_size = pntsd_size - dacl_offset;
+	pdacl_size = le16_to_cpu(pdacl->size);
 
-	if (end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size) ||
-	    le16_to_cpu(pdacl->size) < sizeof(struct smb_acl)) {
-		kfree(pntsd);
-		return 0;
-	}
+	if (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
+		goto err_out;
 
 	if (!pdacl->num_aces) {
-		if (!(le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) &&
+		if (!(pdacl_size - sizeof(struct smb_acl)) &&
 		    *pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)) {
 			rc = -EACCES;
 			goto err_out;
 		}
-		kfree(pntsd);
-		return 0;
+		goto err_out;
 	}
 
 	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
@@ -1200,11 +1235,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 			DELETE;
 
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+			if (offsetof(struct smb_ace, access_req) > aces_size)
+				goto err_out;
+			ace_size = le16_to_cpu(ace->size);
+			if (ace_size > aces_size)
+				break;
+			aces_size -= ace_size;
 			granted |= le32_to_cpu(ace->access_req);
 			ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
-			if (end_of_acl < (char *)ace)
-				goto err_out;
 		}
 
 		if (!pdacl->num_aces)
@@ -1216,7 +1256,15 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 	id_to_sid(uid, sid_type, &sid);
 
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+		if (offsetof(struct smb_ace, access_req) > aces_size)
+			goto err_out;
+		ace_size = le16_to_cpu(ace->size);
+		if (ace_size > aces_size)
+			break;
+		aces_size -= ace_size;
+
 		if (!compare_sids(&sid, &ace->sid) ||
 		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
 			found = 1;
@@ -1226,8 +1274,6 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 			others_ace = ace;
 
 		ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
-		if (end_of_acl < (char *)ace)
-			goto err_out;
 	}
 
 	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE && found) {
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index 811af3309429..fcb2c83f2992 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -193,7 +193,7 @@ struct posix_acl_state {
 int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
 		   int acl_len, struct smb_fattr *fattr);
 int build_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
-		   struct smb_ntsd *ppntsd, int addition_info,
+		   struct smb_ntsd *ppntsd, int ppntsd_size, int addition_info,
 		   __u32 *secdesclen, struct smb_fattr *fattr);
 int init_acl_state(struct posix_acl_state *state, int cnt);
 void free_acl_state(struct posix_acl_state *state);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 4f75b1436eab..7af7e0853f06 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1539,6 +1539,11 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 	}
 
 	*pntsd = acl.sd_buf;
+	if (acl.sd_size < sizeof(struct smb_ntsd)) {
+		pr_err("sd size is invalid\n");
+		goto out_free;
+	}
+
 	(*pntsd)->osidoffset = cpu_to_le32(le32_to_cpu((*pntsd)->osidoffset) -
 					   NDR_NTSD_OFFSETOF);
 	(*pntsd)->gsidoffset = cpu_to_le32(le32_to_cpu((*pntsd)->gsidoffset) -
-- 
2.25.1

