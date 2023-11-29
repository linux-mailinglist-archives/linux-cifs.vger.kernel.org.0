Return-Path: <linux-cifs+bounces-209-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C77FCD84
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Nov 2023 04:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE2F1C20ACF
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Nov 2023 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE42F4A;
	Wed, 29 Nov 2023 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-cifs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307221AD;
	Tue, 28 Nov 2023 19:32:00 -0800 (PST)
X-UUID: e55f3d86a61743f49a2c513ff5a2c083-20231129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:51b088d5-7b57-494f-9d68-1c6afe0d940c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.33,REQID:51b088d5-7b57-494f-9d68-1c6afe0d940c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:12679960-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:2311291131566H9M43EO,BulkQuantity:0,Recheck:0,SF:44|64|66|38|24|17|1
	9|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: e55f3d86a61743f49a2c513ff5a2c083-20231129
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <zhouzongmin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 816927675; Wed, 29 Nov 2023 11:31:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1B55EE0080FF;
	Wed, 29 Nov 2023 11:31:53 +0800 (CST)
X-ns-mid: postfix-6566B0A9-53082935
Received: from [172.20.12.156] (unknown [172.20.12.156])
	by mail.kylinos.cn (NSMail) with ESMTPA id E0382E0080FF;
	Wed, 29 Nov 2023 11:31:47 +0800 (CST)
Message-ID: <328ad7a1-7c54-4028-ae79-eb25c8c7399b@kylinos.cn>
Date: Wed, 29 Nov 2023 11:31:47 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksmbd: initialize ar to NULL
Content-Language: en-US
To: linkinjeon@kernel.org, sfrench@samba.org
Cc: senozhatsky@chromium.org, tom@talpey.com, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231120023950.667246-1-zhouzongmin@kylinos.cn>
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
In-Reply-To: <20231120023950.667246-1-zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Friendly ping. I think this patch was forgotten.

Best regards!

On 2023/11/20 10:39, Zongmin Zhou wrote:
> Initialize ar to NULL to avoid the case of aux_size will be false,
> and kfree(ar) without ar been initialized will be unsafe.
> But kfree(NULL) is safe.
>
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>   fs/smb/server/ksmbd_work.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
> index 44bce4c56daf..2510b9f3c8c1 100644
> --- a/fs/smb/server/ksmbd_work.c
> +++ b/fs/smb/server/ksmbd_work.c
> @@ -106,7 +106,7 @@ static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
>   static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
>   			       void *aux_buf, unsigned int aux_size)
>   {
> -	struct aux_read *ar;
> +	struct aux_read *ar = NULL;
>   	int need_iov_cnt = 1;
>   
>   	if (aux_size) {

