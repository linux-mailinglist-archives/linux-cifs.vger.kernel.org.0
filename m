Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE82BBE9F
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Nov 2020 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgKULS2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 21 Nov 2020 06:18:28 -0500
Received: from mail.archlinux.org ([95.216.189.61]:35414 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgKULS1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 21 Nov 2020 06:18:27 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2020 06:18:26 EST
Received: from mail.archlinux.org (localhost [127.0.0.1])
        by mail.archlinux.org (Postfix) with ESMTP id 47F7523A909;
        Sat, 21 Nov 2020 11:12:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.archlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1,
        DKIMWL_WL_HIGH=-0.001,DKIM_SIGNED=0.1,DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1,NO_RECEIVED=-0.001,NO_RELAYS=-0.001,
        T_DMARC_POLICY_NONE=0.01 autolearn=ham autolearn_force=no version=3.4.4
X-Spam-BL-Results: 
From:   Jonas Witschel <diabonas@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archlinux.org;
        s=mail; t=1605957121;
        bh=RSetouJqjoB4R2XXbsAv84dFoGTvpmZd1c4v4uYrzpU=;
        h=From:To:Cc:Subject:Date;
        b=P1kTHBpVRE6m14+z8HBvFUBrS1mDjGMrd6rcnref3sK7DBw0G4ylUg275Y81wOsef
         E5IJ2pIeVagOeUptCDq/ZZCYB6zR/LTWOEnjtbQD2Xhd8J4OYR0NA1X8l0sObs1xYb
         JR66EVWrNqCegGPM0purQOblmM0sJk8jWfkFnelOoSJYLEhrEkcLU4brlt9gdl2ldt
         uu4LexISiwD8pkukB1nIPB8TtmHZwE9UAVn8s5RAfMV4kkNVaRjD9O1jWlSGlVyeFp
         iIUMA6wSAplx+Oei98ov7qe859UZcSKeeB0Y1DaO1MMbuwGPqnUKp11W17kdw/M0Zt
         crho5J6y4G6QVMSzD8cVvhMm2GO5LPVO0XPTkaQOTSQkA1b2WzqjnlRmQb5UlsHqKG
         h/sAbPWvZw0NpVreoMK/K6TBOVuAoI6vHY2SyelTRKAYmm4QAM5rePkwtS/I56yW2y
         981DletlNoH7ka1NFOVd78NeR8HCzFDL7Zz+kMI4AS683RIsqNeSGYtnf3ld5QyIfe
         Ipgrhmc+XlG9Oqqvc7dFn1xUrXskgEqz5dEVm/L+C4WkXaRVBztX9QlLI+j1NHYvi8
         +/V8iiYy1/iefxrFTg2Xv1qUgQD8gIbSst0yDR8QKeC1NFs/5wNZ0fJlW5x6Q4Iiaf
         L+Dbb5ifBNIqMPwTQrxcIMGY=
To:     linux-cifs@vger.kernel.org
Cc:     Jonas Witschel <diabonas@archlinux.org>
Subject: [PATCH 0/2] cifs-utils: update the cap bounding set only when CAP_SETPCAP is given
Date:   Sat, 21 Nov 2020 12:11:43 +0100
Message-Id: <20201121111145.24975-1-diabonas@archlinux.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

libcap-ng 0.8.1 tightened the error checking on capng_apply [1], returning an
error of -4 [2] when trying to update the capability bounding set without
having the CAP_SETPCAP capability to be able to do so.

Existing applications need to accommodate these changes [3], see e.g. the
corresponding changes in GNOME Keyring [4].

This patch series fixes mount.cifs and cifs.upall to work with libcapn-ng
0.8.1, while maintaining backwards compatibility with previous versions.

[1] https://github.com/stevegrubb/libcap-ng/commit/6a24a9c5e2f3af1d56430417ee8c9a04ead38e6c
[2] https://github.com/stevegrubb/libcap-ng/commit/2ab6a03b78cfa7620641c772d13ddbf3b405576b
[3] https://github.com/stevegrubb/libcap-ng/issues/21
[4] https://gitlab.gnome.org/GNOME/gnome-keyring/-/commit/ebc7bc9efacc17049e54da8d96a4a29943621113

Jonas Witschel (2):
  mount.cifs: update the cap bounding set only when CAP_SETPCAP is given
  cifs.upall: update the cap bounding set only when CAP_SETPCAP is given

 cifs.upcall.c | 7 ++++++-
 mount.cifs.c  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.29.2
