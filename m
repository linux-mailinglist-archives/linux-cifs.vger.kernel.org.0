Return-Path: <linux-cifs+bounces-2155-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211959025B0
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Jun 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26DC1F279AB
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Jun 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49F13C819;
	Mon, 10 Jun 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8EnKlYB"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7663142E62
	for <linux-cifs@vger.kernel.org>; Mon, 10 Jun 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033460; cv=none; b=sarNzoffnRf6A9Ub5Ey9UyKTDRR16G4QBvsohjeEVUEls2wXEhVkJacLyQXNWv4ITZptzl6Hu/f0tNI4WLAEMFCICwg0KNksSYK8EJwlAWNNpm6aYCYnd9zsqwIWGz/Q0vaWXHDvXQpHWaXEczqPW23gxiByecga4yhECQ5vnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033460; c=relaxed/simple;
	bh=yjECLl1FgXCMba3JnGjcAmt82Oh1bxRIlCgKMX4yLNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaQrAUJTRjVS/0igP/KPulvy4Op6kidBn5nJAvwR6WEryiwCRe08Q86awcfwlNLfil5edy5tUwEG5pLa4JrkXDSt8d2a88wSDp7zgWqwLGVBGtdoNsTO9IuZR3MXO5Uncj3bChOvicODeLKMIB5XA6qCefuovqSnJxB0sMwL53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8EnKlYB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5295eb47b48so5336946e87.1
        for <linux-cifs@vger.kernel.org>; Mon, 10 Jun 2024 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718033457; x=1718638257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH18BJmYnDFjdU11yNijKpNf1f9t4pI1Gv91O6NkAd0=;
        b=a8EnKlYB2I2CXmd36iqJ+xYqS20Mg+oY6rbnwJV4qjOAX4WYbmdpBZfabEynBWJBdV
         l3ncF7o5WtnAXFbknsx5BRPByEZP+rZOubQvq8lT2pP5OuEDrlRhMNVzvb8+tlQQ0kNB
         38UJIN2v+JKyc74emKOXPlcPPVfHk8oVZRHzsSXGkyyM2rUpd719XCdR2Okx113xN9A9
         8/qO9CXh2UrrJNIooR4uy/NB+AwkbEaU3fBKf/pnya3FFCd3ULvMf6Qlvk4ZeI+7vWho
         iWXRgCQ4C2SuJGNDMKrGfkGgzxnS1VE4OTGKD/uqd3ATpXnTs+pqnRKaE3qr1KqDk2YQ
         6ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033457; x=1718638257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH18BJmYnDFjdU11yNijKpNf1f9t4pI1Gv91O6NkAd0=;
        b=bc12HRconWafnX6hLC+HEOYOWoFx7CjEYEBbKIE9F1JNT1fpQtxzLbLG47yETuhF06
         7swoRdbUE2vbsGZzbpOAQRdRcE3ZNqYW5QPXTvg1NiWRpok5KI+0IJW02/g458l6Qv/D
         5o0ER6orhLADlecy57oTr2K/qA3k1F+E6iwVi5nRmaNoFUwztV4dodEXYQBYqKxhuZ/R
         8sh70qla4NnZ1kEo1zdqX8b1cEqIVOmpZ1oj0/LEZ2rEVMKHoBBsqa2s3o3e7qmqebyp
         VAJM4mvIfoanfTK13ENJP3n0aiI0Dx3/mb5GUFH1dkpxhCez3FnggyWfdGwJVkFdHLcj
         Ca2w==
X-Gm-Message-State: AOJu0YxN6pCBjUglDP+5/QjCIDymDyjNUgTjzN+FOlevwud943GCmlwJ
	kUBblG3aYG9bNGwYkbFDb35lwRoaBHSeYEUZiemmKoCjR4ICGUewVfp4CHhH10HN2IUovb+Buz/
	/TY/eYRDD/CBBmyFq/4D8h16Uafo=
X-Google-Smtp-Source: AGHT+IGJxB2EcfvJDUr65D+bsVPqYIEolyb1AXBVu6U1zUf2sA0mjDiNeSbIMLFxqaxvT/uBkyIkVV3hAm3BjSmG4oE=
X-Received: by 2002:a05:6512:3ca1:b0:52c:859f:9f77 with SMTP id
 2adb3069b0e04-52c859fa036mr2912752e87.19.1718033456504; Mon, 10 Jun 2024
 08:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610141416.8039-1-linkinjeon@kernel.org> <20240610141416.8039-2-linkinjeon@kernel.org>
In-Reply-To: <20240610141416.8039-2-linkinjeon@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 10 Jun 2024 10:30:45 -0500
Message-ID: <CAH2r5mu_Lyw=jTUegNHAQwqFhAz1=5RmPfdTrVVviFOAQzWYsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ksmbd: add durable scavenger timer
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, senozhatsky@chromium.org, tom@talpey.com, 
	atteh.mailbox@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor compile warning was generated by this:

/home/smfrench/smb3-kernel/fs/smb/server/vfs_cache.c:39:19: warning:
symbol 'dh_task' was not declared. Should it be static?
/home/smfrench/smb3-kernel/fs/smb/server/vfs_cache.c:40:19: warning:
symbol 'dh_wq' was not declared. Should it be static?

On Mon, Jun 10, 2024 at 9:14=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> Launch ksmbd-durable-scavenger kernel thread to scan durable fps that
> have not been reclaimed by a client within the configured time.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/smb/server/mgmt/user_session.c |   2 +
>  fs/smb/server/server.c            |   1 +
>  fs/smb/server/server.h            |   1 +
>  fs/smb/server/smb2pdu.c           |   2 +-
>  fs/smb/server/smb2pdu.h           |   2 +
>  fs/smb/server/vfs_cache.c         | 165 +++++++++++++++++++++++++++++-
>  fs/smb/server/vfs_cache.h         |   2 +
>  7 files changed, 169 insertions(+), 6 deletions(-)
>
> diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_=
session.c
> index aec0a7a12405..162a12685d2c 100644
> --- a/fs/smb/server/mgmt/user_session.c
> +++ b/fs/smb/server/mgmt/user_session.c
> @@ -149,6 +149,7 @@ void ksmbd_session_destroy(struct ksmbd_session *sess=
)
>
>         ksmbd_tree_conn_session_logoff(sess);
>         ksmbd_destroy_file_table(&sess->file_table);
> +       ksmbd_launch_ksmbd_durable_scavenger();
>         ksmbd_session_rpc_clear_list(sess);
>         free_channel_list(sess);
>         kfree(sess->Preauth_HashValue);
> @@ -326,6 +327,7 @@ void destroy_previous_session(struct ksmbd_conn *conn=
,
>
>         ksmbd_destroy_file_table(&prev_sess->file_table);
>         prev_sess->state =3D SMB2_SESSION_EXPIRED;
> +       ksmbd_launch_ksmbd_durable_scavenger();
>  out:
>         up_write(&conn->session_lock);
>         up_write(&sessions_table_lock);
> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> index c67fbc8d6683..4d24cc105ef6 100644
> --- a/fs/smb/server/server.c
> +++ b/fs/smb/server/server.c
> @@ -377,6 +377,7 @@ static void server_ctrl_handle_reset(struct server_ct=
rl_struct *ctrl)
>  {
>         ksmbd_ipc_soft_reset();
>         ksmbd_conn_transport_destroy();
> +       ksmbd_stop_durable_scavenger();
>         server_conf_free();
>         server_conf_init();
>         WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
> diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
> index db7278181760..4fc529335271 100644
> --- a/fs/smb/server/server.h
> +++ b/fs/smb/server/server.h
> @@ -44,6 +44,7 @@ struct ksmbd_server_config {
>         unsigned int            max_connections;
>
>         char                    *conf[SERVER_CONF_WORK_GROUP + 1];
> +       struct task_struct      *dh_task;
>  };
>
>  extern struct ksmbd_server_config server_conf;
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index b6c5a8ea3887..4fb5070d3dc5 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -3519,7 +3519,7 @@ int smb2_open(struct ksmbd_work *work)
>                                         SMB2_CREATE_GUID_SIZE);
>                         if (dh_info.timeout)
>                                 fp->durable_timeout =3D min(dh_info.timeo=
ut,
> -                                               300000);
> +                                               DURABLE_HANDLE_MAX_TIMEOU=
T);
>                         else
>                                 fp->durable_timeout =3D 60;
>                 }
> diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
> index 643f5e1cfe35..3be7d5ae65a8 100644
> --- a/fs/smb/server/smb2pdu.h
> +++ b/fs/smb/server/smb2pdu.h
> @@ -72,6 +72,8 @@ struct create_durable_req_v2 {
>         __u8 CreateGuid[16];
>  } __packed;
>
> +#define DURABLE_HANDLE_MAX_TIMEOUT     300000
> +
>  struct create_durable_reconn_req {
>         struct create_context_hdr ccontext;
>         __u8   Name[8];
> diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
> index a6804545db28..882a87f9e3ab 100644
> --- a/fs/smb/server/vfs_cache.c
> +++ b/fs/smb/server/vfs_cache.c
> @@ -8,6 +8,8 @@
>  #include <linux/filelock.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
>
>  #include "glob.h"
>  #include "vfs_cache.h"
> @@ -17,6 +19,7 @@
>  #include "mgmt/tree_connect.h"
>  #include "mgmt/user_session.h"
>  #include "smb_common.h"
> +#include "server.h"
>
>  #define S_DEL_PENDING                  1
>  #define S_DEL_ON_CLS                   2
> @@ -31,6 +34,11 @@ static struct ksmbd_file_table global_ft;
>  static atomic_long_t fd_limit;
>  static struct kmem_cache *filp_cache;
>
> +static bool durable_scavenger_running;
> +static DEFINE_MUTEX(durable_scavenger_lock);
> +struct task_struc *dh_task;
> +wait_queue_head_t dh_wq;
> +
>  void ksmbd_set_fd_limit(unsigned long limit)
>  {
>         limit =3D min(limit, get_max_files());
> @@ -279,9 +287,16 @@ static void __ksmbd_remove_durable_fd(struct ksmbd_f=
ile *fp)
>         if (!has_file_id(fp->persistent_id))
>                 return;
>
> -       write_lock(&global_ft.lock);
>         idr_remove(global_ft.idr, fp->persistent_id);
> +}
> +
> +static void ksmbd_remove_durable_fd(struct ksmbd_file *fp)
> +{
> +       write_lock(&global_ft.lock);
> +       __ksmbd_remove_durable_fd(fp);
>         write_unlock(&global_ft.lock);
> +       if (waitqueue_active(&dh_wq))
> +               wake_up(&dh_wq);
>  }
>
>  static void __ksmbd_remove_fd(struct ksmbd_file_table *ft, struct ksmbd_=
file *fp)
> @@ -304,7 +319,7 @@ static void __ksmbd_close_fd(struct ksmbd_file_table =
*ft, struct ksmbd_file *fp)
>         struct ksmbd_lock *smb_lock, *tmp_lock;
>
>         fd_limit_close();
> -       __ksmbd_remove_durable_fd(fp);
> +       ksmbd_remove_durable_fd(fp);
>         if (ft)
>                 __ksmbd_remove_fd(ft, fp);
>
> @@ -696,6 +711,142 @@ static bool tree_conn_fd_check(struct ksmbd_tree_co=
nnect *tcon,
>         return fp->tcon !=3D tcon;
>  }
>
> +static bool ksmbd_durable_scavenger_alive(void)
> +{
> +       mutex_lock(&durable_scavenger_lock);
> +       if (!durable_scavenger_running) {
> +               mutex_unlock(&durable_scavenger_lock);
> +               return false;
> +       }
> +       mutex_unlock(&durable_scavenger_lock);
> +
> +       if (kthread_should_stop())
> +               return false;
> +
> +       if (idr_is_empty(global_ft.idr))
> +               return false;
> +
> +       return true;
> +}
> +
> +static void ksmbd_scavenger_dispose_dh(struct list_head *head)
> +{
> +       while (!list_empty(head)) {
> +               struct ksmbd_file *fp;
> +
> +               fp =3D list_first_entry(head, struct ksmbd_file, node);
> +               list_del_init(&fp->node);
> +               __ksmbd_close_fd(NULL, fp);
> +       }
> +}
> +
> +static int ksmbd_durable_scavenger(void *dummy)
> +{
> +       struct ksmbd_file *fp =3D NULL;
> +       unsigned int id;
> +       unsigned int min_timeout =3D 1;
> +       bool found_fp_timeout;
> +       LIST_HEAD(scavenger_list);
> +       unsigned long remaining_jiffies;
> +
> +       __module_get(THIS_MODULE);
> +
> +       set_freezable();
> +       while (ksmbd_durable_scavenger_alive()) {
> +               if (try_to_freeze())
> +                       continue;
> +
> +               found_fp_timeout =3D false;
> +
> +               remaining_jiffies =3D wait_event_timeout(dh_wq,
> +                                  ksmbd_durable_scavenger_alive() =3D=3D=
 false,
> +                                  __msecs_to_jiffies(min_timeout));
> +               if (remaining_jiffies)
> +                       min_timeout =3D jiffies_to_msecs(remaining_jiffie=
s);
> +               else
> +                       min_timeout =3D DURABLE_HANDLE_MAX_TIMEOUT;
> +
> +               write_lock(&global_ft.lock);
> +               idr_for_each_entry(global_ft.idr, fp, id) {
> +                       if (!fp->durable_timeout)
> +                               continue;
> +
> +                       if (atomic_read(&fp->refcount) > 1 ||
> +                           fp->conn)
> +                               continue;
> +
> +                       found_fp_timeout =3D true;
> +                       if (fp->durable_scavenger_timeout <=3D
> +                           jiffies_to_msecs(jiffies)) {
> +                               __ksmbd_remove_durable_fd(fp);
> +                               list_add(&fp->node, &scavenger_list);
> +                       } else {
> +                               unsigned long durable_timeout;
> +
> +                               durable_timeout =3D
> +                                       fp->durable_scavenger_timeout -
> +                                               jiffies_to_msecs(jiffies)=
;
> +
> +                               if (min_timeout > durable_timeout)
> +                                       min_timeout =3D durable_timeout;
> +                       }
> +               }
> +               write_unlock(&global_ft.lock);
> +
> +               ksmbd_scavenger_dispose_dh(&scavenger_list);
> +
> +               if (found_fp_timeout =3D=3D false)
> +                       break;
> +       }
> +
> +       mutex_lock(&durable_scavenger_lock);
> +       durable_scavenger_running =3D false;
> +       mutex_unlock(&durable_scavenger_lock);
> +
> +       module_put(THIS_MODULE);
> +
> +       return 0;
> +}
> +
> +void ksmbd_launch_ksmbd_durable_scavenger(void)
> +{
> +       if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE))
> +               return;
> +
> +       mutex_lock(&durable_scavenger_lock);
> +       if (durable_scavenger_running =3D=3D true) {
> +               mutex_unlock(&durable_scavenger_lock);
> +               return;
> +       }
> +
> +       durable_scavenger_running =3D true;
> +
> +       server_conf.dh_task =3D kthread_run(ksmbd_durable_scavenger,
> +                                    (void *)NULL, "ksmbd-durable-scaveng=
er");
> +       if (IS_ERR(server_conf.dh_task))
> +               pr_err("cannot start conn thread, err : %ld\n",
> +                      PTR_ERR(server_conf.dh_task));
> +       mutex_unlock(&durable_scavenger_lock);
> +}
> +
> +void ksmbd_stop_durable_scavenger(void)
> +{
> +       if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE))
> +               return;
> +
> +       mutex_lock(&durable_scavenger_lock);
> +       if (!durable_scavenger_running) {
> +               mutex_unlock(&durable_scavenger_lock);
> +               return;
> +       }
> +
> +       durable_scavenger_running =3D false;
> +       if (waitqueue_active(&dh_wq))
> +               wake_up(&dh_wq);
> +       mutex_unlock(&durable_scavenger_lock);
> +       kthread_stop(server_conf.dh_task);
> +}
> +
>  static bool session_fd_check(struct ksmbd_tree_connect *tcon,
>                              struct ksmbd_file *fp)
>  {
> @@ -756,11 +907,12 @@ void ksmbd_free_global_file_table(void)
>         unsigned int            id;
>
>         idr_for_each_entry(global_ft.idr, fp, id) {
> -               __ksmbd_remove_durable_fd(fp);
> -               kmem_cache_free(filp_cache, fp);
> +               ksmbd_remove_durable_fd(fp);
> +               __ksmbd_close_fd(NULL, fp);
>         }
>
> -       ksmbd_destroy_file_table(&global_ft);
> +       idr_destroy(global_ft.idr);
> +       kfree(global_ft.idr);
>  }
>
>  int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
> @@ -816,6 +968,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, =
struct ksmbd_file *fp)
>         }
>         up_write(&ci->m_lock);
>
> +       fp->f_state =3D FP_NEW;
>         __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
>         if (!has_file_id(fp->volatile_id)) {
>                 fp->conn =3D NULL;
> @@ -855,6 +1008,8 @@ int ksmbd_init_file_cache(void)
>         if (!filp_cache)
>                 goto out;
>
> +       init_waitqueue_head(&dh_wq);
> +
>         return 0;
>
>  out:
> diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
> index f2ab1514e81a..b0f6d0f94cb8 100644
> --- a/fs/smb/server/vfs_cache.h
> +++ b/fs/smb/server/vfs_cache.h
> @@ -153,6 +153,8 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)=
;
>  struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
>  unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
>  struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *f=
ilp);
> +void ksmbd_launch_ksmbd_durable_scavenger(void);
> +void ksmbd_stop_durable_scavenger(void);
>  void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
>  void ksmbd_close_session_fds(struct ksmbd_work *work);
>  int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
> --
> 2.25.1
>


--=20
Thanks,

Steve

