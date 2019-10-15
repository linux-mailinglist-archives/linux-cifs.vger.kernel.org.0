Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00DDD7B5D
	for <lists+linux-cifs@lfdr.de>; Tue, 15 Oct 2019 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfJOQ1P (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 15 Oct 2019 12:27:15 -0400
Received: from mx.cjr.nz ([51.158.111.142]:42504 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfJOQ1O (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 15 Oct 2019 12:27:14 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id C6E15810C9;
        Tue, 15 Oct 2019 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1571156832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32l8W3VZ9NvYDUi4/azmSCHdBW4IkeS/BsQjBn3IEZY=;
        b=iYm5z5egAaUZs2rGLgOnZpW6c6UJbEff9WqSTSg4glbK0twFW4/KMdAkm2RokK2KdDzXYg
        waGGdOJVuT7EgUW+kcMdrP4aDuQN8TpQIUJ3AMUdcKS+1xGEj7yVJ+1Zgg4Y1nHFFVcBuO
        ozXkQ2ywmRJft5TeLcJJ684dBtDDU469eCt9kt5c4fmf88Wpj2xNSWSqJXfwtdl6UBcQU2
        7ki6j9nQ8ktlUyufnoxxt9zL4h09VBbbpy6BWrZ2tZeL0BtIm3qZ4fuOGxgNdjUh9DPqoh
        VUjevxm9OshAkJ7Jfsbl0kYxYJad955H6ZHHIaLBkrb7mPceCo80Z3lMY08VsA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>,
        Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
        linux-cifs@vger.kernel.org
Subject: Re: Kernel hangs in cifs_reconnect
In-Reply-To: <871rveaurv.fsf@suse.com>
References: <56d13db4-62ed-99c0-90b8-bb332143cece@prodrive-technologies.com>
 <871rveaurv.fsf@suse.com>
Date:   Tue, 15 Oct 2019 13:27:07 -0300
Message-ID: <87a7a2ynxg.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Aur=C3=A9lien Aptel <aaptel@suse.com> writes:

> Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com> writes:
>> Our Linux VMs reports call traces about processes being stuck.
>> I've attached the full dmesg of one of the call traces below.
>>
>> The machine is running kernel 5.3.1 SMP. All mounts are mounted via the
>> dfs shares on our domain controller and have the following options in fs=
tab:
>> nohandlecache,multiuser,sec=3Dkrb5,noperm,user=3Dxxxx,file_mode=3D0600,d=
ir_mode=3D0700,vers=3D3.0
>
> It looks like its DFS related. The DFS cache code takes the reconnect
> mutex and crashes with no chance to give back the mutex, making all
> other process hang while waiting for it.

Yeah, makes sense.

Martijn,

Could you please provide us with some debug logs with the following:

	# echo 'module cifs +p' > /sys/kernel/debug/dynamic_debug/control
	# echo 'file fs/cifs/* +p' > /sys/kernel/debug/dynamic_debug/control
	# echo 1 > /proc/fs/cifs/cifsFYI
	# echo 1 > /sys/module/dns_resolver/parameters/debug

Besides, if you could also enable KASAN, that would be great.

Thanks,
Paulo
