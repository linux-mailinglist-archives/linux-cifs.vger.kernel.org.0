Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83D546B8E
	for <lists+linux-cifs@lfdr.de>; Fri, 10 Jun 2022 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbiFJRQY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 10 Jun 2022 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiFJRQX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 10 Jun 2022 13:16:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401556B2B
        for <linux-cifs@vger.kernel.org>; Fri, 10 Jun 2022 10:16:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D721220C4;
        Fri, 10 Jun 2022 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654881379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DVaI6rEA63rGIEdxd92jUBDvsFBwokSnWyoiTymKnQ=;
        b=lcPIRFTOSjCtGGG04OKGskKK0S9IjnvZYyy31wnKmlRqADEIbFSjA5HWBjX+dXZoverG5k
        WpbHTmx48gy7B6rjT4BKudpIxmikMQlALOSGO/x9JNHyIgXdDhWOFGlrJWGJbQFvdTaGiv
        dzvEpo59V6QDSCeriBfKqttzHbr3FVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654881379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DVaI6rEA63rGIEdxd92jUBDvsFBwokSnWyoiTymKnQ=;
        b=mO5N6sG5r4WMBRLkhs2kfbb7wqtvpd0lwzVdkRr4EjTdUSCzdAPrXgP4Zk0A/fpGooizDz
        Bh74g/6GVJ2yyQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF76A13941;
        Fri, 10 Jun 2022 17:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R9f6J2J8o2JBJgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Fri, 10 Jun 2022 17:16:18 +0000
Date:   Fri, 10 Jun 2022 14:16:16 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>, Paulo Alcantara <pc@cjr.nz>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH] cifs: introduce dns_interval mount option
Message-ID: <20220610171616.op43k3b76o4wqna3@cyberdelia>
References: <20220609224342.892-1-ematsumiya@suse.de>
 <CANT5p=pWqH=1LhakCyfkwDjUCUvkcy2PcNGK0SsR+04v32=KtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANT5p=pWqH=1LhakCyfkwDjUCUvkcy2PcNGK0SsR+04v32=KtQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 06/10, Shyam Prasad N wrote:
>On Fri, Jun 10, 2022 at 4:14 AM Enzo Matsumiya <ematsumiya@suse.de> wrote:
>>
>> This patch introduces a `dns_interval' mount option, used to configure
>> the interval that the DNS resolve worker should be run.
>>
>> Enforces the minimum value SMB_DNS_RESOLVE_INTERVAL_MIN (currently 120s),
>> or uses the default SMB_DNS_RESOLVE_INTERVAL_DEFAULT (currently 600s).
>>
>> Since this is a mount option, each derived connection from it, e.g. DFS
>> root targets, will share the same DNS interval from the primary server
>> since the TCP session options are passed down to them.
>>
>> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
>> ---
>>  fs/cifs/cifsfs.c     |  3 +++
>>  fs/cifs/cifsglob.h   |  1 +
>>  fs/cifs/connect.c    | 20 ++++++++++++++------
>>  fs/cifs/fs_context.c | 11 +++++++++++
>>  fs/cifs/fs_context.h |  2 ++
>>  fs/cifs/sess.c       |  1 +
>>  6 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
>> index 325423180fd2..ad980b235699 100644
>> --- a/fs/cifs/cifsfs.c
>> +++ b/fs/cifs/cifsfs.c
>> @@ -665,6 +665,9 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
>>         if (tcon->ses->server->max_credits != SMB2_MAX_CREDITS_AVAILABLE)
>>                 seq_printf(s, ",max_credits=%u", tcon->ses->server->max_credits);
>>
>> +       if (tcon->ses->server->dns_interval != SMB_DNS_RESOLVE_INTERVAL_DEFAULT)
>> +               seq_printf(s, ",dns_interval=%u", tcon->ses->server->dns_interval);
>> +
>>         if (tcon->snapshot_time)
>>                 seq_printf(s, ",snapshot=%llu", tcon->snapshot_time);
>>         if (tcon->handle_timeout)
>> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
>> index f873379066c7..e28a23b617ef 100644
>> --- a/fs/cifs/cifsglob.h
>> +++ b/fs/cifs/cifsglob.h
>> @@ -679,6 +679,7 @@ struct TCP_Server_Info {
>>         struct smbd_connection *smbd_conn;
>>         struct delayed_work     echo; /* echo ping workqueue job */
>>         struct delayed_work     resolve; /* dns resolution workqueue job */
>> +       unsigned int dns_interval; /* interval for resolve worker */
>>         char    *smallbuf;      /* pointer to current "small" buffer */
>>         char    *bigbuf;        /* pointer to current "big" buffer */
>>         /* Total size of this PDU. Only valid from cifs_demultiplex_thread */
>> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
>> index 06bafba9c3ff..e6bedced576a 100644
>> --- a/fs/cifs/connect.c
>> +++ b/fs/cifs/connect.c
>> @@ -92,7 +92,7 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
>>         int len;
>>         char *unc, *ipaddr = NULL;
>>         time64_t expiry, now;
>> -       unsigned long ttl = SMB_DNS_RESOLVE_INTERVAL_DEFAULT;
>> +       unsigned int ttl = server->dns_interval;
>>
>>         if (!server->hostname ||
>>             server->hostname[0] == '\0')
>> @@ -129,13 +129,15 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
>>                         /*
>>                          * To make sure we don't use the cached entry, retry 1s
>>                          * after expiry.
>> +                        *
>> +                        * dns_interval is guaranteed to be >= SMB_DNS_RESOLVE_INTERVAL_MIN
>>                          */
>> -                       ttl = max_t(unsigned long, expiry - now, SMB_DNS_RESOLVE_INTERVAL_MIN) + 1;
>> +                       ttl = max_t(unsigned long, expiry - now, server->dns_interval) + 1;
>>         }
>>         rc = !rc ? -1 : 0;
>>
>>  requeue_resolve:
>> -       cifs_dbg(FYI, "%s: next dns resolution scheduled for %lu seconds in the future\n",
>> +       cifs_dbg(FYI, "%s: next dns resolution scheduled for %u seconds in the future\n",
>>                  __func__, ttl);
>>         mod_delayed_work(cifsiod_wq, &server->resolve, (ttl * HZ));
>>
>> @@ -1608,6 +1610,12 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
>>                 tcp_ses->echo_interval = ctx->echo_interval * HZ;
>>         else
>>                 tcp_ses->echo_interval = SMB_ECHO_INTERVAL_DEFAULT * HZ;
>> +
>> +       if (ctx->dns_interval >= SMB_DNS_RESOLVE_INTERVAL_MIN)
>> +               tcp_ses->dns_interval = ctx->dns_interval;
>> +       else
>> +               tcp_ses->dns_interval = SMB_DNS_RESOLVE_INTERVAL_DEFAULT;
>> +
>Hi Enzo,
>
>Is the above line a mistake? Shouldn't that be set to
>SMB_DNS_RESOLVE_INTERVAL_MIN value in the else case?
>Rest looks good to me. You can add my RB.

Hy Shyam,

SMB_DNS_RESOLVE_INTERVAL_MIN is just for boundary-checking. In case
dns_interval is < than that, we fallback to the default value (I've copied
echo_interval behaviour, and also the current behaviour).

IMHO we shouldn't use SMB_DNS_RESOLVE_INTERVAL_MIN as a fallback value
because it's too far from the default values used by the servers I've
checked (Windows Server 2019, 600s, samba "name cache timeout" = 660s).


Thanks,

Enzo
