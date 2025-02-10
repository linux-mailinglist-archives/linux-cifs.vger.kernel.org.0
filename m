Return-Path: <linux-cifs+bounces-4029-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA87A2FC88
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Feb 2025 22:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DF63A559D
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Feb 2025 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132EE24CEFB;
	Mon, 10 Feb 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f65VgwxR"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC624CEEF;
	Mon, 10 Feb 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739224476; cv=none; b=sPnALCgWLpLf24rIpkt8WzK0T3grDY3twj27QdR6aP997MPct58y3ovhPC80cJNTJqFd89HaCi/Y+ZIE3S7k/GV6kGeoOZK9mn+ndxOLRFCFN35HbiVgH5AcqmUClAYHSZNAk4Qgqvtw+hJVjsNxlpNbpGFcd3VWxV/LCeYKbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739224476; c=relaxed/simple;
	bh=AyQraTfsD0eAKJNbpAIj37781+CGfi6OdK1JVn5lhT4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CadWTTC3+lr9nEMMim8NeboHksDkhueuQPcysn5wMAXQrJaTFvdq02yVduDZwMrqrSJgooaye2qoBOxq5jU1prWPYWlUktkrnekOz8OoWA2+/dLsLTO+0t29exEPAt71HnhkXeh+RoW02y7hcTNgunCYHWYmYaK52pctITTWtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f65VgwxR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739224461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41Jhkvba1WFpStcLbcComfly4EhWKsI/5ZXXHmjcCPc=;
	b=f65VgwxRDwvtEdsu7NuNmtX7Cgk1A2R7ciEt77+LFeoEdkDCJpP46zQl/tiWsPH6GSyHXV
	3BH4gtWmgsJ/ZkYujW+eU7UhgmO9yYvbv9BNFhJxWx7L9V32PfS1aGM82g5GOAQqkBbJN7
	tc0lxdvFecc/O7MqyUewFbtWj8ltvmk=
Date: Mon, 10 Feb 2025 21:54:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <8d8a5d5b00688ea553b106db690e8a01f15b1410@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] netfs: Add retry stat counters
To: "David Howells" <dhowells@redhat.com>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>, "Steve
 French" <stfrench@microsoft.com>, "Eric Van Hensbergen"
 <ericvh@kernel.org>, "Latchesar  Ionkov" <lucho@ionkov.net>, "Dominique
 Martinet" <asmadeus@codewreck.org>, "Christian Schoenebeck"
 <linux_oss@crudebyte.com>, "Paulo Alcantara" <pc@manguebit.com>, "Jeff
 Layton" <jlayton@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, bpf@vger.kernel.org
In-Reply-To: <2986469.1739185956@warthog.procyon.org.uk>
References: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
 <3173328.1738024385@warthog.procyon.org.uk>
 <3187377.1738056789@warthog.procyon.org.uk>
 <2986469.1739185956@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On 2/10/25 2:57 AM, David Howells wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
>> I recommend trying to reproduce with steps I shared in my initial repo=
rt:
>> https://lore.kernel.org/bpf/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwD=
AhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.m=
e/
>>
>> I know it may not be very convenient due to all the CI stuff,
>
> That's an understatement. :-)
>
>> but you should be able to use it to iterate on the kernel source local=
ly and
>> narrow down the problem.
>
> Can you share just the reproducer without all the docker stuff?=20=20

I=20wrote a couple of shell scripts with a gist of what's happening on
CI: build kernel, build selftests and run. You may try them.

Pull this branch from my github:
https://github.com/theihor/bpf/tree/netfs-debug

It's the kernel source in a broken state with the scripts.
Inlining the scripts here:

## ./reproducer.sh

#!/bin/bash

set -euo pipefail

export KBUILD_OUTPUT=3D$(realpath kbuild-output)
mkdir -p $KBUILD_OUTPUT

cp -f repro.config $KBUILD_OUTPUT/.config
make olddefconfig
make -j$(nproc) all
make -j$(nproc) headers

# apt install lsb-release wget software-properties-common gnupg
# bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
export LLVM_VERSION=3D18

make -C tools/testing/selftests/bpf \
     CLANG=3Dclang-${LLVM_VERSION} \
     LLC=3Dllc-${LLVM_VERSION} \
     LLVM_STRIP=3Dllvm-strip-${LLVM_VERSION} \
     -j$(nproc) test_progs-no_alu32

# wget https://github.com/danobi/vmtest/releases/download/v0.15.0/vmtest-=
x86_64
# chmod +x vmtest-x86_64
./vmtest-x86_64 -k $KBUILD_OUTPUT/$(make -s image_name) ./run-bpf-selftes=
ts.sh | tee test.log

## end of ./reproducer.sh

## ./run-bpf-selftests.sh

#!/bin/bash

/bin/mount bpffs /sys/fs/bpf -t bpf
ip link set lo up

echo 10 > /proc/sys/kernel/hung_task_timeout_secs
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write_iter/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq_ref/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq_ref/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable

function tail_proc {
    src=3D$1
    dst=3D$2
    echo -n > $dst
    while true; do
        echo >> $dst
        cat $src >> $dst
        sleep 1
    done
}
export -f tail_proc

nohup bash -c 'tail_proc /proc/fs/netfs/stats netfs-stats.log' & disown
nohup bash -c 'tail_proc /proc/fs/netfs/requests netfs-requests.log' & di=
sown
nohup bash -c 'trace-cmd show -p > trace-cmd.log' & disown

cd tools/testing/selftests/bpf
./test_progs-no_alu32

## end of ./run-bpf-selftests.sh

One of the reasons for suggesting docker is that all the dependencies
are pre-packaged in the image, and so the environment is pretty close
to the actual CI environment. With only shell scripts you will have to
detect and install missing dependencies on your system and hope
package versions are more or less the same and don't affect the issue.

Notable things: LLVM 18, pahole, qemu, qemu-guest-agent, vmtest tool.

> Is this one
> of those tests that requires 9p over virtio?  I have a different enviro=
nment
> for that.

We run the tests via vmtest tool: https://github.com/danobi/vmtest
This is essentially a qemu wrapper.

I am not familiar with its internals, but for sure it is using 9p.


On 2/10/25 3:12 AM, David Howells wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
>> Bash piece starting a process collecting /proc/fs/netfs/stats:
>>
>>     function tail_netfs {
>>         echo -n > /mnt/vmtest/netfs-stats.log
>>         while true; do
>>             echo >> /mnt/vmtest/netfs-stats.log
>>             cat /proc/fs/netfs/stats >> /mnt/vmtest/netfs-stats.log
>>             sleep 1
>>         done
>>     }
>>     export -f tail_netfs
>>     nohup bash -c 'tail_netfs' & disown
>
> I'm afraid, intermediate snapshots of this file aren't particularly use=
ful -
> just the last snapshot:

The reason I wrote it like this is because the test runner hangs, and
so I have to kill qemu to stop it (with no ability to run
post-processing within qemu instance; well, at least I don't know how
to do it).

>
> [...]
>
> Could you collect some tracing:
>
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write_iter/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq_ref/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq_ref/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable
>
> and then collect the tracelog:
>
> trace-cmd show | bzip2 >some_file_somewhere.bz2
>
> And if you could collect /proc/fs/netfs/requests as well, that will sho=
w the
> debug IDs of the hanging requests.  These can be used to grep the trace=
 by
> prepending "R=3D".  For example, if you see:
>
> 	REQUEST  OR REF FL ERR  OPS COVERAGE
> 	=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	00000043 WB   1 2120    0   0 @34000000 0/0
>
> then:
>
> 	trace-cmd show | grep R=3D00000043

Done. I pushed the logs to the previously mentioned github branch:
https://github.com/kernel-patches/bpf/commit/699a3bb95e2291d877737438fb64=
1628702fd18f

Let me know if I can help with anything else.

>
> Thanks,
> David
>

