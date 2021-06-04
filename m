Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316A39B4E2
	for <lists+linux-cifs@lfdr.de>; Fri,  4 Jun 2021 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFDIcY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 4 Jun 2021 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIcX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 4 Jun 2021 04:32:23 -0400
X-Greylist: delayed 959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Jun 2021 01:30:37 PDT
Received: from s1.jo-so.de (jo-so.de [IPv6:2a03:4000:8:213::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67CC06174A
        for <linux-cifs@vger.kernel.org>; Fri,  4 Jun 2021 01:30:37 -0700 (PDT)
Received: from mail-relay (helo=jo-so.de)
        by s1.jo-so.de with local-bsmtp (Exim 4.92)
        (envelope-from <joerg@jo-so.de>)
        id 1lp4yR-000m4A-2Z
        for linux-cifs@vger.kernel.org; Fri, 04 Jun 2021 10:14:35 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.94.2)
        (envelope-from <joerg@jo-so.de>)
        id 1lp4yQ-006diV-2y
        for linux-cifs@vger.kernel.org; Fri, 04 Jun 2021 10:14:34 +0200
Date:   Fri, 4 Jun 2021 10:14:34 +0200
From:   =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To:     linux-cifs@vger.kernel.org
Subject: Kernel fails to access file on Fritzbox, but smbget works
Message-ID: <20210604081434.rz63qpcmdhqjjuud@jo-so.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hm2qwm4y2rmolrwb"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


--hm2qwm4y2rmolrwb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Kernel fails to access file on Fritzbox, but smbget works
MIME-Version: 1.0

Hi,

I have a nasty problem. I use a cable router named Fritzbox (6490=C2=A0Cabl=
e,
FritzOS=C2=A07.27) as server, but the kernel (5.10.0-7-amd64, Debian-unstab=
le)
has problems to access the files on the share.

This is a network capture using smbget to fetch a file:

```
107.477947156	client	server	Negotiate Protocol Request
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
        ProtocolId: 0xfe534d42
        Header Length: 64
        Credit Charge: 0
        Channel Sequence: 0
        Reserved: 0000
        Command: Negotiate Protocol (0)
        Credits requested: 31
        Flags: 0x00000000
        Chain Offset: 0x00000000
        Message ID: 0
        Process Id: 0x00000000
        Tree Id: 0x00000000
        Session Id: 0x0000000000000000
        Signature: 00000000000000000000000000000000
        [Response in: 2216]
    Negotiate Protocol Request (0x00)
        [Preauth Hash: 09d3a214a8f08e401aa10f5c46c79bfb4b4cbfea0c181589954d=
f4c325e4b054085bfe90=E2=80=A6]
        StructureSize: 0x0024
        Dialect count: 8
        Security mode: 0x01, Signing enabled
        Reserved: 0000
        Capabilities: 0x0000007f, DFS, LEASING, LARGE MTU, MULTI CHANNEL, P=
ERSISTENT HANDLES, DIRECTORY LEASING, ENCRYPTION
        Client Guid: e612920f-05ad-41f1-b34b-5e7650d1be90
        NegotiateContextOffset: 0x00000078
        NegotiateContextCount: 3
        Reserved: 0000
        Dialect: SMB 2.0.2 (0x0202)
        Dialect: SMB 2.1 (0x0210)
        Dialect: Unknown (0x0222)
        Dialect: Unknown (0x0224)
        Dialect: SMB 3.0 (0x0300)
        Dialect: SMB 3.0.2 (0x0302)
        Dialect: SMB 3.1.0 (deprecated; should be 3.1.1) (0x0310)
        Dialect: SMB 3.1.1 (0x0311)
        Negotiate Context: SMB2_PREAUTH_INTEGRITY_CAPABILITIES=20
        Negotiate Context: SMB2_ENCRYPTION_CAPABILITIES=20
        Negotiate Context: SMB2_NETNAME_NEGOTIATE_CONTEXT_ID=20
107.481115263	server	client	Negotiate Protocol Response
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
        ProtocolId: 0xfe534d42
        Header Length: 64
        Credit Charge: 0
        NT Status: STATUS_SUCCESS (0x00000000)
        Command: Negotiate Protocol (0)
        Credits granted: 1
        Flags: 0x00000001, Response
        Chain Offset: 0x00000000
        Message ID: 0
        Process Id: 0x00000000
        Tree Id: 0x00000000
        Session Id: 0x0000000000000000
        Signature: 00000000000000000000000000000000
        [Response to: 2214]
        [Time from request: 0.003168107 seconds]
    Negotiate Protocol Response (0x00)
        [Preauth Hash: 25b9c1efb89f4aa0d8fa9bddd3a8cf7f72298b00197187801a11=
006578ecbcdf23bcdb9f=E2=80=A6]
        StructureSize: 0x0041
        Security mode: 0x01, Signing enabled
        Dialect: SMB 3.1.1 (0x0311)
        NegotiateContextCount: 2
        Server Guid: 7369c667-ff51-ec4a-29cd-baabf2fbe346
        Capabilities: 0x00000000
        Max Transaction Size: 65696
        Max Read Size: 65564
        Max Write Size: 65584
        Current Time: Jun  4, 2021 09:22:04.866600000 CEST
        Boot Time: Sep 14, 2000 20:34:26.039600000 CEST
        Blob Offset: 0x00000080
        Blob Length: 74
        Security Blob: 604806062b0601050502a03e303ca00e300c060a2b0601040182=
3702020aa32a3028a026=E2=80=A6
        NegotiateContextOffset: 0x000000d0
        Negotiate Context: SMB2_PREAUTH_INTEGRITY_CAPABILITIES=20
        Negotiate Context: SMB2_ENCRYPTION_CAPABILITIES=20
107.482745267	client	server	Session Setup Request, NTLMSSP_NEGOTIATE
107.486012547	server	client	Session Setup Response, Error: STATUS_MORE_PROC=
ESSING_REQUIRED, NTLMSSP_CHALLENGE
107.486294745	client	server	Session Setup Request, NTLMSSP_AUTH, User: WORK=
GROUP\public
107.495302076	server	client	Session Setup Response
107.495509240	client	server	Tree Connect Request Tree: \\server\fritzi
107.498547296	server	client	Tree Connect Response
107.498736847	client	server	Create Request File:=20
107.503489606	server	client	Create Response File:=20
107.503663348	client	server	GetInfo Request FS_INFO/FileFsAttributeInformat=
ion File:=20
107.506197658	server	client	GetInfo Response
107.506366587	client	server	Close Request File:=20
107.509582634	server	client	Close Response
107.509816409	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx
107.517840241	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx
107.518034187	client	server	GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO Fi=
le: WD_blau\Public\J=C3=B6rg-Backup\passwd.kdbx
107.521217971	server	client	GetInfo Response
107.521347702	client	server	Read Request Len:64000 Off:0 File: WD_blau\Publ=
ic\J=C3=B6rg-Backup\passwd.kdbx
107.823992939	server	client	Read Response
=E2=80=A6
108.280977571	client	server	Read Request Len:64000 Off:3840000 File: WD_bla=
u\Public\J=C3=B6rg-Backup\passwd.kdbx
108.284075230	server	client	Read Response
108.284259643	client	server	Read Request Len:48413 Off:3855587 File: WD_bla=
u\Public\J=C3=B6rg-Backup\passwd.kdbx
108.286540047	server	client	Read Response, Error: STATUS_END_OF_FILE
108.286742343	client	server	Close Request File: WD_blau\Public\J=C3=B6rg-Ba=
ckup\passwd.kdbx
108.289520300	server	client	Close Response
```

This is a network capture using mount vers=3Ddefault to fetch the same file.
Accessing the file with md5sum gives `Stale file handle`

```
159.745293999	client	server	Negotiate Protocol Request
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
        ProtocolId: 0xfe534d42
        Header Length: 64
        Credit Charge: 0
        Channel Sequence: 0
        Reserved: 0000
        Command: Negotiate Protocol (0)
        Credits requested: 10
        Flags: 0x00000000
        Chain Offset: 0x00000000
        Message ID: 0
        Process Id: 0x0000d504
        Tree Id: 0x00000000
        Session Id: 0x0000000000000000
        Signature: 00000000000000000000000000000000
        [Response in: 3341]
    Negotiate Protocol Request (0x00)
        [Preauth Hash: 637eee42d4a0314f3fb6050d55a25a0b04070a334135bd5eae14=
c88d2e0acfae84c8312f=E2=80=A6]
        StructureSize: 0x0024
        Dialect count: 4
        Security mode: 0x01, Signing enabled
        Reserved: 0000
        Capabilities: 0x00000077, DFS, LEASING, LARGE MTU, PERSISTENT HANDL=
ES, DIRECTORY LEASING, ENCRYPTION
        Client Guid: 10b7aee0-c6dc-5341-aef1-6c8c1d5bef4e
        NegotiateContextOffset: 0x00000070
        NegotiateContextCount: 4
        Reserved: 0000
        Dialect: SMB 2.1 (0x0210)
        Dialect: SMB 3.0 (0x0300)
        Dialect: SMB 3.0.2 (0x0302)
        Dialect: SMB 3.1.1 (0x0311)
        Negotiate Context: SMB2_PREAUTH_INTEGRITY_CAPABILITIES=20
        Negotiate Context: SMB2_ENCRYPTION_CAPABILITIES=20
        Negotiate Context: SMB2_NETNAME_NEGOTIATE_CONTEXT_ID=20
        Negotiate Context: SMB2_POSIX_EXTENSIONS_CAPABILITIES=20
159.747346324	server	client	Negotiate Protocol Response
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
        ProtocolId: 0xfe534d42
        Header Length: 64
        Credit Charge: 0
        NT Status: STATUS_SUCCESS (0x00000000)
        Command: Negotiate Protocol (0)
        Credits granted: 1
        Flags: 0x00000001, Response
        Chain Offset: 0x00000000
        Message ID: 0
        Process Id: 0x0000d504
        Tree Id: 0x00000000
        Session Id: 0x0000000000000000
        Signature: 00000000000000000000000000000000
        [Response to: 3339]
        [Time from request: 0.002052325 seconds]
    Negotiate Protocol Response (0x00)
        [Preauth Hash: 22993b274035b9b6a3cadf7a6c19b9b757df11aff9a45d7c9c70=
acfc3e830ef0b64034d6=E2=80=A6]
        StructureSize: 0x0041
        Security mode: 0x01, Signing enabled
        Dialect: SMB 3.1.1 (0x0311)
        NegotiateContextCount: 2
        Server Guid: 7369c667-ff51-ec4a-29cd-baabf2fbe346
        Capabilities: 0x00000000
        Max Transaction Size: 65696
        Max Read Size: 65564
        Max Write Size: 65584
        Current Time: Jun  4, 2021 09:22:57.133600000 CEST
        Boot Time: Sep 14, 2000 20:34:26.039600000 CEST
        Blob Offset: 0x00000080
        Blob Length: 74
        Security Blob: 604806062b0601050502a03e303ca00e300c060a2b0601040182=
3702020aa32a3028a026=E2=80=A6
        NegotiateContextOffset: 0x000000d0
        Negotiate Context: SMB2_PREAUTH_INTEGRITY_CAPABILITIES=20
        Negotiate Context: SMB2_ENCRYPTION_CAPABILITIES=20
159.747489696	client	server	Session Setup Request, NTLMSSP_NEGOTIATE
159.749757908	server	client	Session Setup Response, Error: STATUS_MORE_PROC=
ESSING_REQUIRED, NTLMSSP_CHALLENGE
159.749963978	client	server	Session Setup Request, NTLMSSP_AUTH, User: \pub=
lic
159.755666410	server	client	Session Setup Response
159.755822268	client	server	Tree Connect Request Tree: \\server\IPC$
159.757998425	server	client	Tree Connect Response
159.758149227	client	server	Tree Connect Request Tree: \\server\fritzi
159.761217776	server	client	Tree Connect Response
159.761390846	client	server	Create Request File:=20
159.766487167	server	client	Create Response File:=20
159.766633459	client	server	Ioctl Request FSCTL_QUERY_NETWORK_INTERFACE_INFO
159.768736951	server	client	Ioctl Response, Error: STATUS_NOT_SUPPORTED
159.768892535	client	server	GetInfo Request FS_INFO/FileFsAttributeInformat=
ion File:=20
159.772155096	server	client	GetInfo Response
159.772308033	client	server	GetInfo Request FS_INFO/FileFsDeviceInformation=
 File:=20
159.774874452	server	client	GetInfo Response
159.775022603	client	server	GetInfo Request FS_INFO/FileFsVolumeInformation=
 File:=20
159.778130405	server	client	GetInfo Response
159.778279828	client	server	GetInfo Request FS_INFO/FileFsSectorSizeInforma=
tion File:=20
159.780849883	server	client	GetInfo Response, Error: STATUS_NOT_SUPPORTED
159.781003009	client	server	Close Request File:=20
159.783777662	server	client	Close Response
159.783938472	client	server	Ioctl Request FSCTL_DFS_GET_REFERRALS, File: \s=
erver\fritzi
159.786039870	server	client	Ioctl Response, Error: STATUS_NOT_FOUND
159.786193956	client	server	Create Request File:=20
159.790835187	server	client	Create Response File:=20
159.790981359	client	server	Close Request File:=20
159.793822253	server	client	Close Response
159.793952080	client	server	Create Request File:=20
159.798685685	server	client	Create Response File:=20
159.798838348	client	server	Close Request File:=20
159.801688226	server	client	Close Response
159.801945547	client	server	Create Request File: ;GetInfo Request FILE_INFO=
/SMB2_FILE_ALL_INFO;Close Request
159.807449380	server	client	Create Response File: ;GetInfo Response;Close R=
esponse
162.884160365	client	server	Create Request File: WD_blau;GetInfo Request FI=
LE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.892931850	server	client	Create Response File: ;GetInfo Response;Close R=
esponse
162.893066730	client	server	Create Request File: WD_blau\Public;GetInfo Req=
uest FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.901135678	server	client	Create Response File: ;GetInfo Response;Close R=
esponse
162.901307878	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup;GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.910088237	server	client	Create Response File: ;GetInfo Response;Close R=
esponse
162.910199171	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx;GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.919726743	server	client	Create Response File: ;GetInfo Response;Close R=
esponse
162.919841841	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx
162.928605146	server	client	Create Response File:=20
162.928699866	client	server	Close Request File:=20
162.931355762	server	client	Close Response
162.931456051	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx;GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.941435848	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup;GetInfo Response;Close Response
162.941552518	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx
162.950640950	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup
162.950727794	client	server	Close Request File: WD_blau\Public\J=C3=B6rg-Ba=
ckup
162.953512696	server	client	Close Response
162.953612392	client	server	Create Request File: WD_blau;GetInfo Request FI=
LE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.960265634	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx;GetInfo Response;Close Response
162.960363152	client	server	Create Request File: WD_blau\Public;GetInfo Req=
uest FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.968120926	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx;GetInfo Response;Close Response
162.968234195	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup;GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.977020433	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx;GetInfo Response;Close Response
162.977123224	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx;GetInfo Request FILE_INFO/SMB2_FILE_ALL_INFO;Close Request
162.986415829	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx;GetInfo Response;Close Response
162.986554470	client	server	Create Request File: WD_blau\Public\J=C3=B6rg-B=
ackup\passwd.kdbx
162.995019319	server	client	Create Response File: WD_blau\Public\J=C3=B6rg-=
Backup\passwd.kdbx
162.995101551	client	server	Close Request File: WD_blau\Public\J=C3=B6rg-Ba=
ckup\passwd.kdbx
162.997887122	server	client	Close Response
169.505713730	client	server	Create Request File: ;GetInfo Request FILE_INFO=
/SMB2_FILE_ALL_INFO;Close Request
169.512323741	server	client	Create Response File: WD_blau\Public;GetInfo Re=
sponse;Close Response
169.512860789	client	server	Tree Disconnect Request
169.515188660	server	client	Tree Disconnect Response
169.515259125	client	server	Session Logoff Request
169.517551272	server	client	Session Logoff Response
```

And this is an access of the file with mount vers=3D1.0. md5sum reports
`Input/output error`

```
181.652435091	client	server	Negotiate Protocol Request
SMB (Server Message Block Protocol)
    SMB Header
        Server Component: SMB
        [Response in: 3642]
        SMB Command: Negotiate Protocol (0x72)
        NT Status: STATUS_SUCCESS (0x00000000)
        Flags: 0x00
        Flags2: 0xc801, Unicode Strings, Error Code Type, Extended Security=
 Negotiation, Long Names Allowed
        Process ID High: 23
        Signature: 0000000000000000
        Reserved: 0000
        Tree ID: 0
        Process ID: 54746
        User ID: 0
        Multiplex ID: 1
    Negotiate Protocol Request (0x72)
        Word Count (WCT): 0
        Byte Count (BCC): 43
        Requested Dialects
            Dialect: LM1.2X002
            Dialect: LANMAN2.1
            Dialect: NT LM 0.12
            Dialect: POSIX 2
181.655826070	server	client	Negotiate Protocol Response
SMB (Server Message Block Protocol)
    SMB Header
        Server Component: SMB
        [Response to: 3640]
        [Time from request: 0.003390979 seconds]
        SMB Command: Negotiate Protocol (0x72)
        NT Status: STATUS_SUCCESS (0x00000000)
        Flags: 0x88, Request/Response, Case Sensitivity
        Flags2: 0xc801, Unicode Strings, Error Code Type, Extended Security=
 Negotiation, Long Names Allowed
        Process ID High: 23
        Signature: 0000000000000000
        Reserved: 0000
        Tree ID: 0
        Process ID: 54746
        User ID: 0
        Multiplex ID: 1
    Negotiate Protocol Response (0x72)
        Word Count (WCT): 17
        Selected Index: 2: NT LM 0.12
        Security Mode: 0x07, Mode, Password, Signatures
        Max Mpx Count: 10
        Max VCs: 1
        Max Buffer Size: 65536
        Max Raw Buffer: 65536
        Session Key: 0x00000000
        Capabilities: 0x8000e05c, Unicode, Large Files, NT SMBs, NT Status =
Codes, Infolevel Passthru, Large ReadX, Large WriteX, Extended Security
        System Time: Jun  4, 2021 09:23:19.039600000 CEST
        Server Time Zone: -120 min from UTC
        Challenge Length: 0
        Byte Count (BCC): 90
        Server GUID: 67c66973-51ff-4aec-29cd-baabf2fbe346
        Security Blob: 604806062b0601050502a03e303ca00e300c060a2b0601040182=
3702020aa32a3028a026=E2=80=A6
181.655974252	client	server	Session Setup AndX Request, NTLMSSP_NEGOTIATE
181.658209133	server	client	Session Setup AndX Response, NTLMSSP_CHALLENGE,=
 Error: STATUS_MORE_PROCESSING_REQUIRED
181.658295009	client	server	Session Setup AndX Request, NTLMSSP_AUTH, User:=
 \public
181.662947503	server	client	Session Setup AndX Response
181.663081108	client	server	Tree Connect AndX Request, Path: \\server\IPC$
181.665337749	server	client	Tree Connect AndX Response
181.665505345	client	server	Tree Connect AndX Request, Path: \\server\fritzi
181.669439351	server	client	Tree Connect AndX Response
181.669585289	client	server	Trans2 Request, QUERY_FS_INFO, Query FS Device =
Info
181.672183252	server	client	Trans2 Response, QUERY_FS_INFO
181.672266260	client	server	Trans2 Request, QUERY_FS_INFO, Query FS Attribu=
te Info
181.674872915	server	client	Trans2 Response, QUERY_FS_INFO
181.674965933	client	server	Trans2 Request, GET_DFS_REFERRAL, File: \server=
\fritzi
181.677692923	server	client	Trans2 Response, GET_DFS_REFERRAL, Error: STATU=
S_NOT_SUPPORTED
181.677809275	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path:=20
181.681715358	server	client	Trans2 Response, QUERY_PATH_INFO
181.681847587	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path:=20
181.686809347	server	client	Trans2 Response, QUERY_PATH_INFO
181.687021639	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path:=20
181.691405260	server	client	Trans2 Response, QUERY_PATH_INFO
181.691552739	client	server	Trans2 Request, QUERY_PATH_INFO, Query File Int=
ernal Info, Path:=20
181.695055860	server	client	Trans2 Response, QUERY_PATH_INFO
182.873928911	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path: \WD_blau
182.880656088	server	client	Trans2 Response, QUERY_PATH_INFO
182.880792332	client	server	Trans2 Request, QUERY_PATH_INFO, Query File Int=
ernal Info, Path: \WD_blau
182.886816299	server	client	Trans2 Response, QUERY_PATH_INFO
182.887061740	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path: \WD_blau\Public
182.892873238	server	client	Trans2 Response, QUERY_PATH_INFO
182.893011485	client	server	Trans2 Request, QUERY_PATH_INFO, Query File Int=
ernal Info, Path: \WD_blau\Public
182.898630411	server	client	Trans2 Response, QUERY_PATH_INFO
182.898728260	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path: \WD_blau\Public\J=C3=B6rg-Backup
182.905397538	server	client	Trans2 Response, QUERY_PATH_INFO
182.905490065	client	server	Trans2 Request, QUERY_PATH_INFO, Query File Int=
ernal Info, Path: \WD_blau\Public\J=C3=B6rg-Backup
182.911806490	server	client	Trans2 Response, QUERY_PATH_INFO
182.911904941	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path: \WD_blau\Public\J=C3=B6rg-Backup\passwd.kdbx
182.919436779	server	client	Trans2 Response, QUERY_PATH_INFO
182.919514901	client	server	Trans2 Request, QUERY_PATH_INFO, Query File Int=
ernal Info, Path: \WD_blau\Public\J=C3=B6rg-Backup\passwd.kdbx
182.926356968	server	client	Trans2 Response, QUERY_PATH_INFO
182.926478308	client	server	NT Create AndX Request, FID: 0x4001, Path: \WD_=
blau\Public\J=EF=BF=BDrg-Backup\passwd.kdbx
182.935217463	server	client	NT Create AndX Response, FID: 0x4001
182.935431010	client	server	Read AndX Request, FID: 0x4001, 32768 bytes at =
offset 0
182.947742379	server	client	Read AndX Response, FID: 0x4001, 32768 bytes
=E2=80=A6
183.462757494	client	server	Read AndX Request, FID: 0x4001, 32768 bytes at =
offset 3833856
183.465864287	server	client	Read AndX Response, FID: 0x4001, 21731 bytes
183.466023126	client	server	Read AndX Request, FID: 0x4001, 8192 bytes at o=
ffset 3855587
183.468370770	server	client	Read AndX Response, FID: 0x4001, Error: STATUS_=
END_OF_FILE
183.468490608	client	server	Read AndX Request, FID: 0x4001, 8192 bytes at o=
ffset 3855587
183.470547535	server	client	Read AndX Response, FID: 0x4001, Error: STATUS_=
END_OF_FILE
183.470775894	client	server	Close Request, FID: 0x4001
183.472856467	server	client	Close Response, FID: 0x4001
187.299929279	client	server	Trans2 Request, QUERY_PATH_INFO, Query File All=
 Info, Path:=20
187.304405796	server	client	Trans2 Response, QUERY_PATH_INFO
187.304940291	client	server	Tree Disconnect Request
187.307143775	server	client	Tree Disconnect Response
187.307301303	client	server	Logoff AndX Request
187.309632364	server	client	Logoff AndX Response
```

Can anyone help?

Kind regards, J=C3=B6rg

--=20
Ich halte ihn zwar f=C3=BCr einen Schurken und das was er sagt f=C3=BCr
falsch =E2=80=93 aber ich bin bereit mein Leben daf=C3=BCr einzusetzen, da=
=C3=9F
er seine Meinung sagen kann.            (Voltaire)

--hm2qwm4y2rmolrwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJMEAREIADsWIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCYLng6B0YaHR0cHM6Ly9q
by1zby5kZS9wZ3Ata2V5LnR4dAAKCRB9LJoj0a6jdUh2AQCydQ33AK6sstYn8ZOG
TXeKbwsGbHxyppeZIA2uNmRrxQEAmousUe/IbmNDsBD4g+VkXSbrtOCa0PzHy9T4
Hz8R3q0=
=U+Lt
-----END PGP SIGNATURE-----

--hm2qwm4y2rmolrwb--
