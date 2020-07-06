Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF7B215C29
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Jul 2020 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgGFQpx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Jul 2020 12:45:53 -0400
Received: from mx.cjr.nz ([51.158.111.142]:2366 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgGFQpx (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 6 Jul 2020 12:45:53 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id DF2637FD17;
        Mon,  6 Jul 2020 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1594053951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7JOJxANU69tkiH1tczdrrVLKZBAGSmUYAxmpxmRYp0=;
        b=S/symbeH/M33GJV4QPvFkYian3F8lU32LjKI5Gy2LrZ4j4nBpsuCbxInc6WUcRV0vL0qWV
        ycmDZ+OIA0U/LV7oRTqbwZTIIQ18Wc5zvCOFLExC5hpRJSUc+LN3YPwvaGl1JoO+0x7lAq
        hfQ8/vjWKmBixzejZSL466RNM0WaVpxgbepj9B9cAmIWmPNMgiXYgkYfH6PH8ftM0R0T9y
        eFmetgXz9wy2PueFq/d3iKhMqdzcn3ngR5ncssfWDG+qVi+UxRHJHO34jMSI/y4301OWMU
        j5kqhQD+IdMmAHlb9Jz2i6Mc6d5h4KcaSqOiZkK0tSQfIHXpupbO0hWNkBRhtw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org,
        smfrench@gmail.com
Subject: Re: [PATCH 1/7] cifs: merge __{cifs,smb2}_reconnect[_tcon]() into
 cifs_tree_connect()
In-Reply-To: <87wo3gsl15.fsf@cjr.nz>
References: <20200706152402.5721-1-pc@cjr.nz>
 <20200706152402.5721-2-pc@cjr.nz>
 <03f472c0-3c36-a28d-41bc-5b064b4ea16f@samba.org> <87wo3gsl15.fsf@cjr.nz>
Date:   Mon, 06 Jul 2020 13:45:46 -0300
Message-ID: <87tuyksibp.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Paulo Alcantara <pc@cjr.nz> writes:

> Stefan Metzmacher <metze@samba.org> writes:
>
>>> +		if (tcon->ipc) {
>>> +			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", share);
>>> +			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
>>> +		} else {
>>> +			scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
>>> +			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
>>> +			if (!rc) {
>>> +				rc = update_super_prepath(tcon, prefix, prefix_len);
>>> +				break;
>>> +			}
>>> +		}
>>
>> The original code used:
>>
>> -		scnprintf(tree, MAX_TREE_SIZE, "\\%.*s", (int)share_len,
>> -			  share);
>>
>> So it's no longer identical.
>>
>> Was the share_len code added after my initial patch?
>
> Yep.  See
>
>       e4af35fa55b0 (cifs: handle hostnames that resolve to same ip in failover)
>       bacd704a95ad (cifs: handle prefix paths in reconnect)

Oh, that's really wrong, sorry.  I should have kept the usage of
"share_len" in scnprintf() for this commit.  So, in patch 6/7, it should
use directly "share" instead.

Thanks for pointing that out.  I'll send v2 with that fix.

