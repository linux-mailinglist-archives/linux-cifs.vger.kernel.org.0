Return-Path: <linux-cifs+bounces-5459-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A81B1A0E1
	for <lists+linux-cifs@lfdr.de>; Mon,  4 Aug 2025 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D1F188D8BC
	for <lists+linux-cifs@lfdr.de>; Mon,  4 Aug 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E01DF248;
	Mon,  4 Aug 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="oZmJAtWm"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BC15DBC1
	for <linux-cifs@vger.kernel.org>; Mon,  4 Aug 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309488; cv=none; b=c3Gql1VjoaaAPV6SPgkzjjuOIM0YYEjcKekQi81ooOaEzkZk0be1wnwWfAffkOEhM71kpKxjDyEY4OzSfMhgTc6Q39ekJaSusvpMxOdwQZSEiW2vsFHIKXvgvsD5SeP53fC4NNR/MWhVDk4OL4rVKvhT29KJ5ZeiTl4OdnySM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309488; c=relaxed/simple;
	bh=VaACKXXFb3thUWwAtwzqv6DyARGfJAftMSePibk8sY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4OsZI7QX7FDDDTNt4FymjOTfl8AGPOPdt4BTyiAZSrCDa46ykGprn/5OXPftPbt8V5YJ3DJuv//B/bH1jrYviDcLWg1NayRh8GO9fXi6WqOajjrer2k1M0wos/GdocnG7zctzLyXClLOPIvXGp79IBZ8BlCXI6aaD21pqw/y5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=oZmJAtWm; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=CS61DGPj97lQRncfj/Xbj3wUZQbd2n896SaL3fO1Uo4=; b=oZmJAtWmE0hQVucr3RPXsqID61
	yL+4ADJQNl6Nx1yZI/I+grmCS+Lhm+7o2Q1uVkrq1zEqHfNySeAkHBAjPX7RwUBp2NZrA05cOfOLI
	j5OfSMzyGOIN9EPf1Q3AMRjZpWv6X03bV/jidOZc/c1mecM8k8NFODmb79fPALNETgpHhiQ8gfSrq
	iTWbHQMH/z+flB1rRRCOZ4fSQxe3DThe8S2cHuWE51ZrZOFxR0mq8oCftPe4OUuSmUlDapcePwdt5
	+NoGsmwlkdTsCA0bOcvSqy8MDlrCmV/+2Kg9lSybJT63nRYsZq7iVCdxU75Pg3mJaVlgGRg2NMzC+
	LvjGw+TLerGM7XKGxaPywt0et0PvW/xt8awhYYcAs6Rudu6DS2aWYv5KkV8wGAJZdDmPimCNO5F/Z
	rJYQcNMK4kZqke3GrDwnKNz28fPfqEdzklGSo7IK/8wiFT90dtxBpdrS/BhbkohfWDe5a3vweCXrm
	Ph76SNPwMtEeRCkEF9rGPnb9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uiu2A-000vtZ-0S;
	Mon, 04 Aug 2025 12:11:18 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH 0/5] smb:client: fix possible use after free problems
Date: Mon,  4 Aug 2025 14:10:11 +0200
Message-ID: <cover.1754308712.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While refactoring the client and server smbdirect code I
noticed a few problems where we might hit use after free
style problems.

In order to allow backports I decided to fix the problems
before trying to move things to common code.

The server has similar problems, I'll send a separate
patchset for the server as they are independed.

Stefan Metzmacher (5):
  smb: client: let send_done() cleanup before calling
    smbd_disconnect_rdma_connection()
  smb: client: remove separate empty_packet_queue
  smb: client: make sure we call ib_dma_unmap_single() only if we called
    ib_dma_map_single already
  smb: client: let recv_done() cleanup before notifying the callers.
  smb: client: let recv_done() avoid touching data_transfer after
    cleanup/move

 fs/smb/client/cifs_debug.c |   6 +-
 fs/smb/client/smbdirect.c  | 124 ++++++++++++-------------------------
 fs/smb/client/smbdirect.h  |   4 --
 3 files changed, 42 insertions(+), 92 deletions(-)

-- 
2.43.0


