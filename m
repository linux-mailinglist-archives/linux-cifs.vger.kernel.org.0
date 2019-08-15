Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9408EF1F
	for <lists+linux-cifs@lfdr.de>; Thu, 15 Aug 2019 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfHOPPF (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 15 Aug 2019 11:15:05 -0400
Received: from mail-eopbgr750095.outbound.protection.outlook.com ([40.107.75.95]:57859
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732517AbfHOPPF (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:15:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NubSnb4kJqcq27mSiCOoZuRNR5mBXeug/w6BByz46MRkkuic/JLa90EBC/CkVVLzuXFj2eUzzNQhq48vu/71LnyiDjosalTcB/6N7VTGgl6vCKzw49XeBrBTetlTzpFyFtylQfgVY6ONPoAi5VzC9XnQpDVqlmd2ug1wl1mb+J3lcBMuKft4KzOYFxQzgLWtABJ9O2u1lK/Qnr9CGkt75Kf7g2v4MjmqEUICJ7hmzAS5eSaQWMEiGYRW/hs9BRhhetJEy4ufpZEcXgwQN5a4Sspq+3JRWoCPTTVwayRvql7GA6l5IMhKIQO2kjjK9hi8ebhoOcodOVdoATFcSBpgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyi6JT5Pgu1fDKHWuIDLpOUoXqgclMdxK8zmkyzTYB8=;
 b=B51grzS+lWmNN2UB/1Jyk7gRTIcMKm/G4aG6i9qgoBiT0t29ByBnsm4XlHpzB2OEp0iwnF6KmeLzRwfkR/+nsOEUD8Ypb5wDj8b3vMiKJ1TusebL4qCh/ZhNM+/FOGdGHOnhgMKiAeHUET48r2sm1X5INOy3F8nNnl5h1vny2NBhzgJBkuawGhXcxJfV/rCrnp+75lRQZsDxdT3EpzUGr/TibUrTrRkh6pRxyD8cTXh+ABALq+0v8Os5rXKPCquOzXgswM7WWdqZNSnj5J6i0f25KpN7VM53Up/wmdW1KiZNbmwjI8y6ETlH710tnD4t3cQkcvb4ycrbpWSwYY9nXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyi6JT5Pgu1fDKHWuIDLpOUoXqgclMdxK8zmkyzTYB8=;
 b=OrLJQbgjQSNerhxVQUY1YT7HQ4Z8efzcKTNP9InoDQtptBxU9k93vHhdDGmOp6UWk0tCH7uluxVlu2XeUG2Ioj1vCe6o52RplTS7z/axnK2bkbg5GJZm9t6rsLrdQY844p0cFom5Sa4E/jkSpirTGcaSfG+itfQCosphoTrCl0o=
Received: from MWHPR2101MB0731.namprd21.prod.outlook.com (10.167.238.165) by
 MWHPR2101MB0730.namprd21.prod.outlook.com (10.167.237.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Thu, 15 Aug 2019 15:15:01 +0000
Received: from MWHPR2101MB0731.namprd21.prod.outlook.com
 ([fe80::e950:3464:b81f:80e5]) by MWHPR2101MB0731.namprd21.prod.outlook.com
 ([fe80::e950:3464:b81f:80e5%8]) with mapi id 15.20.2199.004; Thu, 15 Aug 2019
 15:15:01 +0000
From:   Tom Talpey <ttalpey@microsoft.com>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: RE: FSCTL_QUERY_ALLOCATED_RANGES issue with Windows2016
Thread-Topic: FSCTL_QUERY_ALLOCATED_RANGES issue with Windows2016
Thread-Index: AQHVUzMIxVep5FyrWkKPdfdBy87zGqb8T2kg
Date:   Thu, 15 Aug 2019 15:15:01 +0000
Message-ID: <MWHPR2101MB073136FE90E5C6FCD9F21CA8A0AC0@MWHPR2101MB0731.namprd21.prod.outlook.com>
References: <CAN05THT0OkbAoNu8ZVSHF-xY7w0ZW4q4i-jTxjNManrnz0OMfg@mail.gmail.com>
In-Reply-To: <CAN05THT0OkbAoNu8ZVSHF-xY7w0ZW4q4i-jTxjNManrnz0OMfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ttalpey@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-15T15:14:59.5669922Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d953d639-9efb-4cf6-8fed-c0c483f6c321;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttalpey@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:d0b4:afd0:5c6a:538e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd48133a-159b-4c66-cf0e-08d7219357fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR2101MB0730;
x-ms-traffictypediagnostic: MWHPR2101MB0730:
x-microsoft-antispam-prvs: <MWHPR2101MB0730BE51882273D0340F7A84A0AC0@MWHPR2101MB0730.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(52294003)(13464003)(55674003)(86362001)(10290500003)(46003)(8990500004)(476003)(486006)(74316002)(11346002)(229853002)(446003)(2906002)(6506007)(53546011)(7736002)(6116002)(33656002)(6436002)(10090500001)(305945005)(102836004)(186003)(9686003)(55016002)(6246003)(478600001)(52536014)(76176011)(256004)(14444005)(53936002)(14454004)(99286004)(71190400001)(8676002)(5660300002)(76116006)(7696005)(66946007)(66476007)(25786009)(81156014)(81166006)(66556008)(110136005)(64756008)(66446008)(22452003)(8936002)(316002)(71200400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0730;H:MWHPR2101MB0731.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: er60z+SRaKC7iJ4R3evSDzA2IP0qlpvA8+CibxYKE7mHFb7lKjbH9/31b8HkKJbgFSbOKuol0cezoopKWEVZ0351JFMRwSdOhG1lAcMacgAXVRnMLifJvS6+Kgt2tkHLKVPNiE2VZwDGaery7e7BD8E1q625BY3T7vV/8qPSR0D+MAm2gxgF1TxmA+XqGzDz76fPT7yZvAqcDNSPJFoT+jUDSfjslib5t6tkyMuZhUlhPj9StxmJHCXr6s5MU9No3gtdPEqalZyJr+J7FhD7V8Ed6IK/EQl7QQ9LrAc8HPpPJp4ukDVV30QCz2feGrGvASlcJNSoOgoj5tohov9qByRpONyYm3BwLyu+Ncuoa3rnwiDlCpRlu8g1sJwEOhxluw86AQ0lbg18cLDra6/Ny4I6u43n5QsnNXkXap26o1o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd48133a-159b-4c66-cf0e-08d7219357fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 15:15:01.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC3CTfl9SDaQiEVPsjSJFGeC2NZr/UbYvNc5M3ovOr/OQhh7uqTtyPLhXO6kJnIsUn+WLpD2oa+SZn6dxdksFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0730
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jaWZzLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtY2lmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiByb25uaWUgc2FobGJlcmcNCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTQsIDIw
MTkgMTE6MzEgUE0NCj4gVG86IGxpbnV4LWNpZnMgPGxpbnV4LWNpZnNAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBGU0NUTF9RVUVSWV9BTExPQ0FURURfUkFOR0VTIGlzc3VlIHdpdGggV2lu
ZG93czIwMTYNCj4gDQo+IEkgYW0gc2VlaW5nIGlzc3VlcyB3aXRoIGhvdyBGU0NUTF9RVUVSWV9B
TExPQ0FURURfUkFOR0VTIGJlaGF2ZXMNCj4gdW5kZXIgd2luZG93cywNCj4gaW4gcGFydGljdWxh
ciB0aGF0IGl0IGlzIGluY29uc2lzdGVudCBzbyB3ZSBjYW4ndCBydW4gY2VydGFpbiB4ZnN0ZXN0
cw0KPiBhZ2FpbnN0IHdpbmRvd3Mgc2VydmVycy4NCj4gDQo+IA0KPiBUaGUgYmVoYXZpb3IgY2Fu
IGJlIHRyaWdnZXJlZCB1c2luZyB0aGUgZm9sbG93aW5nIGNvbW1hbmQgZnJvbSB4ZnN0ZXN0cyA6
DQo+ICAgLi9zcmMvc2Vla19zYW5pdHlfdGVzdCAtcyAxOSAtZSAxOSAvbW50L2ZpbGUNCj4gKHdo
ZXJlIC9tbnQgaXMgYW4gc21iIHNoYXJlIG1vdW50ZWQgZnJvbSBhIHdpbmRvd3MgMjAxNiBzZXJ2
ZXIuKQ0KPiANCj4gSW4gY2lmcy5rbyB3ZSB1c2UgdGhpcyBGU0NUTCB0byBpbXBsZW1lbnQgYm90
aCBTRUVLX0hPTEUvU0VFS19EQVRBIGFzIHdlbGwNCj4gYXMNCj4gZmllbWFwKCkuIEJ1dCBzaW5j
ZSB0aGUgYmVoYXZpb3Igb2YgdGhpcyBGU0NUTCBpcyBub3QgZGV0ZW1pbmlzdGljIGl0IG9mdGVu
DQo+IGNhdXNlIHRoZSB0ZXN0cyB0byBmYWlsLg0KPiANCj4gDQo+IFRoaXMgaXMgYSB0ZXN0IHRv
b2wgZm9yIFNFRUtfREFUQSBhbmQgU0VFS19IT0xFLiBBcyBwYXJ0IG9mIHRoaXMgaXQgcGVyZm9y
bXMNCj4gYSBjaGVjayB0byB0cnkgdG8gZGlzY292ZXIgaWYgdGhlIGZpbGVzeXN0ZW0gc3VwcG9y
dHMgc3BhcnNlIGZpbGVzIG9yIG5vdC4NCj4gRm9yIG5vbi1zcGFyc2UgZmlsZXMgU0VFS19EQVRB
IGlzIGJhc2ljYWxseSBhIG5vLW9wIGFuZCBTRUVLX0hPTEUganVzdCByZXR1cm5zDQo+IHRoZSBm
aWxlIHNpemUuDQo+IExhdGVyIGR1cmluZyB0aGUgdGVzdCwgdGhlIHJlc3VsdCBvZiB3aGV0aGVy
IHRoZSBmaWxlIGlzICJzcGFyc2UiIG9yIG5vdA0KPiB3aWxsIGFmZmVjdCB3aGF0IHRoZSBleHBl
Y3RlZCByZXN1bHRzIGFyZS4gSWYgdGhpcyBjaGVjayBnZXRzIHRoZQ0KPiBzcGFyc2Utc3VwcG9y
dGVkIHdyb25nIHRoZSB0ZXN0IGNhc2VzIGxhdGVyIHdpbGwgZmFpbC4NCj4gDQo+IA0KPiBIb3cg
dGhlIGNoZWNrIHdvcmtzOg0KPiA9PT09PT09PT09PT09PT09PT09PQ0KPiBUaGUgYWN0dWFsIGNo
ZWNrIGZvciB3aGV0aGVyIHRoZSBmaWxlIHN1cHBvcnRzIGJlaW5nIHNwYXJzZSBvciBub3QgaXMg
dGhlDQo+IGZvbGxvd2luZyBzbmlwcGV0IDoNCj4gICAgICAgICBmdHJ1bmNhdGUoZmQsIDApOw0K
PiAgICAgICAgIGJ1ZnN6ID0gYWxsb2Nfc2l6ZSAqIDI7DQo+ICAgICAgICAgZmlsc3ogPSBidWZz
eiAqIDI7DQo+IA0KPiAgICAgICAgIGJ1ZiA9IGRvX21hbGxvYyhidWZzeik7DQo+ICAgICAgICAg
aWYgKCFidWYpDQo+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgICBtZW1zZXQo
YnVmLCAnYScsIGJ1ZnN6KTsNCj4gDQo+ICAgICAgICAgLyogRmlsZSB3aXRoIDIgYWxsb2NhdGVk
IGJsb2Nrcy4uLi4gKi8NCj4gICAgICAgICByZXQgPSBkb19wd3JpdGUoZmQsIGJ1ZiwgYnVmc3os
IDApOw0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4g
DQo+ICAgICAgICAgLyogZm9sbG93ZWQgYnkgYSBob2xlLi4uICovDQo+ICAgICAgICAgcmV0ID0g
ZG9fdHJ1bmNhdGUoZmQsIGZpbHN6KTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7DQo+IA0KPiAgICAgICAgIC8qIElzIFNFRUtfREFUQSBhbmQgU0VFS19I
T0xFIHN1cHBvcnRlZCBpbiB0aGUga2VybmVsPyAqLw0KPiAgICAgICAgIHBvcyA9IGxzZWVrKGZk
LCAwLCBTRUVLX0hPTEUpOw0KPiAgICAgICAgIGlmIChwb3MgPT0gLTEpIHsNCj4gICAgICAgICAg
ICAgICAgIGZwcmludGYoc3RkZXJyLCAiS2VybmVsIGRvZXMgbm90IHN1cHBvcnQgbGxzZWVrKDIp
IGV4dGVuc2lvbiAiDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICJTRUVLX0hPTEUuIEFib3J0
aW5nLlxuIik7DQo+ICAgICAgICAgICAgICAgICByZXQgPSAtMTsNCj4gICAgICAgICAgICAgICAg
IGdvdG8gb3V0Ow0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKHBvcyA9PSBmaWxzeikg
ew0KPiAgICAgICAgICAgICAgICAgZGVmYXVsdF9iZWhhdmlvciA9IDE7DQo+ICAgICAgICAgICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgIkZpbGUgc3lzdGVtIHN1cHBvcnRzIHRoZSBkZWZhdWx0IGJl
aGF2aW9yLlxuIilcDQo+IDsNCj4gICAgICAgICB9DQo+IA0KPiBJLmUuDQo+IDEsIGZ0cnVuY2F0
ZSB0byAwDQo+IDIsIHdyaXRlIDJNIHRvIHRoZSBzdGFydCBvZiB0aGUgZmlsZQ0KPiAzLCBmdHJ1
bmNhdGUgdGhlIGZpbGUgdG8gYmUgNE1iDQo+IDQsIFNFRUtfSE9MRSBhbmQgY2hlY2sgaWYgaXQg
cmV0dXJucyA0TWIgb3Igbm8uDQo+IElmIGl0IHJldHVybnMgNE1iIHRoZW4gd2Ugc3dpdGNoIGJh
Y2sgdG8gZGVmYXVsdF9iZWhhdmlvciBhbmQgd2UgYWxsb3cNCj4gdGhlIHNlbWFudGljcyBhcyBp
ZiB0aGUgZmlsZSBpcyBub3Qgc3BhcnNlLg0KPiBJLmUuIGFsbG93IFNFRUtfREFUQSB0byBiZWhh
dmUgYXMgaWYgdGhlIGZpbGUgaXMgZWl0aGVyIHNwYXJzZSBvciBub3Qtc3BhcnNlLg0KPiANCj4g
QWxzbyBub3RlIHRoYXQgaWYgaXQgbG9va3MgbGlrZSB0aGUgc3BhcnNlLWZpbGUgaXMgbm90IHN1
cHBvcnRlZCB0aGVuDQo+IGl0IHByaW50cyAiIkZpbGUgc3lzdGVtIHN1cHBvcnRzIHRoZSBkZWZh
dWx0IGJlaGF2aW9yLiIgd2hpY2ggbWF5IGhlbHAgd2hlbg0KPiBydW5uaW5nIHRoZSB0ZXN0IHRv
b2wuDQo+IA0KPiBTdHJhY2UgZm9yIHRoaXMgY2hlY2sgKHdoZW4gdGhlIGNoZWNrIGZhaWxlZC4p
DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAxODoy
MjoxNC45NDk2MTIgZnRydW5jYXRlKDMsIDApICAgICAgICAgPSAwIDwwLjAxMTUxMz4NCj4gMTg6
MjI6MTQuOTYzNzI1IG1tYXAoTlVMTCwgMjEwMTI0OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsDQo+
IE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4N2ZlOGQ5ZjE0MDAwIDwwLjAN
Cj4gMDAxOTI+DQo+IDE4OjIyOjE0Ljk3MDMzNCBwd3JpdGU2NCgzLA0KPiAiYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhDQo+
IGFhYWFhYWFhYWFhYWFhYWFhYQ0KPiBhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhDQo+IGFhYWFhYWFhYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWENCj4gYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFh
YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWEiLi4uLA0KPiAyMDk3MTUyLCAwKSA9IDIw
OTcxNTIgPDAuMDAyMTI3Pg0KPiAxODoyMjoxNC45NzI2MjAgZnRydW5jYXRlKDMsIDQxOTQzMDQp
ICAgPSAwIDwwLjU4MjQ5MT4NCj4gMTg6MjI6MTUuNTU3MzA4IGxzZWVrKDMsIDAsIFNFRUtfSE9M
RSkgID0gNDE5NDMwNCA8MC4wMTI3OTE+DQo+IDE4OjIyOjE1LjU3MjQ1NyB3cml0ZSgyLCAiRmls
ZSBzeXN0ZW0gc3VwcG9ydHMgdGhlIGRlZmF1bHQNCj4gYmVoYXZpb3IuXG4iLCA0MykgPSA0MyA8
MC4wMDAzMTg+DQo+IA0KPiANCj4gRXhhbXBsZSBvZiB3aGVuIHRoZSBjaGVjayBnb2VzICJXcm9u
ZyIuIENhcHR1cmUgc2Vla19nb29kLmNhcA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFRoZSByZWxldmFudCBwYWNrZXRz
IGhlcmUgYXJlDQo+IDE4MjAsIHNldCBlbmQgb2YgZmlsZSA9PSAwDQo+ICgxODIyLzE4MjMgdXBk
YXRlIHRpbWVzdGFtcHMpDQo+IDI5MzAsIHdyaXRlIDJNYiB0byBvZmZzZXQgMA0KPiAzMDA4LCBz
ZXQgdGhlIGZpbGUgc3BhcnNlDQo+IDMwMTAsIHNldCBlbmQgb2YgZmlsZSB0byA0TQ0KPiAzMDE5
LCBxdWVyeS1hbGxvY2F0ZWQtcmFuZ2VzDQo+IA0KPiBJbiAzMDE5LzMwMjAgdGhlIHNlcnZlciBy
ZXNwb25kcyB0aGF0IHRoZSBmdWxsIDAtNE0gcmFuZ2UgaXMgYWxsb2NhdGVkLg0KPiBUaGlzIGlz
IHdyb25nIHNpbmNlIGZpbGUgc2hvdWxkIG9ubHkgYmUgYWxsb2NhdGVkIGluIHRoZSBmaXJzdCAy
TWIgYXQNCj4gdGhpcyBzdGFnZS4NCj4gQW5kIHRoaXMgbWFrZXMgdGhlIHRlc3QgdG9vbCB0aGlu
ayB0aGF0IHdlIGRvbid0IHN1cHBvcnQgc3BhcnNlIGZpbGVzLA0KPiBhbmQgc2V0cyBkZWZhdWx0
X2JlaGF2aW9yIHRvIDEuDQo+IA0KPiBBIGRpZmZlcmVudCBydW4gd2hlbiB0aGUgY2hlY2sgaXMg
c3VjY2Vzc2Z1bCAoc2Vla19iYWQuY2FwKQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gSW4gdGhlIHNlZWtfYmFkIGNhcHR1
cmUgeW91IGNhbiBzZWUgdGhlIHNhbWUgc2VxdWVuY2UgaW4gcGFja2V0cw0KPiAxODY5LCBzZXQg
ZW5kIG9mIGZpbGUgPT0gMA0KPiAyOTkwLCB3cml0ZSB0aGUgZmlyc3QgMk0gb2YgdGhlIGZpbGUN
Cj4gMzA2Nywgc2V0IGZpbGUgc3BhcnNlDQo+IDMwNjksIHNldCBlbmQgb2YgZmlsZSB0byA0TQ0K
PiAzMDc4LCBxdWVyeS1hbGxvY2F0ZWQtcmFuZ2VzDQo+IEJ1dCB0aGlzIHRpbWUsIHF1ZXJ5LWFs
bG9jYXRlZC1yYW5nZXMgcmVwb3J0IHRoYXQgb25seSAwLTJNIGlzIG1hcHBlZCwNCj4gd2hpY2gg
aXMgdGhlIGNvcnJlY3QgcmFuZ2UsDQo+IGFuZCB0aHVzIHRoZSB0ZXN0IHRvb2wgYXNzdW1lcyB0
aGF0IHdlIGNhbiBoYW5kbGUgaG9sZXMgcHJvcGVybHkuDQo+IA0KPiBUaGUgY2FwdHVyZXMgYXJl
IH41TUJ5dGUgZWFjaCB1bmZpbHRlcmVkIHNvIHRvbyBiaWcgZm9yIHRoZSBsaXN0Lg0KPiBFbWFp
bCBtZSBkaXJlY3RseSBhbmQgSSB3aWxsIHNlbmQgdGhlbSB0byB5b3UuDQo+IA0KPiANCj4gU28g
dGhlIHF1ZXN0aW9uIGhlcmUgaXMgd2hhdCBpcyB0aGUgYWN0dWFsIHNlbWFudGljcyBmb3Igc3Bh
cnNlIGZpbGVzDQo+IGFuZCBxdWVyeS1hbGxvY2F0ZWQtcmFuZ2VzIG9uIHdpbmRvd3M/DQoNCkkn
bGwgdHJ5IHRvIGdldCB5b3UgYW4gYW5zd2VyLCBidXQgaW4gdGhlIG1lYW50aW1lIGp1c3QgYSBx
dWVzdGlvbi4uLg0KRG9lcyB0aGUgYmVoYXZpb3IgY2hhbmdlIGlmIHRoZSBmaWxlIGlzIG9wZW5l
ZCB3aXRoIEZJTEVfRkxBR19XUklURV9USFJPVUdIPw0KDQpUb20uDQo=
