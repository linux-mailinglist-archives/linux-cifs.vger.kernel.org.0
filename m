Return-Path: <linux-cifs+bounces-9294-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B/UJm7liWnpDgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9294-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Feb 2026 14:47:26 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50910FDF2
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Feb 2026 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2E23006B6B
	for <lists+linux-cifs@lfdr.de>; Mon,  9 Feb 2026 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959F378838;
	Mon,  9 Feb 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4okE9gP"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF23093CF
	for <linux-cifs@vger.kernel.org>; Mon,  9 Feb 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644843; cv=none; b=oBGJew31TIKPhDfEgaqyFAq9lSvWpcGj6vmLmptGVHG2TLwgvmhyByKkV9WDeKIQhzjs1rf+NwGl/6I9AJJ2ZG99rymGJ/SAhizA3Z3fZZzMGVicsKEXjW8Ql0+pQPsw4DTEL1p++cuQOUKdfDDcaGlLDaX3fiw4nAdQwTsDCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644843; c=relaxed/simple;
	bh=2TSC0eCcAeKAZ/rLBUVEoTKkLpcpnibSGvMRXLg5ceo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ojr/jOLN6u/3//Neb5hbTRvBPzD99EYAFQYskh1NPlNGk/H/cocDixOGsVUciBxeVZ87+BzuRT0tOGzrr68B+WCujdQrrz6C7dnWvz0uKP87Nd0RO5ds2Fsi5ZS5umuGwxZT8DlfGVKc6ju2dV2B/2P1ben+8Zc17AYcw1SU1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4okE9gP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d248f263-362d-45a2-9390-ab2dd59263e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770644830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNXUIccVNXHwrDOZP6TiEUwf8s2xqnYTqC+yQHypkW8=;
	b=S4okE9gPVRxveNsOup9Yid6PEBs88dSrUencKKeh4ERnZBcWBrRxaXtKjp8hiYkMQO04oJ
	v5QTYa7t3IzDpArDgQzROu4VbG8ciQmmBzyxqFzt+8m8LVSxGdpXBuDed2Vpm2y6XoSBLJ
	aXWwMgx870OAFtylbCKi7jGqLXyWCr8=
Date: Mon, 9 Feb 2026 21:47:01 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [cifs:for-next 51/73] make[6]: *** No rule to make target
 'fs/smb/client/fs/smb/common/smb2status.h', needed by
 'fs/smb/client/smb2_mapping_table.c'.
To: kernel test robot <lkp@intel.com>, David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <stfrench@microsoft.com>,
 chenxiaosong@kylinos.cn
References: <202602071842.fYfRGNxU-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <202602071842.fYfRGNxU-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9294-lists,linux-cifs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,01.org:url,linux.dev:mid,linux.dev:dkim,intel.com:email]
X-Rspamd-Queue-Id: BE50910FDF2
X-Rspamd-Action: no action

It builds successfully on Fedora 43 (gcc 15.2.1), I will install a 
Debian tomorrow and try building with gcc 12.

mkdir build_dir
wget -O build_dir/.config 
https://download.01.org/0day-ci/archive/20260207/202602071842.fYfRGNxU-lkp@intel.com/config
make W=1 O=build_dir ARCH=i386 olddefconfig
make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2026/2/7 18:32, kernel test robot wrote:
> tree:   git://git.samba.org/sfrench/cifs-2.6.git for-next
> head:   7533749b93e943b80d9dc4c627f1193dbac6b5f3
> commit: 9fc8c17aa9cf5e4b50d35a14b65f7d5165bae966 [51/73] cifs: Autogenerate SMB2 error mapping table
> config: i386-randconfig-013-20260207 (https://download.01.org/0day-ci/archive/20260207/202602071842.fYfRGNxU-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602071842.fYfRGNxU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602071842.fYfRGNxU-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> make[6]: *** No rule to make target 'fs/smb/client/fs/smb/common/smb2status.h', needed by 'fs/smb/client/smb2_mapping_table.c'.
>     make[6]: Target 'fs/smb/client/' not remade because of errors.
> 

