Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743A649672
	for <lists+linux-cifs@lfdr.de>; Sun, 11 Dec 2022 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLKVTF (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 11 Dec 2022 16:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKVTF (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 11 Dec 2022 16:19:05 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90556D10A
        for <linux-cifs@vger.kernel.org>; Sun, 11 Dec 2022 13:19:03 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 7CCF97FCF1;
        Sun, 11 Dec 2022 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1670793541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D8ChlyhaWttK1bTrxeOM3eAEMogi67pd8eSAWhLKpmI=;
        b=iYz9GTLhk9lnjRF47GhXjl+qunB9Wf067ILxKQyF2WZMzJlCP7Q0THaNHUT5tiZoEWVaz4
        GqSFSJnXwus6BBJ2rhfeqxq+dm6FK4KQg/hEkKkxDMmnXd2aOjWPjBw0seJdNNG4UrjYjX
        EIdQykDBecUss5M0CBYiN3rQeHJImCMX0zuxpbu/tj0wt4ms3HO3sXoPvupZP1SIl40uUI
        I4bjE0Gr2jj7VMvDxtef7qNaqK97KhIvlMpoC+0EEpBlG2srAceLf5xGv0fWEOsfHWBuEG
        UHLgV80GIdBJ4hXJKHQWykB9B/oZtV2M+5ygu41DIr1vuV0O/VP8ZfrF7QKtew==
From:   Paulo Alcantara <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH] cifs: fix oops during encryption
Date:   Sun, 11 Dec 2022 18:18:55 -0300
Message-Id: <20221211211855.6424-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When running xfstests against Azure the following oops occurred on an
arm64 system

  Unable to handle kernel write to read-only memory at virtual address
  ffff0001221cf000
  Mem abort info:
    ESR = 0x9600004f
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x0f: level 3 permission fault
  Data abort info:
    ISV = 0, ISS = 0x0000004f
    CM = 0, WnR = 1
  swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000294f3000
  [ffff0001221cf000] pgd=18000001ffff8003, p4d=18000001ffff8003,
  pud=18000001ff82e003, pmd=18000001ff71d003, pte=00600001221cf787
  Internal error: Oops: 9600004f [#1] PREEMPT SMP
  ...
  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
  pc : __memcpy+0x40/0x230
  lr : scatterwalk_copychunks+0xe0/0x200
  sp : ffff800014e92de0
  x29: ffff800014e92de0 x28: ffff000114f9de80 x27: 0000000000000008
  x26: 0000000000000008 x25: ffff800014e92e78 x24: 0000000000000008
  x23: 0000000000000001 x22: 0000040000000000 x21: ffff000000000000
  x20: 0000000000000001 x19: ffff0001037c4488 x18: 0000000000000014
  x17: 235e1c0d6efa9661 x16: a435f9576b6edd6c x15: 0000000000000058
  x14: 0000000000000001 x13: 0000000000000008 x12: ffff000114f2e590
  x11: ffffffffffffffff x10: 0000040000000000 x9 : ffff8000105c3580
  x8 : 2e9413b10000001a x7 : 534b4410fb86b005 x6 : 534b4410fb86b005
  x5 : ffff0001221cf008 x4 : ffff0001037c4490 x3 : 0000000000000001
  x2 : 0000000000000008 x1 : ffff0001037c4488 x0 : ffff0001221cf000
  Call trace:
   __memcpy+0x40/0x230
   scatterwalk_map_and_copy+0x98/0x100
   crypto_ccm_encrypt+0x150/0x180
   crypto_aead_encrypt+0x2c/0x40
   crypt_message+0x750/0x880
   smb3_init_transform_rq+0x298/0x340
   smb_send_rqst.part.11+0xd8/0x180
   smb_send_rqst+0x3c/0x100
   compound_send_recv+0x534/0xbc0
   smb2_query_info_compound+0x32c/0x440
   smb2_set_ea+0x438/0x4c0
   cifs_xattr_set+0x5d4/0x7c0

This is because in scatterwalk_copychunks(), we attempted to write to
a buffer (@sign) that was allocated in the stack (vmalloc area) by
crypt_message() and thus accessing its remaining 8 (x2) bytes ended up
crossing a page boundary.

To simply fix it, we could just pass @sign kmalloc'd from
crypt_message() and then we're done.  Luckily, we don't seem to pass
any other vmalloc'd buffers in smb_rqst::rq_iov...

Instead, let's map the correct pages and offsets from vmalloc buffers
as well in cifs_sg_set_buf() and then avoiding such oopses.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/cifsglob.h  |  68 +++++++++++++++++++++
 fs/cifs/cifsproto.h |   4 +-
 fs/cifs/misc.c      |   4 +-
 fs/cifs/smb2ops.c   | 143 +++++++++++++++++++++-----------------------
 4 files changed, 140 insertions(+), 79 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index cd3a173e65b1..703685e2db5e 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -13,6 +13,8 @@
 #include <linux/in6.h>
 #include <linux/inet.h>
 #include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/mm.h>
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
 #include <linux/utsname.h>
@@ -2140,4 +2142,70 @@ static inline void move_cifs_info_to_smb2(struct smb2_file_all_info *dst, const
 	dst->FileNameLength = src->FileNameLength;
 }
 
+static inline unsigned int cifs_get_num_sgs(const struct smb_rqst *rqst,
+					    int num_rqst,
+					    const u8 *sig)
+{
+	unsigned int len, skip;
+	unsigned int nents = 0;
+	unsigned long addr;
+	int i, j;
+
+	/* Assumes the first rqst has a transform header as the first iov.
+	 * I.e.
+	 * rqst[0].rq_iov[0]  is transform header
+	 * rqst[0].rq_iov[1+] data to be encrypted/decrypted
+	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
+	 */
+	for (i = 0; i < num_rqst; i++) {
+		/*
+		 * The first rqst has a transform header where the
+		 * first 20 bytes are not part of the encrypted blob.
+		 */
+		for (j = 0; j < rqst[i].rq_nvec; j++) {
+			struct kvec *iov = &rqst[i].rq_iov[j];
+
+			skip = (i == 0) && (j == 0) ? 20 : 0;
+			addr = (unsigned long)iov->iov_base + skip;
+			if (unlikely(is_vmalloc_addr((void *)addr))) {
+				len = iov->iov_len - skip;
+				nents += DIV_ROUND_UP(offset_in_page(addr) + len,
+						      PAGE_SIZE);
+			} else {
+				nents++;
+			}
+		}
+		nents += rqst[i].rq_npages;
+	}
+	nents += DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_SIZE);
+	return nents;
+}
+
+/* We can not use the normal sg_set_buf() as we will sometimes pass a
+ * stack object as buf.
+ */
+static inline struct scatterlist *cifs_sg_set_buf(struct scatterlist *sg,
+						  const void *buf,
+						  unsigned int buflen)
+{
+	unsigned long addr = (unsigned long)buf;
+	unsigned int off = offset_in_page(addr);
+
+	addr &= PAGE_MASK;
+	if (unlikely(is_vmalloc_addr((void *)addr))) {
+		do {
+			unsigned int len = min_t(unsigned int, buflen, PAGE_SIZE - off);
+
+			sg_set_page(sg++, vmalloc_to_page((void *)addr), len, off);
+
+			off = 0;
+			addr += PAGE_SIZE;
+			buflen -= len;
+		} while (buflen);
+	} else {
+		sg_set_page(sg++, virt_to_page(addr), buflen, off);
+	}
+	return sg;
+}
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index f216fa269c85..9c6147ca029d 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -600,8 +600,8 @@ int setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw);
 int cifs_alloc_hash(const char *name, struct shash_desc **sdesc);
 void cifs_free_hash(struct shash_desc **sdesc);
 
-extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
-				unsigned int *len, unsigned int *offset);
+void rqst_page_get_length(const struct smb_rqst *rqst, unsigned int page,
+			  unsigned int *len, unsigned int *offset);
 struct cifs_chan *
 cifs_ses_find_chan(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 3e68d8208cf5..1cbecd64d697 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1136,8 +1136,8 @@ cifs_free_hash(struct shash_desc **sdesc)
  * @len: Where to store the length for this page:
  * @offset: Where to store the offset for this page
  */
-void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
-				unsigned int *len, unsigned int *offset)
+void rqst_page_get_length(const struct smb_rqst *rqst, unsigned int page,
+			  unsigned int *len, unsigned int *offset)
 {
 	*len = rqst->rq_pagesz;
 	*offset = (page == 0) ? rqst->rq_offset : 0;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 72b22d033ed5..6e772b31e02a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4204,69 +4204,82 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
 	memcpy(&tr_hdr->SessionId, &shdr->SessionId, 8);
 }
 
-/* We can not use the normal sg_set_buf() as we will sometimes pass a
- * stack object as buf.
- */
-static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
-				   unsigned int buflen)
+static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst *rqst,
+				 int num_rqst, const u8 *sig, u8 **iv,
+				 struct aead_request **req, struct scatterlist **sgl,
+				 unsigned int *num_sgs)
 {
-	void *addr;
-	/*
-	 * VMAP_STACK (at least) puts stack into the vmalloc address space
-	 */
-	if (is_vmalloc_addr(buf))
-		addr = vmalloc_to_page(buf);
-	else
-		addr = virt_to_page(buf);
-	sg_set_page(sg, addr, buflen, offset_in_page(buf));
+	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
+	unsigned int iv_size = crypto_aead_ivsize(tfm);
+	unsigned int len;
+	u8 *p;
+
+	*num_sgs = cifs_get_num_sgs(rqst, num_rqst, sig);
+
+	len = iv_size;
+	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+	len += req_size;
+	len = ALIGN(len, __alignof__(struct scatterlist));
+	len += *num_sgs * sizeof(**sgl);
+
+	p = kmalloc(len, GFP_ATOMIC);
+	if (!p)
+		return NULL;
+
+	*iv = (u8 *)PTR_ALIGN(p, crypto_aead_alignmask(tfm) + 1);
+	*req = (struct aead_request *)PTR_ALIGN(*iv + iv_size,
+						crypto_tfm_ctx_alignment());
+	*sgl = (struct scatterlist *)PTR_ALIGN((u8 *)*req + req_size,
+					       __alignof__(struct scatterlist));
+	return p;
 }
 
-/* Assumes the first rqst has a transform header as the first iov.
- * I.e.
- * rqst[0].rq_iov[0]  is transform header
- * rqst[0].rq_iov[1+] data to be encrypted/decrypted
- * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
- */
-static struct scatterlist *
-init_sg(int num_rqst, struct smb_rqst *rqst, u8 *sign)
+static void *smb2_get_aead_req(struct crypto_aead *tfm, const struct smb_rqst *rqst,
+			       int num_rqst, const u8 *sig, u8 **iv,
+			       struct aead_request **req, struct scatterlist **sgl)
 {
-	unsigned int sg_len;
+	unsigned int off, len, skip;
 	struct scatterlist *sg;
-	unsigned int i;
-	unsigned int j;
-	unsigned int idx = 0;
-	int skip;
+	unsigned int num_sgs;
+	unsigned long addr;
+	int i, j;
+	void *p;
 
-	sg_len = 1;
-	for (i = 0; i < num_rqst; i++)
-		sg_len += rqst[i].rq_nvec + rqst[i].rq_npages;
-
-	sg = kmalloc_array(sg_len, sizeof(struct scatterlist), GFP_KERNEL);
-	if (!sg)
+	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, sgl, &num_sgs);
+	if (!p)
 		return NULL;
 
-	sg_init_table(sg, sg_len);
+	sg_init_table(*sgl, num_sgs);
+	sg = *sgl;
+
+	/* Assumes the first rqst has a transform header as the first iov.
+	 * I.e.
+	 * rqst[0].rq_iov[0]  is transform header
+	 * rqst[0].rq_iov[1+] data to be encrypted/decrypted
+	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
+	 */
 	for (i = 0; i < num_rqst; i++) {
+		/*
+		 * The first rqst has a transform header where the
+		 * first 20 bytes are not part of the encrypted blob.
+		 */
 		for (j = 0; j < rqst[i].rq_nvec; j++) {
-			/*
-			 * The first rqst has a transform header where the
-			 * first 20 bytes are not part of the encrypted blob
-			 */
+			struct kvec *iov = &rqst[i].rq_iov[j];
+
 			skip = (i == 0) && (j == 0) ? 20 : 0;
-			smb2_sg_set_buf(&sg[idx++],
-					rqst[i].rq_iov[j].iov_base + skip,
-					rqst[i].rq_iov[j].iov_len - skip);
-			}
-
+			addr = (unsigned long)iov->iov_base + skip;
+			len = iov->iov_len - skip;
+			sg = cifs_sg_set_buf(sg, (void *)addr, len);
+		}
 		for (j = 0; j < rqst[i].rq_npages; j++) {
-			unsigned int len, offset;
-
-			rqst_page_get_length(&rqst[i], j, &len, &offset);
-			sg_set_page(&sg[idx++], rqst[i].rq_pages[j], len, offset);
+			rqst_page_get_length(&rqst[i], j, &len, &off);
+			sg_set_page(sg++, rqst[i].rq_pages[j], len, off);
 		}
 	}
-	smb2_sg_set_buf(&sg[idx], sign, SMB2_SIGNATURE_SIZE);
-	return sg;
+	cifs_sg_set_buf(sg, sig, SMB2_SIGNATURE_SIZE);
+
+	return p;
 }
 
 static int
@@ -4314,11 +4327,11 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 sign[SMB2_SIGNATURE_SIZE] = {};
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
-	char *iv;
-	unsigned int iv_len;
+	u8 *iv;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	void *creq;
 
 	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), enc, key);
 	if (rc) {
@@ -4352,32 +4365,15 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	req = aead_request_alloc(tfm, GFP_KERNEL);
-	if (!req) {
-		cifs_server_dbg(VFS, "%s: Failed to alloc aead request\n", __func__);
+	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg);
+	if (unlikely(!creq))
 		return -ENOMEM;
-	}
 
 	if (!enc) {
 		memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
 		crypt_len += SMB2_SIGNATURE_SIZE;
 	}
 
-	sg = init_sg(num_rqst, rqst, sign);
-	if (!sg) {
-		cifs_server_dbg(VFS, "%s: Failed to init sg\n", __func__);
-		rc = -ENOMEM;
-		goto free_req;
-	}
-
-	iv_len = crypto_aead_ivsize(tfm);
-	iv = kzalloc(iv_len, GFP_KERNEL);
-	if (!iv) {
-		cifs_server_dbg(VFS, "%s: Failed to alloc iv\n", __func__);
-		rc = -ENOMEM;
-		goto free_sg;
-	}
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
 	    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
@@ -4386,6 +4382,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
 	}
 
+	aead_request_set_tfm(req, tfm);
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
@@ -4398,11 +4395,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
 
-	kfree_sensitive(iv);
-free_sg:
-	kfree_sensitive(sg);
-free_req:
-	kfree_sensitive(req);
+	kfree_sensitive(creq);
 	return rc;
 }
 
-- 
2.38.1

