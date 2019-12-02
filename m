Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0817710E655
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Dec 2019 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLBH3O (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 2 Dec 2019 02:29:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbfLBH3O (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 2 Dec 2019 02:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575271752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syR+M9x+I3NFsqGEh1KO9vu8LAD3MCIJka9OWuVYX9U=;
        b=SWEn0HLK2Pnbc0zeRarIthyYB/XPleULJjzHibrsUE9U7MF8g6lFv2Q5r7TxgYPfqYIdFr
        nsktKKgd3hxrcUO4SEXpSEclpmhyAS7PcQ9ir/OcQggZ6q5TrelBfNDsbNEtK+MBfTiJfb
        W7v20nidVbCQLZI2eJA0CUP+L7dplAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Qu31GxuSM4qACvfr6QS1Tg-1; Mon, 02 Dec 2019 02:29:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 739C6DB23
        for <linux-cifs@vger.kernel.org>; Mon,  2 Dec 2019 07:29:09 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA14D5D6A0;
        Mon,  2 Dec 2019 07:29:08 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 2/3] cifs: create a helper function to parse the query-directory response buffer
Date:   Mon,  2 Dec 2019 17:28:59 +1000
Message-Id: <20191202072900.21981-3-lsahlber@redhat.com>
In-Reply-To: <20191202072900.21981-1-lsahlber@redhat.com>
References: <20191202072900.21981-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Qu31GxuSM4qACvfr6QS1Tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2pdu.c | 110 +++++++++++++++++++++++++++++++-------------------=
----
 1 file changed, 63 insertions(+), 47 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index df903931590e..4e1bd20d97ae 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4286,6 +4286,67 @@ void SMB2_query_directory_free(struct smb_rqst *rqst=
)
 }
=20
 int
+smb2_parse_query_directory(struct cifs_tcon *tcon,
+=09=09=09   struct kvec *rsp_iov,
+=09=09=09   int resp_buftype,
+=09=09=09   struct cifs_search_info *srch_inf)
+{
+=09struct smb2_query_directory_rsp *rsp;
+=09size_t info_buf_size;
+=09char *end_of_smb;
+=09int rc;
+
+=09rsp =3D (struct smb2_query_directory_rsp *)rsp_iov->iov_base;
+
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
+=09=09return -EINVAL;
+=09}
+
+=09rc =3D smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
+=09=09=09       le32_to_cpu(rsp->OutputBufferLength), rsp_iov,
+=09=09=09       info_buf_size);
+=09if (rc)
+=09=09return rc;
+
+=09srch_inf->unicode =3D true;
+
+=09if (srch_inf->ntwrk_buf_start) {
+=09=09if (srch_inf->smallBuf)
+=09=09=09cifs_small_buf_release(srch_inf->ntwrk_buf_start);
+=09=09else
+=09=09=09cifs_buf_release(srch_inf->ntwrk_buf_start);
+=09}
+=09srch_inf->ntwrk_buf_start =3D (char *)rsp;
+=09srch_inf->srch_entries_start =3D srch_inf->last_entry =3D
+=09=09(char *)rsp + le16_to_cpu(rsp->OutputBufferOffset);
+=09end_of_smb =3D rsp_iov->iov_len + (char *)rsp;
+=09srch_inf->entries_in_buffer =3D
+=09=09=09num_entries(srch_inf->srch_entries_start, end_of_smb,
+=09=09=09=09    &srch_inf->last_entry, info_buf_size);
+=09srch_inf->index_of_last_entry +=3D srch_inf->entries_in_buffer;
+=09cifs_dbg(FYI, "num entries %d last_index %lld srch start %p srch end %p=
\n",
+=09=09 srch_inf->entries_in_buffer, srch_inf->index_of_last_entry,
+=09=09 srch_inf->srch_entries_start, srch_inf->last_entry);
+=09if (resp_buftype =3D=3D CIFS_LARGE_BUFFER)
+=09=09srch_inf->smallBuf =3D false;
+=09else if (resp_buftype =3D=3D CIFS_SMALL_BUFFER)
+=09=09srch_inf->smallBuf =3D true;
+=09else
+=09=09cifs_tcon_dbg(VFS, "illegal search buffer type\n");
+
+=09return 0;
+}
+
+int
 SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 =09=09     u64 persistent_fid, u64 volatile_fid, int index,
 =09=09     struct cifs_search_info *srch_inf)
@@ -4298,8 +4359,6 @@ SMB2_query_directory(const unsigned int xid, struct c=
ifs_tcon *tcon,
 =09int rc =3D 0;
 =09struct TCP_Server_Info *server;
 =09struct cifs_ses *ses =3D tcon->ses;
-=09char *end_of_smb;
-=09size_t info_buf_size;
 =09int flags =3D 0;
=20
 =09if (ses && (ses->server))
@@ -4339,56 +4398,13 @@ SMB2_query_directory(const unsigned int xid, struct=
 cifs_tcon *tcon,
 =09=09goto qdir_exit;
 =09}
=20
-=09switch (srch_inf->info_level) {
-=09case SMB_FIND_FILE_DIRECTORY_INFO:
-=09=09info_buf_size =3D sizeof(FILE_DIRECTORY_INFO) - 1;
-=09=09break;
-=09case SMB_FIND_FILE_ID_FULL_DIR_INFO:
-=09=09info_buf_size =3D sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
-=09=09break;
-=09default:
-=09=09cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
-=09=09=09 srch_inf->info_level);
-=09=09rc =3D -EINVAL;
-=09=09goto qdir_exit;
-=09}
-
-=09rc =3D smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
-=09=09=09       le32_to_cpu(rsp->OutputBufferLength), &rsp_iov,
-=09=09=09       info_buf_size);
+=09rc =3D smb2_parse_query_directory(tcon, &rsp_iov,=09resp_buftype,
+=09=09=09=09=09srch_inf);
 =09if (rc) {
 =09=09trace_smb3_query_dir_err(xid, persistent_fid, tcon->tid,
 =09=09=09tcon->ses->Suid, index, 0, rc);
 =09=09goto qdir_exit;
 =09}
-
-=09srch_inf->unicode =3D true;
-
-=09if (srch_inf->ntwrk_buf_start) {
-=09=09if (srch_inf->smallBuf)
-=09=09=09cifs_small_buf_release(srch_inf->ntwrk_buf_start);
-=09=09else
-=09=09=09cifs_buf_release(srch_inf->ntwrk_buf_start);
-=09}
-=09srch_inf->ntwrk_buf_start =3D (char *)rsp;
-=09srch_inf->srch_entries_start =3D srch_inf->last_entry =3D
-=09=09(char *)rsp + le16_to_cpu(rsp->OutputBufferOffset);
-=09end_of_smb =3D rsp_iov.iov_len + (char *)rsp;
-=09srch_inf->entries_in_buffer =3D
-=09=09=09num_entries(srch_inf->srch_entries_start, end_of_smb,
-=09=09=09=09    &srch_inf->last_entry, info_buf_size);
-=09srch_inf->index_of_last_entry +=3D srch_inf->entries_in_buffer;
-=09cifs_dbg(FYI, "num entries %d last_index %lld srch start %p srch end %p=
\n",
-=09=09 srch_inf->entries_in_buffer, srch_inf->index_of_last_entry,
-=09=09 srch_inf->srch_entries_start, srch_inf->last_entry);
-=09if (resp_buftype =3D=3D CIFS_LARGE_BUFFER)
-=09=09srch_inf->smallBuf =3D false;
-=09else if (resp_buftype =3D=3D CIFS_SMALL_BUFFER)
-=09=09srch_inf->smallBuf =3D true;
-=09else
-=09=09cifs_tcon_dbg(VFS, "illegal search buffer type\n");
-
-=09rsp =3D NULL;
 =09resp_buftype =3D CIFS_NO_BUFFER;
=20
 =09trace_smb3_query_dir_done(xid, persistent_fid, tcon->tid,
--=20
2.13.6

