Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CED5307B6
	for <lists+linux-cifs@lfdr.de>; Mon, 23 May 2022 04:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352857AbiEWCce (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 22 May 2022 22:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350467AbiEWCcd (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 22 May 2022 22:32:33 -0400
Received: from winds.org (winds.org [68.75.195.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A2CAAE63;
        Sun, 22 May 2022 19:32:31 -0700 (PDT)
Received: by winds.org (Postfix, from userid 100)
        id 3DC4A1DE8787; Sun, 22 May 2022 22:32:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id 3B7851DE8781;
        Sun, 22 May 2022 22:32:30 -0400 (EDT)
Date:   Sun, 22 May 2022 22:32:30 -0400 (EDT)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Steven French <sfrench@samba.org>
cc:     Paulo Alcantara <pc@cjr.nz>, Steve French <smfrench@gmail.com>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
In-Reply-To: <1c766d88-6130-1523-26d4-fefebc15af27@samba.org>
Message-ID: <b9c69369-e22d-98b3-b85c-8c1cc63e7c4@winds.org>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org> <874k1nj3p4.fsf@cjr.nz> <1c766d88-6130-1523-26d4-fefebc15af27@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sat, 21 May 2022, Steven French wrote:

> Yes - please let us know if this worked.

I was on a business trip all last week and didn't get the email till now. I'll
try this out first thing tomorrow morning.

Thanks,
  -Byron

>
> On 5/17/22 15:37, Paulo Alcantara wrote:
>>  Hi Byron,
>>
>>  Byron Stanoszek <gandalf@winds.org> writes:
>>
>>>  I would like to report a regression in the CIFS fs. Sometime between
>>>  Linux 4.14
>>>  and 5.16, mounting CIFS with option vers=1.0 (and
>>>  CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y set appropriately) with security type
>>>  NTLMSSP stopped working for me. The server side is a Windows 2003 Server.
>>>
>>>  I found that this behavior depends on the length of the Linux client's
>>>  host+domain name (e.g. utsname()->nodename), where the mount works as
>>>  long as
>>>  the name is 16 characters or less. Anything 17 or above returns -EIO, per
>>>  the
>>>  following example:
>>>
>>>  /etc/fstab entry:
>>>
>>>  //10.0.0.12/xxxxxxxxx /ext0     cifs
>>>  vers=1.0,user=xxxxx,pass=xxxxxxxxxxx,dom=xxxxxxxxxxx,dir_mode=0755,file_mode=0644,noauto
>>>  0 0
>>>
>>>  # hostname 12345678901234567;mount /ext0
>>>  mount error(5): Input/output error
>>>  Refer to the mount.cifs(8) manual page (e.g. man mount.cifs) and kernel
>>>  log messages (dmesg)
>>> #  hostname 1234567890123456;mount /ext0
>>> #
>>  Could you please try below patch?
>>
>>  Let me know if I missed something else.  Thanks.
>>
>>  From bf63fb30ac90c06f45e40acbd3bbd2284d8ffffb Mon Sep 17 00:00:00 2001
>>  From: Paulo Alcantara <pc@cjr.nz>
>>  Date: Tue, 17 May 2022 17:23:23 -0300
>>  Subject: [PATCH] cifs: fix ntlmssp on old servers
>>
>>  Some older servers seem to require the workstation name during ntlmssp
>>  to be at most 15 chars (RFC1001 name length), so truncate it before
>>  sending when using insecure dialects.
>>
>>  Link:
>>  https://lore.kernel.org/r/e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org
>>  Reported-by: Byron Stanoszek <gandalf@winds.org>
>>  Fixes: 49bd49f983b5 ("cifs: send workstation name during ntlmssp session
>>  setup")
>>  Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>>  ---
>>    fs/cifs/cifsglob.h   | 15 ++++++++++++++-
>>    fs/cifs/connect.c    | 22 ++++------------------
>>    fs/cifs/fs_context.c | 29 ++++-------------------------
>>    fs/cifs/fs_context.h |  2 +-
>>    fs/cifs/misc.c       |  1 -
>>    fs/cifs/sess.c       |  6 +++---
>>    6 files changed, 26 insertions(+), 49 deletions(-)
>>
>>  diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
>>  index 8de977c359b1..5024b6792dab 100644
>>  --- a/fs/cifs/cifsglob.h
>>  +++ b/fs/cifs/cifsglob.h
>>  @@ -944,7 +944,7 @@ struct cifs_ses {
>>     			   and after mount option parsing we fill it */
>>     char *domainName;
>>     char *password;
>>  -	char *workstation_name;
>>  +	char workstation_name[CIFS_MAX_WORKSTATION_LEN];
>>     struct session_key auth_key;
>>     struct ntlmssp_auth *ntlmssp; /* ciphertext, flags, server challenge */
>>     enum securityEnum sectype; /* what security flavor was specified? */
>>  @@ -1979,4 +1979,17 @@ static inline bool cifs_is_referral_server(struct
>>  cifs_tcon *tcon,
>>    	return is_tcon_dfs(tcon) || (ref && (ref->flags &
>>    DFSREF_REFERRAL_SERVER));
>>    }
>>
>>  +static inline size_t ntlmssp_workstation_name_size(const struct cifs_ses
>>  *ses)
>>  +{
>>  +	if (WARN_ON_ONCE(!ses || !ses->server))
>>  +		return 0;
>>  +	/*
>>  +	 * Make workstation name no more than 15 chars when using insecure
>>  dialects as some legacy
>>  +	 * servers do require it during NTLMSSP.
>>  +	 */
>>  +	if (ses->server->dialect <= SMB20_PROT_ID)
>>  +		return min_t(size_t, sizeof(ses->workstation_name),
>>  RFC1001_NAME_LEN_WITH_NULL);
>>  +	return sizeof(ses->workstation_name);
>>  +}
>>  +
>>    #endif	/* _CIFS_GLOB_H */
>>  diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
>>  index 42e14f408856..6ae5193fb562 100644
>>  --- a/fs/cifs/connect.c
>>  +++ b/fs/cifs/connect.c
>>  @@ -2037,18 +2037,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx,
>>  struct cifs_ses *ses)
>>     	}
>>     }
>>    -	ctx->workstation_name = kstrdup(ses->workstation_name, GFP_KERNEL);
>>  -	if (!ctx->workstation_name) {
>>  -		cifs_dbg(FYI, "Unable to allocate memory for
>>  workstation_name\n");
>>  -		rc = -ENOMEM;
>>  -		kfree(ctx->username);
>>  -		ctx->username = NULL;
>>  -		kfree_sensitive(ctx->password);
>>  -		ctx->password = NULL;
>>  -		kfree(ctx->domainname);
>>  -		ctx->domainname = NULL;
>>  -		goto out_key_put;
>>  -	}
>>  +	strscpy(ctx->workstation_name, ses->workstation_name,
>>  sizeof(ctx->workstation_name));
>>
>>    out_key_put:
>>    	up_read(&key->sem);
>>  @@ -2157,12 +2146,9 @@ cifs_get_smb_ses(struct TCP_Server_Info *server,
>>  struct smb3_fs_context *ctx)
>>      if (!ses->domainName)
>>     		goto get_ses_fail;
>>    	}
>>  -	if (ctx->workstation_name) {
>>  -		ses->workstation_name = kstrdup(ctx->workstation_name,
>>  -						GFP_KERNEL);
>>  -		if (!ses->workstation_name)
>>  -			goto get_ses_fail;
>>  -	}
>>  +
>>  +	strscpy(ses->workstation_name, ctx->workstation_name,
>>  sizeof(ses->workstation_name));
>>  +
>>     if (ctx->domainauto)
>>     	ses->domainAuto = ctx->domainauto;
>>    	ses->cred_uid = ctx->cred_uid;
>>  diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
>>  index a92e9eec521f..fbb0e98c7d2c 100644
>>  --- a/fs/cifs/fs_context.c
>>  +++ b/fs/cifs/fs_context.c
>>  @@ -312,7 +312,6 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx,
>>  struct smb3_fs_context *ctx
>>     new_ctx->password = NULL;
>>     new_ctx->server_hostname = NULL;
>>     new_ctx->domainname = NULL;
>>  -	new_ctx->workstation_name = NULL;
>>     new_ctx->UNC = NULL;
>>     new_ctx->source = NULL;
>>     new_ctx->iocharset = NULL;
>>  @@ -327,7 +326,6 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx,
>>  struct smb3_fs_context *ctx
>>     DUP_CTX_STR(UNC);
>>     DUP_CTX_STR(source);
>>     DUP_CTX_STR(domainname);
>>  -	DUP_CTX_STR(workstation_name);
>>     DUP_CTX_STR(nodename);
>>     DUP_CTX_STR(iocharset);
>>    @@ -766,8 +764,7 @@ static int smb3_verify_reconfigure_ctx(struct
>>  fs_context *fc,
>>      cifs_errorf(fc, "can not change domainname during remount\n");
>>      return -EINVAL;
>>    	}
>>  -	if (new_ctx->workstation_name &&
>>  -	    (!old_ctx->workstation_name || strcmp(new_ctx->workstation_name,
>>  old_ctx->workstation_name))) {
>>  +	if (strcmp(new_ctx->workstation_name, old_ctx->workstation_name)) {
>>      cifs_errorf(fc, "can not change workstation_name during remount\n");
>>      return -EINVAL;
>>    	}
>>  @@ -814,7 +811,6 @@ static int smb3_reconfigure(struct fs_context *fc)
>>     STEAL_STRING(cifs_sb, ctx, username);
>>     STEAL_STRING(cifs_sb, ctx, password);
>>     STEAL_STRING(cifs_sb, ctx, domainname);
>>  -	STEAL_STRING(cifs_sb, ctx, workstation_name);
>>     STEAL_STRING(cifs_sb, ctx, nodename);
>>     STEAL_STRING(cifs_sb, ctx, iocharset);
>>    @@ -1467,22 +1463,15 @@ static int smb3_fs_context_parse_param(struct
>>  fs_context *fc,
>>
>>    int smb3_init_fs_context(struct fs_context *fc)
>>    {
>>  -	int rc;
>>     struct smb3_fs_context *ctx;
>>     char *nodename = utsname()->nodename;
>>     int i;
>>
>>    	ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
>>  -	if (unlikely(!ctx)) {
>>  -		rc = -ENOMEM;
>>  -		goto err_exit;
>>  -	}
>>  +	if (unlikely(!ctx))
>>  +		return -ENOMEM;
>>    -	ctx->workstation_name = kstrdup(nodename, GFP_KERNEL);
>>  -	if (unlikely(!ctx->workstation_name)) {
>>  -		rc = -ENOMEM;
>>  -		goto err_exit;
>>  -	}
>>  +	strscpy(ctx->workstation_name, nodename,
>>  sizeof(ctx->workstation_name));
>>
>>     /*
>>    	 * does not have to be perfect mapping since field is
>>  @@ -1555,14 +1544,6 @@ int smb3_init_fs_context(struct fs_context *fc)
>>     fc->fs_private = ctx;
>>     fc->ops = &smb3_fs_context_ops;
>>     return 0;
>>  -
>>  -err_exit:
>>  -	if (ctx) {
>>  -		kfree(ctx->workstation_name);
>>  -		kfree(ctx);
>>  -	}
>>  -
>>  -	return rc;
>>    }
>>
>>    void
>>  @@ -1588,8 +1569,6 @@ smb3_cleanup_fs_context_contents(struct
>>  smb3_fs_context *ctx)
>>     ctx->source = NULL;
>>     kfree(ctx->domainname);
>>     ctx->domainname = NULL;
>>  -	kfree(ctx->workstation_name);
>>  -	ctx->workstation_name = NULL;
>>     kfree(ctx->nodename);
>>     ctx->nodename = NULL;
>>     kfree(ctx->iocharset);
>>  diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
>>  index e54090d9ef36..3a156c143925 100644
>>  --- a/fs/cifs/fs_context.h
>>  +++ b/fs/cifs/fs_context.h
>>  @@ -170,7 +170,7 @@ struct smb3_fs_context {
>>     char *server_hostname;
>>     char *UNC;
>>     char *nodename;
>>  -	char *workstation_name;
>>  +	char workstation_name[CIFS_MAX_WORKSTATION_LEN];
>>     char *iocharset;  /* local code page for mapping to and from Unicode */
>>     char source_rfc1001_name[RFC1001_NAME_LEN_WITH_NULL]; /* clnt nb name
>>     */
>>     char target_rfc1001_name[RFC1001_NAME_LEN_WITH_NULL]; /* srvr nb name
>>     */
>>  diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
>>  index afaf59c22193..114810e563a9 100644
>>  --- a/fs/cifs/misc.c
>>  +++ b/fs/cifs/misc.c
>>  @@ -95,7 +95,6 @@ sesInfoFree(struct cifs_ses *buf_to_free)
>>     kfree_sensitive(buf_to_free->password);
>>     kfree(buf_to_free->user_name);
>>     kfree(buf_to_free->domainName);
>>  -	kfree(buf_to_free->workstation_name);
>>     kfree_sensitive(buf_to_free->auth_key.response);
>>     kfree(buf_to_free->iface_list);
>>     kfree_sensitive(buf_to_free);
>>  diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
>>  index 32f478c7a66d..1a0995bb5d90 100644
>>  --- a/fs/cifs/sess.c
>>  +++ b/fs/cifs/sess.c
>>  @@ -714,9 +714,9 @@ static int size_of_ntlmssp_blob(struct cifs_ses *ses,
>>  int base_size)
>>     else
>>      sz += sizeof(__le16);
>>    -	if (ses->workstation_name)
>>  +	if (ses->workstation_name[0])
>>    		sz += sizeof(__le16) * strnlen(ses->workstation_name,
>>  -			CIFS_MAX_WORKSTATION_LEN);
>>  +
>>  ntlmssp_workstation_name_size(ses));
>>     else
>>      sz += sizeof(__le16);
>>    @@ -960,7 +960,7 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
>>
>>     cifs_security_buffer_from_str(&sec_blob->WorkstationName,
>>    				      ses->workstation_name,
>>  -				      CIFS_MAX_WORKSTATION_LEN,
>>  +				      ntlmssp_workstation_name_size(ses),
>>              *pbuffer, &tmp,
>>              nls_cp);
>> 
>
