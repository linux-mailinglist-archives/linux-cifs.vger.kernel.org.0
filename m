Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43B5ADD6F
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Sep 2022 04:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiIFCgo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 5 Sep 2022 22:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIFCgn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 5 Sep 2022 22:36:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35AA5D11C
        for <linux-cifs@vger.kernel.org>; Mon,  5 Sep 2022 19:36:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e17so5742573edc.5
        for <linux-cifs@vger.kernel.org>; Mon, 05 Sep 2022 19:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vVduqOEB+pCIaj8Wd3mt3q1D9HyFN3j5pxwutpSuveo=;
        b=S897lCJmcWPHEDyPyYvLO4I/hjXdZf4IXEjfr9OP9ZViuPhFLIeVHZy2+SPnuyvv1Y
         eW3vAd2pf7qKScLn4/eeG3hgr8kCllm3IR1jZFqLenwxt3Lw9VC7Ifs8y2uHRgW6ScN2
         +BNpxnCLxQrpzKfXe2g+J9EnEYTrVHlVponbDXTqn1LbK1hHZnf74dt961VzryTwQw3x
         Abo5vSMZRpCr4FfyvJ82HloL0p0yHAVPfxFsKrIZ8vUdD1LAn1Z/eYUmwaMCtyPTUyuo
         XfvtcyFnKR3CBHYGH8aQ+SsmY08WCZAobQSmdw2IBGtgCdq8TGyegOx8WRbpDxrG1wDG
         UlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vVduqOEB+pCIaj8Wd3mt3q1D9HyFN3j5pxwutpSuveo=;
        b=ysWAq4VM1fY+Qd62xYtqrduQBoQUJ5d6EB95DCRZwcK7F+l34fUipjZlkOv7x4EGGB
         PSFbJmrKlFJxtbDFTjfaEw96lg5RKkm25cP/gt4rl+B23gAGSeX6lNZObvu3in8rkaD6
         E0GrVJwqR81excABSGYGB1iwyomJIuY0k84e6cDfJVfj2pYiMCDcr3C/WbPezlT6NcMv
         ByDcCijwJwfdkhzs4CfDixWDZiMgZoxwC+zDn0nC1hhU/0y2Dr5VhqdxU7TWQlqRnYNO
         e6JeqbIZ9WrUiA4X7mKqbxu/ltXuMw+oouAjrwA6PR4KB9pkuw44vCWLZ7syAy9ue5uo
         7FmQ==
X-Gm-Message-State: ACgBeo16qC8/I4J30tlYVHloJ3jLGlWKFLJXrWx/sgg6IpN50Oli83xb
        ohO2v9Hhb3kM57u3ySB2BKKlMSXBFVJfhiv7zg4=
X-Google-Smtp-Source: AA6agR6JfGRdylVaUR+BJxHce7lgFApTR755Y/YIU6HlbSJjapfvaHpCyfIH6cnzYYtESb0uRGQ7Rhr/AhFrBLDpg4Y=
X-Received: by 2002:a05:6402:42d4:b0:443:4b8:8cba with SMTP id
 i20-20020a05640242d400b0044304b88cbamr45610536edc.3.1662431800342; Mon, 05
 Sep 2022 19:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220906013040.2467-1-ematsumiya@suse.de>
In-Reply-To: <20220906013040.2467-1-ematsumiya@suse.de>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 6 Sep 2022 12:36:27 +1000
Message-ID: <CAN05THRK3hPQ0c4h9bxhrJYa17eH7NjXKe4Gj8upCcuMvPB2cQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: perf improvement - use faster macros ALIGN() and round_up()
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        nspmangalore@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Very nice. The performance change can not be explained, but nice cleanup.

Reviewed by me

On Tue, 6 Sept 2022 at 11:31, Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
> Replace hardcoded alignment computations (e.g. (len + 7) & ~0x7) of
> (mostly) SMB2 messages length by ALIGN()/IS_ALIGNED() macros (right
> tools for the job, less prone to errors).
>
> But also replace (DIV_ROUND_UP(len, 8) * 8) with ALIGN(len, 8), which,
> if not optimized by the compiler, has the overhead of a multiplication
> and a division. Do the same for roundup() by replacing it by round_up()
> (division-less version, but requires the multiple to be a power of 2,
> which is always the case for us).
>
> Also remove some unecessary checks where !IS_ALIGNED() would fit, but
> calling round_up() directly is just fine as it'll be a no-op if the
> value is already aligned.
>
> Afraid this was a useless micro-optimization, I ran some tests with a
> very light workload, and I observed a ~50% perf improvement already:
>
> Record all cifs.ko functions:
>   # trace-cmd record --module cifs -p function_graph
>
> (test-dir has ~50MB with ~4000 files)
> Test commands after share is mounted and with no activity:
>   # cp -r test-dir /mnt/test
>   # sync
>   # umount /mnt/test
>
> Number of traced functions:
>   # trace-cmd report -l | awk '{ print $6 }' | grep "^[0-9].*" | wc -l
> - unpatched: 307746
> - patched: 313199
>
> Measuring the average latency of all traced functions:
>   # trace-cmd report -l | awk '{ print $6 }' | grep "^[0-9].*" | jq -s add/length
> - unpatched: 27105.577791262822 us
> - patched: 14548.665733635338 us
>
> So even though the patched version made 5k+ more function calls (for
> whatever reason), it still did it with ~50% reduced latency.
>
> On a larger scale, given the affected code paths, this patch should
> show a relevant improvement.
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
> Please let me know if my measurements are enough/valid.
>
>  fs/cifs/cifssmb.c   |  7 +++---
>  fs/cifs/connect.c   | 11 ++++++--
>  fs/cifs/sess.c      | 18 +++++--------
>  fs/cifs/smb2inode.c |  4 +--
>  fs/cifs/smb2misc.c  |  2 +-
>  fs/cifs/smb2pdu.c   | 61 +++++++++++++++++++--------------------------
>  6 files changed, 47 insertions(+), 56 deletions(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 7aa91e272027..addf3fc62aef 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -2305,7 +2305,7 @@ int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
>                                         remap);
>         }
>         rename_info->target_name_len = cpu_to_le32(2 * len_of_str);
> -       count = 12 /* sizeof(struct set_file_rename) */ + (2 * len_of_str);
> +       count = sizeof(struct set_file_rename) + (2 * len_of_str);
>         byte_count += count;
>         pSMB->DataCount = cpu_to_le16(count);
>         pSMB->TotalDataCount = pSMB->DataCount;
> @@ -2796,7 +2796,7 @@ CIFSSMBQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
>                 cifs_dbg(FYI, "Invalid return data count on get reparse info ioctl\n");
>                 goto qreparse_out;
>         }
> -       end_of_smb = 2 + get_bcc(&pSMBr->hdr) + (char *)&pSMBr->ByteCount;
> +       end_of_smb = sizeof(__le16) + get_bcc(&pSMBr->hdr) + (char *)&pSMBr->ByteCount;
>         reparse_buf = (struct reparse_symlink_data *)
>                                 ((char *)&pSMBr->hdr.Protocol + data_offset);
>         if ((char *)reparse_buf >= end_of_smb) {
> @@ -3350,8 +3350,7 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
>         pSMBr = (struct smb_com_ntransact_rsp *)buf;
>
>         bcc = get_bcc(&pSMBr->hdr);
> -       end_of_smb = 2 /* sizeof byte count */ + bcc +
> -                       (char *)&pSMBr->ByteCount;
> +       end_of_smb = sizeof(__le16) + bcc + (char *)&pSMBr->ByteCount;
>
>         data_offset = le32_to_cpu(pSMBr->DataOffset);
>         data_count = le32_to_cpu(pSMBr->DataCount);
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index a0a06b6f252b..389127e21563 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -2833,9 +2833,12 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
>          * sessinit is sent but no second negprot
>          */
>         struct rfc1002_session_packet *ses_init_buf;
> +       unsigned int req_noscope_len;
>         struct smb_hdr *smb_buf;
> +
>         ses_init_buf = kzalloc(sizeof(struct rfc1002_session_packet),
>                                GFP_KERNEL);
> +
>         if (ses_init_buf) {
>                 ses_init_buf->trailer.session_req.called_len = 32;
>
> @@ -2871,8 +2874,12 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
>                 ses_init_buf->trailer.session_req.scope2 = 0;
>                 smb_buf = (struct smb_hdr *)ses_init_buf;
>
> -               /* sizeof RFC1002_SESSION_REQUEST with no scope */
> -               smb_buf->smb_buf_length = cpu_to_be32(0x81000044);
> +               /* sizeof RFC1002_SESSION_REQUEST with no scopes */
> +               req_noscope_len = sizeof(struct rfc1002_session_packet) - 2;
> +
> +               /* == cpu_to_be32(0x81000044) */
> +               smb_buf->smb_buf_length =
> +                       cpu_to_be32((RFC1002_SESSION_REQUEST << 24) | req_noscope_len);
>                 rc = smb_send(server, smb_buf, 0x44);
>                 kfree(ses_init_buf);
>                 /*
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index 3af3b05b6c74..951874928d70 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -601,11 +601,6 @@ static void unicode_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
>         /* BB FIXME add check that strings total less
>         than 335 or will need to send them as arrays */
>
> -       /* unicode strings, must be word aligned before the call */
> -/*     if ((long) bcc_ptr % 2) {
> -               *bcc_ptr = 0;
> -               bcc_ptr++;
> -       } */
>         /* copy user */
>         if (ses->user_name == NULL) {
>                 /* null user mount */
> @@ -1318,7 +1313,7 @@ sess_auth_ntlmv2(struct sess_data *sess_data)
>         }
>
>         if (ses->capabilities & CAP_UNICODE) {
> -               if (sess_data->iov[0].iov_len % 2) {
> +               if (!IS_ALIGNED(sess_data->iov[0].iov_len, 2)) {
>                         *bcc_ptr = 0;
>                         bcc_ptr++;
>                 }
> @@ -1358,7 +1353,7 @@ sess_auth_ntlmv2(struct sess_data *sess_data)
>                 /* no string area to decode, do nothing */
>         } else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
>                 /* unicode string area must be word-aligned */
> -               if (((unsigned long) bcc_ptr - (unsigned long) smb_buf) % 2) {
> +               if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
>                         ++bcc_ptr;
>                         --bytes_remaining;
>                 }
> @@ -1442,8 +1437,7 @@ sess_auth_kerberos(struct sess_data *sess_data)
>
>         if (ses->capabilities & CAP_UNICODE) {
>                 /* unicode strings must be word aligned */
> -               if ((sess_data->iov[0].iov_len
> -                       + sess_data->iov[1].iov_len) % 2) {
> +               if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
>                         *bcc_ptr = 0;
>                         bcc_ptr++;
>                 }
> @@ -1494,7 +1488,7 @@ sess_auth_kerberos(struct sess_data *sess_data)
>                 /* no string area to decode, do nothing */
>         } else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
>                 /* unicode string area must be word-aligned */
> -               if (((unsigned long) bcc_ptr - (unsigned long) smb_buf) % 2) {
> +               if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
>                         ++bcc_ptr;
>                         --bytes_remaining;
>                 }
> @@ -1546,7 +1540,7 @@ _sess_auth_rawntlmssp_assemble_req(struct sess_data *sess_data)
>
>         bcc_ptr = sess_data->iov[2].iov_base;
>         /* unicode strings must be word aligned */
> -       if ((sess_data->iov[0].iov_len + sess_data->iov[1].iov_len) % 2) {
> +       if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
>                 *bcc_ptr = 0;
>                 bcc_ptr++;
>         }
> @@ -1747,7 +1741,7 @@ sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data)
>                 /* no string area to decode, do nothing */
>         } else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
>                 /* unicode string area must be word-aligned */
> -               if (((unsigned long) bcc_ptr - (unsigned long) smb_buf) % 2) {
> +               if (!IS_ALIGNED((unsigned long)bcc_ptr - (unsigned long)smb_buf, 2)) {
>                         ++bcc_ptr;
>                         --bytes_remaining;
>                 }
> diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
> index b83f59051b26..4eefbe574b82 100644
> --- a/fs/cifs/smb2inode.c
> +++ b/fs/cifs/smb2inode.c
> @@ -207,7 +207,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
>                 rqst[num_rqst].rq_iov = &vars->si_iov[0];
>                 rqst[num_rqst].rq_nvec = 1;
>
> -               size[0] = 1; /* sizeof __u8 See MS-FSCC section 2.4.11 */
> +               size[0] = sizeof(u8); /* See MS-FSCC section 2.4.11 */
>                 data[0] = &delete_pending[0];
>
>                 rc = SMB2_set_info_init(tcon, server,
> @@ -225,7 +225,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
>                 rqst[num_rqst].rq_iov = &vars->si_iov[0];
>                 rqst[num_rqst].rq_nvec = 1;
>
> -               size[0] = 8; /* sizeof __le64 */
> +               size[0] = sizeof(__le64);
>                 data[0] = ptr;
>
>                 rc = SMB2_set_info_init(tcon, server,
> diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
> index d73e5672aac4..258b01306d85 100644
> --- a/fs/cifs/smb2misc.c
> +++ b/fs/cifs/smb2misc.c
> @@ -248,7 +248,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
>                  * Some windows servers (win2016) will pad also the final
>                  * PDU in a compound to 8 bytes.
>                  */
> -               if (((calc_len + 7) & ~7) == len)
> +               if (ALIGN(calc_len, 8) == len)
>                         return 0;
>
>                 /*
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 6352ab32c7e7..5da0b596c8a0 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -466,15 +466,14 @@ build_signing_ctxt(struct smb2_signing_capabilities *pneg_ctxt)
>         /*
>          * Context Data length must be rounded to multiple of 8 for some servers
>          */
> -       pneg_ctxt->DataLength = cpu_to_le16(DIV_ROUND_UP(
> -                               sizeof(struct smb2_signing_capabilities) -
> -                               sizeof(struct smb2_neg_context) +
> -                               (num_algs * 2 /* sizeof u16 */), 8) * 8);
> +       pneg_ctxt->DataLength = cpu_to_le16(ALIGN(sizeof(struct smb2_signing_capabilities) -
> +                                           sizeof(struct smb2_neg_context) +
> +                                           (num_algs * sizeof(u16)), 8));
>         pneg_ctxt->SigningAlgorithmCount = cpu_to_le16(num_algs);
>         pneg_ctxt->SigningAlgorithms[0] = cpu_to_le16(SIGNING_ALG_AES_CMAC);
>
> -       ctxt_len += 2 /* sizeof le16 */ * num_algs;
> -       ctxt_len = DIV_ROUND_UP(ctxt_len, 8) * 8;
> +       ctxt_len += sizeof(__le16) * num_algs;
> +       ctxt_len = ALIGN(ctxt_len, 8);
>         return ctxt_len;
>         /* TBD add SIGNING_ALG_AES_GMAC and/or SIGNING_ALG_HMAC_SHA256 */
>  }
> @@ -511,8 +510,7 @@ build_netname_ctxt(struct smb2_netname_neg_context *pneg_ctxt, char *hostname)
>         /* copy up to max of first 100 bytes of server name to NetName field */
>         pneg_ctxt->DataLength = cpu_to_le16(2 * cifs_strtoUTF16(pneg_ctxt->NetName, hostname, 100, cp));
>         /* context size is DataLength + minimal smb2_neg_context */
> -       return DIV_ROUND_UP(le16_to_cpu(pneg_ctxt->DataLength) +
> -                       sizeof(struct smb2_neg_context), 8) * 8;
> +       return ALIGN(le16_to_cpu(pneg_ctxt->DataLength) + sizeof(struct smb2_neg_context), 8);
>  }
>
>  static void
> @@ -557,18 +555,18 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
>          * round up total_len of fixed part of SMB3 negotiate request to 8
>          * byte boundary before adding negotiate contexts
>          */
> -       *total_len = roundup(*total_len, 8);
> +       *total_len = ALIGN(*total_len, 8);
>
>         pneg_ctxt = (*total_len) + (char *)req;
>         req->NegotiateContextOffset = cpu_to_le32(*total_len);
>
>         build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt);
> -       ctxt_len = DIV_ROUND_UP(sizeof(struct smb2_preauth_neg_context), 8) * 8;
> +       ctxt_len = ALIGN(sizeof(struct smb2_preauth_neg_context), 8);
>         *total_len += ctxt_len;
>         pneg_ctxt += ctxt_len;
>
>         build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt);
> -       ctxt_len = DIV_ROUND_UP(sizeof(struct smb2_encryption_neg_context), 8) * 8;
> +       ctxt_len = ALIGN(sizeof(struct smb2_encryption_neg_context), 8);
>         *total_len += ctxt_len;
>         pneg_ctxt += ctxt_len;
>
> @@ -595,9 +593,7 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
>         if (server->compress_algorithm) {
>                 build_compression_ctxt((struct smb2_compression_capabilities_context *)
>                                 pneg_ctxt);
> -               ctxt_len = DIV_ROUND_UP(
> -                       sizeof(struct smb2_compression_capabilities_context),
> -                               8) * 8;
> +               ctxt_len = ALIGN(sizeof(struct smb2_compression_capabilities_context), 8);
>                 *total_len += ctxt_len;
>                 pneg_ctxt += ctxt_len;
>                 neg_context_count++;
> @@ -780,7 +776,7 @@ static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
>                 if (rc)
>                         break;
>                 /* offsets must be 8 byte aligned */
> -               clen = (clen + 7) & ~0x7;
> +               clen = ALIGN(clen, 8);
>                 offset += clen + sizeof(struct smb2_neg_context);
>                 len_of_ctxts -= clen;
>         }
> @@ -2413,7 +2409,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
>         unsigned int group_offset = 0;
>         struct smb3_acl acl;
>
> -       *len = roundup(sizeof(struct crt_sd_ctxt) + (sizeof(struct cifs_ace) * 4), 8);
> +       *len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct cifs_ace) * 4), 8);
>
>         if (set_owner) {
>                 /* sizeof(struct owner_group_sids) is already multiple of 8 so no need to round */
> @@ -2487,7 +2483,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
>         memcpy(aclptr, &acl, sizeof(struct smb3_acl));
>
>         buf->ccontext.DataLength = cpu_to_le32(ptr - (__u8 *)&buf->sd);
> -       *len = roundup(ptr - (__u8 *)buf, 8);
> +       *len = round_up((unsigned int)(ptr - (__u8 *)buf), 8);
>
>         return buf;
>  }
> @@ -2581,7 +2577,7 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
>          * final path needs to be 8-byte aligned as specified in
>          * MS-SMB2 2.2.13 SMB2 CREATE Request.
>          */
> -       *out_size = roundup(*out_len * sizeof(__le16), 8);
> +       *out_size = round_up(*out_len * sizeof(__le16), 8);
>         *out_path = kzalloc(*out_size + sizeof(__le16) /* null */, GFP_KERNEL);
>         if (!*out_path)
>                 return -ENOMEM;
> @@ -2687,20 +2683,17 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
>                 uni_path_len = (2 * UniStrnlen((wchar_t *)utf16_path, PATH_MAX)) + 2;
>                 /* MUST set path len (NameLength) to 0 opening root of share */
>                 req->NameLength = cpu_to_le16(uni_path_len - 2);
> -               if (uni_path_len % 8 != 0) {
> -                       copy_size = roundup(uni_path_len, 8);
> -                       copy_path = kzalloc(copy_size, GFP_KERNEL);
> -                       if (!copy_path) {
> -                               rc = -ENOMEM;
> -                               goto err_free_req;
> -                       }
> -                       memcpy((char *)copy_path, (const char *)utf16_path,
> -                              uni_path_len);
> -                       uni_path_len = copy_size;
> -                       /* free before overwriting resource */
> -                       kfree(utf16_path);
> -                       utf16_path = copy_path;
> +               copy_size = round_up(uni_path_len, 8);
> +               copy_path = kzalloc(copy_size, GFP_KERNEL);
> +               if (!copy_path) {
> +                       rc = -ENOMEM;
> +                       goto err_free_req;
>                 }
> +               memcpy((char *)copy_path, (const char *)utf16_path, uni_path_len);
> +               uni_path_len = copy_size;
> +               /* free before overwriting resource */
> +               kfree(utf16_path);
> +               utf16_path = copy_path;
>         }
>
>         iov[1].iov_len = uni_path_len;
> @@ -2826,9 +2819,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
>                 uni_path_len = (2 * UniStrnlen((wchar_t *)path, PATH_MAX)) + 2;
>                 /* MUST set path len (NameLength) to 0 opening root of share */
>                 req->NameLength = cpu_to_le16(uni_path_len - 2);
> -               copy_size = uni_path_len;
> -               if (copy_size % 8 != 0)
> -                       copy_size = roundup(copy_size, 8);
> +               copy_size = round_up(uni_path_len, 8);
>                 copy_path = kzalloc(copy_size, GFP_KERNEL);
>                 if (!copy_path)
>                         return -ENOMEM;
> @@ -4090,7 +4081,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
>         if (request_type & CHAINED_REQUEST) {
>                 if (!(request_type & END_OF_CHAIN)) {
>                         /* next 8-byte aligned request */
> -                       *total_len = DIV_ROUND_UP(*total_len, 8) * 8;
> +                       *total_len = ALIGN(*total_len, 8);
>                         shdr->NextCommand = cpu_to_le32(*total_len);
>                 } else /* END_OF_CHAIN */
>                         shdr->NextCommand = 0;
> --
> 2.35.3
>
