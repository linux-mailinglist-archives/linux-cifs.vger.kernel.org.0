Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802895EF8CD
	for <lists+linux-cifs@lfdr.de>; Thu, 29 Sep 2022 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiI2PcM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 29 Sep 2022 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiI2PbY (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 29 Sep 2022 11:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE431814CC;
        Thu, 29 Sep 2022 08:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0EBB824F7;
        Thu, 29 Sep 2022 15:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840DDC43470;
        Thu, 29 Sep 2022 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465468;
        bh=/O23BZj+qZCiXS8BU2GwxcD3na1jWHWJ2K4/6EAftqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq5zbNPYpvSNY/i34qps9aguEF+9gYMrVoDKAfy3wOWW6izHDS4wN4GiQvf8/zNJ3
         SO5zAgHJJqOLdANqyE2Et5MXildAlu/k/9WqG4Y4wSddnCvt3ug6M3SCC3V8AaT6hi
         SKRg1haEkRZ4zteyFBELT+BNrCnB3o+QoGi4KGSAwlYzZIgUjBUlWYqy7qGoYuaB8+
         VI+mIEjGc2Ulm+qno4zmwZ9a+RRE+exq8FdIAxE2Wtm9jRB/Go3CpAgKfwKrpSv+Oz
         fmnvfmKZUU8RKP70GNVXcOIEp2wUOgqM4PYYRa2TEzcT9auSRlEX+OX4Fp2Hs9VSPW
         c+ZIvvIVTDnYQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v4 06/30] cifs: implement set acl method
Date:   Thu, 29 Sep 2022 17:30:16 +0200
Message-Id: <20220929153041.500115-7-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12616; i=brauner@kernel.org; h=from:subject; bh=/O23BZj+qZCiXS8BU2GwxcD3na1jWHWJ2K4/6EAftqY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hI6w1BlNMvKI4/9u3l91p1FhxhCFv5iZZwqeWfFjp1q UpU5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRmsHwV/LfkY0tW665XF37Pm9DiP Hm+gqD2W9y2jY2ne005dq2+xYjw3WfsxEdjkc/d24XXzdpxslkhn8CFcFX3vWcrm1isUt5ygoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

So far cifs wasn't able to implement get and set acl inode operations
because it needs access to the dentry. Now that we extended the set acl
inode operation to take a dentry argument and added a new get acl inode
operation that takes a dentry argument we can let cifs implement get and
set acl inode operations.

This is mostly a copy and paste of the codepaths currently used in cifs'
posix acl xattr handler. After we have fully implemented the posix acl
api and switched the vfs over to it, the cifs specific posix acl xattr
handler and associated code will be removed and the code duplication
will go away.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged

 fs/cifs/cifsacl.c   |  74 ++++++++++++++++++++
 fs/cifs/cifsfs.c    |   2 +
 fs/cifs/cifsproto.h |   6 ++
 fs/cifs/cifssmb.c   | 160 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index a6730e0eb57b..d068cdfd9ab5 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -14,6 +14,8 @@
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <uapi/linux/posix_acl.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include <keys/user-type.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
@@ -1735,3 +1737,75 @@ struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
 	return ERR_PTR(-EOPNOTSUPP);
 #endif
 }
+
+int cifs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct posix_acl *acl, int type)
+{
+	int rc = -EOPNOTSUPP;
+	unsigned int xid;
+	struct super_block *sb = dentry->d_sb;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	struct tcon_link *tlink;
+	struct cifs_tcon *pTcon;
+	const char *full_path;
+	void *page;
+
+	tlink = cifs_sb_tlink(cifs_sb);
+	if (IS_ERR(tlink))
+		return PTR_ERR(tlink);
+	pTcon = tlink_tcon(tlink);
+
+	xid = get_xid();
+	page = alloc_dentry_path();
+
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
+		goto out;
+	}
+	/* return dos attributes as pseudo xattr */
+	/* return alt name if available as pseudo attr */
+
+	/* if proc/fs/cifs/streamstoxattr is set then
+		search server for EAs or streams to
+		returns as xattrs */
+	if (posix_acl_xattr_size(acl->a_count) > CIFSMaxBufSize) {
+		cifs_dbg(FYI, "size of EA value too large\n");
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	switch (type) {
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+	case ACL_TYPE_ACCESS:
+#ifdef CONFIG_CIFS_POSIX
+		if (!acl)
+			goto out;
+		if (sb->s_flags & SB_POSIXACL)
+			rc = cifs_do_set_acl(xid, pTcon, full_path, acl,
+					     ACL_TYPE_ACCESS,
+					     cifs_sb->local_nls,
+					     cifs_remap(cifs_sb));
+#endif  /* CONFIG_CIFS_POSIX */
+		break;
+
+	case ACL_TYPE_DEFAULT:
+#ifdef CONFIG_CIFS_POSIX
+		if (!acl)
+			goto out;
+		if (sb->s_flags & SB_POSIXACL)
+			rc = cifs_do_set_acl(xid, pTcon, full_path, acl,
+					     ACL_TYPE_DEFAULT,
+					     cifs_sb->local_nls,
+					     cifs_remap(cifs_sb));
+#endif  /* CONFIG_CIFS_POSIX */
+		break;
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
+	}
+
+out:
+	free_dentry_path(page);
+	free_xid(xid);
+	cifs_put_tlink(tlink);
+	return rc;
+}
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 5c00d79fda99..c8d46c1b10e4 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1129,6 +1129,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.mknod   = cifs_mknod,
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
+	.set_acl = cifs_set_acl,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1138,6 +1139,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
+	.set_acl = cifs_set_acl,
 };
 
 const struct inode_operations cifs_symlink_inode_ops = {
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 953fd910da70..279e867dee2e 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -227,6 +227,8 @@ extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
 				const struct cifs_fid *, u32 *, u32);
 extern struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
 				      struct dentry *dentry, int type);
+extern int cifs_set_acl(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct posix_acl *acl, int type);
 extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
 				const char *, int);
 extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
@@ -552,6 +554,10 @@ extern int CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 		const unsigned char *fileName,
 		const char *local_acl, const int buflen, const int acl_type,
 		const struct nls_table *nls_codepage, int remap_special_chars);
+extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+			   const unsigned char *fileName,
+			   const struct posix_acl *acl, const int acl_type,
+			   const struct nls_table *nls_codepage, int remap);
 extern int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 			const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
 #endif /* CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 4c0871771c76..7b47d0def5d2 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -3308,6 +3308,83 @@ static int cifs_to_posix_acl(struct posix_acl **acl, char *src,
 	return 0;
 }
 
+/**
+ * cifs_init_ace - convert ACL entry from POSIX ACL to cifs format
+ * @cifs_ace: the cifs ACL entry to store into
+ * @local_ace: the POSIX ACL entry to convert
+ */
+static void cifs_init_ace(struct cifs_posix_ace *cifs_ace,
+			  const struct posix_acl_entry *local_ace)
+{
+	cifs_ace->cifs_e_perm = local_ace->e_perm;
+	cifs_ace->cifs_e_tag =  local_ace->e_tag;
+
+	switch (local_ace->e_tag) {
+	case ACL_USER:
+		cifs_ace->cifs_uid =
+			cpu_to_le64(from_kuid(&init_user_ns, local_ace->e_uid));
+		break;
+	case ACL_GROUP:
+		cifs_ace->cifs_uid =
+			cpu_to_le64(from_kgid(&init_user_ns, local_ace->e_gid));
+		break;
+	default:
+		cifs_ace->cifs_uid = cpu_to_le64(-1);
+	}
+}
+
+/**
+ * posix_acl_to_cifs - convert ACLs from POSIX ACL to cifs format
+ * @parm_data: ACLs in cifs format to conver to
+ * @acl: ACLs in POSIX ACL format to convert from
+ * @acl_type: the type of POSIX ACLs stored in @acl
+ *
+ * Return: the number cifs ACL entries after conversion
+ */
+static __u16 posix_acl_to_cifs(char *parm_data, const struct posix_acl *acl,
+			       const int acl_type)
+{
+	__u16 rc = 0;
+	struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)parm_data;
+	const struct posix_acl_entry *pa, *pe;
+	int count;
+	int i = 0;
+
+	if ((acl == NULL) || (cifs_acl == NULL))
+		return 0;
+
+	count = acl->a_count;
+	cifs_dbg(FYI, "setting acl with %d entries\n", count);
+
+	/*
+	 * Note that the uapi POSIX ACL version is verified by the VFS and is
+	 * independent of the cifs ACL version. Changing the POSIX ACL version
+	 * is a uapi change and if it's changed we will pass down the POSIX ACL
+	 * version in struct posix_acl from the VFS. For now there's really
+	 * only one that all filesystems know how to deal with.
+	 */
+	cifs_acl->version = cpu_to_le16(1);
+	if (acl_type == ACL_TYPE_ACCESS) {
+		cifs_acl->access_entry_count = cpu_to_le16(count);
+		cifs_acl->default_entry_count = cpu_to_le16(0xFFFF);
+	} else if (acl_type == ACL_TYPE_DEFAULT) {
+		cifs_acl->default_entry_count = cpu_to_le16(count);
+		cifs_acl->access_entry_count = cpu_to_le16(0xFFFF);
+	} else {
+		cifs_dbg(FYI, "unknown ACL type %d\n", acl_type);
+		return 0;
+	}
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+		cifs_init_ace(&cifs_acl->ace_array[i++], pa);
+	}
+	if (rc == 0) {
+		rc = (__u16)(count * sizeof(struct cifs_posix_ace));
+		rc += sizeof(struct cifs_posix_acl);
+		/* BB add check to make sure ACL does not overflow SMB */
+	}
+	return rc;
+}
+
 int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 		    const unsigned char *searchName, struct posix_acl **acl,
 		    const int acl_type, const struct nls_table *nls_codepage,
@@ -3398,6 +3475,81 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 		goto queryAclRetry;
 	return rc;
 }
+
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap)
+{
+	struct smb_com_transaction2_spi_req *pSMB = NULL;
+	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
+	char *parm_data;
+	int name_len;
+	int rc = 0;
+	int bytes_returned = 0;
+	__u16 params, byte_count, data_count, param_offset, offset;
+
+	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
+setAclRetry:
+	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
+		      (void **) &pSMBr);
+	if (rc)
+		return rc;
+	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
+		name_len =
+			cifsConvertToUTF16((__le16 *) pSMB->FileName, fileName,
+					   PATH_MAX, nls_codepage, remap);
+		name_len++;     /* trailing null */
+		name_len *= 2;
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fileName);
+	}
+	params = 6 + name_len;
+	pSMB->MaxParameterCount = cpu_to_le16(2);
+	/* BB find max SMB size from sess */
+	pSMB->MaxDataCount = cpu_to_le16(1000);
+	pSMB->MaxSetupCount = 0;
+	pSMB->Reserved = 0;
+	pSMB->Flags = 0;
+	pSMB->Timeout = 0;
+	pSMB->Reserved2 = 0;
+	param_offset = offsetof(struct smb_com_transaction2_spi_req,
+				InformationLevel) - 4;
+	offset = param_offset + params;
+	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
+	pSMB->ParameterOffset = cpu_to_le16(param_offset);
+
+	/* convert to on the wire format for POSIX ACL */
+	data_count = posix_acl_to_cifs(parm_data, acl, acl_type);
+
+	if (data_count == 0) {
+		rc = -EOPNOTSUPP;
+		goto setACLerrorExit;
+	}
+	pSMB->DataOffset = cpu_to_le16(offset);
+	pSMB->SetupCount = 1;
+	pSMB->Reserved3 = 0;
+	pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
+	pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_ACL);
+	byte_count = 3 /* pad */  + params + data_count;
+	pSMB->DataCount = cpu_to_le16(data_count);
+	pSMB->TotalDataCount = pSMB->DataCount;
+	pSMB->ParameterCount = cpu_to_le16(params);
+	pSMB->TotalParameterCount = pSMB->ParameterCount;
+	pSMB->Reserved4 = 0;
+	inc_rfc1001_len(pSMB, byte_count);
+	pSMB->ByteCount = cpu_to_le16(byte_count);
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
+			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
+	if (rc)
+		cifs_dbg(FYI, "Set POSIX ACL returned %d\n", rc);
+
+setACLerrorExit:
+	cifs_buf_release(pSMB);
+	if (rc == -EAGAIN)
+		goto setAclRetry;
+	return rc;
+}
 #else
 int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 		    const unsigned char *searchName, struct posix_acl **acl,
@@ -3406,6 +3558,14 @@ int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	return -EOPNOTSUPP;
 }
+
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 int
-- 
2.34.1

