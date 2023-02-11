Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B77693433
	for <lists+linux-cifs@lfdr.de>; Sat, 11 Feb 2023 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBKWkC (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 11 Feb 2023 17:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBKWkB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 11 Feb 2023 17:40:01 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017A18A85
        for <linux-cifs@vger.kernel.org>; Sat, 11 Feb 2023 14:40:00 -0800 (PST)
From:   Sam James <sam@gentoo.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B645AB2A-341D-4CCB-8B3E-D81936F81506";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 1/2] getcifsacl, setcifsacl: add missing <linux/limits.h>
 include for XATTR_SIZE_MAX
Message-Id: <8A956E6B-DFE2-47ED-B5FB-4F1349C2A08F@gentoo.org>
Date:   Sat, 11 Feb 2023 22:39:43 +0000
Cc:     Sam James <sam@gentoo.org>
To:     linux-cifs@vger.kernel.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


--Apple-Mail=_B645AB2A-341D-4CCB-8B3E-D81936F81506
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Ping

--Apple-Mail=_B645AB2A-341D-4CCB-8B3E-D81936F81506
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCY+gZL18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kFEsAP4jMCd6lF6FU9GmI1HPDn/PS1T/68LnDdbLHphpG2UEMwD/UsflO+2marwo
e7399Ch5cix7MCaY9iaqsuKW9vdNXgo=
=KbFP
-----END PGP SIGNATURE-----

--Apple-Mail=_B645AB2A-341D-4CCB-8B3E-D81936F81506--
