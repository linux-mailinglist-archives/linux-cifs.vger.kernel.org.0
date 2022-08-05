Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8F58AE1D
	for <lists+linux-cifs@lfdr.de>; Fri,  5 Aug 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiHEQ1g (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 5 Aug 2022 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEQ1f (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 5 Aug 2022 12:27:35 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F21D9
        for <linux-cifs@vger.kernel.org>; Fri,  5 Aug 2022 09:27:32 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id m67so2916521vsc.12
        for <linux-cifs@vger.kernel.org>; Fri, 05 Aug 2022 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLIHW2fM8a5Qalf+vRCyUK8vGsNTotTPWjRKuTK4VQM=;
        b=P9LS7VGT7WwWsxcjVlN8132ytPLefwvSr6x7WqjOCb4CaWe102PvsAneKEDCbbRn8R
         aM6OBKt0XrEltBMsR5sPyUcckB+dRB4jdcQ7Ph+gakCNeRzCf2RN9puW+Ppl5+Eyn1v2
         /WUdlHtDW0/boopPH1+LHrVg91BXV35mSl6ikc71VZfqajGV+D2hll+TWiJQehAx6sRD
         an9twno/yVSwpLAIUodbY9OPAo5xGGC6xBavuxzfHQHqeank6vvlu4uBGamEYzk1lxoO
         qqIcxHoiSaf67qFxFRVTTZ8yFGULcTFiYtA0W7y9oQWbPJER6tLenAFGv8Fnnqu2b1K/
         IXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLIHW2fM8a5Qalf+vRCyUK8vGsNTotTPWjRKuTK4VQM=;
        b=M4WK9zakHPCSB9Hj0sGYDwqSp58Cl+mnXl4Ro7t7G+Iw4EtYTY5wweiCgpvM65SZDh
         k+A5iw31dNvCd6dmWXFw9Z48uJaancurKV1iS8BVCSl5/QaPK/eqJQj5RGG7HZ5TNn0h
         NbmFscCQfa+V7AwHturgN4w1WIftrWEbDV4kE9GjuAHekvNR5uONjjpmsBSJJnVFiq3V
         8lzRprC+UIz6bQaMqh6bruYB9dtfwPjECShWcDi/DREo0DescElkzYON6HWXidmsrgFK
         LzwgaX6cYRsioVr721n0HdlBnjtp+VoxswK+UfxvrJx9x3Hwemk8o+VTLF6PrJJmqQ6t
         cyhA==
X-Gm-Message-State: ACgBeo01Wp2hrJIFhpXpFGpEkL2copLcp9w6gVsdpCd31mCe+IU4TSXF
        qmN3G2WbhcaqVeh925QsENTu7uzElehMdiUNIRM=
X-Google-Smtp-Source: AA6agR41vPVGiT/GQp1K2KUx9DEZppZuFLYBgdGI7FkXB8rgJ1uTy+fILcnOb8BNCuOeJFczLfUyGKHYPDxnn7acI9M=
X-Received: by 2002:a67:ca83:0:b0:374:ab95:ed82 with SMTP id
 a3-20020a67ca83000000b00374ab95ed82mr3256692vsl.60.1659716851069; Fri, 05 Aug
 2022 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220805144739.27641-1-ematsumiya@suse.de>
In-Reply-To: <20220805144739.27641-1-ematsumiya@suse.de>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 5 Aug 2022 11:27:20 -0500
Message-ID: <CAH2r5msgVYVXQ_su0dD8O7BncvrLjfhmrvMu6xE45BwRnTBfKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cifs: remove useless DeleteMidQEntry()
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
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

merged into cifs-2.6.git for-next

On Fri, Aug 5, 2022 at 9:47 AM Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
> DeleteMidQEntry() was just a proxy for cifs_mid_q_entry_release().
>
> - remove DeleteMidQEntry()
> - rename cifs_mid_q_entry_release() to release_mid()
> - rename kref_put() callback _cifs_mid_q_entry_release to __release_mid
> - rename AllocMidQEntry() to alloc_mid()
> - rename cifs_delete_mid() to delete_mid()
>
> Update callers to use new names.
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
> v2:
> - remove "cifs_" prefix from generic mid functions
> - rename AllocMidQEntry() and cifs_delete_mid() as well
> - add a follow-up patch to rename cifs_{init,destroy}_mids() in cifsfs.c
>
> @Steve: since most mid handling code treats "mid_q_entry" as the mid per
> se, I went with "release_mid()" instead of "release_mid_q_entry()" to
> keep a standard.
>
>  fs/cifs/cifsproto.h     |  9 +++----
>  fs/cifs/cifssmb.c       |  6 ++---
>  fs/cifs/connect.c       |  8 +++---
>  fs/cifs/smb2ops.c       |  2 +-
>  fs/cifs/smb2pdu.c       |  6 ++---
>  fs/cifs/smb2transport.c |  4 +--
>  fs/cifs/transport.c     | 57 +++++++++++++++++++----------------------
>  7 files changed, 43 insertions(+), 49 deletions(-)
>
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index de167e3af015..a3cb47619a0a 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -79,11 +79,10 @@ extern char *cifs_compose_mount_options(const char *sb_mountdata,
>                 const char *fullpath, const struct dfs_info3_param *ref,
>                 char **devname);
>  /* extern void renew_parental_timestamps(struct dentry *direntry);*/
> -extern struct mid_q_entry *AllocMidQEntry(const struct smb_hdr *smb_buffer,
> -                                       struct TCP_Server_Info *server);
> -extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
> -extern void cifs_delete_mid(struct mid_q_entry *mid);
> -extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
> +extern struct mid_q_entry *alloc_mid(const struct smb_hdr *,
> +                                    struct TCP_Server_Info *);
> +extern void delete_mid(struct mid_q_entry *mid);
> +extern void release_mid(struct mid_q_entry *mid);
>  extern void cifs_wake_up_task(struct mid_q_entry *mid);
>  extern int cifs_handle_standard(struct TCP_Server_Info *server,
>                                 struct mid_q_entry *mid);
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 26b9d2438228..7aa91e272027 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -591,7 +591,7 @@ cifs_echo_callback(struct mid_q_entry *mid)
>         struct TCP_Server_Info *server = mid->callback_data;
>         struct cifs_credits credits = { .value = 1, .instance = 0 };
>
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(server, &credits, CIFS_ECHO_OP);
>  }
>
> @@ -1336,7 +1336,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
>         }
>
>         queue_work(cifsiod_wq, &rdata->work);
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(server, &credits, 0);
>  }
>
> @@ -1684,7 +1684,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
>         }
>
>         queue_work(cifsiod_wq, &wdata->work);
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(tcon->ses->server, &credits, 0);
>  }
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index abb65dd7471f..7f205a9a2de4 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -334,7 +334,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
>         list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
>                 list_del_init(&mid->qhead);
>                 mid->callback(mid);
> -               cifs_mid_q_entry_release(mid);
> +               release_mid(mid);
>         }
>
>         if (cifs_rdma_enabled(server)) {
> @@ -1007,7 +1007,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
>                         cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
>                         list_del_init(&mid_entry->qhead);
>                         mid_entry->callback(mid_entry);
> -                       cifs_mid_q_entry_release(mid_entry);
> +                       release_mid(mid_entry);
>                 }
>                 /* 1/8th of sec is more than enough time for them to exit */
>                 msleep(125);
> @@ -1246,7 +1246,7 @@ cifs_demultiplex_thread(void *p)
>                 if (length < 0) {
>                         for (i = 0; i < num_mids; i++)
>                                 if (mids[i])
> -                                       cifs_mid_q_entry_release(mids[i]);
> +                                       release_mid(mids[i]);
>                         continue;
>                 }
>
> @@ -1273,7 +1273,7 @@ cifs_demultiplex_thread(void *p)
>                                 if (!mids[i]->multiRsp || mids[i]->multiEnd)
>                                         mids[i]->callback(mids[i]);
>
> -                               cifs_mid_q_entry_release(mids[i]);
> +                               release_mid(mids[i]);
>                         } else if (server->ops->is_oplock_break &&
>                                    server->ops->is_oplock_break(bufs[i],
>                                                                 server)) {
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 82dd2e973753..c0039dc0715a 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -5099,7 +5099,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
>                                 spin_unlock(&dw->server->srv_lock);
>                         }
>                 }
> -               cifs_mid_q_entry_release(mid);
> +               release_mid(mid);
>         }
>
>  free_pages:
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 131bec79d6fd..590a1d4ac140 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3776,7 +3776,7 @@ smb2_echo_callback(struct mid_q_entry *mid)
>                 credits.instance = server->reconnect_instance;
>         }
>
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(server, &credits, CIFS_ECHO_OP);
>  }
>
> @@ -4201,7 +4201,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>                                      rdata->offset, rdata->got_bytes);
>
>         queue_work(cifsiod_wq, &rdata->work);
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(server, &credits, 0);
>  }
>
> @@ -4440,7 +4440,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
>                                       wdata->offset, wdata->bytes);
>
>         queue_work(cifsiod_wq, &wdata->work);
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         add_credits(server, &credits, 0);
>  }
>
> diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
> index f64922f340b3..1a5fc3314dbf 100644
> --- a/fs/cifs/smb2transport.c
> +++ b/fs/cifs/smb2transport.c
> @@ -856,7 +856,7 @@ smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
>         rc = smb2_sign_rqst(rqst, server);
>         if (rc) {
>                 revert_current_mid_from_hdr(server, shdr);
> -               cifs_delete_mid(mid);
> +               delete_mid(mid);
>                 return ERR_PTR(rc);
>         }
>
> @@ -890,7 +890,7 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
>         rc = smb2_sign_rqst(rqst, server);
>         if (rc) {
>                 revert_current_mid_from_hdr(server, shdr);
> -               DeleteMidQEntry(mid);
> +               release_mid(mid);
>                 return ERR_PTR(rc);
>         }
>
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 914a7aaf9fa7..dc69ac9dad60 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -39,12 +39,12 @@ cifs_wake_up_task(struct mid_q_entry *mid)
>  }
>
>  struct mid_q_entry *
> -AllocMidQEntry(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
> +alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
>  {
>         struct mid_q_entry *temp;
>
>         if (server == NULL) {
> -               cifs_dbg(VFS, "Null TCP session in AllocMidQEntry\n");
> +               cifs_dbg(VFS, "%s: null TCP session\n", __func__);
>                 return NULL;
>         }
>
> @@ -74,7 +74,7 @@ AllocMidQEntry(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
>         return temp;
>  }
>
> -static void _cifs_mid_q_entry_release(struct kref *refcount)
> +static void __release_mid(struct kref *refcount)
>  {
>         struct mid_q_entry *midEntry =
>                         container_of(refcount, struct mid_q_entry, refcount);
> @@ -153,22 +153,17 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
>         mempool_free(midEntry, cifs_mid_poolp);
>  }
>
> -void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
> +void release_mid(struct mid_q_entry *mid)
>  {
> -       struct TCP_Server_Info *server = midEntry->server;
> +       struct TCP_Server_Info *server = mid->server;
>
>         spin_lock(&server->mid_lock);
> -       kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
> +       kref_put(&mid->refcount, __release_mid);
>         spin_unlock(&server->mid_lock);
>  }
>
> -void DeleteMidQEntry(struct mid_q_entry *midEntry)
> -{
> -       cifs_mid_q_entry_release(midEntry);
> -}
> -
>  void
> -cifs_delete_mid(struct mid_q_entry *mid)
> +delete_mid(struct mid_q_entry *mid)
>  {
>         spin_lock(&mid->server->mid_lock);
>         if (!(mid->mid_flags & MID_DELETED)) {
> @@ -177,7 +172,7 @@ cifs_delete_mid(struct mid_q_entry *mid)
>         }
>         spin_unlock(&mid->server->mid_lock);
>
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>  }
>
>  /*
> @@ -748,7 +743,7 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
>         }
>         spin_unlock(&ses->ses_lock);
>
> -       *ppmidQ = AllocMidQEntry(in_buf, ses->server);
> +       *ppmidQ = alloc_mid(in_buf, ses->server);
>         if (*ppmidQ == NULL)
>                 return -ENOMEM;
>         spin_lock(&ses->server->mid_lock);
> @@ -785,13 +780,13 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
>         if (server->sign)
>                 hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
>
> -       mid = AllocMidQEntry(hdr, server);
> +       mid = alloc_mid(hdr, server);
>         if (mid == NULL)
>                 return ERR_PTR(-ENOMEM);
>
>         rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
>         if (rc) {
> -               DeleteMidQEntry(mid);
> +               release_mid(mid);
>                 return ERR_PTR(rc);
>         }
>
> @@ -868,7 +863,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
>         if (rc < 0) {
>                 revert_current_mid(server, mid->credits);
>                 server->sequence_number -= 2;
> -               cifs_delete_mid(mid);
> +               delete_mid(mid);
>         }
>
>         cifs_server_unlock(server);
> @@ -940,7 +935,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
>         }
>         spin_unlock(&server->mid_lock);
>
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>         return rc;
>  }
>
> @@ -1000,7 +995,7 @@ cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
>                 return ERR_PTR(rc);
>         rc = cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
>         if (rc) {
> -               cifs_delete_mid(mid);
> +               delete_mid(mid);
>                 return ERR_PTR(rc);
>         }
>         return mid;
> @@ -1029,7 +1024,7 @@ static void
>  cifs_cancelled_callback(struct mid_q_entry *mid)
>  {
>         cifs_compound_callback(mid);
> -       DeleteMidQEntry(mid);
> +       release_mid(mid);
>  }
>
>  /*
> @@ -1133,7 +1128,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>                 if (IS_ERR(midQ[i])) {
>                         revert_current_mid(server, i);
>                         for (j = 0; j < i; j++)
> -                               cifs_delete_mid(midQ[j]);
> +                               delete_mid(midQ[j]);
>                         cifs_server_unlock(server);
>
>                         /* Update # of requests on wire to server */
> @@ -1253,7 +1248,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>                 rc = server->ops->check_receive(midQ[i], server,
>                                                      flags & CIFS_LOG_ERROR);
>
> -               /* mark it so buf will not be freed by cifs_delete_mid */
> +               /* mark it so buf will not be freed by delete_mid */
>                 if ((flags & CIFS_NO_RSP_BUF) == 0)
>                         midQ[i]->resp_buf = NULL;
>
> @@ -1285,7 +1280,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>          */
>         for (i = 0; i < num_rqst; i++) {
>                 if (!cancelled_mid[i])
> -                       cifs_delete_mid(midQ[i]);
> +                       delete_mid(midQ[i]);
>         }
>
>         return rc;
> @@ -1425,7 +1420,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
>                 spin_lock(&server->mid_lock);
>                 if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>                         /* no longer considered to be "in-flight" */
> -                       midQ->callback = DeleteMidQEntry;
> +                       midQ->callback = release_mid;
>                         spin_unlock(&server->mid_lock);
>                         add_credits(server, &credits, 0);
>                         return rc;
> @@ -1450,7 +1445,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
>         memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
>         rc = cifs_check_receive(midQ, server, 0);
>  out:
> -       cifs_delete_mid(midQ);
> +       delete_mid(midQ);
>         add_credits(server, &credits, 0);
>
>         return rc;
> @@ -1543,7 +1538,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>
>         rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
>         if (rc) {
> -               cifs_delete_mid(midQ);
> +               delete_mid(midQ);
>                 cifs_server_unlock(server);
>                 return rc;
>         }
> @@ -1560,7 +1555,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>         cifs_server_unlock(server);
>
>         if (rc < 0) {
> -               cifs_delete_mid(midQ);
> +               delete_mid(midQ);
>                 return rc;
>         }
>
> @@ -1583,7 +1578,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>                            blocking lock to return. */
>                         rc = send_cancel(server, &rqst, midQ);
>                         if (rc) {
> -                               cifs_delete_mid(midQ);
> +                               delete_mid(midQ);
>                                 return rc;
>                         }
>                 } else {
> @@ -1595,7 +1590,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>                         /* If we get -ENOLCK back the lock may have
>                            already been removed. Don't exit in this case. */
>                         if (rc && rc != -ENOLCK) {
> -                               cifs_delete_mid(midQ);
> +                               delete_mid(midQ);
>                                 return rc;
>                         }
>                 }
> @@ -1606,7 +1601,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>                         spin_lock(&server->mid_lock);
>                         if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
>                                 /* no longer considered to be "in-flight" */
> -                               midQ->callback = DeleteMidQEntry;
> +                               midQ->callback = release_mid;
>                                 spin_unlock(&server->mid_lock);
>                                 return rc;
>                         }
> @@ -1634,7 +1629,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
>         memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
>         rc = cifs_check_receive(midQ, server, 0);
>  out:
> -       cifs_delete_mid(midQ);
> +       delete_mid(midQ);
>         if (rstart && rc == -EACCES)
>                 return -ERESTARTSYS;
>         return rc;
> --
> 2.35.3
>


-- 
Thanks,

Steve
