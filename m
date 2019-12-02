Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51E10E657
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Dec 2019 08:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLBH3Q (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 2 Dec 2019 02:29:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbfLBH3Q (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 2 Dec 2019 02:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575271755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9gUCs/cEBpxrT7eKfVFRimfnB7hqRsKbRDQyHZ9Yt4=;
        b=VbliR3z0AFFvdWE2B+2jYn/vXleaw9QKYL7jX7IK5dltNzv9BrMfv7kRYK9aIIYxQJ0n6o
        n1/n4N90+YxjW+KyuTACmRaLXbTdo+3g8Ak6Jk0Sv5vp9fU/xGaOpD2BBM7H0l2oQnxk3n
        EtXIyzFK5M2m97ANvbBJRtimS3Kj7uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-fk2qsD-BOYSOIPUEDYTAUQ-1; Mon, 02 Dec 2019 02:29:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40528800D4C
        for <linux-cifs@vger.kernel.org>; Mon,  2 Dec 2019 07:29:13 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 919B967E4D;
        Mon,  2 Dec 2019 07:29:12 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 1/3] cifs: prepare SMB2_query_directory to be used with compounding
Date:   Mon,  2 Dec 2019 17:28:58 +1000
Message-Id: <20191202072900.21981-2-lsahlber@redhat.com>
In-Reply-To: <20191202072900.21981-1-lsahlber@redhat.com>
References: <20191202072900.21981-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fk2qsD-BOYSOIPUEDYTAUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2pdu.c   | 108 +++++++++++++++++++++++++++++++++++-------------=
----
 fs/cifs/smb2pdu.h   |   2 +
 fs/cifs/smb2proto.h |   5 +++
 3 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index ed77f94dbf1d..df903931590e 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4214,56 +4214,36 @@ num_entries(char *bufstart, char *end_of_buf, char =
**lastentry, size_t size)
 /*
  * Readdir/FindFirst
  */
-int
-SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
-=09=09     u64 persistent_fid, u64 volatile_fid, int index,
-=09=09     struct cifs_search_info *srch_inf)
+int SMB2_query_directory_init(const unsigned int xid,
+=09=09=09      struct cifs_tcon *tcon, struct smb_rqst *rqst,
+=09=09=09      u64 persistent_fid, u64 volatile_fid,
+=09=09=09      int index, int info_level)
 {
-=09struct smb_rqst rqst;
+=09struct TCP_Server_Info *server =3D tcon->ses->server;
 =09struct smb2_query_directory_req *req;
-=09struct smb2_query_directory_rsp *rsp =3D NULL;
-=09struct kvec iov[2];
-=09struct kvec rsp_iov;
-=09int rc =3D 0;
-=09int len;
-=09int resp_buftype =3D CIFS_NO_BUFFER;
 =09unsigned char *bufptr;
-=09struct TCP_Server_Info *server;
-=09struct cifs_ses *ses =3D tcon->ses;
 =09__le16 asteriks =3D cpu_to_le16('*');
-=09char *end_of_smb;
 =09unsigned int output_size =3D CIFSMaxBufSize;
-=09size_t info_buf_size;
-=09int flags =3D 0;
 =09unsigned int total_len;
-
-=09if (ses && (ses->server))
-=09=09server =3D ses->server;
-=09else
-=09=09return -EIO;
+=09struct kvec *iov =3D rqst->rq_iov;
+=09int len, rc;
=20
 =09rc =3D smb2_plain_req_init(SMB2_QUERY_DIRECTORY, tcon, (void **) &req,
 =09=09=09     &total_len);
 =09if (rc)
 =09=09return rc;
=20
-=09if (smb3_encryption_required(tcon))
-=09=09flags |=3D CIFS_TRANSFORM_REQ;
-
-=09switch (srch_inf->info_level) {
+=09switch (info_level) {
 =09case SMB_FIND_FILE_DIRECTORY_INFO:
 =09=09req->FileInformationClass =3D FILE_DIRECTORY_INFORMATION;
-=09=09info_buf_size =3D sizeof(FILE_DIRECTORY_INFO) - 1;
 =09=09break;
 =09case SMB_FIND_FILE_ID_FULL_DIR_INFO:
 =09=09req->FileInformationClass =3D FILEID_FULL_DIRECTORY_INFORMATION;
-=09=09info_buf_size =3D sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
 =09=09break;
 =09default:
 =09=09cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
-=09=09=09 srch_inf->info_level);
-=09=09rc =3D -EINVAL;
-=09=09goto qdir_exit;
+=09=09=09info_level);
+=09=09return -EINVAL;
 =09}
=20
 =09req->FileIndex =3D cpu_to_le32(index);
@@ -4292,15 +4272,56 @@ SMB2_query_directory(const unsigned int xid, struct=
 cifs_tcon *tcon,
 =09iov[1].iov_base =3D (char *)(req->Buffer);
 =09iov[1].iov_len =3D len;
=20
+=09trace_smb3_query_dir_enter(xid, persistent_fid, tcon->tid,
+=09=09=09tcon->ses->Suid, index, output_size);
+
+=09return 0;
+}
+
+void SMB2_query_directory_free(struct smb_rqst *rqst)
+{
+=09if (rqst && rqst->rq_iov) {
+=09=09cifs_small_buf_release(rqst->rq_iov[0].iov_base); /* request */
+=09}
+}
+
+int
+SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
+=09=09     u64 persistent_fid, u64 volatile_fid, int index,
+=09=09     struct cifs_search_info *srch_inf)
+{
+=09struct smb_rqst rqst;
+=09struct kvec iov[SMB2_QUERY_DIRECTORY_IOV_SIZE];
+=09struct smb2_query_directory_rsp *rsp =3D NULL;
+=09int resp_buftype =3D CIFS_NO_BUFFER;
+=09struct kvec rsp_iov;
+=09int rc =3D 0;
+=09struct TCP_Server_Info *server;
+=09struct cifs_ses *ses =3D tcon->ses;
+=09char *end_of_smb;
+=09size_t info_buf_size;
+=09int flags =3D 0;
+
+=09if (ses && (ses->server))
+=09=09server =3D ses->server;
+=09else
+=09=09return -EIO;
+
+=09if (smb3_encryption_required(tcon))
+=09=09flags |=3D CIFS_TRANSFORM_REQ;
+
 =09memset(&rqst, 0, sizeof(struct smb_rqst));
+=09memset(&iov, 0, sizeof(iov));
 =09rqst.rq_iov =3D iov;
-=09rqst.rq_nvec =3D 2;
+=09rqst.rq_nvec =3D SMB2_QUERY_DIRECTORY_IOV_SIZE;
=20
-=09trace_smb3_query_dir_enter(xid, persistent_fid, tcon->tid,
-=09=09=09tcon->ses->Suid, index, output_size);
+=09rc =3D SMB2_query_directory_init(xid, tcon, &rqst, persistent_fid,
+=09=09=09=09       volatile_fid, index,
+=09=09=09=09       srch_inf->info_level);
+=09if (rc)
+=09=09goto qdir_exit;
=20
 =09rc =3D cifs_send_recv(xid, ses, &rqst, &resp_buftype, flags, &rsp_iov);
-=09cifs_small_buf_release(req);
 =09rsp =3D (struct smb2_query_directory_rsp *)rsp_iov.iov_base;
=20
 =09if (rc) {
@@ -4318,6 +4339,20 @@ SMB2_query_directory(const unsigned int xid, struct =
cifs_tcon *tcon,
 =09=09goto qdir_exit;
 =09}
=20
+=09switch (srch_inf->info_level) {
+=09case SMB_FIND_FILE_DIRECTORY_INFO:
+=09=09info_buf_size =3D sizeof(FILE_DIRECTORY_INFO) - 1;
+=09=09break;
+=09case SMB_FIND_FILE_ID_FULL_DIR_INFO:
+=09=09info_buf_size =3D sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
+=09=09break;
+=09default:
+=09=09cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
+=09=09=09 srch_inf->info_level);
+=09=09rc =3D -EINVAL;
+=09=09goto qdir_exit;
+=09}
+
 =09rc =3D smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
 =09=09=09       le32_to_cpu(rsp->OutputBufferLength), &rsp_iov,
 =09=09=09       info_buf_size);
@@ -4353,11 +4388,14 @@ SMB2_query_directory(const unsigned int xid, struct=
 cifs_tcon *tcon,
 =09else
 =09=09cifs_tcon_dbg(VFS, "illegal search buffer type\n");
=20
+=09rsp =3D NULL;
+=09resp_buftype =3D CIFS_NO_BUFFER;
+
 =09trace_smb3_query_dir_done(xid, persistent_fid, tcon->tid,
 =09=09=09tcon->ses->Suid, index, srch_inf->entries_in_buffer);
-=09return rc;
=20
 qdir_exit:
+=09SMB2_query_directory_free(&rqst);
 =09free_rsp_buf(resp_buftype, rsp);
 =09return rc;
 }
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index f264e1d36fe1..caf323be0d7f 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -1272,6 +1272,8 @@ struct smb2_echo_rsp {
 #define SMB2_INDEX_SPECIFIED=09=090x04
 #define SMB2_REOPEN=09=09=090x10
=20
+#define SMB2_QUERY_DIRECTORY_IOV_SIZE 2
+
 struct smb2_query_directory_req {
 =09struct smb2_sync_hdr sync_hdr;
 =09__le16 StructureSize; /* Must be 33 */
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index d21a5fcc8d06..ba48ce9af620 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -194,6 +194,11 @@ extern int SMB2_echo(struct TCP_Server_Info *server);
 extern int SMB2_query_directory(const unsigned int xid, struct cifs_tcon *=
tcon,
 =09=09=09=09u64 persistent_fid, u64 volatile_fid, int index,
 =09=09=09=09struct cifs_search_info *srch_inf);
+extern int SMB2_query_directory_init(unsigned int xid, struct cifs_tcon *t=
con,
+=09=09=09=09     struct smb_rqst *rqst,
+=09=09=09=09     u64 persistent_fid, u64 volatile_fid,
+=09=09=09=09     int index, int info_level);
+extern void SMB2_query_directory_free(struct smb_rqst *rqst);
 extern int SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon,
 =09=09=09u64 persistent_fid, u64 volatile_fid, u32 pid,
 =09=09=09__le64 *eof);
--=20
2.13.6

