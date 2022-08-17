Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3F597754
	for <lists+linux-cifs@lfdr.de>; Wed, 17 Aug 2022 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiHQT7X (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 17 Aug 2022 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbiHQT7W (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 17 Aug 2022 15:59:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660457E0D
        for <linux-cifs@vger.kernel.org>; Wed, 17 Aug 2022 12:59:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABE8638139;
        Wed, 17 Aug 2022 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660766359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=za5D10ll3e0mvoBsmPJTUyAEjrn7i+euq9C3GKzmWGs=;
        b=RQtvojma0MmHUzg1v2lI+nrz5m2YA4HjhejAUGKCglh38qF7xDaBuLA/bhBDPH1yzT+sRg
        KbVmlmLiBxbvN+0VujR0IBn2Bv/CRNZj4Wbnhj1xOfbkB3r4z6Dxyh9VSA/wEDOaDodp15
        4QEYVtVvscjzQLPuhnRc1hqZwcPx7tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660766359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=za5D10ll3e0mvoBsmPJTUyAEjrn7i+euq9C3GKzmWGs=;
        b=1nrVUdxch2AstUlZxCc7PAMktsCNdzC8X6HLyTWOhN98v70gYamuRBnEfWBGf+6B3D/CHI
        lFjSbTxxHtTQV2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C0BB13428;
        Wed, 17 Aug 2022 19:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nlN/N5ZI/WJdcQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 17 Aug 2022 19:59:18 +0000
Date:   Wed, 17 Aug 2022 16:59:16 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Subject: Re: [PATCH] cifs: remove useless parameter 'is_fsctl' from
 SMB2_ioctl()
Message-ID: <20220817195916.gkmc4dera3syo5nh@cyberdelia>
References: <20220817190834.15137-1-ematsumiya@suse.de>
 <CAH2r5mvjeBo7pDVyrD5Hqu5=2L-f8DD=j2-r2iPRPeC8PoR2JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5mvjeBo7pDVyrD5Hqu5=2L-f8DD=j2-r2iPRPeC8PoR2JA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 08/17, Steve French wrote:
>One alternative would be to allow the user space "pass through ioctl"
>to set this flag to false (in case there were cases where a server did
>support it and a test program or userspace utility needs to set it).

I don't really see the point of having so.

>Do both Samba and ksmbd always reject it if isFsctl is false?

Yes.

For reference, Samba in smbd_smb2_request_ioctl_done() (source3/smbd/smb2_ioctl.c):

7599         if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
7600                 rsp->hdr.Status = STATUS_NOT_SUPPORTED;
7601                 goto out;
7602         }

and in ksmbd smb2_ioctl() (fs/ksmbd/smb2pdu.c):

7599         if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
7600                 rsp->hdr.Status = STATUS_NOT_SUPPORTED;
7601                 goto out;
7602         }


Cheers,

Enzo

>On Wed, Aug 17, 2022 at 2:08 PM Enzo Matsumiya <ematsumiya@suse.de> wrote:
>>
>> SMB2_ioctl() is always called with is_fsctl = true, so doesn't make any
>> sense to have it at all.
>>
>> Thus, always set SMB2_0_IOCTL_IS_FSCTL flag on the request.
>>
>> Also, as per MS-SMB2 3.3.5.15 "Receiving an SMB2 IOCTL Request", servers
>> must fail the request if the request flags is zero anyway.
>>
>> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
>> ---
>>  fs/cifs/smb2file.c  |  1 -
>>  fs/cifs/smb2ops.c   | 35 +++++++++++++----------------------
>>  fs/cifs/smb2pdu.c   | 20 +++++++++-----------
>>  fs/cifs/smb2proto.h |  4 ++--
>>  4 files changed, 24 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
>> index f5dcc4940b6d..9dfd2dd612c2 100644
>> --- a/fs/cifs/smb2file.c
>> +++ b/fs/cifs/smb2file.c
>> @@ -61,7 +61,6 @@ smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
>>                 nr_ioctl_req.Reserved = 0;
>>                 rc = SMB2_ioctl(xid, oparms->tcon, fid->persistent_fid,
>>                         fid->volatile_fid, FSCTL_LMR_REQUEST_RESILIENCY,
>> -                       true /* is_fsctl */,
>>                         (char *)&nr_ioctl_req, sizeof(nr_ioctl_req),
>>                         CIFSMaxBufSize, NULL, NULL /* no return info */);
>>                 if (rc == -EOPNOTSUPP) {
>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>> index f406af596887..c8ada000de7f 100644
>> --- a/fs/cifs/smb2ops.c
>> +++ b/fs/cifs/smb2ops.c
>> @@ -681,7 +681,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
>>         struct cifs_ses *ses = tcon->ses;
>>
>>         rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>> -                       FSCTL_QUERY_NETWORK_INTERFACE_INFO, true /* is_fsctl */,
>> +                       FSCTL_QUERY_NETWORK_INTERFACE_INFO,
>>                         NULL /* no data input */, 0 /* no data input */,
>>                         CIFSMaxBufSize, (char **)&out_buf, &ret_data_len);
>>         if (rc == -EOPNOTSUPP) {
>> @@ -1323,9 +1323,8 @@ SMB2_request_res_key(const unsigned int xid, struct cifs_tcon *tcon,
>>         struct resume_key_req *res_key;
>>
>>         rc = SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
>> -                       FSCTL_SRV_REQUEST_RESUME_KEY, true /* is_fsctl */,
>> -                       NULL, 0 /* no input */, CIFSMaxBufSize,
>> -                       (char **)&res_key, &ret_data_len);
>> +                       FSCTL_SRV_REQUEST_RESUME_KEY, NULL, 0 /* no input */,
>> +                       CIFSMaxBufSize, (char **)&res_key, &ret_data_len);
>>
>>         if (rc == -EOPNOTSUPP) {
>>                 pr_warn_once("Server share %s does not support copy range\n", tcon->treeName);
>> @@ -1467,7 +1466,7 @@ smb2_ioctl_query_info(const unsigned int xid,
>>                 rqst[1].rq_nvec = SMB2_IOCTL_IOV_SIZE;
>>
>>                 rc = SMB2_ioctl_init(tcon, server, &rqst[1], COMPOUND_FID, COMPOUND_FID,
>> -                                    qi.info_type, true, buffer, qi.output_buffer_length,
>> +                                    qi.info_type, buffer, qi.output_buffer_length,
>>                                      CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
>>                                      MAX_SMB2_CLOSE_RESPONSE_SIZE);
>>                 free_req1_func = SMB2_ioctl_free;
>> @@ -1643,9 +1642,8 @@ smb2_copychunk_range(const unsigned int xid,
>>                 retbuf = NULL;
>>                 rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
>>                         trgtfile->fid.volatile_fid, FSCTL_SRV_COPYCHUNK_WRITE,
>> -                       true /* is_fsctl */, (char *)pcchunk,
>> -                       sizeof(struct copychunk_ioctl), CIFSMaxBufSize,
>> -                       (char **)&retbuf, &ret_data_len);
>> +                       (char *)pcchunk, sizeof(struct copychunk_ioctl),
>> +                       CIFSMaxBufSize, (char **)&retbuf, &ret_data_len);
>>                 if (rc == 0) {
>>                         if (ret_data_len !=
>>                                         sizeof(struct copychunk_ioctl_rsp)) {
>> @@ -1805,7 +1803,6 @@ static bool smb2_set_sparse(const unsigned int xid, struct cifs_tcon *tcon,
>>
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid, FSCTL_SET_SPARSE,
>> -                       true /* is_fctl */,
>>                         &setsparse, 1, CIFSMaxBufSize, NULL, NULL);
>>         if (rc) {
>>                 tcon->broken_sparse_sup = true;
>> @@ -1888,7 +1885,6 @@ smb2_duplicate_extents(const unsigned int xid,
>>         rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
>>                         trgtfile->fid.volatile_fid,
>>                         FSCTL_DUPLICATE_EXTENTS_TO_FILE,
>> -                       true /* is_fsctl */,
>>                         (char *)&dup_ext_buf,
>>                         sizeof(struct duplicate_extents_to_file),
>>                         CIFSMaxBufSize, NULL,
>> @@ -1923,7 +1919,6 @@ smb3_set_integrity(const unsigned int xid, struct cifs_tcon *tcon,
>>         return SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid,
>>                         FSCTL_SET_INTEGRITY_INFORMATION,
>> -                       true /* is_fsctl */,
>>                         (char *)&integr_info,
>>                         sizeof(struct fsctl_set_integrity_information_req),
>>                         CIFSMaxBufSize, NULL,
>> @@ -1976,7 +1971,6 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid,
>>                         FSCTL_SRV_ENUMERATE_SNAPSHOTS,
>> -                       true /* is_fsctl */,
>>                         NULL, 0 /* no input data */, max_response_size,
>>                         (char **)&retbuf,
>>                         &ret_data_len);
>> @@ -2699,7 +2693,6 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
>>         do {
>>                 rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>>                                 FSCTL_DFS_GET_REFERRALS,
>> -                               true /* is_fsctl */,
>>                                 (char *)dfs_req, dfs_req_size, CIFSMaxBufSize,
>>                                 (char **)&dfs_rsp, &dfs_rsp_size);
>>                 if (!is_retryable_error(rc))
>> @@ -2906,8 +2899,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
>>
>>         rc = SMB2_ioctl_init(tcon, server,
>>                              &rqst[1], fid.persistent_fid,
>> -                            fid.volatile_fid, FSCTL_GET_REPARSE_POINT,
>> -                            true /* is_fctl */, NULL, 0,
>> +                            fid.volatile_fid, FSCTL_GET_REPARSE_POINT, NULL, 0,
>>                              CIFSMaxBufSize -
>>                              MAX_SMB2_CREATE_RESPONSE_SIZE -
>>                              MAX_SMB2_CLOSE_RESPONSE_SIZE);
>> @@ -3087,8 +3079,7 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
>>
>>         rc = SMB2_ioctl_init(tcon, server,
>>                              &rqst[1], COMPOUND_FID,
>> -                            COMPOUND_FID, FSCTL_GET_REPARSE_POINT,
>> -                            true /* is_fctl */, NULL, 0,
>> +                            COMPOUND_FID, FSCTL_GET_REPARSE_POINT, NULL, 0,
>>                              CIFSMaxBufSize -
>>                              MAX_SMB2_CREATE_RESPONSE_SIZE -
>>                              MAX_SMB2_CLOSE_RESPONSE_SIZE);
>> @@ -3358,7 +3349,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
>>         fsctl_buf.BeyondFinalZero = cpu_to_le64(offset + len);
>>
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>> -                       cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA, true,
>> +                       cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA,
>>                         (char *)&fsctl_buf,
>>                         sizeof(struct file_zero_data_information),
>>                         0, NULL, NULL);
>> @@ -3421,7 +3412,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
>>
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA,
>> -                       true /* is_fctl */, (char *)&fsctl_buf,
>> +                       (char *)&fsctl_buf,
>>                         sizeof(struct file_zero_data_information),
>>                         CIFSMaxBufSize, NULL, NULL);
>>         free_xid(xid);
>> @@ -3481,7 +3472,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
>>         in_data.length = cpu_to_le64(len);
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid,
>> -                       FSCTL_QUERY_ALLOCATED_RANGES, true,
>> +                       FSCTL_QUERY_ALLOCATED_RANGES,
>>                         (char *)&in_data, sizeof(in_data),
>>                         1024 * sizeof(struct file_allocated_range_buffer),
>>                         (char **)&out_data, &out_data_len);
>> @@ -3802,7 +3793,7 @@ static loff_t smb3_llseek(struct file *file, struct cifs_tcon *tcon, loff_t offs
>>
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid,
>> -                       FSCTL_QUERY_ALLOCATED_RANGES, true,
>> +                       FSCTL_QUERY_ALLOCATED_RANGES,
>>                         (char *)&in_data, sizeof(in_data),
>>                         sizeof(struct file_allocated_range_buffer),
>>                         (char **)&out_data, &out_data_len);
>> @@ -3862,7 +3853,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>>
>>         rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
>>                         cfile->fid.volatile_fid,
>> -                       FSCTL_QUERY_ALLOCATED_RANGES, true,
>> +                       FSCTL_QUERY_ALLOCATED_RANGES,
>>                         (char *)&in_data, sizeof(in_data),
>>                         1024 * sizeof(struct file_allocated_range_buffer),
>>                         (char **)&out_data, &out_data_len);
>> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
>> index 9b31ea946d45..918152fb8582 100644
>> --- a/fs/cifs/smb2pdu.c
>> +++ b/fs/cifs/smb2pdu.c
>> @@ -1173,7 +1173,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>>         }
>>
>>         rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>> -               FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
>> +               FSCTL_VALIDATE_NEGOTIATE_INFO,
>>                 (char *)pneg_inbuf, inbuflen, CIFSMaxBufSize,
>>                 (char **)&pneg_rsp, &rsplen);
>>         if (rc == -EOPNOTSUPP) {
>> @@ -3056,7 +3056,7 @@ int
>>  SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
>>                 struct smb_rqst *rqst,
>>                 u64 persistent_fid, u64 volatile_fid, u32 opcode,
>> -               bool is_fsctl, char *in_data, u32 indatalen,
>> +               char *in_data, u32 indatalen,
>>                 __u32 max_response_size)
>>  {
>>         struct smb2_ioctl_req *req;
>> @@ -3131,10 +3131,8 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
>>         req->hdr.CreditCharge =
>>                 cpu_to_le16(DIV_ROUND_UP(max(indatalen, max_response_size),
>>                                          SMB2_MAX_BUFFER_SIZE));
>> -       if (is_fsctl)
>> -               req->Flags = cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL);
>> -       else
>> -               req->Flags = 0;
>> +       /* always an FSCTL (for now) */
>> +       req->Flags = cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL);
>>
>>         /* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
>>         if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
>> @@ -3161,9 +3159,9 @@ SMB2_ioctl_free(struct smb_rqst *rqst)
>>   */
>>  int
>>  SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
>> -          u64 volatile_fid, u32 opcode, bool is_fsctl,
>> -          char *in_data, u32 indatalen, u32 max_out_data_len,
>> -          char **out_data, u32 *plen /* returned data len */)
>> +          u64 volatile_fid, u32 opcode, char *in_data, u32 indatalen,
>> +          u32 max_out_data_len, char **out_data,
>> +          u32 *plen /* returned data len */)
>>  {
>>         struct smb_rqst rqst;
>>         struct smb2_ioctl_rsp *rsp = NULL;
>> @@ -3205,7 +3203,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
>>
>>         rc = SMB2_ioctl_init(tcon, server,
>>                              &rqst, persistent_fid, volatile_fid, opcode,
>> -                            is_fsctl, in_data, indatalen, max_out_data_len);
>> +                            in_data, indatalen, max_out_data_len);
>>         if (rc)
>>                 goto ioctl_exit;
>>
>> @@ -3297,7 +3295,7 @@ SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
>>                         cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
>>
>>         rc = SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
>> -                       FSCTL_SET_COMPRESSION, true /* is_fsctl */,
>> +                       FSCTL_SET_COMPRESSION,
>>                         (char *)&fsctl_input /* data input */,
>>                         2 /* in data len */, CIFSMaxBufSize /* max out data */,
>>                         &ret_data /* out data */, NULL);
>> diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
>> index 51c5bf4a338a..7001317de9dc 100644
>> --- a/fs/cifs/smb2proto.h
>> +++ b/fs/cifs/smb2proto.h
>> @@ -137,13 +137,13 @@ extern int SMB2_open_init(struct cifs_tcon *tcon,
>>  extern void SMB2_open_free(struct smb_rqst *rqst);
>>  extern int SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon,
>>                      u64 persistent_fid, u64 volatile_fid, u32 opcode,
>> -                    bool is_fsctl, char *in_data, u32 indatalen, u32 maxoutlen,
>> +                    char *in_data, u32 indatalen, u32 maxoutlen,
>>                      char **out_data, u32 *plen /* returned data len */);
>>  extern int SMB2_ioctl_init(struct cifs_tcon *tcon,
>>                            struct TCP_Server_Info *server,
>>                            struct smb_rqst *rqst,
>>                            u64 persistent_fid, u64 volatile_fid, u32 opcode,
>> -                          bool is_fsctl, char *in_data, u32 indatalen,
>> +                          char *in_data, u32 indatalen,
>>                            __u32 max_response_size);
>>  extern void SMB2_ioctl_free(struct smb_rqst *rqst);
>>  extern int SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
>> --
>> 2.35.3
>>
>
>
>-- 
>Thanks,
>
>Steve
