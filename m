Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E891D154
	for <lists+linux-cifs@lfdr.de>; Tue, 14 May 2019 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfENVd4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 May 2019 17:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfENVd4 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 14 May 2019 17:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B7D134CF;
        Tue, 14 May 2019 21:33:56 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-44.bne.redhat.com [10.64.54.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0617019C7C;
        Tue, 14 May 2019 21:33:55 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 0/1] cifs: add support for SEEK_DATA and SEEK_HOLE
Date:   Wed, 15 May 2019 07:33:45 +1000
Message-Id: <20190514213346.25337-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 14 May 2019 21:33:56 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Resending, I think something went wrong.

Steve,
Support for SEEK_DATA/HOLE.
It passes xfstests 285,286,436,445,448,490

