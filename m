Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DCF3F5D5B
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Aug 2021 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhHXLxh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 24 Aug 2021 07:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhHXLxh (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 24 Aug 2021 07:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C689E61246;
        Tue, 24 Aug 2021 11:52:52 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:52:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH][SMB3.1.1] incorrect initialization of the posix
 extensions in new mount API
Message-ID: <20210824115249.gdd3jlf6wi2joxdt@wittgenstein>
References: <CAH2r5muZqv0Zv415suhAjv5s9a=rU8nMkY1p7doq5koMYU0wBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5muZqv0Zv415suhAjv5s9a=rU8nMkY1p7doq5koMYU0wBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Aug 23, 2021 at 02:07:22PM -0500, Steve French wrote:
> We were incorrectly initializing the posix extensions in the
> conversion to the new mount API.
> 
> CC: <stable@vger.kernel.org> # 5.11+
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Suggested-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---

The indentation looks rather strange to me but maybe that's just mail
that got garbled. In any case, with the indentation fixed:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
