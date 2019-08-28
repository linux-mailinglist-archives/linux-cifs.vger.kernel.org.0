Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCC9FB44
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Aug 2019 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1HPr (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 28 Aug 2019 03:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfH1HPq (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 28 Aug 2019 03:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90B0B308339B;
        Wed, 28 Aug 2019 07:15:46 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-71.bne.redhat.com [10.64.54.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 057D25C1D6;
        Wed, 28 Aug 2019 07:15:45 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 0/1] add new debugging macro
Date:   Wed, 28 Aug 2019 17:15:34 +1000
Message-Id: <20190828071535.19436-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 28 Aug 2019 07:15:46 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve, List

Please find an updated proposal for the new macro to add the server-name
to the debug log messages.

Steve suggested we should only do this for VFS entries in order to not grow the footprint of the more noisy messages and risk starting to drop debug
log messages.

