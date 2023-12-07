Return-Path: <linux-cifs+bounces-303-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAD808FED
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 19:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2B31F21159
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CF44C94;
	Thu,  7 Dec 2023 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="NmJyB0Kh"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244D1709
	for <linux-cifs@vger.kernel.org>; Thu,  7 Dec 2023 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=U54oUgBdDBv69Iy6UYcPDEqi69VKSUFJNJev/TzXD7M=; b=NmJyB0KhZxJAKM0BxFF2BO/X72
	7Ikeyj+sfNULuzhvGSpUqqDizz3AR3Q9FyhTBQZ3XIGO6TApoddLwLU1yqz2fn7arRWHbAbFB7Pjy
	NhqAMkY04RSNVQC6BGf6nphXgEA7jboTEL5SzXDCrtapYs+HTZcOqYfNRI/viY0/Bn5zIBo3hLzWA
	G5Dd0OfBd7z5j0pSKus6evFpm3KeWUvTsHoGhq5nxgLqCcS2K7cyyCqw5CBUwO5vLLHZzmo/rFAwW
	TlbdVCNxiW/irTH8mV/tLtdLhioK6wF/n9FReweKHo+6RfpnCIfoa1MnfBMyUhF9eARYJoIlTUjPu
	cnEyvZLNRgDqyXetLQGLXkQeIBacrs07oQNJPQM7yhaKV4pNw7emA+4+t3WWej/nqdkzvo35nIgBC
	bTrT6ac2/dt1sbNdAqfPF8v7bHiWGyFf32WHFmQvUioaji+8RYUtYyt+E0iOLvQHZG0g51/fx/6ms
	NDwo+M3wvUu5K7G5vZY64fRE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rBJAm-002R73-0W;
	Thu, 07 Dec 2023 18:32:33 +0000
Date: Thu, 7 Dec 2023 10:32:27 -0800
From: Jeremy Allison <jra@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
	ronniesahlberg@gmail.com, Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>, jlayton@kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: Can fallocate() ops be emulated better using SMB request
 compounding?
Message-ID: <ZXIPuwnUNycH+ZuI@jeremy-HP-Z840-Workstation>
Reply-To: Jeremy Allison <jra@samba.org>
References: <ZXIDgvZ8/iBhYXwy@jeremy-HP-Z840-Workstation>
 <700923.1701964726@warthog.procyon.org.uk>
 <1215461.1701971450@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1215461.1701971450@warthog.procyon.org.uk>

On Thu, Dec 07, 2023 at 05:50:50PM +0000, David Howells wrote:
>Jeremy Allison <jra@samba.org> wrote:
>
>> >Further, are the two ops then essentially done atomically?
>>
>> No. They are processed (at least in Samba) as two separate
>> requests and can be raced by local or other remote access.
>
>So just compounding them would leave us in the same situation we are in now -
>which would be fine.
>
>What do you think about the idea of having the server see a specifically
>arranged compounded pair and turn them into an op that can't otherwise be
>represented in the protocol?

Complex, ugly code. How long does the server wait
for the second operation before proceeding with
the first ?

>Or is it better to try and get the protocol extended?

If this is a Linux -> Linux op, we have a protocol
space (the SMB3+POSIX) we can extend without having
to go via Microsoft. But this would need to be very carefully designed.

