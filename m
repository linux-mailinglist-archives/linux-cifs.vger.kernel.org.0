Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723A57E7A5
	for <lists+linux-cifs@lfdr.de>; Fri, 22 Jul 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiGVTu4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 22 Jul 2022 15:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGVTuz (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 22 Jul 2022 15:50:55 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6388AEF9
        for <linux-cifs@vger.kernel.org>; Fri, 22 Jul 2022 12:50:54 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id t23so2523263vkm.7
        for <linux-cifs@vger.kernel.org>; Fri, 22 Jul 2022 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6ZjNUb7ApSFYrr4TI0cozkZ9NqBO5mL5h4wlUFPJCQ=;
        b=ghL0DGMftMJLkFI7rGms0zT+Lsd2fEZz8jOnIJFNzZL5LsZzzKhyxOSnRTr/4bk1Qo
         aLHDJWPkjE9cuKGLQwbJTSGvFDt5rUQ915Kq8xud8Gr0EaOGRbBhaEtPxQ2dUpxVNph9
         nYQDYoQ12QnUnIh2gOZPYEACZ3frI/CQPh5xttwF9IK/L/5USkGySY5KjqLLzw3P0MOY
         wkfOOFTMnNNgLrZXkJSpGY4H3LBuZROgpoFMCtmjx1F42fkx45PsjDq+uUEUpP94uROh
         sdx37ZsxAt9IPsgMEspJDrFFAPIkB+dn9YtNx8t5yI2ThhMPANUVwxX6s2RWOFUJHgbl
         2nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6ZjNUb7ApSFYrr4TI0cozkZ9NqBO5mL5h4wlUFPJCQ=;
        b=Mgz/jvHcaFR3rypoFbYVzSmYhVHIUgEi4Uvd6EdcmztEI6yHQQyUiejYQkrp+k/5gl
         0Jqh//X5WUrDQMvzpJ9UA4gxERu7qx9TxF1n8IfhPMuVpc91b/YnvqfpqYsFucqqHKgp
         Xjzxct2ar61dbjCO89MBPtAKfwWmmt6y5+eZkMIt0cFYZelZA4y/Zt65x6XsO/j8+iUy
         u0S7QdkJxeUxFPlA2IPr+1sa2kj5FCDOhipCcZazONexK2qkL/jNMMB0wpAgVclVyPjV
         6jdqV7LY2V/nDkRA2MmWeYSSVpXDJ4N5JHry38gElE2U4UgftKoLx46vEGZ7OKCvg57E
         lLyQ==
X-Gm-Message-State: AJIora8YjfvBRsSk2g5+MdaT1tsfohwUj5t6fDUi7vH+296rRSFUQuSu
        zK4sxJq5R0kvnmMi7stynRu/pOiSwCfJ4NCXwPGNE9tda+g=
X-Google-Smtp-Source: AGRyM1uOSNTSpnMYa6TdX4GTqtbMGbc7gURgiJqiXfqn/JCVeP1aGobl4JjYJz9c49iGvoureCN2bztoPZlhbI6RlkY=
X-Received: by 2002:a05:6122:16a7:b0:374:ba7f:7f15 with SMTP id
 39-20020a05612216a700b00374ba7f7f15mr499838vkl.3.1658519453338; Fri, 22 Jul
 2022 12:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220722170259.29437-1-ematsumiya@suse.de>
In-Reply-To: <20220722170259.29437-1-ematsumiya@suse.de>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 22 Jul 2022 14:50:42 -0500
Message-ID: <CAH2r5muSoLBL5GAreEnP2fpL9oY-rzec_trbZZNq=ed0jw22iQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: list_for_each() -> list_for_each_entry()
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

merged into cifs-2.6.git for-next

On Fri, Jul 22, 2022 at 12:03 PM Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
> Replace list_for_each() by list_for_each_entr() where appropriate.
> Remove no longer used list_head stack variables.
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
>  fs/cifs/cifs_debug.c | 48 ++++++++++----------------------------------
>  fs/cifs/connect.c    |  5 +----
>  fs/cifs/file.c       | 10 +++------
>  fs/cifs/misc.c       | 19 +++++-------------
>  fs/cifs/smb2ops.c    |  7 ++-----
>  5 files changed, 22 insertions(+), 67 deletions(-)
>
> diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
> index f5e63dfac2b1..aac4240893af 100644
> --- a/fs/cifs/cifs_debug.c
> +++ b/fs/cifs/cifs_debug.c
> @@ -168,7 +168,6 @@ cifs_dump_iface(struct seq_file *m, struct cifs_server_iface *iface)
>
>  static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
>  {
> -       struct list_head *tmp, *tmp1, *tmp2;
>         struct TCP_Server_Info *server;
>         struct cifs_ses *ses;
>         struct cifs_tcon *tcon;
> @@ -184,14 +183,10 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
>  #endif /* CIFS_DEBUG2 */
>         spin_lock(&cifs_tcp_ses_lock);
>         list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
> -               list_for_each(tmp, &server->smb_ses_list) {
> -                       ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
> -                       list_for_each(tmp1, &ses->tcon_list) {
> -                               tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
> +               list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
> +                       list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                                 spin_lock(&tcon->open_file_lock);
> -                               list_for_each(tmp2, &tcon->openFileList) {
> -                                       cfile = list_entry(tmp2, struct cifsFileInfo,
> -                                                    tlist);
> +                               list_for_each_entry(cfile, &tcon->openFileList, tlist) {
>                                         seq_printf(m,
>                                                 "0x%x 0x%llx 0x%x %d %d %d %pd",
>                                                 tcon->tid,
> @@ -218,7 +213,6 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
>
>  static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>  {
> -       struct list_head *tmp2, *tmp3;
>         struct mid_q_entry *mid_entry;
>         struct TCP_Server_Info *server;
>         struct cifs_ses *ses;
> @@ -381,9 +375,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>
>                 seq_printf(m, "\n\n\tSessions: ");
>                 i = 0;
> -               list_for_each(tmp2, &server->smb_ses_list) {
> -                       ses = list_entry(tmp2, struct cifs_ses,
> -                                        smb_ses_list);
> +               list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
>                         i++;
>                         if ((ses->serverDomain == NULL) ||
>                                 (ses->serverOS == NULL) ||
> @@ -447,9 +439,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>                         else
>                                 seq_puts(m, "none\n");
>
> -                       list_for_each(tmp3, &ses->tcon_list) {
> -                               tcon = list_entry(tmp3, struct cifs_tcon,
> -                                                 tcon_list);
> +                       list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                                 ++j;
>                                 seq_printf(m, "\n\t%d) ", j);
>                                 cifs_debug_tcon(m, tcon);
> @@ -474,9 +464,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>
>                 seq_puts(m, "\n\n\tMIDs: ");
>                 spin_lock(&GlobalMid_Lock);
> -               list_for_each(tmp3, &server->pending_mid_q) {
> -                       mid_entry = list_entry(tmp3, struct mid_q_entry,
> -                                       qhead);
> +               list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
>                         seq_printf(m, "\n\tState: %d com: %d pid:"
>                                         " %d cbdata: %p mid %llu\n",
>                                         mid_entry->mid_state,
> @@ -504,7 +492,6 @@ static ssize_t cifs_stats_proc_write(struct file *file,
>  {
>         bool bv;
>         int rc;
> -       struct list_head *tmp1, *tmp2, *tmp3;
>         struct TCP_Server_Info *server;
>         struct cifs_ses *ses;
>         struct cifs_tcon *tcon;
> @@ -525,9 +512,7 @@ static ssize_t cifs_stats_proc_write(struct file *file,
>                 GlobalCurrentXid = 0;
>                 spin_unlock(&GlobalMid_Lock);
>                 spin_lock(&cifs_tcp_ses_lock);
> -               list_for_each(tmp1, &cifs_tcp_ses_list) {
> -                       server = list_entry(tmp1, struct TCP_Server_Info,
> -                                           tcp_ses_list);
> +               list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
>                         server->max_in_flight = 0;
>  #ifdef CONFIG_CIFS_STATS2
>                         for (i = 0; i < NUMBER_OF_SMB2_COMMANDS; i++) {
> @@ -538,13 +523,8 @@ static ssize_t cifs_stats_proc_write(struct file *file,
>                                 server->fastest_cmd[0] = 0;
>                         }
>  #endif /* CONFIG_CIFS_STATS2 */
> -                       list_for_each(tmp2, &server->smb_ses_list) {
> -                               ses = list_entry(tmp2, struct cifs_ses,
> -                                                smb_ses_list);
> -                               list_for_each(tmp3, &ses->tcon_list) {
> -                                       tcon = list_entry(tmp3,
> -                                                         struct cifs_tcon,
> -                                                         tcon_list);
> +                       list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
> +                               list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                                         atomic_set(&tcon->num_smbs_sent, 0);
>                                         spin_lock(&tcon->stat_lock);
>                                         tcon->bytes_read = 0;
> @@ -569,7 +549,6 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
>  #ifdef CONFIG_CIFS_STATS2
>         int j;
>  #endif /* STATS2 */
> -       struct list_head *tmp2, *tmp3;
>         struct TCP_Server_Info *server;
>         struct cifs_ses *ses;
>         struct cifs_tcon *tcon;
> @@ -619,13 +598,8 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
>                                         atomic_read(&server->smb2slowcmd[j]),
>                                         server->hostname, j);
>  #endif /* STATS2 */
> -               list_for_each(tmp2, &server->smb_ses_list) {
> -                       ses = list_entry(tmp2, struct cifs_ses,
> -                                        smb_ses_list);
> -                       list_for_each(tmp3, &ses->tcon_list) {
> -                               tcon = list_entry(tmp3,
> -                                                 struct cifs_tcon,
> -                                                 tcon_list);
> +               list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
> +                       list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                                 i++;
>                                 seq_printf(m, "\n%d) %s", i, tcon->treeName);
>                                 if (tcon->need_reconnect)
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 8859da70cb06..6e670e7c2182 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -2257,13 +2257,10 @@ static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
>  static struct cifs_tcon *
>  cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
>  {
> -       struct list_head *tmp;
>         struct cifs_tcon *tcon;
>
>         spin_lock(&cifs_tcp_ses_lock);
> -       list_for_each(tmp, &ses->tcon_list) {
> -               tcon = list_entry(tmp, struct cifs_tcon, tcon_list);
> -
> +       list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                 if (!match_tcon(tcon, ctx))
>                         continue;
>                 ++tcon->tc_count;
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6985710e14c2..967663ad63a0 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -928,9 +928,7 @@ int cifs_close(struct inode *inode, struct file *file)
>  void
>  cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
>  {
> -       struct cifsFileInfo *open_file;
> -       struct list_head *tmp;
> -       struct list_head *tmp1;
> +       struct cifsFileInfo *open_file, *tmp;
>         struct list_head tmp_list;
>
>         if (!tcon->use_persistent || !tcon->need_reopen_files)
> @@ -943,8 +941,7 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
>
>         /* list all files open on tree connection, reopen resilient handles  */
>         spin_lock(&tcon->open_file_lock);
> -       list_for_each(tmp, &tcon->openFileList) {
> -               open_file = list_entry(tmp, struct cifsFileInfo, tlist);
> +       list_for_each_entry(open_file, &tcon->openFileList, tlist) {
>                 if (!open_file->invalidHandle)
>                         continue;
>                 cifsFileInfo_get(open_file);
> @@ -952,8 +949,7 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
>         }
>         spin_unlock(&tcon->open_file_lock);
>
> -       list_for_each_safe(tmp, tmp1, &tmp_list) {
> -               open_file = list_entry(tmp, struct cifsFileInfo, rlist);
> +       list_for_each_entry_safe(open_file, tmp, &tmp_list, rlist) {
>                 if (cifs_reopen_file(open_file, false /* do not flush */))
>                         tcon->need_reopen_files = true;
>                 list_del_init(&open_file->rlist);
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index 16168ebd1a62..a825cc09a53e 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -400,7 +400,6 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
>  {
>         struct smb_hdr *buf = (struct smb_hdr *)buffer;
>         struct smb_com_lock_req *pSMB = (struct smb_com_lock_req *)buf;
> -       struct list_head *tmp, *tmp1, *tmp2;
>         struct cifs_ses *ses;
>         struct cifs_tcon *tcon;
>         struct cifsInodeInfo *pCifsInode;
> @@ -467,18 +466,14 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
>
>         /* look up tcon based on tid & uid */
>         spin_lock(&cifs_tcp_ses_lock);
> -       list_for_each(tmp, &srv->smb_ses_list) {
> -               ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
> -               list_for_each(tmp1, &ses->tcon_list) {
> -                       tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
> +       list_for_each_entry(ses, &srv->smb_ses_list, smb_ses_list) {
> +               list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                         if (tcon->tid != buf->Tid)
>                                 continue;
>
>                         cifs_stats_inc(&tcon->stats.cifs_stats.num_oplock_brks);
>                         spin_lock(&tcon->open_file_lock);
> -                       list_for_each(tmp2, &tcon->openFileList) {
> -                               netfile = list_entry(tmp2, struct cifsFileInfo,
> -                                                    tlist);
> +                       list_for_each_entry(netfile, &tcon->openFileList, tlist) {
>                                 if (pSMB->Fid != netfile->fid.netfid)
>                                         continue;
>
> @@ -763,14 +758,12 @@ void
>  cifs_close_all_deferred_files(struct cifs_tcon *tcon)
>  {
>         struct cifsFileInfo *cfile;
> -       struct list_head *tmp;
>         struct file_list *tmp_list, *tmp_next_list;
>         struct list_head file_head;
>
>         INIT_LIST_HEAD(&file_head);
>         spin_lock(&tcon->open_file_lock);
> -       list_for_each(tmp, &tcon->openFileList) {
> -               cfile = list_entry(tmp, struct cifsFileInfo, tlist);
> +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
>                 if (delayed_work_pending(&cfile->deferred)) {
>                         if (cancel_delayed_work(&cfile->deferred)) {
>                                 tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
> @@ -793,7 +786,6 @@ void
>  cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
>  {
>         struct cifsFileInfo *cfile;
> -       struct list_head *tmp;
>         struct file_list *tmp_list, *tmp_next_list;
>         struct list_head file_head;
>         void *page;
> @@ -802,8 +794,7 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
>         INIT_LIST_HEAD(&file_head);
>         page = alloc_dentry_path();
>         spin_lock(&tcon->open_file_lock);
> -       list_for_each(tmp, &tcon->openFileList) {
> -               cfile = list_entry(tmp, struct cifsFileInfo, tlist);
> +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
>                 full_path = build_path_from_dentry(cfile->dentry, page);
>                 if (strstr(full_path, path)) {
>                         if (delayed_work_pending(&cfile->deferred)) {
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index aa4c1d403708..5bed8b584086 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -2575,7 +2575,6 @@ static void
>  smb2_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
>  {
>         struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
> -       struct list_head *tmp, *tmp1;
>         struct cifs_ses *ses;
>         struct cifs_tcon *tcon;
>
> @@ -2583,10 +2582,8 @@ smb2_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
>                 return;
>
>         spin_lock(&cifs_tcp_ses_lock);
> -       list_for_each(tmp, &server->smb_ses_list) {
> -               ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
> -               list_for_each(tmp1, &ses->tcon_list) {
> -                       tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
> +       list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
> +               list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                         if (tcon->tid == le32_to_cpu(shdr->Id.SyncId.TreeId)) {
>                                 tcon->need_reconnect = true;
>                                 spin_unlock(&cifs_tcp_ses_lock);
> --
> 2.35.3
>


-- 
Thanks,

Steve
