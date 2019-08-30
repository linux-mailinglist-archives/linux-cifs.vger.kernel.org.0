Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E16A2C7A
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Aug 2019 03:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfH3BsN (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 29 Aug 2019 21:48:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43128 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfH3BsN (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 29 Aug 2019 21:48:13 -0400
Received: by mail-io1-f66.google.com with SMTP id u185so7089941iod.10
        for <linux-cifs@vger.kernel.org>; Thu, 29 Aug 2019 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNC7tVtw2Afc3G5U0m6OnflwtZWTKR9Vvk0SFIyHvEg=;
        b=HTfePWJW2ZYZp0H4QmSN9hakJ223FUkxL8HHyMNfOjY4xqvUyic4ERNP9JOzgVOCkw
         /Jt1Qz5417OrUbpR/4ic1AWKE0CMyaxiAhlgSUEl+ssnL7WiTsCOJmMAGgV8nC4aZTMy
         AOj+IEQBRIvJL6G8AAdaraMTQc2sUOvmDjw3azVS1JguRIT4IpH37Tj/Gy6CpwqKsqWs
         C8b1HVOcXcyGKgF9+euRSs5qJvn1d2bHlcX46bvlppOaKoCnLEt3fQyoNSRxcWggcnMv
         IOoqUvLcXbLTMIaX+H4IZos0/WJF/Tffzn+PACbx/fW+aTNrq5geqig1mJBRicXew7Z1
         Jyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNC7tVtw2Afc3G5U0m6OnflwtZWTKR9Vvk0SFIyHvEg=;
        b=LwJUk3OBFtrinAsEvJTZAqJy3DSDd9b5taRKIKAyYvR4c0q49hd/sDAd44lSAwuCIE
         jh3DJ0jkJ/UTQmf2nQmJV/yOk046Xf0ZmguY1pco4RAfyV5aXh5KLVu8i3GTfJIzlpZq
         dDzIrkEisKBLnFaVZ3UdmrdOLvm+dtH/R9COAJadHQieQoo3NbEsyoSbZwVfUP8TY62P
         7os8jNnbuQfpzsXl+uRWsJXWNq+yoakyu2xJJvWh1Hswdwi0BiQ8RfYPB8CmsRA6xWGW
         Ph369ZJQmI8SnV2HavwCyvv1ZJv8yhQcOgZ/E/eZ9WocHmOUxIILigcqu5xgSU36O/6x
         /wBA==
X-Gm-Message-State: APjAAAXsCpUp4ob4Ug+DezrCRfqfNRSg4sRzawV+jLzOZ+FMDaoyGfJy
        SPI72WgLBrAxLJ+UVgwVX3IxItJ7CtTS7zDYmJl9kh6N
X-Google-Smtp-Source: APXvYqzG5+BK5MzVpDnx2SKEHF2czfi/YAyS4xG2qFxpowj//xWVsDnhxS9z5/hKc/FqB+4uNeLrys7UWFNm8P9Zw9U=
X-Received: by 2002:a6b:c38f:: with SMTP id t137mr7049415iof.137.1567129690534;
 Thu, 29 Aug 2019 18:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190828071535.19436-1-lsahlber@redhat.com> <20190828071535.19436-2-lsahlber@redhat.com>
In-Reply-To: <20190828071535.19436-2-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 29 Aug 2019 20:47:58 -0500
Message-ID: <CAH2r5mtA9dSW+4zg+e26R3m+T162F+xOPk1vzc+6UROqGcwYLw@mail.gmail.com>
Subject: Re: [PATCH] cifs: add new debugging macro cifs_server_dbg
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

tentatively merged into cifs-2.6.git pending additional reviews but
looked useful in my review

On Wed, Aug 28, 2019 at 2:15 AM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> which can be used from contexts where we have a TCP_Server_Info *server.
> This new macro will prepend the debugging string with "Server:<servername> "
> which will help when debugging issues on hosts with many cifs connections
> to several different servers.
>
> Convert a bunch of cifs_dbg(VFS) calls to cifs_server_dbg(VFS)
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/cifs_debug.h    |  31 +++++++++++++
>  fs/cifs/connect.c       |  47 ++++++++++----------
>  fs/cifs/smb2pdu.c       | 113 ++++++++++++++++++++++++-----------------------
>  fs/cifs/smb2transport.c |  61 ++++++++++++-------------
>  fs/cifs/transport.c     | 115 +++++++++++++++++++++++++-----------------------
>  5 files changed, 204 insertions(+), 163 deletions(-)
>
> diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
> index 3d392620a2f4..567af916f103 100644
> --- a/fs/cifs/cifs_debug.h
> +++ b/fs/cifs/cifs_debug.h
> @@ -80,6 +80,30 @@ do {                                                 \
>                         type, fmt, ##__VA_ARGS__);      \
>  } while (0)
>
> +#define cifs_server_dbg_func(ratefunc, type, fmt, ...)         \
> +do {                                                           \
> +       if ((type) & FYI && cifsFYI & CIFS_INFO) {              \
> +               pr_debug_ ## ratefunc("%s: Server:%s "  fmt,    \
> +                       __FILE__, server->hostname, ##__VA_ARGS__);\
> +       } else if ((type) & VFS) {                              \
> +               pr_err_ ## ratefunc("CIFS VFS: Server:%s " fmt, \
> +                       server->hostname, ##__VA_ARGS__);       \
> +       } else if ((type) & NOISY && (NOISY != 0)) {            \
> +               pr_debug_ ## ratefunc("Server:%s " fmt,         \
> +                       server->hostname, ##__VA_ARGS__);       \
> +       }                                                       \
> +} while (0)
> +
> +#define cifs_server_dbg(type, fmt, ...)                        \
> +do {                                                   \
> +       if ((type) & ONCE)                              \
> +               cifs_server_dbg_func(once,              \
> +                       type, fmt, ##__VA_ARGS__);      \
> +       else                                            \
> +               cifs_server_dbg_func(ratelimited,       \
> +                       type, fmt, ##__VA_ARGS__);      \
> +} while (0)
> +
>  /*
>   *     debug OFF
>   *     ---------
> @@ -91,6 +115,13 @@ do {                                                                        \
>                 pr_debug(fmt, ##__VA_ARGS__);                           \
>  } while (0)
>
> +#define cifs_server_dbg(type, fmt, ...)                                        \
> +do {                                                                   \
> +       if (0)                                                          \
> +               pr_debug("Server:%s " fmt,                              \
> +                        server->hostname, ##__VA_ARGS__);              \
> +} while (0)
> +
>  #define cifs_info(fmt, ...)                                            \
>  do {                                                                   \
>         pr_info("CIFS: "fmt, ##__VA_ARGS__);                            \
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 5299effa6f7d..bce9c22d72b4 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -489,7 +489,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         } else {
>                 rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list, &tgt_it);
>                 if (rc && (rc != -EOPNOTSUPP)) {
> -                       cifs_dbg(VFS, "%s: no target servers for DFS failover\n",
> +                       cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
>                                  __func__);
>                 } else {
>                         server->nr_targets = dfs_cache_get_nr_tgts(&tgt_list);
> @@ -617,12 +617,12 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                 rc = dfs_cache_noreq_update_tgthint(cifs_sb->origin_fullpath + 1,
>                                                     tgt_it);
>                 if (rc) {
> -                       cifs_dbg(VFS, "%s: failed to update DFS target hint: rc = %d\n",
> +                       cifs_server_dbg(VFS, "%s: failed to update DFS target hint: rc = %d\n",
>                                  __func__, rc);
>                 }
>                 rc = dfs_cache_update_vol(cifs_sb->origin_fullpath, server);
>                 if (rc) {
> -                       cifs_dbg(VFS, "%s: failed to update vol info in DFS cache: rc = %d\n",
> +                       cifs_server_dbg(VFS, "%s: failed to update vol info in DFS cache: rc = %d\n",
>                                  __func__, rc);
>                 }
>                 dfs_cache_free_tgts(&tgt_list);
> @@ -678,7 +678,7 @@ allocate_buffers(struct TCP_Server_Info *server)
>         if (!server->bigbuf) {
>                 server->bigbuf = (char *)cifs_buf_get();
>                 if (!server->bigbuf) {
> -                       cifs_dbg(VFS, "No memory for large SMB response\n");
> +                       cifs_server_dbg(VFS, "No memory for large SMB response\n");
>                         msleep(3000);
>                         /* retry will check if exiting */
>                         return false;
> @@ -691,7 +691,7 @@ allocate_buffers(struct TCP_Server_Info *server)
>         if (!server->smallbuf) {
>                 server->smallbuf = (char *)cifs_small_buf_get();
>                 if (!server->smallbuf) {
> -                       cifs_dbg(VFS, "No memory for SMB response\n");
> +                       cifs_server_dbg(VFS, "No memory for SMB response\n");
>                         msleep(1000);
>                         /* retry will check if exiting */
>                         return false;
> @@ -722,8 +722,8 @@ server_unresponsive(struct TCP_Server_Info *server)
>         if ((server->tcpStatus == CifsGood ||
>             server->tcpStatus == CifsNeedNegotiate) &&
>             time_after(jiffies, server->lstrp + 3 * server->echo_interval)) {
> -               cifs_dbg(VFS, "Server %s has not responded in %lu seconds. Reconnecting...\n",
> -                        server->hostname, (3 * server->echo_interval) / HZ);
> +               cifs_server_dbg(VFS, "has not responded in %lu seconds. Reconnecting...\n",
> +                        (3 * server->echo_interval) / HZ);
>                 cifs_reconnect(server);
>                 wake_up(&server->response_q);
>                 return true;
> @@ -861,7 +861,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
>                 wake_up(&server->response_q);
>                 break;
>         default:
> -               cifs_dbg(VFS, "RFC 1002 unknown response type 0x%x\n", type);
> +               cifs_server_dbg(VFS, "RFC 1002 unknown response type 0x%x\n", type);
>                 cifs_reconnect(server);
>         }
>
> @@ -1008,7 +1008,7 @@ standard_receive3(struct TCP_Server_Info *server, struct mid_q_entry *mid)
>         /* make sure this will fit in a large buffer */
>         if (pdu_length > CIFSMaxBufSize + MAX_HEADER_SIZE(server) -
>                 server->vals->header_preamble_size) {
> -               cifs_dbg(VFS, "SMB response too long (%u bytes)\n", pdu_length);
> +               cifs_server_dbg(VFS, "SMB response too long (%u bytes)\n", pdu_length);
>                 cifs_reconnect(server);
>                 wake_up(&server->response_q);
>                 return -ECONNABORTED;
> @@ -1149,7 +1149,7 @@ cifs_demultiplex_thread(void *p)
>                 /* make sure we have enough to get to the MID */
>                 if (server->pdu_size < HEADER_SIZE(server) - 1 -
>                     server->vals->header_preamble_size) {
> -                       cifs_dbg(VFS, "SMB response too short (%u bytes)\n",
> +                       cifs_server_dbg(VFS, "SMB response too short (%u bytes)\n",
>                                  server->pdu_size);
>                         cifs_reconnect(server);
>                         wake_up(&server->response_q);
> @@ -1222,7 +1222,7 @@ cifs_demultiplex_thread(void *p)
>                                 smb2_add_credits_from_hdr(bufs[i], server);
>                                 cifs_dbg(FYI, "Received oplock break\n");
>                         } else {
> -                               cifs_dbg(VFS, "No task to wake, unknown frame "
> +                               cifs_server_dbg(VFS, "No task to wake, unknown frame "
>                                          "received! NumMids %d\n",
>                                          atomic_read(&midCount));
>                                 cifs_dump_mem("Received Data is: ", bufs[i],
> @@ -2840,16 +2840,17 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb_vol *volume_info)
>         struct nls_table *nls_codepage;
>         char unc[SERVER_NAME_LENGTH + sizeof("//x/IPC$")] = {0};
>         bool seal = false;
> +       struct TCP_Server_Info *server = ses->server;
>
>         /*
>          * If the mount request that resulted in the creation of the
>          * session requires encryption, force IPC to be encrypted too.
>          */
>         if (volume_info->seal) {
> -               if (ses->server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION)
> +               if (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION)
>                         seal = true;
>                 else {
> -                       cifs_dbg(VFS,
> +                       cifs_server_dbg(VFS,
>                                  "IPC: server doesn't support encryption\n");
>                         return -EOPNOTSUPP;
>                 }
> @@ -2859,7 +2860,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb_vol *volume_info)
>         if (tcon == NULL)
>                 return -ENOMEM;
>
> -       scnprintf(unc, sizeof(unc), "\\\\%s\\IPC$", ses->server->hostname);
> +       scnprintf(unc, sizeof(unc), "\\\\%s\\IPC$", server->hostname);
>
>         /* cannot fail */
>         nls_codepage = load_nls_default();
> @@ -2868,11 +2869,11 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb_vol *volume_info)
>         tcon->ses = ses;
>         tcon->ipc = true;
>         tcon->seal = seal;
> -       rc = ses->server->ops->tree_connect(xid, ses, unc, tcon, nls_codepage);
> +       rc = server->ops->tree_connect(xid, ses, unc, tcon, nls_codepage);
>         free_xid(xid);
>
>         if (rc) {
> -               cifs_dbg(VFS, "failed to connect to IPC (rc=%d)\n", rc);
> +               cifs_server_dbg(VFS, "failed to connect to IPC (rc=%d)\n", rc);
>                 tconInfoFree(tcon);
>                 goto out;
>         }
> @@ -2958,7 +2959,7 @@ void cifs_put_smb_ses(struct cifs_ses *ses)
>                 xid = get_xid();
>                 rc = server->ops->logoff(xid, ses);
>                 if (rc)
> -                       cifs_dbg(VFS, "%s: Session Logoff failure rc=%d\n",
> +                       cifs_server_dbg(VFS, "%s: Session Logoff failure rc=%d\n",
>                                 __func__, rc);
>                 _free_xid(xid);
>         }
> @@ -3659,10 +3660,10 @@ bind_socket(struct TCP_Server_Info *server)
>                         saddr4 = (struct sockaddr_in *)&server->srcaddr;
>                         saddr6 = (struct sockaddr_in6 *)&server->srcaddr;
>                         if (saddr6->sin6_family == AF_INET6)
> -                               cifs_dbg(VFS, "Failed to bind to: %pI6c, error: %d\n",
> +                               cifs_server_dbg(VFS, "Failed to bind to: %pI6c, error: %d\n",
>                                          &saddr6->sin6_addr, rc);
>                         else
> -                               cifs_dbg(VFS, "Failed to bind to: %pI4, error: %d\n",
> +                               cifs_server_dbg(VFS, "Failed to bind to: %pI4, error: %d\n",
>                                          &saddr4->sin_addr.s_addr, rc);
>                 }
>         }
> @@ -3766,7 +3767,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
>                 rc = __sock_create(cifs_net_ns(server), sfamily, SOCK_STREAM,
>                                    IPPROTO_TCP, &socket, 1);
>                 if (rc < 0) {
> -                       cifs_dbg(VFS, "Error %d creating socket\n", rc);
> +                       cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>                         server->ssocket = NULL;
>                         return rc;
>                 }
> @@ -4150,7 +4151,7 @@ static int mount_get_conns(struct smb_vol *vol, struct cifs_sb_info *cifs_sb,
>
>         if ((vol->persistent == true) && (!(ses->server->capabilities &
>                                             SMB2_GLOBAL_CAP_PERSISTENT_HANDLES))) {
> -               cifs_dbg(VFS, "persistent handles not supported by server\n");
> +               cifs_server_dbg(VFS, "persistent handles not supported by server\n");
>                 return -EOPNOTSUPP;
>         }
>
> @@ -4588,7 +4589,7 @@ static int is_path_remote(struct cifs_sb_info *cifs_sb, struct smb_vol *vol,
>                 rc = cifs_are_all_path_components_accessible(server, xid, tcon,
>                         cifs_sb, full_path, tcon->Flags & SMB_SHARE_IS_IN_DFS);
>                 if (rc != 0) {
> -                       cifs_dbg(VFS, "cannot query dirs between root and final path, "
> +                       cifs_server_dbg(VFS, "cannot query dirs between root and final path, "
>                                  "enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
>                         cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
>                         rc = 0;
> @@ -5090,7 +5091,7 @@ cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
>                 rc = server->ops->sess_setup(xid, ses, nls_info);
>
>         if (rc)
> -               cifs_dbg(VFS, "Send error in SessSetup = %d\n", rc);
> +               cifs_server_dbg(VFS, "Send error in SessSetup = %d\n", rc);
>
>         return rc;
>  }
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 31e4a1b0b170..8145ca95d48e 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -543,7 +543,7 @@ assemble_neg_contexts(struct smb2_negotiate_req *req,
>
>         if (*total_len > 200) {
>                 /* In case length corrupted don't want to overrun smb buffer */
> -               cifs_dbg(VFS, "Bad frame length assembling neg contexts\n");
> +               cifs_server_dbg(VFS, "Bad frame length assembling neg contexts\n");
>                 return;
>         }
>
> @@ -661,7 +661,7 @@ static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
>
>         cifs_dbg(FYI, "decoding %d negotiate contexts\n", ctxt_cnt);
>         if (len_of_smb <= offset) {
> -               cifs_dbg(VFS, "Invalid response: negotiate context offset\n");
> +               cifs_server_dbg(VFS, "Invalid response: negotiate context offset\n");
>                 return -EINVAL;
>         }
>
> @@ -693,7 +693,7 @@ static int smb311_decode_neg_context(struct smb2_negotiate_rsp *rsp,
>                 else if (pctx->ContextType == SMB2_POSIX_EXTENSIONS_AVAILABLE)
>                         server->posix_ext_supported = true;
>                 else
> -                       cifs_dbg(VFS, "unknown negcontext of type %d ignored\n",
> +                       cifs_server_dbg(VFS, "unknown negcontext of type %d ignored\n",
>                                 le16_to_cpu(pctx->ContextType));
>
>                 if (rc)
> @@ -818,7 +818,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>                 req->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
>                 req->DialectCount = cpu_to_le16(2);
>                 total_len += 4;
> -       } else if (strcmp(ses->server->vals->version_string,
> +       } else if (strcmp(server->vals->version_string,
>                    SMBDEFAULT_VERSION_STRING) == 0) {
>                 req->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
>                 req->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> @@ -841,16 +841,16 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>         else
>                 req->SecurityMode = 0;
>
> -       req->Capabilities = cpu_to_le32(ses->server->vals->req_capabilities);
> +       req->Capabilities = cpu_to_le32(server->vals->req_capabilities);
>
>         /* ClientGUID must be zero for SMB2.02 dialect */
> -       if (ses->server->vals->protocol_id == SMB20_PROT_ID)
> +       if (server->vals->protocol_id == SMB20_PROT_ID)
>                 memset(req->ClientGUID, 0, SMB2_CLIENT_GUID_SIZE);
>         else {
>                 memcpy(req->ClientGUID, server->client_guid,
>                         SMB2_CLIENT_GUID_SIZE);
> -               if ((ses->server->vals->protocol_id == SMB311_PROT_ID) ||
> -                   (strcmp(ses->server->vals->version_string,
> +               if ((server->vals->protocol_id == SMB311_PROT_ID) ||
> +                   (strcmp(server->vals->version_string,
>                      SMBDEFAULT_VERSION_STRING) == 0))
>                         assemble_neg_contexts(req, server, &total_len);
>         }
> @@ -869,42 +869,42 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>          * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...]);
>          */
>         if (rc == -EOPNOTSUPP) {
> -               cifs_dbg(VFS, "Dialect not supported by server. Consider "
> +               cifs_server_dbg(VFS, "Dialect not supported by server. Consider "
>                         "specifying vers=1.0 or vers=2.0 on mount for accessing"
>                         " older servers\n");
>                 goto neg_exit;
>         } else if (rc != 0)
>                 goto neg_exit;
>
> -       if (strcmp(ses->server->vals->version_string,
> +       if (strcmp(server->vals->version_string,
>                    SMB3ANY_VERSION_STRING) == 0) {
>                 if (rsp->DialectRevision == cpu_to_le16(SMB20_PROT_ID)) {
> -                       cifs_dbg(VFS,
> +                       cifs_server_dbg(VFS,
>                                 "SMB2 dialect returned but not requested\n");
>                         return -EIO;
>                 } else if (rsp->DialectRevision == cpu_to_le16(SMB21_PROT_ID)) {
> -                       cifs_dbg(VFS,
> +                       cifs_server_dbg(VFS,
>                                 "SMB2.1 dialect returned but not requested\n");
>                         return -EIO;
>                 }
> -       } else if (strcmp(ses->server->vals->version_string,
> +       } else if (strcmp(server->vals->version_string,
>                    SMBDEFAULT_VERSION_STRING) == 0) {
>                 if (rsp->DialectRevision == cpu_to_le16(SMB20_PROT_ID)) {
> -                       cifs_dbg(VFS,
> +                       cifs_server_dbg(VFS,
>                                 "SMB2 dialect returned but not requested\n");
>                         return -EIO;
>                 } else if (rsp->DialectRevision == cpu_to_le16(SMB21_PROT_ID)) {
>                         /* ops set to 3.0 by default for default so update */
> -                       ses->server->ops = &smb21_operations;
> -                       ses->server->vals = &smb21_values;
> +                       server->ops = &smb21_operations;
> +                       server->vals = &smb21_values;
>                 } else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID)) {
> -                       ses->server->ops = &smb311_operations;
> -                       ses->server->vals = &smb311_values;
> +                       server->ops = &smb311_operations;
> +                       server->vals = &smb311_values;
>                 }
>         } else if (le16_to_cpu(rsp->DialectRevision) !=
> -                               ses->server->vals->protocol_id) {
> +                               server->vals->protocol_id) {
>                 /* if requested single dialect ensure returned dialect matched */
> -               cifs_dbg(VFS, "Illegal 0x%x dialect returned: not requested\n",
> +               cifs_server_dbg(VFS, "Illegal 0x%x dialect returned: not requested\n",
>                         le16_to_cpu(rsp->DialectRevision));
>                 return -EIO;
>         }
> @@ -922,7 +922,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>         else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID))
>                 cifs_dbg(FYI, "negotiated smb3.1.1 dialect\n");
>         else {
> -               cifs_dbg(VFS, "Illegal dialect returned by server 0x%x\n",
> +               cifs_server_dbg(VFS, "Illegal dialect returned by server 0x%x\n",
>                          le16_to_cpu(rsp->DialectRevision));
>                 rc = -EIO;
>                 goto neg_exit;
> @@ -982,7 +982,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>                         rc = smb311_decode_neg_context(rsp, server,
>                                                        rsp_iov.iov_len);
>                 else
> -                       cifs_dbg(VFS, "Missing expected negotiate contexts\n");
> +                       cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
>         }
>  neg_exit:
>         free_rsp_buf(resp_buftype, rsp);
> @@ -996,11 +996,12 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>         struct validate_negotiate_info_rsp *pneg_rsp = NULL;
>         u32 rsplen;
>         u32 inbuflen; /* max of 4 dialects */
> +       struct TCP_Server_Info *server = tcon->ses->server;
>
>         cifs_dbg(FYI, "validate negotiate\n");
>
>         /* In SMB3.11 preauth integrity supersedes validate negotiate */
> -       if (tcon->ses->server->dialect == SMB311_PROT_ID)
> +       if (server->dialect == SMB311_PROT_ID)
>                 return 0;
>
>         /*
> @@ -1019,15 +1020,15 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>         }
>
>         if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
> -               cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
> +               cifs_server_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
>
>         pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
>         if (!pneg_inbuf)
>                 return -ENOMEM;
>
>         pneg_inbuf->Capabilities =
> -                       cpu_to_le32(tcon->ses->server->vals->req_capabilities);
> -       memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
> +                       cpu_to_le32(server->vals->req_capabilities);
> +       memcpy(pneg_inbuf->Guid, server->client_guid,
>                                         SMB2_CLIENT_GUID_SIZE);
>
>         if (tcon->ses->sign)
> @@ -1040,7 +1041,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>                 pneg_inbuf->SecurityMode = 0;
>
>
> -       if (strcmp(tcon->ses->server->vals->version_string,
> +       if (strcmp(server->vals->version_string,
>                 SMB3ANY_VERSION_STRING) == 0) {
>                 pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
>                 pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
> @@ -1048,7 +1049,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>                 /* structure is big enough for 3 dialects, sending only 2 */
>                 inbuflen = sizeof(*pneg_inbuf) -
>                                 (2 * sizeof(pneg_inbuf->Dialects[0]));
> -       } else if (strcmp(tcon->ses->server->vals->version_string,
> +       } else if (strcmp(server->vals->version_string,
>                 SMBDEFAULT_VERSION_STRING) == 0) {
>                 pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
>                 pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> @@ -1060,7 +1061,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>         } else {
>                 /* otherwise specific dialect was requested */
>                 pneg_inbuf->Dialects[0] =
> -                       cpu_to_le16(tcon->ses->server->vals->protocol_id);
> +                       cpu_to_le16(server->vals->protocol_id);
>                 pneg_inbuf->DialectCount = cpu_to_le16(1);
>                 /* structure is big enough for 3 dialects, sending only 1 */
>                 inbuflen = sizeof(*pneg_inbuf) -
> @@ -1076,18 +1077,18 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>                  * Old Windows versions or Netapp SMB server can return
>                  * not supported error. Client should accept it.
>                  */
> -               cifs_dbg(VFS, "Server does not support validate negotiate\n");
> +               cifs_server_dbg(VFS, "Server does not support validate negotiate\n");
>                 rc = 0;
>                 goto out_free_inbuf;
>         } else if (rc != 0) {
> -               cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> +               cifs_server_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
>                 rc = -EIO;
>                 goto out_free_inbuf;
>         }
>
>         rc = -EIO;
>         if (rsplen != sizeof(*pneg_rsp)) {
> -               cifs_dbg(VFS, "invalid protocol negotiate response size: %d\n",
> +               cifs_server_dbg(VFS, "invalid protocol negotiate response size: %d\n",
>                          rsplen);
>
>                 /* relax check since Mac returns max bufsize allowed on ioctl */
> @@ -1096,16 +1097,16 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>         }
>
>         /* check validate negotiate info response matches what we got earlier */
> -       if (pneg_rsp->Dialect != cpu_to_le16(tcon->ses->server->dialect))
> +       if (pneg_rsp->Dialect != cpu_to_le16(server->dialect))
>                 goto vneg_out;
>
> -       if (pneg_rsp->SecurityMode != cpu_to_le16(tcon->ses->server->sec_mode))
> +       if (pneg_rsp->SecurityMode != cpu_to_le16(server->sec_mode))
>                 goto vneg_out;
>
>         /* do not validate server guid because not saved at negprot time yet */
>
>         if ((le32_to_cpu(pneg_rsp->Capabilities) | SMB2_NT_FIND |
> -             SMB2_LARGE_FILES) != tcon->ses->server->capabilities)
> +             SMB2_LARGE_FILES) != server->capabilities)
>                 goto vneg_out;
>
>         /* validate negotiate successful */
> @@ -1114,7 +1115,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>         goto out_free_rsp;
>
>  vneg_out:
> -       cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
> +       cifs_server_dbg(VFS, "protocol revalidation - security settings mismatch\n");
>  out_free_rsp:
>         kfree(pneg_rsp);
>  out_free_inbuf:
> @@ -1568,7 +1569,7 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
>                 sess_data->func(sess_data);
>
>         if ((ses->session_flags & SMB2_SESSION_FLAG_IS_GUEST) && (ses->sign))
> -               cifs_dbg(VFS, "signing requested but authenticated as guest\n");
> +               cifs_server_dbg(VFS, "signing requested but authenticated as guest\n");
>         rc = sess_data->result;
>  out:
>         kfree(sess_data);
> @@ -1661,10 +1662,11 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
>         __le16 *unc_path = NULL;
>         int flags = 0;
>         unsigned int total_len;
> +       struct TCP_Server_Info *server = ses->server;
>
>         cifs_dbg(FYI, "TCON\n");
>
> -       if (!(ses->server) || !tree)
> +       if (!server || !tree)
>                 return -EIO;
>
>         unc_path = kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
> @@ -1707,7 +1709,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
>          * unless it is guest or anonymous user. See MS-SMB2 3.2.5.3.1
>          * (Samba servers don't always set the flag so also check if null user)
>          */
> -       if ((ses->server->dialect == SMB311_PROT_ID) &&
> +       if ((server->dialect == SMB311_PROT_ID) &&
>             !smb3_encryption_required(tcon) &&
>             !(ses->session_flags &
>                     (SMB2_SESSION_FLAG_IS_GUEST|SMB2_SESSION_FLAG_IS_NULL)) &&
> @@ -1746,7 +1748,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
>                 cifs_dbg(FYI, "connection to printer\n");
>                 break;
>         default:
> -               cifs_dbg(VFS, "unknown share type %d\n", rsp->ShareType);
> +               cifs_server_dbg(VFS, "unknown share type %d\n", rsp->ShareType);
>                 rc = -EOPNOTSUPP;
>                 goto tcon_error_exit;
>         }
> @@ -1761,15 +1763,15 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
>
>         if ((rsp->Capabilities & SMB2_SHARE_CAP_DFS) &&
>             ((tcon->share_flags & SHI1005_FLAGS_DFS) == 0))
> -               cifs_dbg(VFS, "DFS capability contradicts DFS flag\n");
> +               cifs_server_dbg(VFS, "DFS capability contradicts DFS flag\n");
>
>         if (tcon->seal &&
> -           !(tcon->ses->server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
> -               cifs_dbg(VFS, "Encryption is requested but not supported\n");
> +           !(server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
> +               cifs_server_dbg(VFS, "Encryption is requested but not supported\n");
>
>         init_copy_chunk_defaults(tcon);
> -       if (tcon->ses->server->ops->validate_negotiate)
> -               rc = tcon->ses->server->ops->validate_negotiate(xid, tcon);
> +       if (server->ops->validate_negotiate)
> +               rc = server->ops->validate_negotiate(xid, tcon);
>  tcon_exit:
>
>         free_rsp_buf(resp_buftype, rsp);
> @@ -1778,7 +1780,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
>
>  tcon_error_exit:
>         if (rsp && rsp->sync_hdr.Status == STATUS_BAD_NETWORK_NAME) {
> -               cifs_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
> +               cifs_server_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
>         }
>         goto tcon_exit;
>  }
> @@ -2742,6 +2744,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
>         int resp_buftype = CIFS_NO_BUFFER;
>         int rc = 0;
>         int flags = 0;
> +       struct TCP_Server_Info *server;
>
>         cifs_dbg(FYI, "SMB2 IOCTL\n");
>
> @@ -2757,7 +2760,8 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
>         else
>                 return -EIO;
>
> -       if (!ses || !(ses->server))
> +       server = ses->server;
> +       if (!ses || !(server))
>                 return -EIO;
>
>         if (smb3_encryption_required(tcon))
> @@ -2807,14 +2811,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
>         if (*plen == 0)
>                 goto ioctl_exit; /* server returned no data */
>         else if (*plen > rsp_iov.iov_len || *plen > 0xFF00) {
> -               cifs_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
> +               cifs_server_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
>                 *plen = 0;
>                 rc = -EIO;
>                 goto ioctl_exit;
>         }
>
>         if (rsp_iov.iov_len - *plen < le32_to_cpu(rsp->OutputOffset)) {
> -               cifs_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
> +               cifs_server_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
>                         le32_to_cpu(rsp->OutputOffset));
>                 *plen = 0;
>                 rc = -EIO;
> @@ -3055,12 +3059,13 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
>         int rc = 0;
>         int resp_buftype = CIFS_NO_BUFFER;
>         struct cifs_ses *ses = tcon->ses;
> +       struct TCP_Server_Info *server = ses->server;
>         int flags = 0;
>         bool allocated = false;
>
>         cifs_dbg(FYI, "Query Info\n");
>
> -       if (!ses || !(ses->server))
> +       if (!ses || !(server))
>                 return -EIO;
>
>         if (smb3_encryption_required(tcon))
> @@ -3098,7 +3103,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
>                 if (!*data) {
>                         *data = kmalloc(*dlen, GFP_KERNEL);
>                         if (!*data) {
> -                               cifs_dbg(VFS,
> +                               cifs_server_dbg(VFS,
>                                         "Error %d allocating memory for acl\n",
>                                         rc);
>                                 *dlen = 0;
> @@ -3468,7 +3473,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>
>                         rc = smb2_verify_signature(&rqst, server);
>                         if (rc)
> -                               cifs_dbg(VFS, "SMB signature verification returned error = %d\n",
> +                               cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
>                                          rc);
>                 }
>                 /* FIXME: should this be counted toward the initiating task? */
> @@ -4058,7 +4063,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
>                 info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
>                 break;
>         default:
> -               cifs_dbg(VFS, "info level %u isn't supported\n",
> +               cifs_server_dbg(VFS, "info level %u isn't supported\n",
>                          srch_inf->info_level);
>                 rc = -EINVAL;
>                 goto qdir_exit;
> @@ -4149,7 +4154,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
>         else if (resp_buftype == CIFS_SMALL_BUFFER)
>                 srch_inf->smallBuf = true;
>         else
> -               cifs_dbg(VFS, "illegal search buffer type\n");
> +               cifs_server_dbg(VFS, "illegal search buffer type\n");
>
>         trace_smb3_query_dir_done(xid, persistent_fid, tcon->tid,
>                         tcon->ses->Suid, index, srch_inf->entries_in_buffer);
> diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
> index 1ccbcf9c2c3b..b02242eacb55 100644
> --- a/fs/cifs/smb2transport.c
> +++ b/fs/cifs/smb2transport.c
> @@ -176,7 +176,7 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>
>         ses = smb2_find_smb_ses(server, shdr->SessionId);
>         if (!ses) {
> -               cifs_dbg(VFS, "%s: Could not find session\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not find session\n", __func__);
>                 return 0;
>         }
>
> @@ -185,21 +185,21 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>
>         rc = smb2_crypto_shash_allocate(server);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: sha256 alloc failed\n", __func__);
> +               cifs_server_dbg(VFS, "%s: sha256 alloc failed\n", __func__);
>                 return rc;
>         }
>
>         rc = crypto_shash_setkey(server->secmech.hmacsha256,
>                                  ses->auth_key.response, SMB2_NTLMV2_SESSKEY_SIZE);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with response\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with response\n", __func__);
>                 return rc;
>         }
>
>         shash = &server->secmech.sdeschmacsha256->shash;
>         rc = crypto_shash_init(shash);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not init sha256", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not init sha256", __func__);
>                 return rc;
>         }
>
> @@ -215,7 +215,7 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>                 rc = crypto_shash_update(shash, iov[0].iov_base,
>                                          iov[0].iov_len);
>                 if (rc) {
> -                       cifs_dbg(VFS, "%s: Could not update with payload\n",
> +                       cifs_server_dbg(VFS, "%s: Could not update with payload\n",
>                                  __func__);
>                         return rc;
>                 }
> @@ -239,68 +239,69 @@ static int generate_key(struct cifs_ses *ses, struct kvec label,
>         int rc = 0;
>         unsigned char prfhash[SMB2_HMACSHA256_SIZE];
>         unsigned char *hashptr = prfhash;
> +       struct TCP_Server_Info *server = ses->server;
>
>         memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
>         memset(key, 0x0, key_size);
>
> -       rc = smb3_crypto_shash_allocate(ses->server);
> +       rc = smb3_crypto_shash_allocate(server);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: crypto alloc failed\n", __func__);
> +               cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_setkey(ses->server->secmech.hmacsha256,
> +       rc = crypto_shash_setkey(server->secmech.hmacsha256,
>                 ses->auth_key.response, SMB2_NTLMV2_SESSKEY_SIZE);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not set with session key\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not set with session key\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_init(&ses->server->secmech.sdeschmacsha256->shash);
> +       rc = crypto_shash_init(&server->secmech.sdeschmacsha256->shash);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not init sign hmac\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not init sign hmac\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_update(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_update(&server->secmech.sdeschmacsha256->shash,
>                                 i, 4);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with n\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with n\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_update(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_update(&server->secmech.sdeschmacsha256->shash,
>                                 label.iov_base, label.iov_len);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with label\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with label\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_update(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_update(&server->secmech.sdeschmacsha256->shash,
>                                 &zero, 1);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with zero\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with zero\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_update(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_update(&server->secmech.sdeschmacsha256->shash,
>                                 context.iov_base, context.iov_len);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with context\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with context\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_update(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_update(&server->secmech.sdeschmacsha256->shash,
>                                 L, 4);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not update with L\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not update with L\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc = crypto_shash_final(&ses->server->secmech.sdeschmacsha256->shash,
> +       rc = crypto_shash_final(&server->secmech.sdeschmacsha256->shash,
>                                 hashptr);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not generate sha256 hash\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not generate sha256 hash\n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> @@ -436,7 +437,7 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>
>         ses = smb2_find_smb_ses(server, shdr->SessionId);
>         if (!ses) {
> -               cifs_dbg(VFS, "%s: Could not find session\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not find session\n", __func__);
>                 return 0;
>         }
>
> @@ -446,7 +447,7 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>         rc = crypto_shash_setkey(server->secmech.cmacaes,
>                                  ses->smb3signingkey, SMB2_CMACAES_SIZE);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not set key for cmac aes\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not set key for cmac aes\n", __func__);
>                 return rc;
>         }
>
> @@ -457,7 +458,7 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>          */
>         rc = crypto_shash_init(shash);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: Could not init cmac aes\n", __func__);
> +               cifs_server_dbg(VFS, "%s: Could not init cmac aes\n", __func__);
>                 return rc;
>         }
>
> @@ -473,7 +474,7 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>                 rc = crypto_shash_update(shash, iov[0].iov_base,
>                                          iov[0].iov_len);
>                 if (rc) {
> -                       cifs_dbg(VFS, "%s: Could not update with payload\n",
> +                       cifs_server_dbg(VFS, "%s: Could not update with payload\n",
>                                  __func__);
>                         return rc;
>                 }
> @@ -665,7 +666,7 @@ smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
>
>                 rc = smb2_verify_signature(&rqst, server);
>                 if (rc)
> -                       cifs_dbg(VFS, "SMB signature verification returned error = %d\n",
> +                       cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
>                                  rc);
>         }
>
> @@ -739,7 +740,7 @@ smb3_crypto_aead_allocate(struct TCP_Server_Info *server)
>                 else
>                         tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
>                 if (IS_ERR(tfm)) {
> -                       cifs_dbg(VFS, "%s: Failed to alloc encrypt aead\n",
> +                       cifs_server_dbg(VFS, "%s: Failed to alloc encrypt aead\n",
>                                  __func__);
>                         return PTR_ERR(tfm);
>                 }
> @@ -754,7 +755,7 @@ smb3_crypto_aead_allocate(struct TCP_Server_Info *server)
>                 if (IS_ERR(tfm)) {
>                         crypto_free_aead(server->secmech.ccmaesencrypt);
>                         server->secmech.ccmaesencrypt = NULL;
> -                       cifs_dbg(VFS, "%s: Failed to alloc decrypt aead\n",
> +                       cifs_server_dbg(VFS, "%s: Failed to alloc decrypt aead\n",
>                                  __func__);
>                         return PTR_ERR(tfm);
>                 }
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 5d6d44bfe10a..0d60bd2f4dca 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -118,7 +118,7 @@ DeleteMidQEntry(struct mid_q_entry *midEntry)
>  #ifdef CONFIG_CIFS_STATS2
>         now = jiffies;
>         if (now < midEntry->when_alloc)
> -               cifs_dbg(VFS, "invalid mid allocation time\n");
> +               cifs_server_dbg(VFS, "invalid mid allocation time\n");
>         roundtrip_time = now - midEntry->when_alloc;
>
>         if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
> @@ -232,7 +232,7 @@ smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
>                         retries++;
>                         if (retries >= 14 ||
>                             (!server->noblocksnd && (retries > 2))) {
> -                               cifs_dbg(VFS, "sends on sock %p stuck for 15 seconds\n",
> +                               cifs_server_dbg(VFS, "sends on sock %p stuck for 15 seconds\n",
>                                          ssocket);
>                                 return -EAGAIN;
>                         }
> @@ -246,7 +246,7 @@ smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
>                 if (rc == 0) {
>                         /* should never happen, letting socket clear before
>                            retrying is our only obvious option here */
> -                       cifs_dbg(VFS, "tcp sent no data\n");
> +                       cifs_server_dbg(VFS, "tcp sent no data\n");
>                         msleep(500);
>                         continue;
>                 }
> @@ -440,7 +440,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
>         }
>  smbd_done:
>         if (rc < 0 && rc != -EINTR)
> -               cifs_dbg(VFS, "Error %d sending data on socket to server\n",
> +               cifs_server_dbg(VFS, "Error %d sending data on socket to server\n",
>                          rc);
>         else if (rc > 0)
>                 rc = 0;
> @@ -473,8 +473,8 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
>         cur_rqst[0].rq_nvec = 1;
>
>         if (!server->ops->init_transform_rq) {
> -               cifs_dbg(VFS, "Encryption requested but transform callback "
> -                        "is missing\n");
> +               cifs_server_dbg(VFS, "Encryption requested but transform "
> +                               "callback is missing\n");
>                 return -EIO;
>         }
>
> @@ -548,7 +548,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
>                         if (!rc) {
>                                 trace_smb3_credit_timeout(server->CurrentMid,
>                                         server->hostname, num_credits);
> -                               cifs_dbg(VFS, "wait timed out after %d ms\n",
> +                               cifs_server_dbg(VFS, "wait timed out after %d ms\n",
>                                          timeout);
>                                 return -ENOTSUPP;
>                         }
> @@ -589,7 +589,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
>                                         trace_smb3_credit_timeout(
>                                                 server->CurrentMid,
>                                                 server->hostname, num_credits);
> -                                       cifs_dbg(VFS, "wait timed out after %d ms\n",
> +                                       cifs_server_dbg(VFS, "wait timed out after %d ms\n",
>                                                  timeout);
>                                         return -ENOTSUPP;
>                                 }
> @@ -869,7 +869,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
>                 break;
>         default:
>                 list_del_init(&mid->qhead);
> -               cifs_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
> +               cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
>                          __func__, mid->mid, mid->mid_state);
>                 rc = -EIO;
>         }
> @@ -910,7 +910,7 @@ cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
>                 rc = cifs_verify_signature(&rqst, server,
>                                            mid->sequence_number);
>                 if (rc)
> -                       cifs_dbg(VFS, "SMB signature verification returned error = %d\n",
> +                       cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
>                                  rc);
>         }
>
> @@ -1107,7 +1107,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>         }
>         if (rc != 0) {
>                 for (; i < num_rqst; i++) {
> -                       cifs_dbg(VFS, "Cancelling wait for mid %llu cmd: %d\n",
> +                       cifs_server_dbg(VFS, "Cancelling wait for mid %llu cmd: %d\n",
>                                  midQ[i]->mid, le16_to_cpu(midQ[i]->command));
>                         send_cancel(server, &rqst[i], midQ[i]);
>                         spin_lock(&GlobalMid_Lock);
> @@ -1242,17 +1242,18 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
>         struct kvec iov = { .iov_base = in_buf, .iov_len = len };
>         struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
>         struct cifs_credits credits = { .value = 1, .instance = 0 };
> +       struct TCP_Server_Info *server = ses->server;
>
>         if (ses == NULL) {
>                 cifs_dbg(VFS, "Null smb session\n");
>                 return -EIO;
>         }
> -       if (ses->server == NULL) {
> +       if (server == NULL) {
>                 cifs_dbg(VFS, "Null tcp session\n");
>                 return -EIO;
>         }
>
> -       if (ses->server->tcpStatus == CifsExiting)
> +       if (server->tcpStatus == CifsExiting)
>                 return -ENOENT;
>
>         /* Ensure that we do not send more than 50 overlapping requests
> @@ -1260,12 +1261,12 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
>            use ses->maxReq */
>
>         if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
> -               cifs_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
> +               cifs_server_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
>                          len);
>                 return -EIO;
>         }
>
> -       rc = wait_for_free_request(ses->server, flags, &credits.instance);
> +       rc = wait_for_free_request(server, flags, &credits.instance);
>         if (rc)
>                 return rc;
>
> @@ -1273,70 +1274,70 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
>            and avoid races inside tcp sendmsg code that could cause corruption
>            of smb data */
>
> -       mutex_lock(&ses->server->srv_mutex);
> +       mutex_lock(&server->srv_mutex);
>
>         rc = allocate_mid(ses, in_buf, &midQ);
>         if (rc) {
>                 mutex_unlock(&ses->server->srv_mutex);
>                 /* Update # of requests on wire to server */
> -               add_credits(ses->server, &credits, 0);
> +               add_credits(server, &credits, 0);
>                 return rc;
>         }
>
> -       rc = cifs_sign_smb(in_buf, ses->server, &midQ->sequence_number);
> +       rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
>         if (rc) {
> -               mutex_unlock(&ses->server->srv_mutex);
> +               mutex_unlock(&server->srv_mutex);
>                 goto out;
>         }
>
>         midQ->mid_state = MID_REQUEST_SUBMITTED;
>
> -       cifs_in_send_inc(ses->server);
> -       rc = smb_send(ses->server, in_buf, len);
> -       cifs_in_send_dec(ses->server);
> +       cifs_in_send_inc(server);
> +       rc = smb_send(server, in_buf, len);
> +       cifs_in_send_dec(server);
>         cifs_save_when_sent(midQ);
>
>         if (rc < 0)
> -               ses->server->sequence_number -= 2;
> +               server->sequence_number -= 2;
>
> -       mutex_unlock(&ses->server->srv_mutex);
> +       mutex_unlock(&server->srv_mutex);
>
>         if (rc < 0)
>                 goto out;
>
> -       rc = wait_for_response(ses->server, midQ);
> +       rc = wait_for_response(server, midQ);
>         if (rc != 0) {
> -               send_cancel(ses->server, &rqst, midQ);
> +               send_cancel(server, &rqst, midQ);
>                 spin_lock(&GlobalMid_Lock);
>                 if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>                         /* no longer considered to be "in-flight" */
>                         midQ->callback = DeleteMidQEntry;
>                         spin_unlock(&GlobalMid_Lock);
> -                       add_credits(ses->server, &credits, 0);
> +                       add_credits(server, &credits, 0);
>                         return rc;
>                 }
>                 spin_unlock(&GlobalMid_Lock);
>         }
>
> -       rc = cifs_sync_mid_result(midQ, ses->server);
> +       rc = cifs_sync_mid_result(midQ, server);
>         if (rc != 0) {
> -               add_credits(ses->server, &credits, 0);
> +               add_credits(server, &credits, 0);
>                 return rc;
>         }
>
>         if (!midQ->resp_buf || !out_buf ||
>             midQ->mid_state != MID_RESPONSE_RECEIVED) {
>                 rc = -EIO;
> -               cifs_dbg(VFS, "Bad MID state?\n");
> +               cifs_server_dbg(VFS, "Bad MID state?\n");
>                 goto out;
>         }
>
>         *pbytes_returned = get_rfc1002_length(midQ->resp_buf);
>         memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
> -       rc = cifs_check_receive(midQ, ses->server, 0);
> +       rc = cifs_check_receive(midQ, server, 0);
>  out:
>         cifs_delete_mid(midQ);
> -       add_credits(ses->server, &credits, 0);
> +       add_credits(server, &credits, 0);
>
>         return rc;
>  }
> @@ -1379,19 +1380,21 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>         struct kvec iov = { .iov_base = in_buf, .iov_len = len };
>         struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
>         unsigned int instance;
> +       struct TCP_Server_Info *server;
>
>         if (tcon == NULL || tcon->ses == NULL) {
>                 cifs_dbg(VFS, "Null smb session\n");
>                 return -EIO;
>         }
>         ses = tcon->ses;
> +       server = ses->server;
>
> -       if (ses->server == NULL) {
> +       if (server == NULL) {
>                 cifs_dbg(VFS, "Null tcp session\n");
>                 return -EIO;
>         }
>
> -       if (ses->server->tcpStatus == CifsExiting)
> +       if (server->tcpStatus == CifsExiting)
>                 return -ENOENT;
>
>         /* Ensure that we do not send more than 50 overlapping requests
> @@ -1399,12 +1402,12 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>            use ses->maxReq */
>
>         if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
> -               cifs_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
> +               cifs_server_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
>                          len);
>                 return -EIO;
>         }
>
> -       rc = wait_for_free_request(ses->server, CIFS_BLOCKING_OP, &instance);
> +       rc = wait_for_free_request(server, CIFS_BLOCKING_OP, &instance);
>         if (rc)
>                 return rc;
>
> @@ -1412,31 +1415,31 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>            and avoid races inside tcp sendmsg code that could cause corruption
>            of smb data */
>
> -       mutex_lock(&ses->server->srv_mutex);
> +       mutex_lock(&server->srv_mutex);
>
>         rc = allocate_mid(ses, in_buf, &midQ);
>         if (rc) {
> -               mutex_unlock(&ses->server->srv_mutex);
> +               mutex_unlock(&server->srv_mutex);
>                 return rc;
>         }
>
> -       rc = cifs_sign_smb(in_buf, ses->server, &midQ->sequence_number);
> +       rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
>         if (rc) {
>                 cifs_delete_mid(midQ);
> -               mutex_unlock(&ses->server->srv_mutex);
> +               mutex_unlock(&server->srv_mutex);
>                 return rc;
>         }
>
>         midQ->mid_state = MID_REQUEST_SUBMITTED;
> -       cifs_in_send_inc(ses->server);
> -       rc = smb_send(ses->server, in_buf, len);
> -       cifs_in_send_dec(ses->server);
> +       cifs_in_send_inc(server);
> +       rc = smb_send(server, in_buf, len);
> +       cifs_in_send_dec(server);
>         cifs_save_when_sent(midQ);
>
>         if (rc < 0)
> -               ses->server->sequence_number -= 2;
> +               server->sequence_number -= 2;
>
> -       mutex_unlock(&ses->server->srv_mutex);
> +       mutex_unlock(&server->srv_mutex);
>
>         if (rc < 0) {
>                 cifs_delete_mid(midQ);
> @@ -1444,21 +1447,21 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>         }
>
>         /* Wait for a reply - allow signals to interrupt. */
> -       rc = wait_event_interruptible(ses->server->response_q,
> +       rc = wait_event_interruptible(server->response_q,
>                 (!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
> -               ((ses->server->tcpStatus != CifsGood) &&
> -                (ses->server->tcpStatus != CifsNew)));
> +               ((server->tcpStatus != CifsGood) &&
> +                (server->tcpStatus != CifsNew)));
>
>         /* Were we interrupted by a signal ? */
>         if ((rc == -ERESTARTSYS) &&
>                 (midQ->mid_state == MID_REQUEST_SUBMITTED) &&
> -               ((ses->server->tcpStatus == CifsGood) ||
> -                (ses->server->tcpStatus == CifsNew))) {
> +               ((server->tcpStatus == CifsGood) ||
> +                (server->tcpStatus == CifsNew))) {
>
>                 if (in_buf->Command == SMB_COM_TRANSACTION2) {
>                         /* POSIX lock. We send a NT_CANCEL SMB to cause the
>                            blocking lock to return. */
> -                       rc = send_cancel(ses->server, &rqst, midQ);
> +                       rc = send_cancel(server, &rqst, midQ);
>                         if (rc) {
>                                 cifs_delete_mid(midQ);
>                                 return rc;
> @@ -1477,9 +1480,9 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>                         }
>                 }
>
> -               rc = wait_for_response(ses->server, midQ);
> +               rc = wait_for_response(server, midQ);
>                 if (rc) {
> -                       send_cancel(ses->server, &rqst, midQ);
> +                       send_cancel(server, &rqst, midQ);
>                         spin_lock(&GlobalMid_Lock);
>                         if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>                                 /* no longer considered to be "in-flight" */
> @@ -1494,20 +1497,20 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>                 rstart = 1;
>         }
>
> -       rc = cifs_sync_mid_result(midQ, ses->server);
> +       rc = cifs_sync_mid_result(midQ, server);
>         if (rc != 0)
>                 return rc;
>
>         /* rcvd frame is ok */
>         if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
>                 rc = -EIO;
> -               cifs_dbg(VFS, "Bad MID state?\n");
> +               cifs_server_dbg(VFS, "Bad MID state?\n");
>                 goto out;
>         }
>
>         *pbytes_returned = get_rfc1002_length(midQ->resp_buf);
>         memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
> -       rc = cifs_check_receive(midQ, ses->server, 0);
> +       rc = cifs_check_receive(midQ, server, 0);
>  out:
>         cifs_delete_mid(midQ);
>         if (rstart && rc == -EACCES)
> --
> 2.13.6
>


-- 
Thanks,

Steve
