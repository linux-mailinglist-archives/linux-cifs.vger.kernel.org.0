Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C958258F7F1
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Aug 2022 08:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiHKGv2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 11 Aug 2022 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiHKGv1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 11 Aug 2022 02:51:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516825C57
        for <linux-cifs@vger.kernel.org>; Wed, 10 Aug 2022 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wLYCIyXXB8hf4feczNPgR2pmJT3K9Crsld8RtkVVa1g=; b=4SL+TNOi2ngp+bTBOG6/T9z6j3
        mphZ+Vwl0dMg1/U/NG1A1F7Ic2xPjf/E53eI7XXyjJLfQIfcDUv+tngEDOFTXR1Se2I7pv65/pN56
        xz50caWDTy9ZtanOWHexP2tbTfj4cC8+5TclAlL+460RWkCBg/ocLnRCSL21ieivkeVRoj4Z3JFLw
        cLABHLtOfAmGSzAgBvd4igC733yNhDiQB50pVaXCCqYchHQlG63FjAl1bGuKW/0Ej0PAEG6LVzJBS
        oICwOP/RNulySvU8gX8JCzk6KyLqD+tA69S+XWxveLsRfwrH79YdjsS5tIwgQBb/hOm/QGWOrErSm
        wkZ+vmkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM22N-007Qhx-3Y; Thu, 11 Aug 2022 06:51:23 +0000
Date:   Wed, 10 Aug 2022 23:51:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-cifs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v3] ksmbd: remove unnecessary generic_fillattr in
 smb2_open
Message-ID: <YvSm62l0+6fTZ9E8@infradead.org>
References: <20220811063659.67248-1-hyc.lee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811063659.67248-1-hyc.lee@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Aug 11, 2022 at 03:36:59PM +0900, Hyunchul Lee wrote:
> +	rc = ksmbd_vfs_getattr(&path, &stat);
> +	if (rc) {
> +		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
> +		rc = 0;
> +	}

Why is this calling generic_fillattr at all?  generic_fillattr is a
helper for file systems.  Consumers of the file system API like ksmbd
must never use it directly.
