Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15F26B7BDF
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Mar 2023 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCMPZG (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Mar 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCMPZF (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 13 Mar 2023 11:25:05 -0400
Received: from mail.sernet.de (mail.sernet.de [IPv6:2a0a:a3c0:0:25::217:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEA41BC8
        for <linux-cifs@vger.kernel.org>; Mon, 13 Mar 2023 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sernet.de;
        s=20210621-rsa; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:To:From:Date:Sender:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VvUfO11HIGFwRloqa/Wf1evR6S3vu9TdvdrOE9zhWXM=; b=ADLydBYz9cS4a8CNm2j7S7ebCp
        /wO1Qnxv+aEYyUZN7X8JKVGuFrbTl1jyfPEhWExMkYVi+LxhAiFvPYc2wfqMkdw3EUpwbyngQ/VRM
        SVRmfSD2n1LsfMj0sCwHTLv8Fuf3+4hdMJW1IAPT2xfCXdNm/tIqSWomJX2Odd66h7wnjuSQgYi6B
        CGAEJSUXL0zzhqK46+hWtKxivu4TpGCB8XsHTDfnzT1orfn0rKGCYUVDqp5okBRF3iic/vZahePgb
        /vTrYB0v0S2SiveXUgkyqa0ekFDr0YW+zTdkkSVmIA4wSFVTNE3dMvRLBzs/eA0f47HNuc+UKktMj
        JmOpKNgg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sernet.de; s=20210621-ed25519; h=In-Reply-To:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date:Sender:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VvUfO11HIGFwRloqa/Wf1evR6S3vu9TdvdrOE9zhWXM=; b=hFPoNKCj2xMnxk4/3qxKW6Sb9b
        ot0i0KwQtfaNF8ylr69wJBOEA5W/B0Cx3IHqCOCew0xzMt+Z7VXxtOYPLdAg==;
Received: from intern.sernet.de by mail.sernet.de
        with esmtps (Exim Mail Transfer Agent)
        for linux-cifs@vger.kernel.org
        id 1pbk2o-001J6e-3K; Mon, 13 Mar 2023 16:25:02 +0100
Received: by intern.sernet.de
        id 1pbk2n-00DtHZ-QO; Mon, 13 Mar 2023 16:25:01 +0100
Date:   Mon, 13 Mar 2023 16:24:57 +0100
From:   Volker Lendecke <Volker.Lendecke@sernet.de>
To:     linux-cifs@vger.kernel.org
Subject: Re: Fix setting EOF
Message-ID: <ZA9ASbdsD0AJH6wV@sernet.de>
Reply-To: Volker.Lendecke@sernet.de
References: <ZA8/B2wzQP8mEtRn@sernet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA8/B2wzQP8mEtRn@sernet.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Am Mon, Mar 13, 2023 at 04:19:35PM +0100 schrieb Volker Lendecke:
> b6f2a0f89d7ed introduced looking for a writable path. This patch
> should probably have gone with it.

Skip that, patch is incomplete. Will submit a fixed one v soon.

Volker
