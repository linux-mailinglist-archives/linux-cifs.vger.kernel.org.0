Return-Path: <linux-cifs+bounces-4326-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA775A7328F
	for <lists+linux-cifs@lfdr.de>; Thu, 27 Mar 2025 13:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08F3177A95
	for <lists+linux-cifs@lfdr.de>; Thu, 27 Mar 2025 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8F1E5218;
	Thu, 27 Mar 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=opentext.com header.i=@opentext.com header.b="Tvrub+kx"
X-Original-To: linux-cifs@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11010066.outbound.protection.outlook.com [52.101.191.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D04C96
	for <linux-cifs@vger.kernel.org>; Thu, 27 Mar 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079719; cv=fail; b=B1gDdMul7FgY3zdgReEDC2k574VJ86vL1vUXzVdBAd2aDXF6rRZc8oxDe3BUL9DgvA1dyRDMdYu6ECR7xPndhPKjoeSkK/GKZqj8CsROYBt89aEHadw3nAk+qeBUOG+dfRaq2/EbWr9yHXAdO+nzrmwqVIUx18vzKEpUyILTiHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079719; c=relaxed/simple;
	bh=o/39RZsx+yObbsIG4SxnsnzOh6dlVdHDR4dtkEVODRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeflBW4039sUcWBRht3kvwqPVNn0GNjfxmI6SrngcFxxLfs52mao7rQ+Ulr58lJwFJDiXCaPakdtsVTBMvqsiPHB4pqQ/m5IkZHMBQJinoNRj07MYEUhLaYYPi7FUa4GUse8JRa8yb6RKcUiwBAlmTGnAH/7IC6KtBuKgHlQBMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opentext.com; spf=pass smtp.mailfrom=opentext.com; dkim=pass (1024-bit key) header.d=opentext.com header.i=@opentext.com header.b=Tvrub+kx; arc=fail smtp.client-ip=52.101.191.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opentext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opentext.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk7MWUNOixZ96uHgpNDT4YUfVi9JJ068KFo0Cho2voH7QhrmXZQXxYnmIwBrhSMmMAKH7AEHMremJhM2lrNNmzOizikSyz2lJeyO0xbroPOYoM76ArasOpHLHRYGgzsBGAf7q5ZJVUh5omIZjC8/SYlom+f2oV/DHx++eSc7AmSVf0NffOl+bGLxSivSBQy2gpR5K2koXuEbpTaq2VwAmaxyRz4RnaQuIYxM22ThKKz3fX4G7e9qf28nrxVjkdyhx4e09IrHzQMpkjTXRIZ/0xELSFFW9jyMM1XWe7rk/dWHvao5pjSNLkk4WdbnNFkRUiAR8h19xZ5MchEB2bNQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/39RZsx+yObbsIG4SxnsnzOh6dlVdHDR4dtkEVODRM=;
 b=dW0aPRh3SaOd1Mx0PQCK08d/4J7XPz4g2yiGAuEj45niuQHUgt6t+dDhbil5wS1di6oXiWFYJe1oUGOfHJl30yEGVsyGD5J+jaePFDYBMJff7m50f07+tmiDDXAp4nksY6LzI3mzMZN1e2PYGlm2CKu1EFKtQ0IOPFXrQ3aZTZfAMMicPpJ1VnLbb8q2rHQs6uuI89KJVT8KqEZ9yjla7Eu9E5FvrIfsaLiZuNP/ZewgHVnc1rQFhpItpVZBCqnqZFlvIuBpX7YuWPZ9Gjk/0Yj/6nOWb5lTNgUO2WFZFsimC1O6XfsuIeDaV+DFghQAZXLW8lMxxOu9g2OST0Ar0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opentext.com; dmarc=pass action=none header.from=opentext.com;
 dkim=pass header.d=opentext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opentext.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/39RZsx+yObbsIG4SxnsnzOh6dlVdHDR4dtkEVODRM=;
 b=Tvrub+kxBMOxyxM7bifivF612uRbgZ1Hp9NwIY588Ly8V9lnNFQVwMn69+z+pmg1Urn5leAHotaDhzwjnaYTUqVTfJAWLmWJTOUjZHOeVkW69zuxG8BW27BHPha0SPQxO83QWWXCeVQ0EyJCNnBKelEDi2tro39d+CB9bFKavUE=
Received: from YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:aa::5)
 by YT3PR01MB11083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:48:34 +0000
Received: from YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a233:82d0:bb5c:678d]) by YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a233:82d0:bb5c:678d%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:48:33 +0000
From: Mark A Whiting <whitingm@opentext.com>
To: Enzo Matsumiya <ematsumiya@suse.de>, Steve French <smfrench@gmail.com>
CC: "Heckmann, Ilja" <heckmann@izw-berlin.de>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "henrique.carvalho@suse.com"
	<henrique.carvalho@suse.com>
Subject: Re: [[ EXT ]] [BUG REPORT] cifs/smb data corruption when writing,
 x86_64, kernel 6.6.71
Thread-Topic: [[ EXT ]] [BUG REPORT] cifs/smb data corruption when writing,
 x86_64, kernel 6.6.71
Thread-Index: AQHbnxaMdZRI0DQNpUKr5IityG/s9g==
Date: Thu, 27 Mar 2025 12:48:33 +0000
Message-ID:
 <YT1PR01MB945191C652AEE173CEADBA3EB3A12@YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM>
References:
 <YT1PR01MB9451424C6870795133FB7C96B3A72@YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM>
 <36fb31bf2c854cdc930a3415f5551dcd@izw-berlin.de>
 <CAH2r5mtNtyqZBpT8hL2xvZ8QYWAymrPR-5LmpZbeTHr_1ATPWg@mail.gmail.com>
 <uildcjpqxzc5nckupgdeeifkrqwrau2qxuc2df2uxuyys3i2k2@iz2bmi6yojyu>
In-Reply-To: <uildcjpqxzc5nckupgdeeifkrqwrau2qxuc2df2uxuyys3i2k2@iz2bmi6yojyu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opentext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT1PR01MB9451:EE_|YT3PR01MB11083:EE_
x-ms-office365-filtering-correlation-id: dfb3bb12-c79f-4f1d-0613-08dd6d2daf01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnJMQ1BhQnEzdTRSUEI2M0EyV1hGNTlySmY2bENUMEtXTTRtWWE1ZlJpQXVr?=
 =?utf-8?B?blVJcVpVaWFGL3dSRGwwb2RsWnJUd2V4bVllMElaUFd4Nm9Hbm1BWW40T2pH?=
 =?utf-8?B?ek82SUoyMkFucG9QZFhteVlkS05pVDcrMlQxdGdJc053TDZodXMvYlJkQk0w?=
 =?utf-8?B?RWo0VGN4c0V1Q0JnVTk2aHdya1FOdXd1Nm80T205WG95WURxN2FyZ0F0TFR4?=
 =?utf-8?B?NGNBR1RvaHJQYld4bnBCeEdTOFBYcm1ORE8rakFwYlVaK1VEMjdCbHFBSVda?=
 =?utf-8?B?aUxEV1NDcUg5Y0paYnlITjl1NHE4STlhUkhvR0RNMHdMSGZHNURYYytPOXNM?=
 =?utf-8?B?TStjK2JUN3laczJTNnpreTQ1UXZzQzlobWZJTlhhWmVjT3FXbUxHOFkrYlMy?=
 =?utf-8?B?WGlnV0pxQ1ZXY3FNYlYyZ3ROcVdZc2Zpb1g3cElaS3F4cEh4WWFkZjZyTmYx?=
 =?utf-8?B?b01iVUo2b2ZueHJGeUdoeGRnaFZiKzBOL2o0VDJMK2RHZVEyTmYvYzBZT2pX?=
 =?utf-8?B?SSt5T1VNdjB0Qmxnc3diV3RUR1hsaERmbFc3OXBQK1cvYXlJRldOTVZObDdI?=
 =?utf-8?B?TUU2cGdnR1lIYTBuY08rSVNJbmRBV2pjZDgvcDFkem84QS85a1ZTaWxjUStS?=
 =?utf-8?B?WkxybWFLQ2lBYnkxR2MxUG5RVUtFMXNQdFRWVnp6dUNhamhqcUV5SXhBazBY?=
 =?utf-8?B?UWZyNWRSZnNteG83MFpTMTVEZXhuZkExMzM2ZTFmTkIweXFkRVRFZmtveHVU?=
 =?utf-8?B?QU8wLzRESklxejFHcEpWSGZjcGlpTlhiRzMwUnd6Z3JMK01wWXhGbXlZMUQ4?=
 =?utf-8?B?VVlrRTJickV0cGhkNFhJU2J2bEEvS293ckdhQUx3SHNtUnlzZkR6RUtXcTdR?=
 =?utf-8?B?bUhhTzVCUWE2ODVvSjNKNHp6cENzeDJiQXRvUVVwb3NJam51M0wxbm1Ydk5P?=
 =?utf-8?B?dUIrRmRLdWJEczNTbnNsU0E0elE2MnA2TDJyd3gwNFpobGZUQm1qUE1JSkpm?=
 =?utf-8?B?RkhDR2haZWdBNlVwVmQzb0pGZUhKMWZVRXVVZjJYbEhlU0c1K2xkd3FwT0hM?=
 =?utf-8?B?eGQzTEk3UEZ2ZVYyTmI3cG9GUHpJdi90V3RMUnhpa2ZKQ3IySWdVOVNIaDUr?=
 =?utf-8?B?bGNuMmFia1dsK0NrYmJjZkdmeHhTYTBFeS9LVWRCQXV5ZUJmb1V2VUtHWjlY?=
 =?utf-8?B?ZnpQak1ja1Q0di9MRk1tYVdYc29LQnh4QXZPSHppN2paZGpnRGdSb3ZnZThF?=
 =?utf-8?B?aHpDZ2o2aTFTc2M1RFlHSWEwRFhWc1YvdmFjYzAvcEw5WkJDeTdtVEY5MlRX?=
 =?utf-8?B?V1JQcVcwbTZrR2Q1TnZsaXVUNjdLcDBaVWhiVXNybmlKbEF2VjQwMldaTU12?=
 =?utf-8?B?UC8rVEZTWWRzdzVtNElMMlBWWjlUdGxPbHBySlJQbThGUzEyNmF3b3l2Vnpl?=
 =?utf-8?B?VUxORkFYWlphbXBZWW1qZVZmZDNXUXR4TEZqM080cS9lbC95NWhEWk5yeEFU?=
 =?utf-8?B?OHNRb0tKN3NQd05aSmR5QU9oN3h6RVVUVmJnR1pCNFM5ZWRtcG1ySEUvU1lp?=
 =?utf-8?B?N2pSa1kyODE1dW04THZoYzY5eG5ub2VrQTFLQUJUZWthT2NzdDFWOHR6R2Z6?=
 =?utf-8?B?NnhvWUd5Vm1iWVVBSDMrS1kzSHhmUEY1Z3dnS1U5WjN0QW5CRFFqMVVocits?=
 =?utf-8?B?Z3lMSlN4UnNLRWM2UEJac3B1TzdKcVlvcW1qZlN1T0tjU3lMVlhXUGo0VCs0?=
 =?utf-8?B?aUpCZnh1M2k3SFNLcjNPa2pxWng2TGZzMVd1eFYrdEE1RTVqZ1hrdXZBUEVD?=
 =?utf-8?B?N0k2RW0yTUhtVndFbFdjY2p0ZWZtSHBqRGRJQk9RckxReW14Nm9Sbk0zT29R?=
 =?utf-8?Q?nnSfJkr6tekZx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEF3SHYwbjhzNFRBU3U1dXFUQmFCa1VYVXoxVkhyMnBEbDhpTGxreEw1ZENX?=
 =?utf-8?B?bUw0bGxtVDFyMDMwY1RWaXdYKyt2OUZJenJxNmh5WUZzY29SUlU1RlBoMm1M?=
 =?utf-8?B?RWhsanRtaFczc3E1QUJ3SkwzZXNTUi9Ub1ZEY01KaGpCK212anVCRTNlQ1I4?=
 =?utf-8?B?ejAveVVuRTR5bENBdEJhYXJlWW9uWmI4RGNrdWFxQTRKdEF5alRpbkxFdjN5?=
 =?utf-8?B?QzVSZis0eWJCNHdGeW1xWkc5Sngvc1hEczhsUjhBcGhDdUJUYjJjRzFDd045?=
 =?utf-8?B?QStFWkhsRHBwMTNvTVFwUGdDeDFmN1crNncxaStlVFVpMTVWekJhNHpuUWNM?=
 =?utf-8?B?eFNjSlRZQ3QzK1ROWkw5cFAvbjNnZW9qNDFCdjYzZmFFK1VPWXpqQmhpNHc0?=
 =?utf-8?B?eVh3Q0JQVVF4NUZLUG1iZ2hYUlFIbzlMTHZ3UG1LTXVUUEE4UjQwZEVUV0Rn?=
 =?utf-8?B?dHpaVytIRTlPcnNUU05Sa2I5a1hWcnRmaXBBbndwTU90ZXM0M3JJYmEyR0d3?=
 =?utf-8?B?dFpHc0l1bU1PajcrcEFjOHVZZnJyNXB2bkR1ZUQ5NW4raFdmMGlCSmIrWFVa?=
 =?utf-8?B?YThjaDNGU2RWQmMrOEJlcEVBWS93NGRtM2tiUDE1a0p3V0FSbmNxZlN3SGwx?=
 =?utf-8?B?VEZnSTJWWStiTnBOU3dva3hLZ3lRelBTQWlubTZDWllRdStpN3hVNTFxcVZh?=
 =?utf-8?B?TU1QM3IrVXdvV0x2TXRlQ2dBbU16S3B4dVBESHREUkVDc3haeHNVQmtHakNG?=
 =?utf-8?B?TUdIbXdpeHczdS9xTFJtVUF3SEFRaEQ4bHZjcnJxNEJEVFFvWkt1RVhhdUVW?=
 =?utf-8?B?UVBKSURZUGd5YlNUWE1YVk1Pam11Yk1Sbm5IMUovTkNpTGc5cXFDYm1uS1JF?=
 =?utf-8?B?QVZMMHRJTTE1d2YyVlRpQjEvczVCSHB1M1hGTnBQZ3ozd2FXVGFqWnZNcUxZ?=
 =?utf-8?B?MWZkLy9IQ0pkeDNsMkVOQ2hKODFGamg5MmtlN3JjcFZ2ai9zV202OEpUVHRw?=
 =?utf-8?B?cmhlbXlvQkFha29pb0hTMGdtckJZb29MdjFqd1lLV1F6N05tczd2ZVZiQVl0?=
 =?utf-8?B?bzBYSm9hZ0dwUkpvaFdxcS9mUUh5UW9Vc2dCWFBJWmE4MWkyUkpTcjUrRkVN?=
 =?utf-8?B?ZXdmZXFERk5KS3ZvRFZsalJRMkxDV3BOb3FyNzBUbmZVN3I1aVZ4MWc4bVpm?=
 =?utf-8?B?TjRTaGhqcjFDaXJTeTd4WFprcWlqNVFWc3VkTTcvQmRuWXRuZFJhRmV3bW5k?=
 =?utf-8?B?M0dXK3F0Y0hKS051K1BRK25pUks5cGoxdHdzMkFYMDkrMUZEVnJGVzR2SVU2?=
 =?utf-8?B?YXhMeTV2VytJRkhkUm1CYm14ZG52ZDZUekVHREpvQTlqUEVlaWgxOFkvRmp5?=
 =?utf-8?B?ZGZpUC9FSFNGME85MndpWFppSldpNEx0UFpDNVBMZy9EdE5LNFpGVUZmQkdm?=
 =?utf-8?B?aGdHQTdrY1p3TC8rOTAxZWJTS1BySGNHT1Z2bng3WlFxQmVGMWJxT0xiYUQ2?=
 =?utf-8?B?clFzSUVkYlROSWVsV2M4ZzJ0OFFRWXlzTEZFb0srd052ZHJFM3VlbDhEdjJo?=
 =?utf-8?B?Tjc4cUVBSHFDMklCRGtsYWpnWEJzWUszQTllQkhXWnJ0c2p6bUp6MUFJWmds?=
 =?utf-8?B?Mmc1aXBnRFcya05Vd1JVTWdRcCtkaW8wMW9La0E5alRheDV1ZjlWVktXWUZY?=
 =?utf-8?B?MkYybHVTb29PdC8wcHR4VTRWYkMvNWkvT3BEU1dFUTlodkc1MExxQ2hmUEJm?=
 =?utf-8?B?WTJQS1drbjBvMDVCT2pyMmFvSDhzWEcyL0lSTnVuWlg5YlJEaVAxYm5uQ3Fr?=
 =?utf-8?B?ZFVwZVlRVkdyU1JxVGxoTnViNVNXcklnWENyNzV6OHBUeTMzV1BxekdXNHBJ?=
 =?utf-8?B?eERsb2JEWW5CcSt5cXZHSndaeks0cC9jRFNNVFhMN0dEYkhHcFMyL010aVVH?=
 =?utf-8?B?TjMzVVlQS3hBUUZTUWJuei8yenA5QmpEeW5qZm04UmtyOFVieTAxR3VNMFhM?=
 =?utf-8?B?TUNWZko5VEpSVWoxZmNuL3V3SWE2WEprQ2hiT0ZWNXZXdE43bEdJQjZCU0Ev?=
 =?utf-8?B?d081ZHNWSVNpTENZOFNseDc2ZUJ6QWVXQ0lwbnNtcVRnWHpieWNyUzZ4c0Vs?=
 =?utf-8?Q?XcpwdAK436sS72Yo5g4NrR1aN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: opentext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB9451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb3bb12-c79f-4f1d-0613-08dd6d2daf01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 12:48:33.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 10a18477-d533-4ecd-a78d-916dbd849d7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oc9peJQqjvHGMlmzd2DXlRp3C8eFCS3UIJwVE1UT4E7Oj7cYisNYIQyCliCyGBjtoGrPfJK7HtvxY0K5WK7Hpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11083

SGVsbG8sDQoNCj5IZWxsbywNCj4NCj5PbiAwMy8yNiwgU3RldmUgRnJlbmNoIHdyb3RlOg0KPj5X
ZXJlIHlvdSBhYmxlIHRvIGNvbmZpcm0gdGhhdCB0aGUgcHJvYmxlbSBzdGFydGVkIGFmdGVyIDYu
Ni4wIGJ1dCANCj4+cmVncmVzc2VkIGJlZm9yZSA2LjYuOSAtIGFueSBjaGFuY2Ugb2YgbmFycm93
aW5nIHRoZSByZWdyZXNzaW9uIGRvd24gYnkgDQo+PmJpc2VjdGlvbj8NCj4NCj5UaGlzIGxvb2tz
IHNpbWlsYXIgdG8gYSBidWcgd2UgZm91bmQgaW4gb3VyIHY2LjQtYmFzZWQgU0xFUyBwcm9kdWN0
cy4NCj4NCj5CaXNlY3RpbmcgaXQgaW5kaWNhdGVkIHRoZSByZWdyZXNzaW9uIGlzDQo+ZDA4MDg5
ZjY0OWEwICJjaWZzOiBDaGFuZ2UgdGhlIEkvTyBwYXRocyB0byB1c2UgYW4gaXRlcmF0b3IgcmF0
aGVyIHRoYW4gYSBwYWdlIGxpc3QiLg0KPg0KPlRoZSBmaXJzdCBnb29kIGNvbW1pdCB3ZSBmb3Vu
ZCBpcyBhMzk1NzI2Y2Y4MjMgImNpZnM6IGZpeCBkYXRhIGNvcnJ1cHRpb24gaW4gcmVhZCBhZnRl
ciBpbnZhbGlkYXRlIiwgYnV0IGl0IHdhcyBwcm9iYWJseSBhIGJpdCBiZWZvcmUgdGhhdCAod2Ug
ZGlkbid0IGNoZWNrIGZ1cnRoZXIgYmVjYXVzZSB3ZSBjb3VsZG4ndCBhZmZvcmQgdG8gYmFja3Bv
cnQgYWxsIG5ldGZzIG1vZGlmaWNhdGlvbnMpLg0KPg0KPlRoaXMgaXMgdGhlIGZpeCB3ZSB1c2Vk
IChyZWJhc2VkIG9uIHRvcCBvZiB2Ni42LjcxIHRhZyk6DQo+aHR0cHM6Ly9naXQuZXhpcy50ZWNo
L2xpbnV4LmdpdC9jb21taXQvP2g9ZGF0YV9jb3JydXB0aW9uX3Y2LngmaWQ9OGQ0YzQwZTA4NGYz
ZDEzMjQzNGQ1ZDNkMDY4MTc1YzhkYjU5Y2U2NQ0KDQpJIHRyaWVkIGZvbGxvd2luZyB0aGUgbGlu
ayBidXQgaXQgZ2F2ZSBtZSBhICI1MDIgQmFkIEdhdGV3YXkiIGVycm9yLCBJIGFsc28gdHJpZWQg
dGhlIGxpbmsgb24gbXkgcGVyc29uYWwgbWFjaGluZSBhdCBob21lIGluIGNhc2UgaXQgd2FzIG15
IGNvcnBvcmF0ZSBuZXR3b3JrIGJsb2NraW5nIHRoaW5ncywgc2FtZSByZXN1bHQuIEkgZG9uJ3Qg
a25vdyBob3cgYmlnIHRoZSBwYXRjaCBpcy4gQW55IGNoYW5jZSB5b3UgY291bGQganVzdCBkcm9w
IGl0IGluIHRoaXMgdGhyZWFkPw0KDQo+DQo+QElsamEgQE1hcmsgY291bGQgeW91IHRlc3QgaXQg
d2l0aCB5b3VyIHJlcHJvZHVjZXIgcGxlYXNlPw0KPkBTdGV2ZSBjYW4geW91IHRyeSBpdCB3aXRo
IHRoZSByZXByb2R1Y2VyIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgcGxlYXNlPw0K
Pg0KDQpJIHdvdWxkIGJlIGhhcHB5IHRvIHRyeSBpdCBvdXQuDQoNClRoYW5rcyENCk1hcmsNCg0K
Pg0KPkNoZWVycywNCj4NCj5FbnpvDQo+DQo+Pk9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDU6MTPi
gK9BTSBIZWNrbWFubiwgSWxqYSA8aGVja21hbm5AaXp3LWJlcmxpbi5kZT4gd3JvdGU6DQo+Pj4N
Cj4+PiBXZSByYW4gaW50byB3aGF0IHByb2JhYmx5IGlzIHRoZSBzYW1lIHByb2JsZW0gd2l0aCBz
aWxlbnQgZGF0YSBjb3JydXB0aW9uIHRoYXQgd2FzIG9ubHkgbm90aWNlZCB0aGFua3MgdG8gdXNp
bmcgYSBkYXRhIGZvcm1hdCB3aXRoIGludGVybmFsIGNoZWNrc3Vtcy4gSXQgYWxzbyB3ZW50IGF3
YXkgd2hlbiBtb3VudGluZyBhIHNoYXJlIHdpdGggImNhY2hlPW5vbmUiIHdoaWxlIHJ1bm5pbmcg
dGhlIGtlcm5lbCA2LjYuOSwgYnV0IHRoYXQgaGFkIHRoZSBzaWRlLWVmZmVjdCB0aGF0IG5vIGV4
ZWN1dGFibGVzIGNvdWxkIGJlIHN0YXJ0ZWQgZnJvbSB0aGUgc2hhcmUgKEkgcmVwb3J0ZWQgdGhp
cyBpbiBKdW5lIDIwMjQpLiBUaGlzIHNlY29uZCBwcm9ibGVtIHdhcyBmaXhlZCBpbiA2LjEwLCBi
dXQgYXQgdGhlIHNhbWUgdGltZSBtb3VudGluZyB3aXRoICJjYWNoZT1ub25lIiBzdG9wcGVkIGhl
bHBpbmcgYWdhaW5zdCB0aGUgZGF0YSBjb3JydXB0aW9uIGlzc3VlLiBJdCBwZXJzaXN0cyB1bnRp
bCBub3csIHdpdGgga2VybmVsIDYuMTIuOCwgYWx0aG91Z2ggdGhlIGZyZXF1ZW5jeSBhdCB3aGlj
aCB0aGUgcHJvYmxlbSBtYW5pZmVzdHMgd2VudCBkb3duIHNpZ25pZmljYW50bHkuDQo+Pj4NCj4+
PiBUaGUgd2F5IHdlIHRlc3QgZm9yIGl0IGlzIGJ5IHJ1bm5pbmcgYSBjZXJ0YWluIHdvcmtsb2Fk
IDEwMCB0aW1lcyBpbiBhIGxvb3AgYW5kIGNvdW50aW5nIHRoZSBudW1iZXIgb2YgcnVucyBhYm9y
dGVkIGJlY2F1c2Ugb2YgZXJyb3JzLiBUaGF0IG51bWJlciB3ZW50IGRvd24gZnJvbSBhYm91dCAx
MCBwZXIgMTAwIHJ1bnMgd2l0aCBrZXJuZWwgNi42LjkgdG8gYWJvdXQgMSBwZXIgMTAwIHJ1bnMg
d2l0aCA2LjEyLjguIEl0cyBub24tZGV0ZXJtaW5pc3RpYyBuYXR1cmUgYW5kIHRoZSBsYWNrIG9m
IGluLWhvdXNlIGV4cGVydGlzZSB0byBpbnZlc3RpZ2F0ZSB0aGUgaXNzdWUgYXQgdGhlIHNhbWUg
bGV2ZWwgYXMgTWFyayBkaWQgc3RvcHBlZCB1cyBmcm9tIHJlcG9ydGluZyBpdCBzbyBmYXIuIEFu
ZCB3aGlsZSB0aGVyZSBpcyBubyB3YXkgb2Yga25vd2luZyB0aGF0IHRoZSBpc3N1ZSB3ZSBvYnNl
cnZlIGluIDYuMTIuOCBpcyB0aGUgc2FtZSBvbmUsIGF0IGxlYXN0IEkgY2FuIGNvbmZpcm0gdGhh
dCB0aGVyZSBpcyBhIHNpbWlsYXIgaXNzdWUgaW4gbW9yZSByZWNlbnQga2VybmVsIHZlcnNpb25z
IGFzIHdlbGwuDQo+Pj4NCj4+PiBCZXN0IHdpc2hlcywNCj4+PiBJbGphIEhlY2ttYW5uDQo+Pj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+IFZvbjogTWFyayBB
IFdoaXRpbmcgPHdoaXRpbmdtQG9wZW50ZXh0LmNvbT4NCj4+PiBHZXNlbmRldDogRGllbnN0YWcs
IDI1LiBNw6RyeiAyMDI1IDIyOjI0OjU1DQo+Pj4gQW46IGxpbnV4LWNpZnNAdmdlci5rZXJuZWwu
b3JnDQo+Pj4gQmV0cmVmZjogW1sgRVhUIF1dIFtCVUcgUkVQT1JUXSBjaWZzL3NtYiBkYXRhIGNv
cnJ1cHRpb24gd2hlbiANCj4+PiB3cml0aW5nLCB4ODZfNjQsIGtlcm5lbCA2LjYuNzENCj4+Pg0K
Pj4+IEhlbGxvLA0KPj4+DQo+Pj4gSSBoYXZlIGRpc2NvdmVyZWQgYSBkYXRhIGNvcnJ1cHRpb24g
aXNzdWUgd2l0aCBvdXIgYXBwbGljYXRpb24gd3JpdGluZyB0byBhIENJRlMgc2hhcmUuIEkgYmVs
aWV2ZSB0aGlzIGlzc3VlIG1heSBiZSByZWxhdGVkIHRvIGFub3RoZXIgcmVwb3J0IEkgc2F3IG9u
IHRoaXMgbWFpbGluZyBsaXN0LCBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtY2lmcy9ERkMxREFDNS01QzZDLTREQzItODA3QS1EQUYxMkU0
Qjc4ODJAZ21haWwuY29tL19fOyEhT2JiY2s2a1RKQSFZNk1TQW9OTUZwTlhiSVNqdUVrXzlXN1lP
TlRYY054UjU0U1dYdVYtRXAycUhBbGtlaDEwWERabjNXMGVDVml4ZTR6Z25XUllPUHlZaVpCMHNN
ZG9aZyQgLiBJIHVuZGVyc3RhbmQgdGhhdCB1cGRhdGluZyB0byBhIG5ld2VyIGtlcm5lbCB3b3Vs
ZCBsaWtlbHkgZml4IHRoaXMgaXNzdWUuIEhvd2V2ZXIsIGF0IHRoZSBtb21lbnQsIHRoYXQncyBu
b3QgYW4gb3B0aW9uIGZvciB1cy4gSW4gdGhlIGxvbmcgdGVybSB3ZSBhcmUgbG9va2luZyB0byB1
cGdyYWRlIHRvIDYuMTIgYnV0IEknbSBob3BpbmcgdG8gZmluZCBhIHNvbHV0aW9uIGZvciBvdXIg
Y3VycmVudCA2LjYga2VybmVsLg0KPj4+DQo+Pj4gSSBoYXZlIHRlc3RlZCBtb3VudGluZyB3aXRo
IHRoZSAiY2FjaGU9bm9uZSIgb3B0aW9uIGFuZCB0aGF0IHNvbHZlcyB0aGUgcHJvYmxlbSwgYWxi
ZWl0IHdpdGggYSB2ZXJ5IGxhcmdlIHBlcmZvcm1hbmNlIGhpdC4NCj4+Pg0KPj4+IFRoZSBwbGF0
Zm9ybSBpcyBhbiBlbWJlZGRlZCBzeXN0ZW0uIFdlJ3JlIHVzaW5nIGFuIG9mZi10aGUtc2hlbGYg
Q09NIEV4cHJlc3MgVHlwZSA3IG1vZHVsZSB3aXRoIGFuIEludGVsIFhFT04gRC0xNzEzTlQgcHJv
Y2Vzc29yLiBXZSdyZSBydW5uaW5nIGEgY3VzdG9tIExpbnV4IHN5c3RlbSBidWlsdCB1c2luZyBC
dWlsZHJvb3QsIGN1cnJlbnRseSBydW5uaW5nIHRoZSA2LjYuNzEga2VybmVsLiBJJ3ZlIHRlc3Rl
ZCB0aGUgbGF0ZXN0IDYuNi44NCBrZXJuZWwgYW5kIHRoZSBwcm9ibGVtIHN0aWxsIGV4aXN0cyB0
aGVyZS4gT3VyIGFwcGxpY2F0aW9uIGlzIHdyaXRpbmcgbGFyZ2UgYW1vdW50cyBvZiBjb21wcmVz
c2VkIGRhdGEgKDQrIEdCKSB0byB0aGUgbmV0d29yayBzaGFyZS4gV2hlbiBJIHJlYWQgYmFjayB0
aGUgZGF0YSB0byB2ZXJpZnkgaXQsIEknbSBzZWVpbmcgc21hbGwgcG9ydGlvbnMgb2YgdGhlIGZp
bGUgdGhhdCBoYXZlIGJlZW4gcmVwbGFjZWQgd2l0aCB6ZXJvcy4NCj4+Pg0KPj4+IEkndmUgYXR0
YWNrZWQgdGhlIGlzc3VlIGZyb20gc2V2ZXJhbCBhbmdsZXMuIFN0YXJ0aW5nIHdpdGggYSBUQ1Ag
ZHVtcCBvZiBhIGNvbXBsZXRlIG9wZXJhdGlvbiBmcm9tIG1vdW50aW5nLCBkYXRhIHRyYW5zZmVy
LCB0byB1bm1vdW50aW5nIHRoZSBuZXR3b3JrIHNoYXJlLiBUaHJvdWdoIFdpcmVzaGFyayBJIGNh
biBzZWUgdGhhdCB0aGVyZSBpcyBubyB3cml0ZSBjb21tYW5kIHRvIHRoZSBzZXJ2ZXIgY292ZXJp
bmcgdGhlIHNlY3Rpb25zIG9mIHRoZSBvdXRwdXQgdGhhdCBlbmRzIHVwIGFzIHplcm9zLiBUaGlz
IGluZGljYXRlZCB0byBtZSB0aGF0IHRoZSBDSUZTIGtlcm5lbCBkcml2ZXIgaXMgZmFpbGluZyB0
byB3cml0ZSBvdXQgcG9ydGlvbnMgb2YgdGhlIGZpbGUuDQo+Pj4NCj4+PiBJIHRoZW4gZW5hYmxl
ZCBhbGwgdGhlIENJRlMgZGVidWcgaW5mbyBJIGNvdWxkIHZpYSBjaWZzRllJIGFuZCB0aGUga2Vy
bmVsIGR5bmFtaWMgZGVidWcgY29udHJvbHMgYW5kIHR3ZWFrZWQgdGhlIGNvZGUgdG8gbm90IHJh
dGUgbGltaXQgdGhlIHByX2RlYnVnIGNhbGxzLiBJIGNvdWxkIHRyYWNlIHRocm91Z2ggdGhlIHJl
c3VsdGluZyBsb2dzIGFuZCBmaW5kIHBhaXJzIG9mIGNpZnNfd3JpdGVfYmVnaW4oKSAvIGNpZnNf
d3JpdGVfZW5kKCkgdGhhdCBjb3ZlcmVkIGFsbCB0aGUgZGF0YSBpbmNsdWRpbmcgdGhlIHNlY3Rp
b25zIHRoYXQgdWx0aW1hdGVseSBkb24ndCBnZXQgd3JpdHRlbiBvdXQuIEhvd2V2ZXIsIHRyYWNp
bmcgdGhyb3VnaCB0aGUgc21iMl9hc3luY193cml0ZXYoKSBtZXNzYWdlcyBJIGFnYWluIGNvdWxk
IG5vdCBmaW5kIGFueSB3cml0ZXMgdGhhdCBjb3ZlcmVkIHRoZSBjb3JydXB0IHBvcnRpb25zLiBB
dCB0aGlzIHBvaW50IEkgYmVnYW4gdG8gc3VzcGVjdCBzb21lIGtpbmQgb2YgcmFjZSBjb25kaXRp
b24gd2l0aGluIHRoZSBjaWZzX3dyaXRlcGFnZXMoKSBmdW5jdGlvbi4NCj4+Pg0KPj4+IEkgYWxz
byBhbmFseXplZCB0aGUgZGF0YSBjb3JydXB0aW9uIGFuZCBub3RpY2VkIGEgcGF0dGVybi4gSXQg
ZG9lcyBub3QgZmFpbCAxMDAlIG9mIHRoZSB0aW1lLCBhbmQgaXQgZG9lcyBub3QgYWx3YXlzIGZh
aWwgaW4gdGhlIHNhbWUgcGxhY2UuIFRoaXMgZnVydGhlcmVkIG15IGJlbGllZiB0aGF0IGl0IHdh
cyBzb21lIGtpbmQgb2Ygbm9uLWRldGVybWluaXN0aWMgZGF0YSByYWNlLiBUaGUgY29ycnVwdCBk
YXRhIHJlZ2lvbiBpcyBhbHdheXMgbGVzcyB0aGFuIGEgcGFnZSBpbiBzaXplICg8NDA5NiBieXRl
cyksIGl0J3MgYWx3YXlzIHplcm9zLCBhbmQgaXQgYWx3YXlzIGVuZHMgb24gYSBwYWdlIGJvdW5k
YXJ5LiBCZWNhdXNlIEkga25ldyB0aGUgZXhwZWN0ZWQgZm9ybWF0IG9mIHRoZSBkYXRhLCBJIGNv
dWxkIGFsc28gdGVsbCB0aGF0IHRoZSBjb3JydXB0IGRhdGEgd2FzIGFsd2F5cyBhdCB0aGUgYmVn
aW5uaW5nIG9mIGEgd3JpdGUgc3lzY2FsbCBieSBvdXIgYXBwbGljYXRpb24uDQo+Pj4NCj4+PiBJ
J3ZlIGF0dGVtcHRlZCB0byByZWFkIHRocm91Z2ggdGhlIENJRlMga2VybmVsIGNvZGUgaW52b2x2
ZWQgaW4gdGhpcy4gQnV0IEkndmUgbmV2ZXIgd29ya2VkIGluIHRoZSBWRlMvZmlsZXN5c3RlbSBs
YXllcnMgYmVmb3JlLiBBbmQgSSdtIGhhdmluZyB0cm91YmxlIGZvbGxvd2luZyAvIHVuZGVyc3Rh
bmRpbmcgdGhlIGludHJpY2FjaWVzIG9mIHRoZSBwYWdlIGNhY2hlLCBwYWdlIGRpcnR5aW5nL2Ns
ZWFuaW5nLCBhbmQgd3JpdGViYWNrLg0KPj4+DQo+Pj4gTXkgY3VycmVudCBiZXN0IGd1ZXNzIGF0
IHdoYXQncyBoYXBwZW5pbmcgaXMgYXMgZm9sbG93czoNCj4+PiAgICAgKiBPdXIgYXBwbGljYXRp
b24gd3JpdGVzIG91dCBhIGJ1ZmZlciBvZiBkYXRhIHRvIHRoZSBmaWxlIG9uIGEgQ0lGUyBzaGFy
ZSwgdGhpcyBpcyBjb21wcmVzc2VkIGRhdGEgdGhhdCBpc24ndCBuaWNlbHkgYWxpZ25lZCwgdGhl
IGRhdGEgZG9lcyBub3QgZW5kIG9uIGEgcGFnZSBib3VuZGFyeS4gVGhpcyBpcyBhIG5ld2x5IGNy
ZWF0ZWQgZmlsZSB0aGF0IHdlIGFyZSB3cml0aW5nIHRvLCBzbyB0aGlzIHdyaXRlIGV4dGVuZHMg
dGhlIGZpbGVzIEVPRiB0byB0aGUgZW5kIG9mIHRoZSBuZXdseSB3cml0dGVuIGRhdGEgd2hpY2gg
aXMgaW4gdGhlIG1pZGRsZSBvZiBhIHBhZ2UgaW4gdGhlIGNhY2hlLg0KPj4+ICAgICAqIGNpZnNf
d3JpdGVwYWdlcygpIGlzIGludm9rZWQgdG8gd3JpdGUgdGhlIGNhY2hlZCBkYXRhIGJhY2sgdG8g
dGhlIHNlcnZlciwgaXQgc2NhbnMgdGhlIGNhY2hlZCBwYWdlcyBhbmQgcHJlcGFyZXMgdG8gd3Jp
dGUgb3V0IGFsbCB0aGUgZGlydHkgcGFnZXMgKGluY2x1ZGluZyB0aGUgZmluYWwgcGFydGlhbCBw
YWdlKS4NCj4+PiAgICAgKiBPdXIgYXBwbGljYXRpb24gcGVyZm9ybXMgYW5vdGhlciB3cml0ZS4g
VGhpcyBleHRlbmRzIHRoZSBmaWxlIGFuZCB0aGUgYmVnaW5uaW5nIG9mIHRoaXMgd3JpdGUgZmFs
bHMgaW50byB0aGUgZW5kIG9mIHRoZSBwcmV2aW91cyBmaW5hbCBwYXJ0aWFsIGNhY2hlZCBwYWdl
Lg0KPj4+ICAgICAqIGNpZnNfd3JpdGVwYWdlcygpIGZpbmlzaGVzIHdyaXRpbmcgb3V0IHRoZSBk
aXJ0eSBwYWdlcywgaW5jbHVkaW5nIHRoZSBmaXJzdCBwb3J0aW9uIG9mIHdoYXQgaXQgdGhvdWdo
dCB3YXMgdGhlIGZpbmFsIHBhcnRpYWwgcGFnZSwgYW5kIG1hcmtzIGFsbCBwYWdlcyBhcyBjbGVh
bi4NCj4+PiAgICAgKiBPbiB0aGUgbmV4dCBpbnZvY2F0aW9uIG9mIGNpZnNfd3JpdGVwYWdlcygp
LCBpdCBzY2FucyBmb3IgZGlydHkgcGFnZXMgYW5kIHNraXBzIHRoZSBiZWdpbm5pbmcgb2YgdGhl
IHNlY29uZCB3cml0ZSBiZWNhdXNlIGl0IHRoaW5rcyB0aGF0IHBhZ2UgaXMgY2xlYW4uIFRoZSBm
b2xsb3dpbmcgcGFnZSBpcyBhIGNvbXBsZXRlbHkgbmV3IHBhZ2UgYW5kIGlzIGRpcnR5LCBzbyBp
dCBzdGFydHMgYSBuZXcgd3JpdGUgZnJvbSB0aGF0IHBhZ2UuIFRoaXMgd291bGQgZXhwbGFpbiB3
aHkgdGhlIGNvcnJ1cHRpb24gaXMgYWx3YXlzIGF0IHRoZSBiZWdpbm5pbmcgb2Ygb3VyIGFwcGxp
Y2F0aW9uJ3Mgd3JpdGUgYW5kIGNvcnJlY3RzIGl0c2VsZiBhdCB0aGUgbmV4dCBwYWdlIGJvdW5k
YXJ5Lg0KPj4+DQo+Pj4gSSBoYXZlIHlldCB0byByZWFsbHkgcHJvdmUgdGhpcywgYnV0IHRoaXMg
dHlwZSBvZiByYWNlIGJldHdlZW4gZGlydHkvY2xlYW4gcGFnZXMgd291bGQgZXhwbGFpbiBhbGwg
dGhlIGJlaGF2aW9yIEknbSBzZWVpbmcuIEknbSBob3Bpbmcgc29tZW9uZSBtdWNoIG1vcmUgaW50
aW1hdGVseSBmYW1pbGlhciB3aXRoIHRoZSBDSUZTIGNvZGUgY2FuIGhlbHAgcG9pbnQgbWUgaW4g
dGhlIHJpZ2h0IGRpcmVjdGlvbi4NCj4+Pg0KPj4+IEkgZGlkIHRyeSBvbmUgcXVpY2sgYW5kIGRp
cnR5IGZpeCwgYXNzdW1pbmcgaXQgd2FzIGEgcmFjZSBJIGFwcGxpZWQgdGhlIGZvbGxvd2luZyBw
YXRjaC4gVGhpcyBhZGRlZCBhIHBlciBpbm9kZSBtdXRleCB0aGF0IGNvbXBsZXRlbHkgc2VyaWFs
aXplZCB0aGUgY2lmc193cml0ZV9iZWdpbigpLCBjaWZzX3dyaXRlX2VuZCgpLCBhbmQgY2lmc193
cml0ZXBhZ2VzKCkgZnVuY3Rpb25zLiBUaGlzIGRpZCBzZWVtIHRvIHJlc29sdmUgdGhlIGRhdGEg
Y29ycnVwdGlvbiBpc3N1ZSwgYnV0IGF0IHRoZSBjb3N0IG9mIG9jY2FzaW9uYWwgZGVhZGxvY2tz
IHdyaXRpbmcgdG8gQ0lGUyBmaWxlcy4NCj4+Pg0KPj4+ID4gZGlmZiAtLWdpdCBhL2ZzL3NtYi9j
bGllbnQvY2lmc2ZzLmMgYi9mcy9zbWIvY2xpZW50L2NpZnNmcy5jIGluZGV4IA0KPj4+ID4gYmJi
MGVmMThkN2I4Li42ZTJlMjczYjk4MzggMTAwNjQ0DQo+Pj4gPiAtLS0gYS9mcy9zbWIvY2xpZW50
L2NpZnNmcy5jDQo+Pj4gPiArKysgYi9mcy9zbWIvY2xpZW50L2NpZnNmcy5jDQo+Pj4gPiBAQCAt
MTY1OSw2ICsxNjU5LDcgQEAgY2lmc19pbml0X29uY2Uodm9pZCAqaW5vZGUpDQo+Pj4gPg0KPj4+
ID4gICAgICAgaW5vZGVfaW5pdF9vbmNlKCZjaWZzaS0+bmV0ZnMuaW5vZGUpOw0KPj4+ID4gICAg
ICAgaW5pdF9yd3NlbSgmY2lmc2ktPmxvY2tfc2VtKTsNCj4+PiA+ICsgICAgIG11dGV4X2luaXQo
JmNpZnNpLT50Ymxfd3JpdGVfbXV0ZXgpOw0KPj4+ICA+IH0NCj4+PiAgPg0KPj4+ID4gIHN0YXRp
YyBpbnQgX19pbml0DQo+Pj4gPiBkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5o
IGIvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oIA0KPj4+ID4gaW5kZXggNDNiNDJlY2E2NzgwLi40
YWY0YzUwMzZkODEgMTAwNjQ0DQo+Pj4gPiAtLS0gYS9mcy9zbWIvY2xpZW50L2NpZnNnbG9iLmgN
Cj4+PiA+ICsrKyBiL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaA0KPj4+ID4gQEAgLTE2MDYsNiAr
MTYwNiwxNyBAQCBzdHJ1Y3QgY2lmc0lub2RlSW5mbyB7DQo+Pj4gPiAgICAgICBib29sIGxlYXNl
X2dyYW50ZWQ7IC8qIEZsYWcgdG8gaW5kaWNhdGUgd2hldGhlciBsZWFzZSBvciBvcGxvY2sgaXMg
Z3JhbnRlZC4gKi8NCj4+PiA+ICAgICAgIGNoYXIgKnN5bWxpbmtfdGFyZ2V0Ow0KPj4+ID4gICAg
ICAgX191MzIgcmVwYXJzZV90YWc7DQo+Pj4gPiArDQo+Pj4gPiArICAgICAvKiBEdXJpbmcgZGV2
ZWxvcG1lbnQgd2UgZGlzY292ZXJlZCB3aGF0IHdlIGJlbGlldmUgdG8gYmUgYSByYWNlIGNvbmRp
dGlvbg0KPj4+ID4gKyAgICAgICogaW4gdGhlIHdyaXRlIGNhY2hpbmcgYmVoYXZpb3Igb2YgY2lm
cy4gU2V0dGluZyBjYWNoZT1ub25lIHNvbHZlZCB0aGUNCj4+PiA+ICsgICAgICAqIGlzc3VlIGJ1
dCB3aXRoIGFuIHVuYWNjZXB0YWJsZSBwZXJmb3JtYW5jZSBoaXQuIFRoZSBmb2xsb3dpbmcgbXV0
ZXggd2FzDQo+Pj4gPiArICAgICAgKiBhZGRlZCB0byBzZXJpYWxpemUgdGhlIGNpZnNfd3JpdGVf
YmVnaW4sIGNpZnNfd3JpdGVfZW5kLCBhbmQNCj4+PiA+ICsgICAgICAqIGNpZnNfd3JpdGVwYWdl
cyBmdW5jdGlvbnMgaW4gZmlsZS5jLiBUaGlzIGFwcGVhcnMgdG8gc29sdmUgdGhlIGlzc3VlDQo+
Pj4gPiArICAgICAgKiB3aXRob3V0IGNvbXBsZXRlbHkgZGlzYWJsaW5nIGNhY2hpbmcuDQo+Pj4g
PiArICAgICAgKg0KPj4+ID4gKyAgICAgICogLU1hcmsgV2hpdGluZyAod2hpdGluZ21Ab3BlbnRl
eHQuY29tKQ0KPj4+ID4gKyAgICAgICovDQo+Pj4gPiArICAgICBzdHJ1Y3QgbXV0ZXggdGJsX3dy
aXRlX211dGV4Ow0KPj4+ID4gIH07DQo+Pj4gPg0KPj4+ID4gIHN0YXRpYyBpbmxpbmUgc3RydWN0
IGNpZnNJbm9kZUluZm8gKiBkaWZmIC0tZ2l0IA0KPj4+ID4gYS9mcy9zbWIvY2xpZW50L2ZpbGUu
YyBiL2ZzL3NtYi9jbGllbnQvZmlsZS5jIGluZGV4IA0KPj4+ID4gY2I3NWI5NWVmYjcwLi5kM2Jj
NjUyYTdlNjUgMTAwNjQ0DQo+Pj4gPiAtLS0gYS9mcy9zbWIvY2xpZW50L2ZpbGUuYw0KPj4+ID4g
KysrIGIvZnMvc21iL2NsaWVudC9maWxlLmMNCj4+PiA+IEBAIC0zMDg1LDYgKzMwODUsNyBAQCBz
dGF0aWMgaW50IGNpZnNfd3JpdGVwYWdlcyhzdHJ1Y3QgDQo+Pj4gPiBhZGRyZXNzX3NwYWNlICpt
YXBwaW5nLCAgew0KPj4+ID4gICAgICAgbG9mZl90IHN0YXJ0LCBlbmQ7DQo+Pj4gPiAgICAgICBp
bnQgcmV0Ow0KPj4+ID4gKyAgICAgbXV0ZXhfbG9jaygmQ0lGU19JKG1hcHBpbmctPmhvc3QpLT50
Ymxfd3JpdGVfbXV0ZXgpOw0KPj4+ID4NCj4+PiA+ICAgICAgIC8qIFdlIGhhdmUgdG8gYmUgY2Fy
ZWZ1bCBhcyB3ZSBjYW4gZW5kIHVwIHJhY2luZyB3aXRoIHNldGF0dHIoKQ0KPj4+ID4gICAgICAg
ICogdHJ1bmNhdGluZyB0aGUgcGFnZWNhY2hlIHNpbmNlIHRoZSBjYWxsZXIgZG9lc24ndCB0YWtl
IGEgDQo+Pj4gPiBsb2NrIGhlcmUgQEAgLTMxMTksNiArMzEyMCw3IEBAIHN0YXRpYyBpbnQgY2lm
c193cml0ZXBhZ2VzKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPj4+ID4gICAgICAg
fQ0KPj4+ID4NCj4+PiA+ICBvdXQ6DQo+Pj4gPiArICAgICBtdXRleF91bmxvY2soJkNJRlNfSSht
YXBwaW5nLT5ob3N0KS0+dGJsX3dyaXRlX211dGV4KTsNCj4+PiA+ICAgICAgIHJldHVybiByZXQ7
DQo+Pj4gPiAgfQ0KPj4+ID4NCj4+PiA+IEBAIC0zMTc0LDYgKzMxNzYsOCBAQCBzdGF0aWMgaW50
IGNpZnNfd3JpdGVfZW5kKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAq
bWFwcGluZywNCj4+PiA+ICAgICAgIHN0cnVjdCBmb2xpbyAqZm9saW8gPSBwYWdlX2ZvbGlvKHBh
Z2UpOw0KPj4+ID4gICAgICAgX191MzIgcGlkOw0KPj4+ID4NCj4+PiA+ICsgICAgIG11dGV4X2xv
Y2soJkNJRlNfSShtYXBwaW5nLT5ob3N0KS0+dGJsX3dyaXRlX211dGV4KTsNCj4+PiA+ICsNCj4+
PiA+ICAgICAgIGlmIChjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNfTU9VTlRfUldQSURG
T1JXQVJEKQ0KPj4+ID4gICAgICAgICAgICAgICBwaWQgPSBjZmlsZS0+cGlkOw0KPj4+ID4gICAg
ICAgZWxzZQ0KPj4+ID4gQEAgLTMyMzMsNiArMzIzNyw3IEBAIHN0YXRpYyBpbnQgY2lmc193cml0
ZV9lbmQoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0K
Pj4+ID4gICAgICAgLyogSW5kaWNhdGlvbiB0byB1cGRhdGUgY3RpbWUgYW5kIG10aW1lIGFzIGNs
b3NlIGlzIGRlZmVycmVkICovDQo+Pj4gPiAgICAgICBzZXRfYml0KENJRlNfSU5PX01PRElGSUVE
X0FUVFIsICZDSUZTX0koaW5vZGUpLT5mbGFncyk7DQo+Pj4gPg0KPj4+ID4gKyAgICAgbXV0ZXhf
dW5sb2NrKCZDSUZTX0kobWFwcGluZy0+aG9zdCktPnRibF93cml0ZV9tdXRleCk7DQo+Pj4gPiAg
ICAgICByZXR1cm4gcmM7DQo+Pj4gPiAgfQ0KPj4+ID4NCj4+PiA+IEBAIC00OTA1LDYgKzQ5MTAs
NyBAQCBzdGF0aWMgaW50IGNpZnNfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPj4+ID4gICAgICAgaW50IHJjID0gMDsNCj4+PiA+
DQo+Pj4gPiAgICAgICBjaWZzX2RiZyhGWUksICJ3cml0ZV9iZWdpbiBmcm9tICVsbGQgbGVuICVk
XG4iLCAobG9uZyANCj4+PiA+IGxvbmcpcG9zLCBsZW4pOw0KPj4+ID4gKyAgICAgbXV0ZXhfbG9j
aygmQ0lGU19JKG1hcHBpbmctPmhvc3QpLT50Ymxfd3JpdGVfbXV0ZXgpOw0KPj4+ID4NCj4+PiA+
ICBzdGFydDoNCj4+PiA+ICAgICAgIHBhZ2UgPSBncmFiX2NhY2hlX3BhZ2Vfd3JpdGVfYmVnaW4o
bWFwcGluZywgaW5kZXgpOyBAQCANCj4+PiA+IC00OTY1LDYgKzQ5NzEsNyBAQCBzdGF0aWMgaW50
IGNpZnNfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nLA0KPj4+ID4gICAgICAgICAgICAgICAgICB0aGlzIHdpbGwgYmUgd3JpdHRlbiBv
dXQgYnkgd3JpdGVfZW5kIHNvIGlzIGZpbmUgKi8NCj4+PiA+ICAgICAgIH0NCj4+PiA+ICBvdXQ6
DQo+Pj4gPiArICAgICBtdXRleF91bmxvY2soJkNJRlNfSShtYXBwaW5nLT5ob3N0KS0+dGJsX3dy
aXRlX211dGV4KTsNCj4+PiA+ICAgICAgICpwYWdlcCA9IHBhZ2U7DQo+Pj4gPiAgICAgICByZXR1
cm4gcmM7DQo+Pj4gPiAgfQ0KPj4+DQo+Pj4gSGVyZSBhcmUgc29tZSBvZiB0aGUgbG9nIGV4Y2Vy
cHRzIGZvciBvbmUgb2YgbXkgdGVzdCBjYXNlcy4gSW4gdGhpcyBmaWxlIG9uZSBvZiB0aGUgY29y
cnVwdCByZWdpb25zIHN0YXJ0cyBhdCBmaWxlIG9mZnNldCAxLDA3NCwyMTQsNDc0ICgweDQwMDcz
NjRBKSwgYW5kIHdhcyBjb3JydXB0IGZvciAyLDQ4NiBieXRlcywgZW5kaW5nIG9uIGEgcGFnZSBi
b3VuZGFyeS4gRmlyc3QgdGhlcmUgaXMgYSBzZWN0aW9uIG9mIHRoZSBsb2cgdHJpbW1lZCB0byBq
dXN0IHRoZSBjaWZzX3dyaXRlX2JlZ2luKCkgLyBjaWZzX3dyaXRlX2VuZCgpIGZ1bmN0aW9ucy4g
WW91IGNhbiBzZWUgdGhhdCB0aGVyZSBpcyBhIHdyaXRlIHNob3duIGF0IHRoZSBleGFjdCBvZmZz
ZXQvbGVuZ3RoIG9mIHRoZSBjb3JydXB0ZWQgZGF0YS4NCj4+Pg0KPj4+ID4gTWFyIDI1IDE1OjI1
OjM5IFRYMiBrZXJuZWw6IFsgIDEyNC4wODA5MDBdIFsxNTY3XSANCj4+PiA+IGNpZnNfd3JpdGVf
YmVnaW46NDkwNzogQ0lGUzogZnMvc21iL2NsaWVudC9maWxlLmM6IHdyaXRlX2JlZ2luIGZyb20g
DQo+Pj4gPiAxMDc0MjEyODY0IGxlbiAxNjEwIE1hciAyNSAxNToyNTozOSBUWDIga2VybmVsOiBb
ICAxMjQuMDgwOTA2XSANCj4+PiA+IFsxNTY3XSBjaWZzX3dyaXRlX2VuZDozMTgyOiBDSUZTOiBm
cy9zbWIvY2xpZW50L2ZpbGUuYzogd3JpdGVfZW5kIA0KPj4+ID4gZm9yIHBhZ2UgMDAwMDAwMDA4
NjUxOWFmZCBmcm9tIHBvcyAxMDc0MjEyODY0IHdpdGggMTYxMCBieXRlcyBNYXIgDQo+Pj4gPiAy
NSAxNToyNTozOSBUWDIga2VybmVsOiBbICAxMjQuMDgwOTExXSBbMTU2N10gDQo+Pj4gPiBjaWZz
X3dyaXRlX2JlZ2luOjQ5MDc6IENJRlM6IGZzL3NtYi9jbGllbnQvZmlsZS5jOiB3cml0ZV9iZWdp
biBmcm9tIA0KPj4+ID4gMTA3NDIxNDQ3NCBsZW4gMjQ4NiBNYXIgMjUgMTU6MjU6MzkgVFgyIGtl
cm5lbDogWyAgMTI0LjA4MDkxNl0gDQo+Pj4gPiBbMTU2N10gY2lmc193cml0ZV9lbmQ6MzE4Mjog
Q0lGUzogZnMvc21iL2NsaWVudC9maWxlLmM6IHdyaXRlX2VuZCANCj4+PiA+IGZvciBwYWdlIDAw
MDAwMDAwODY1MTlhZmQgZnJvbSBwb3MgMTA3NDIxNDQ3NCB3aXRoIDI0ODYgYnl0ZXMgTWFyIA0K
Pj4+ID4gMjUgMTU6MjU6MzkgVFgyIGtlcm5lbDogWyAgMTI0LjA4MDkxN10gWzE1NjddIA0KPj4+
ID4gY2lmc193cml0ZV9iZWdpbjo0OTA3OiBDSUZTOiBmcy9zbWIvY2xpZW50L2ZpbGUuYzogd3Jp
dGVfYmVnaW4gZnJvbSANCj4+PiA+IDEwNzQyMTY5NjAgbGVuIDg0NiBNYXIgMjUgMTU6MjU6Mzkg
VFgyIGtlcm5lbDogWyAgMTI0LjA4MDkyNF0gDQo+Pj4gPiBbMTU2N10gY2lmc193cml0ZV9lbmQ6
MzE4MjogQ0lGUzogZnMvc21iL2NsaWVudC9maWxlLmM6IHdyaXRlX2VuZCANCj4+PiA+IGZvciBw
YWdlIDAwMDAwMDAwODgwY2VlMDMgZnJvbSBwb3MgMTA3NDIxNjk2MCB3aXRoIDg0NiBieXRlcw0K
Pj4+DQo+Pj4gTm93IGhlcmUncyBhIHNlY3Rpb24gb2YgdGhlIGxvZyB0cmltbWVkIHRvIGp1c3Qg
dGhlIHNtYjJfYXN5bmNfd3JpdGV2KCkgZnVuY3Rpb24uIFlvdSBjYW4gc2VlIHdyaXRlcyBjb3Zl
cmluZyB0aGUgZGF0YSBpbW1lZGlhdGVseSBiZWZvcmUgYW5kIGFmdGVyIHRoZSBjb3JydXB0ZWQg
cmVnaW9uLCBidXQgdGhlcmUgaXMgbm8gd3JpdGUgdG8gdGhlIGNvcnJ1cHRlZCByZWdpb24uIEkn
bSBhc3N1bWluZyB0aGUgY29ycnVwdGVkIHJlZ2lvbiBpcyBhbHdheXMgemVyb3MgYmVjYXVzZSB0
aGUgc2VydmVyIGlzIGV4dGVuZGluZyBhbmQgemVyby1maWxsaW5nIHRoZSBmaWxlIHRvIHRoZSBu
ZXcgd3JpdGUgb2Zmc2V0IGFmdGVyIHRoZSBnYXAgb2YgdGhlIG1pc3Npbmcgd3JpdGUuDQo+Pj4N
Cj4+PiA+IE1hciAyNSAxNToyNTozOSBUWDIga2VybmVsOiBbICAxMjMuODI5Njk2XSBbMTYzNV0g
DQo+Pj4gPiBzbWIyX2FzeW5jX3dyaXRldjo0OTQ1OiBDSUZTOiBmcy9zbWIvY2xpZW50L3NtYjJw
ZHUuYzogYXN5bmMgd3JpdGUgDQo+Pj4gPiBhdCAxMDcyMjE0MDE2IDk4ODI2MCBieXRlcyBpdGVy
PWYxNDY0IE1hciAyNSAxNToyNTozOSBUWDIga2VybmVsOiBbICANCj4+PiA+IDEyNC4wODEwMTZd
IFsxNjM2XSBzbWIyX2FzeW5jX3dyaXRldjo0OTQ1OiBDSUZTOiANCj4+PiA+IGZzL3NtYi9jbGll
bnQvc21iMnBkdS5jOiBhc3luYyB3cml0ZSBhdCAxMDczMjAxMTUyIDEwMTMzMjIgYnl0ZXMgDQo+
Pj4gPiBpdGVyPWY3NjRhDQo+Pj4gKiogTWlzc2luZyB3cml0ZTogMTA3MzIwMTE1MiArIDEwMTMz
MjIgPSAxMDc0MjE0NDc0ICoqDQo+Pj4gPiBNYXIgMjUgMTU6MjU6MzkgVFgyIGtlcm5lbDogWyAg
MTI0LjA4MzkwMV0gWzE2MzZdIA0KPj4+ID4gc21iMl9hc3luY193cml0ZXY6NDk0NTogQ0lGUzog
ZnMvc21iL2NsaWVudC9zbWIycGR1LmM6IGFzeW5jIHdyaXRlIA0KPj4+ID4gYXQgMTA3NDIxNjk2
MCAzOTU2NCBieXRlcyBpdGVyPTlhOGMgTWFyIDI1IDE1OjI1OjQwIFRYMiBrZXJuZWw6IFsgIA0K
Pj4+ID4gMTI0LjM0MDU1N10gWzE2MzddIHNtYjJfYXN5bmNfd3JpdGV2OjQ5NDU6IENJRlM6IA0K
Pj4+ID4gZnMvc21iL2NsaWVudC9zbWIycGR1LmM6IGFzeW5jIHdyaXRlIGF0IDEwNzQyNTM4MjQg
MTIzNzg0MyBieXRlcyANCj4+PiA+IGl0ZXI9MTJlMzUzDQo+Pj4NCj4+PiBJIGNhbiB2ZXJ5IGVh
c2lseSByZXByb2R1Y2UgdGhpcyB3aXRoIG91ciBhcHBsaWNhdGlvbi4gSWYgYW55b25lIGhhcyBh
bnkgc3VnZ2VzdGlvbnMgdG8gdHJ5LCBhZGRpdGlvbmFsIGxvZ2dpbmcgLyB0cmFjaW5nIHRoZXkg
d291bGQgbGlrZSBtZSB0byBwZXJmb3JtLCBwbGVhc2UgbGV0IG1lIGtub3cuIEkgY2FuIHByb3Zp
ZGUgbW9yZSBkZXRhaWxlZCwgZnVsbCBsb2dzIGlmIGRlc2lyZWQsIGJ1dCB0aGV5J3JlIHF1aXRl
IGxhcmdlLiBJJ2xsIGNvbnRpbnVlIHRvIHJlYWQgdGhyb3VnaCB0aGUgY29kZSBhbmQgdHJ5IHRv
IHVuZGVyc3RhbmQsIGlmIEkgZmluZCBhbnl0aGluZyBJIHdpbGwgdXBkYXRlIHlvdS4NCj4+Pg0K
Pj4+IFRoYW5rcywNCj4+PiBNYXJrIFdoaXRpbmcNCj4+Pg0KPj4+DQo+Pg0KPj4NCj4+LS0NCj4+
VGhhbmtzLA0KPj4NCj4+U3RldmUNCj4+DQo=

