Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B118641B7E
	for <lists+linux-cifs@lfdr.de>; Sun,  4 Dec 2022 09:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDITX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 4 Dec 2022 03:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLDITU (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 4 Dec 2022 03:19:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375914D1C
        for <linux-cifs@vger.kernel.org>; Sun,  4 Dec 2022 00:19:18 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5709868AFE; Sun,  4 Dec 2022 09:19:14 +0100 (CET)
Date:   Sun, 4 Dec 2022 09:19:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Steve French <smfrench@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        David Howells <dhowells@redhat.com>
Subject: Re: RFC: remove cifs_writepage
Message-ID: <20221204081913.GB26937@lst.de>
References: <20221116131835.2192188-1-hch@lst.de> <CAH2r5msoMJ6jNFDtHigKOqq9EwxEb9buxGVi8duW8EMz6wwgBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msoMJ6jNFDtHigKOqq9EwxEb9buxGVi8duW8EMz6wwgBg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Wed, Nov 16, 2022 at 12:29:41PM -0600, Steve French wrote:
> I can run some tests on this later this week.

Did you get a chance to do that?
