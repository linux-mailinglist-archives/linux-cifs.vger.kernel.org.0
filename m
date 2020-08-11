Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5B2414CC
	for <lists+linux-cifs@lfdr.de>; Tue, 11 Aug 2020 04:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHKCL6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 10 Aug 2020 22:11:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3051 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbgHKCL6 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 10 Aug 2020 22:11:58 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 67BF6889246144DE4A5F;
        Tue, 11 Aug 2020 10:11:55 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 11 Aug 2020 10:11:55 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 11 Aug 2020 10:11:54 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Steve French <smfrench@gmail.com>
CC:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cifs: Convert to use the fallthrough macro
Thread-Topic: [PATCH] cifs: Convert to use the fallthrough macro
Thread-Index: AdZvhEz9lZlZpnrOTpiNG8A3ntxZxA==
Date:   Tue, 11 Aug 2020 02:11:54 +0000
Message-ID: <5c4a8c734508477082819724c6853337@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.252]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

U3RldmUgRnJlbmNoIDxzbWZyZW5jaEBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPm1lcmdlZCBpbnRv
IGNpZnMtMi42LmdpdCBmb3ItbmV4dA0KPg0KDQpNYW55IHRoYW5rcy4NCg0KPiAoYnV0IG5vdGUg
dGhhdCBtb3N0IHBsYWNlcyBpbiBmcyBkaXJlY3Rvcnkgb3RoZXIgdGhhbiBjaWZzIGFuZCBidHJm
cyBoYXZlIG5vdCBiZWVuIHVwZGF0ZWQpLCBhbmQgSSBub3RpY2VkIGFub3RoZXIgOCBwbGFjZXMg
aW4gZnMvY2lmcyB0aGF0IHlvdSBkaWRuJ3QgY2hhbmdlIGluIHlvdXIgcGF0Y2ggKGllIGNoYW5n
ZSBmcm9tIHRoZSBvbGRlciB3YXkgb2YNCj5pbmRpY2F0aW5nIGZhbGx0aHJvdWdoICAgLyogRmFs
bHRocm91Z2ggKi8gYXMgYSBjb21tZW50IHRvIHRoZSBuZXdlcg0KPmZhbGx0aHJvdWdoIG1hY3Jv
Lg0KPg0KDQpJJ2FtIHNvcnJ5LCBJIG1pc3NlZCB0aGF0LiBJIHdvdWxkIGZpeCBhbm90aGVyIDgg
cGxhY2VzIGluIGZzL2NpZnMgc29vbi4NClRoYW5rcy4NCg0KPg0KPi0tDQo+VGhhbmtzLA0KPg0K
PlN0ZXZlDQo=
