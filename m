Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00F3613A4
	for <lists+linux-cifs@lfdr.de>; Thu, 15 Apr 2021 22:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhDOUmg (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 15 Apr 2021 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDOUmg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 15 Apr 2021 16:42:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD606C061574
        for <linux-cifs@vger.kernel.org>; Thu, 15 Apr 2021 13:42:12 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX8oV-005ah2-KP; Thu, 15 Apr 2021 20:42:11 +0000
Date:   Thu, 15 Apr 2021 20:42:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [CFT] vfs.git #work.cifs
Message-ID: <YHilI9yjUb3CtCAo@zeniv-ca.linux.org.uk>
References: <YG+yK97KkSTkhwx7@zeniv-ca.linux.org.uk>
 <CAH2r5mvEF6RyQ2dCB7y9m_knDxFWw6q2+kBBT_+seA3Tcox4EA@mail.gmail.com>
 <CAH2r5muY4wQjqw9MhP0-NchXMSNQ+JfwNiDtmNcJMC3i0vPGxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muY4wQjqw9MhP0-NchXMSNQ+JfwNiDtmNcJMC3i0vPGxg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Apr 09, 2021 at 08:36:24PM -0500, Steve French wrote:
> Your series passed an all Azure test group
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/11/builds/20
> (with additional patches) and the main test group (with your 7 and
> Ronnie's finsert/fcollapse)
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/11/builds/20
> which tests to the wider variety of server and target server fs types.

OK...  I can
	* rebase it on top of your tree and repost the patches for applying
to cifs.git
	* rebase it and send you a pull request
	* send you a pull request on the branch as-is
	* keep it in vfs.git and send a pull request to Linus when window
opens.

Which variant would you prefer?
