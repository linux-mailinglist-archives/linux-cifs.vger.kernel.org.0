Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F46177675
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Mar 2020 13:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgCCMz5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Mar 2020 07:55:57 -0500
Received: from mx.cjr.nz ([51.158.111.142]:7656 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCCMz5 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 3 Mar 2020 07:55:57 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id E75CD80A40;
        Tue,  3 Mar 2020 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1583240154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ki8ZhYynCr+9J9Gt88iyGTdbQim6U89NvBNnLukA8Sc=;
        b=Yy8nTv0RKguK8QqmPjrYRtJPPLbS2IxEKuEt4SpfdhFMeDDn8MacOg0LnTOLCV+DRUK80N
        Rq82kiuYcaeQ0kWukhlWjzlNaoqm0VEPTO7JrIhXeflm9fpRPoqLhoWBA2loL7oaAS6eWp
        3qwbUTP6YZrjZYkslQhSB78cqdRQGHDHB702GjRFRpQ2pys/O0OjLfhKM2mT/6J38caWhv
        EvylnNqGel4dHBHqjLSdNb7WNMYRGcATuJ5PdhKFfHzmevybGhZg5Uw1q+PFr+cTUH8YrD
        3YUYlXxYhu4NhtyxOjXqmZxHKhrPXYuTvjoHGH4/mpOg0RTWP1lrVIgaqkbvSQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Aurelien Aptel <aaptel@suse.com>, linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: Re: [PATCH] cifs: add SMB2_open() arg to return POSIX data
In-Reply-To: <20200302165322.7380-1-aaptel@suse.com>
References: <20200302165322.7380-1-aaptel@suse.com>
Date:   Tue, 03 Mar 2020 09:55:50 -0300
Message-ID: <87zhcx4my1.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Aurelien Aptel <aaptel@suse.com> writes:

> allows SMB2_open() callers to pass down a POSIX data buffer that will
> trigger requesting POSIX create context and parsing the response into
> the provided buffer.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  fs/cifs/link.c      |  4 ++--
>  fs/cifs/smb2file.c  |  2 +-
>  fs/cifs/smb2ops.c   | 23 ++++++++++++++--------
>  fs/cifs/smb2pdu.c   | 55 +++++++++++++++++++++++++++++++++++++----------------
>  fs/cifs/smb2pdu.h   | 12 +++++-------
>  fs/cifs/smb2proto.h |  5 ++++-
>  6 files changed, 66 insertions(+), 35 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
