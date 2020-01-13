Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAF139B45
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Jan 2020 22:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAMVNs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Jan 2020 16:13:48 -0500
Received: from mx.cjr.nz ([51.158.111.142]:34680 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgAMVNs (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 13 Jan 2020 16:13:48 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id EF640808C9;
        Mon, 13 Jan 2020 21:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1578950027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqQ9mHMLxJWJpjOzUL7tiqB08ArhMl1nMPucjbfz7T0=;
        b=S4DKUaUo6P8OOHlv1Q8PGH2yQVyeqx+ODOM0zTyBOKFL87EovZHXEpQzKHuMYcbI7uGiaa
        AdeIZUEi4uXaLAOIk0HYP7GICtP76rCTJbyw2+SI2NkiduEzeEk8kYQszRk7FYMrdOox5E
        WHPii7qYr9RxnfXWSM+qFJgUTlxmLLXrQIIRKvgHuxT/QxWrapXd6/HTEAQYjFTUaocIsc
        IxUSf80cjY+08gSO3kiOgdwaiaE/k6xc2sPVp6h3nJRsrr42Y8icz67r15XQlJrItkFmlO
        sj58eej02qQYZARCDLYS8l3E4GY9+a1coJe2EGGlos7N2pffkEkhjZdEsiW03g==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] cifs: Fix memory allocation in
 __smb2_handle_cancelled_cmd()
In-Reply-To: <CAKywueSnatSmp-=w1J7Jf=9dab70SjV8JgfFoys37-sgGqOD_Q@mail.gmail.com>
References: <20200113204659.4867-1-pc@cjr.nz>
 <CAKywueSnatSmp-=w1J7Jf=9dab70SjV8JgfFoys37-sgGqOD_Q@mail.gmail.com>
Date:   Mon, 13 Jan 2020 18:13:42 -0300
Message-ID: <87y2ubxdo9.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Pavel Shilovsky <piastryyy@gmail.com> writes:

> The patch 9150c3adbf24 was marked for stable, so, this one should be
> marked too.

Ah, good point. Thanks!

Should I resend it or Steve would take care of it?

Paulo
