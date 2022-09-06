Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E5ADD23
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Sep 2022 04:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIFCEd (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 5 Sep 2022 22:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIFCEc (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 5 Sep 2022 22:04:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575006446
        for <linux-cifs@vger.kernel.org>; Mon,  5 Sep 2022 19:04:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 145so9967614pfw.4
        for <linux-cifs@vger.kernel.org>; Mon, 05 Sep 2022 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JCwft7lhtz289I3Gs9eyZUbdaqcvhxyrfzGgFcGpbXY=;
        b=ldjaJh5vaQq1Zg7EJQryfOjr0j4F+Nvl/BCH66nbW4pV9AW5YzYunnGxCiiwubScYj
         MPq9bx4szGLCnufgAJ6qsv1UFSaWf8FL9E9NgQMPCeMt0DTLM5DX1kC2q+ftraxmKLuq
         2n8fMKHsLcPq/B0jX+cPwFcD4PptqSaqf6oV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JCwft7lhtz289I3Gs9eyZUbdaqcvhxyrfzGgFcGpbXY=;
        b=38VxW95WDKqsvtk4XqUt63baucspV45/k0Oq45ZgJZBPMfkDwpuXfY4gmKVC/rFY9f
         7wx6z2OP4vmF19HNhP/VHb/FNTiGSpoQ7lJqJsFR5L7MdJBQZegESyD9dvawkrpnqndM
         f7/PU+8NcJUA3YTjnz7WmM02zIDSx68XwYrs3uwo/YV0UDKpNu6sYDBSGfh4GW6MDMmO
         NbdrWOQtmu2ZFkCZBaMKTJwoA3ebxkI+xW3j0YkuEkumqySL69GKOeY9Ek6PkCiw9cb2
         Txn2Dn0SIRet7l8AUUbspCGLBs26GQeHI4VeRbudcTTARgS/H8z4vFeg2a09joPqFvfF
         29ug==
X-Gm-Message-State: ACgBeo3t0HNgVRMVJeA4Ytw3GgHdCmNXoHXND4fonJ7E0S6C34LE179X
        wJMaVkBuMcZlWRzOtemz3cbyiA==
X-Google-Smtp-Source: AA6agR6EFRawraEMHex3xor2xdDkHyqdvqfn5rjLtKdOgv/7ifbTMeTyDiuYK5qW7ZE4SSftOo0rDg==
X-Received: by 2002:a63:ed15:0:b0:430:48ac:3771 with SMTP id d21-20020a63ed15000000b0043048ac3771mr22547633pgi.423.1662429869891;
        Mon, 05 Sep 2022 19:04:29 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:5167:aa6c:9829:64dd])
        by smtp.gmail.com with ESMTPSA id 135-20020a62188d000000b0053dd1bc5ac6sm2470507pfy.66.2022.09.05.19.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:04:29 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:04:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, hyc.lee@gmail.com,
        senozhatsky@chromium.org, tom@talpey.com, atteh.mailbox@gmail.com
Subject: Re: [PATCH v2] ksmbd: update documentation
Message-ID: <YxaqqSfzD6fIrGeV@google.com>
References: <20220906015823.12390-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906015823.12390-1-linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On (22/09/06 10:58), Namjae Jeon wrote:
> 
> configuration.txt in ksmbd-tools moved to ksmb.conf manpage.
> update it and more detailed ksmbd-tools build method.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
