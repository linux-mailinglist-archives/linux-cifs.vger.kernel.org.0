Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF223B24A0
	for <lists+linux-cifs@lfdr.de>; Thu, 24 Jun 2021 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXByr (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 23 Jun 2021 21:54:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30304 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXByq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 23 Jun 2021 21:54:46 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210624015226epoutp02d7718c5c71829dd19f865166b732be52~LYbr3BMDA2519625196epoutp02Y
        for <linux-cifs@vger.kernel.org>; Thu, 24 Jun 2021 01:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210624015226epoutp02d7718c5c71829dd19f865166b732be52~LYbr3BMDA2519625196epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624499546;
        bh=FQBHgfVz3jPN0iAH1xs7SG8yucWBCWSgzsaIbWxev90=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CLDo5HiOYDboYw+vOHNytny8giFNSFs6QD3yuKce7GUQQUb9jFNQ3EtP6T9aca7CG
         ashShnH/ob2pgeaPK62pxx99vmIDJ4ABO6nVUI9H+Q136aWJ2XxN0WtdgNn5hGBu6C
         Ip8lxRcMQ23JJIv2oCgMg1qgjujfmbwisjdGnA88=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210624015225epcas1p17c025739f7111abb21d91b9ea05eb7a2~LYbrSapjL2499824998epcas1p1L;
        Thu, 24 Jun 2021 01:52:25 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4G9NRr4VqXz4x9QK; Thu, 24 Jun
        2021 01:52:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.B3.09952.855E3D06; Thu, 24 Jun 2021 10:52:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210624015215epcas1p1a5b07effa03a047b1f76481d344d52c6~LYbh5riPg0607106071epcas1p1B;
        Thu, 24 Jun 2021 01:52:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210624015215epsmtrp26bc522dc075007db669b6e6058be8ad2~LYbh4yNnh3160031600epsmtrp2G;
        Thu, 24 Jun 2021 01:52:15 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-1c-60d3e5582841
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.1F.08394.F45E3D06; Thu, 24 Jun 2021 10:52:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.219]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210624015215epsmtip1254de95d776033da241308fbcee18019~LYbhrC7WU1066110661epsmtip1l;
        Thu, 24 Jun 2021 01:52:15 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-cifs@vger.kernel.org, linux-cifsd-devel@lists.sourceforge.net
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/2] ksmbd: move fs/cifsd to fs/ksmbd
Date:   Thu, 24 Jun 2021 10:42:42 +0900
Message-Id: <20210624014242.900-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7bCmrm7E08sJBsvfK1mcnrCIyeLF/13M
        Fj//f2e0+DG93qK37xOrxZsXh9kc2Dx2zrrL7rF5hZbH7gWfmTz6tqxi9Pi8SS6ANSrHJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQwMDIFKgyISej4ctW
        9oIDsxkrDjV9Z25gPFDbxcjBISFgItG8RKmLkYtDSGAHo8S543vYIZxPjBLNL+cydzFyAjnf
        GCVOLdMEsUEaPjb3M0MU7WWUWLphEhtcx58tO9hAxrIJaAPZoiANIgLuEsv2QzQwCyxmlOhp
        Xs0OUiMsYCEx63UUSA2LgKrEqhsT2UBsXgEriRkXFrFCLJOXWL3hAFivhMAqdokNncuYIRIu
        EjuXb2OCsIUlXh3fwg5hS0l8freXDcIulzhx8hdUTY3Ehnn72CFeNpboeVECYjILaEqs36UP
        UaEosfP3XEYQm1mAT+Ld1x5WiGpeiY42IYgSVYm+S4ehBkpLdLV/gFrqITH9UTMTJKhiJZ7+
        OMk8gVF2FsKCBYyMqxjFUguKc9NTiw0LDJGjaBMjOEVpme5gnPj2g94hRiYOxkOMEhzMSiK8
        j1ouJQjxpiRWVqUW5ccXleakFh9iNAUG10RmKdHkfGCSzCuJNzQ1MjY2tjAxMzczNVYS593J
        dihBSCA9sSQ1OzW1ILUIpo+Jg1OqgYk3IeuAbV/ikX8HvZf5mqm/nl/M9qFULnr5oWeVeyIX
        3MmydftcH/bw1Y3a4pfxLYqH53iGS0zb7MDOuSGf0dA60m7ltAMPauPd0l7eykm0u7nfn1sg
        Xzv3gPDfd9Ebzd42eu/K/Tf1svLf0Mygh4frhRYoXJoRdf6w5Pq2iVZL3pqt3Pw1aU/Pp+m1
        j7IOxEz8Ey/DYZ3q4vtMpWV/7+PnPfqNOx/ETHsef+Kh2MG3PmdXpjplbczJnB3QzMDm4dSZ
        8/noDIYdX9NSFv2W/u610fDWf0vLKmYHo1Myez18PjM5tsce3fM9+ZjV8xXRFaa3UxeXXz2e
        F1T8f+cGt9/Bp3Ie/vWrzOjYlyayTUmJpTgj0VCLuag4EQAb35WQ2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsWy7bCSnK7/08sJBtO2S1qcnrCIyeLF/13M
        Fj//f2e0+DG93qK37xOrxZsXh9kc2Dx2zrrL7rF5hZbH7gWfmTz6tqxi9Pi8SS6ANYrLJiU1
        J7MstUjfLoEro+HLVvaCA7MZKw41fWduYDxQ28XIySEhYCLxsbmfGcQWEtjNKPG5twAiLi1x
        7MQZoDgHkC0scfhwcRcjF1DJB0aJje2PGEHibALaEn+2iIKUiwh4Suy9ep4dpIZZYCmjxJw7
        3ewgNcICFhKzXkeB1LAIqEqsujGRDcTmFbCSmHFhESvEKnmJ1RsOME9g5FnAyLCKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4aLQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5HLZcShHhT
        EiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDK1/T2emc1/9PW
        +n9BfALz3LdeXdNpOlnT922GJctzk9qoyfNvNcp/DdB8efvt6wtnSyvO3J8UfuP3ymtNh0Mf
        +Dks/LY/xH1nceHX7JtCpyzF29gYP64zCVkzdTfDyitXV5XyzNnvWJUq6sq/aMuN+5fsX2o0
        xIsZztl+L99qmf6WPv0ffM/mPGs+2+tw22JN5XPJUwZcyqZLArudf1bH88t/nDXBdMb18g4x
        2xZn7UlmDjNmX99k92p/gXLI52ZD2cs81tH9cYuuG0m9kLi0UXnKXZXepzeOntd+w7Fp5qr9
        RfeeW9pdiUipMdbcnLPymljb3vW34wW0uiTX19Vt5mw+wO6Y6l8medI5Oz5diaU4I9FQi7mo
        OBEA+/EZVokCAAA=
X-CMS-MailID: 20210624015215epcas1p1a5b07effa03a047b1f76481d344d52c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210624015215epcas1p1a5b07effa03a047b1f76481d344d52c6
References: <CGME20210624015215epcas1p1a5b07effa03a047b1f76481d344d52c6@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move fs/cifsd to fs/ksmbd and rename the remaining cifsd name to ksmbd.

Cc: Steve French <smfrench@gmail.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 v2:
  - rename missing cifsd name in Kconfig.

 Documentation/filesystems/cifs/index.rst           |  2 +-
 .../filesystems/cifs/{cifsd.rst => ksmbd.rst}      | 10 +++++-----
 fs/Kconfig                                         |  2 +-
 fs/Makefile                                        |  2 +-
 fs/{cifsd => ksmbd}/Kconfig                        | 14 +++++++-------
 fs/{cifsd => ksmbd}/Makefile                       |  0
 fs/{cifsd => ksmbd}/asn1.c                         |  0
 fs/{cifsd => ksmbd}/asn1.h                         |  0
 fs/{cifsd => ksmbd}/auth.c                         |  0
 fs/{cifsd => ksmbd}/auth.h                         |  0
 fs/{cifsd => ksmbd}/connection.c                   |  0
 fs/{cifsd => ksmbd}/connection.h                   |  0
 fs/{cifsd => ksmbd}/crypto_ctx.c                   |  0
 fs/{cifsd => ksmbd}/crypto_ctx.h                   |  0
 fs/{cifsd => ksmbd}/glob.h                         |  0
 fs/{cifsd => ksmbd}/ksmbd_server.h                 |  0
 fs/{cifsd => ksmbd}/ksmbd_spnego_negtokeninit.asn1 |  0
 fs/{cifsd => ksmbd}/ksmbd_spnego_negtokentarg.asn1 |  0
 fs/{cifsd => ksmbd}/ksmbd_work.c                   |  0
 fs/{cifsd => ksmbd}/ksmbd_work.h                   |  0
 fs/{cifsd => ksmbd}/mgmt/ksmbd_ida.c               |  0
 fs/{cifsd => ksmbd}/mgmt/ksmbd_ida.h               |  0
 fs/{cifsd => ksmbd}/mgmt/share_config.c            |  0
 fs/{cifsd => ksmbd}/mgmt/share_config.h            |  0
 fs/{cifsd => ksmbd}/mgmt/tree_connect.c            |  0
 fs/{cifsd => ksmbd}/mgmt/tree_connect.h            |  0
 fs/{cifsd => ksmbd}/mgmt/user_config.c             |  0
 fs/{cifsd => ksmbd}/mgmt/user_config.h             |  0
 fs/{cifsd => ksmbd}/mgmt/user_session.c            |  0
 fs/{cifsd => ksmbd}/mgmt/user_session.h            |  0
 fs/{cifsd => ksmbd}/misc.c                         |  0
 fs/{cifsd => ksmbd}/misc.h                         |  0
 fs/{cifsd => ksmbd}/ndr.c                          |  0
 fs/{cifsd => ksmbd}/ndr.h                          |  0
 fs/{cifsd => ksmbd}/nterr.h                        |  0
 fs/{cifsd => ksmbd}/ntlmssp.h                      |  0
 fs/{cifsd => ksmbd}/oplock.c                       |  0
 fs/{cifsd => ksmbd}/oplock.h                       |  0
 fs/{cifsd => ksmbd}/server.c                       |  0
 fs/{cifsd => ksmbd}/server.h                       |  0
 fs/{cifsd => ksmbd}/smb2misc.c                     |  0
 fs/{cifsd => ksmbd}/smb2ops.c                      |  0
 fs/{cifsd => ksmbd}/smb2pdu.c                      |  0
 fs/{cifsd => ksmbd}/smb2pdu.h                      |  0
 fs/{cifsd => ksmbd}/smb_common.c                   |  0
 fs/{cifsd => ksmbd}/smb_common.h                   |  0
 fs/{cifsd => ksmbd}/smbacl.c                       |  0
 fs/{cifsd => ksmbd}/smbacl.h                       |  0
 fs/{cifsd => ksmbd}/smbfsctl.h                     |  0
 fs/{cifsd => ksmbd}/smbstatus.h                    |  0
 fs/{cifsd => ksmbd}/transport_ipc.c                |  0
 fs/{cifsd => ksmbd}/transport_ipc.h                |  0
 fs/{cifsd => ksmbd}/transport_rdma.c               |  0
 fs/{cifsd => ksmbd}/transport_rdma.h               |  0
 fs/{cifsd => ksmbd}/transport_tcp.c                |  0
 fs/{cifsd => ksmbd}/transport_tcp.h                |  0
 fs/{cifsd => ksmbd}/unicode.c                      |  0
 fs/{cifsd => ksmbd}/unicode.h                      |  0
 fs/{cifsd => ksmbd}/uniupr.h                       |  0
 fs/{cifsd => ksmbd}/vfs.c                          |  0
 fs/{cifsd => ksmbd}/vfs.h                          |  0
 fs/{cifsd => ksmbd}/vfs_cache.c                    |  0
 fs/{cifsd => ksmbd}/vfs_cache.h                    |  0
 63 files changed, 15 insertions(+), 15 deletions(-)
 rename Documentation/filesystems/cifs/{cifsd.rst => ksmbd.rst} (98%)
 rename fs/{cifsd => ksmbd}/Kconfig (81%)
 rename fs/{cifsd => ksmbd}/Makefile (100%)
 rename fs/{cifsd => ksmbd}/asn1.c (100%)
 rename fs/{cifsd => ksmbd}/asn1.h (100%)
 rename fs/{cifsd => ksmbd}/auth.c (100%)
 rename fs/{cifsd => ksmbd}/auth.h (100%)
 rename fs/{cifsd => ksmbd}/connection.c (100%)
 rename fs/{cifsd => ksmbd}/connection.h (100%)
 rename fs/{cifsd => ksmbd}/crypto_ctx.c (100%)
 rename fs/{cifsd => ksmbd}/crypto_ctx.h (100%)
 rename fs/{cifsd => ksmbd}/glob.h (100%)
 rename fs/{cifsd => ksmbd}/ksmbd_server.h (100%)
 rename fs/{cifsd => ksmbd}/ksmbd_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifsd => ksmbd}/ksmbd_spnego_negtokentarg.asn1 (100%)
 rename fs/{cifsd => ksmbd}/ksmbd_work.c (100%)
 rename fs/{cifsd => ksmbd}/ksmbd_work.h (100%)
 rename fs/{cifsd => ksmbd}/mgmt/ksmbd_ida.c (100%)
 rename fs/{cifsd => ksmbd}/mgmt/ksmbd_ida.h (100%)
 rename fs/{cifsd => ksmbd}/mgmt/share_config.c (100%)
 rename fs/{cifsd => ksmbd}/mgmt/share_config.h (100%)
 rename fs/{cifsd => ksmbd}/mgmt/tree_connect.c (100%)
 rename fs/{cifsd => ksmbd}/mgmt/tree_connect.h (100%)
 rename fs/{cifsd => ksmbd}/mgmt/user_config.c (100%)
 rename fs/{cifsd => ksmbd}/mgmt/user_config.h (100%)
 rename fs/{cifsd => ksmbd}/mgmt/user_session.c (100%)
 rename fs/{cifsd => ksmbd}/mgmt/user_session.h (100%)
 rename fs/{cifsd => ksmbd}/misc.c (100%)
 rename fs/{cifsd => ksmbd}/misc.h (100%)
 rename fs/{cifsd => ksmbd}/ndr.c (100%)
 rename fs/{cifsd => ksmbd}/ndr.h (100%)
 rename fs/{cifsd => ksmbd}/nterr.h (100%)
 rename fs/{cifsd => ksmbd}/ntlmssp.h (100%)
 rename fs/{cifsd => ksmbd}/oplock.c (100%)
 rename fs/{cifsd => ksmbd}/oplock.h (100%)
 rename fs/{cifsd => ksmbd}/server.c (100%)
 rename fs/{cifsd => ksmbd}/server.h (100%)
 rename fs/{cifsd => ksmbd}/smb2misc.c (100%)
 rename fs/{cifsd => ksmbd}/smb2ops.c (100%)
 rename fs/{cifsd => ksmbd}/smb2pdu.c (100%)
 rename fs/{cifsd => ksmbd}/smb2pdu.h (100%)
 rename fs/{cifsd => ksmbd}/smb_common.c (100%)
 rename fs/{cifsd => ksmbd}/smb_common.h (100%)
 rename fs/{cifsd => ksmbd}/smbacl.c (100%)
 rename fs/{cifsd => ksmbd}/smbacl.h (100%)
 rename fs/{cifsd => ksmbd}/smbfsctl.h (100%)
 rename fs/{cifsd => ksmbd}/smbstatus.h (100%)
 rename fs/{cifsd => ksmbd}/transport_ipc.c (100%)
 rename fs/{cifsd => ksmbd}/transport_ipc.h (100%)
 rename fs/{cifsd => ksmbd}/transport_rdma.c (100%)
 rename fs/{cifsd => ksmbd}/transport_rdma.h (100%)
 rename fs/{cifsd => ksmbd}/transport_tcp.c (100%)
 rename fs/{cifsd => ksmbd}/transport_tcp.h (100%)
 rename fs/{cifsd => ksmbd}/unicode.c (100%)
 rename fs/{cifsd => ksmbd}/unicode.h (100%)
 rename fs/{cifsd => ksmbd}/uniupr.h (100%)
 rename fs/{cifsd => ksmbd}/vfs.c (100%)
 rename fs/{cifsd => ksmbd}/vfs.h (100%)
 rename fs/{cifsd => ksmbd}/vfs_cache.c (100%)
 rename fs/{cifsd => ksmbd}/vfs_cache.h (100%)

diff --git a/Documentation/filesystems/cifs/index.rst b/Documentation/filesystems/cifs/index.rst
index e762586b5dc7..1c8597a679ab 100644
--- a/Documentation/filesystems/cifs/index.rst
+++ b/Documentation/filesystems/cifs/index.rst
@@ -6,5 +6,5 @@ CIFS
 .. toctree::
    :maxdepth: 1
 
-   cifsd
+   ksmbd
    cifsroot
diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/ksmbd.rst
similarity index 98%
rename from Documentation/filesystems/cifs/cifsd.rst
rename to Documentation/filesystems/cifs/ksmbd.rst
index 01a0be272ce6..1e111efecd45 100644
--- a/Documentation/filesystems/cifs/cifsd.rst
+++ b/Documentation/filesystems/cifs/ksmbd.rst
@@ -1,13 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ==========================
-CIFSD - SMB3 Kernel Server
+KSMBD - SMB3 Kernel Server
 ==========================
 
-CIFSD is a linux kernel server which implements SMB3 protocol in kernel space
+KSMBD is a linux kernel server which implements SMB3 protocol in kernel space
 for sharing files over network.
 
-CIFSD architecture
+KSMBD architecture
 ==================
 
 The subset of performance related operations belong in kernelspace and
@@ -60,7 +60,7 @@ NetServerGetInfo. Complete DCE/RPC response is prepared from the user space
 and passed over to the associated kernel thread for the client.
 
 
-CIFSD Feature Status
+KSMBD Feature Status
 ====================
 
 ============================== =================================================
@@ -138,7 +138,7 @@ How to run
 
 6. Access share from Windows or Linux using CIFS
 
-Shutdown CIFSD
+Shutdown KSMBD
 ==============
 
 1. kill user and kernel space daemon
diff --git a/fs/Kconfig b/fs/Kconfig
index 7462761ebd2f..720c38f484c6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -344,7 +344,7 @@ config NFS_V4_2_SSC_HELPER
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 source "fs/cifs/Kconfig"
-source "fs/cifsd/Kconfig"
+source "fs/ksmbd/Kconfig"
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
 source "fs/9p/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 542a77374d12..e03a048b2cd8 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_UNICODE)		+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
-obj-$(CONFIG_SMB_SERVER)	+= cifsd/
+obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_UFS_FS)		+= ufs/
diff --git a/fs/cifsd/Kconfig b/fs/ksmbd/Kconfig
similarity index 81%
rename from fs/cifsd/Kconfig
rename to fs/ksmbd/Kconfig
index 796f928a7da0..e9a5ac01b6e0 100644
--- a/fs/cifsd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -1,5 +1,5 @@
 config SMB_SERVER
-	tristate "SMB server support (EXPERIMENTAL)"
+	tristate "SMB3 server support (EXPERIMENTAL)"
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
@@ -31,13 +31,13 @@ config SMB_SERVER
 	  case you can choose N here.
 
 	  You also need to install user space programs which can be found
-	  in cifsd-tools, available from
-	  https://github.com/cifsd-team/cifsd-tools.
-	  More detail about how to run the cifsd kernel server is
+	  in ksmbd-tools, available from
+	  https://github.com/cifsd-team/ksmbd-tools.
+	  More detail about how to run the ksmbd kernel server is
 	  available via README file
-	  (https://github.com/cifsd-team/cifsd-tools/blob/master/README).
+	  (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
 
-	  cifsd kernel server includes support for auto-negotiation,
+	  ksmbd kernel server includes support for auto-negotiation,
 	  Secure negotiate, Pre-authentication integrity, oplock/lease,
 	  compound requests, multi-credit, packet signing, RDMA(smbdirect),
 	  smb3 encryption, copy-offload, secure per-user session
@@ -61,7 +61,7 @@ config SMB_SERVER_CHECK_CAP_NET_ADMIN
 	default y
 
 	help
-	  Prevent unprivileged processes to start the cifsd kernel server.
+	  Prevent unprivileged processes to start the ksmbd kernel server.
 
 config SMB_SERVER_KERBEROS5
 	bool "Support for Kerberos 5"
diff --git a/fs/cifsd/Makefile b/fs/ksmbd/Makefile
similarity index 100%
rename from fs/cifsd/Makefile
rename to fs/ksmbd/Makefile
diff --git a/fs/cifsd/asn1.c b/fs/ksmbd/asn1.c
similarity index 100%
rename from fs/cifsd/asn1.c
rename to fs/ksmbd/asn1.c
diff --git a/fs/cifsd/asn1.h b/fs/ksmbd/asn1.h
similarity index 100%
rename from fs/cifsd/asn1.h
rename to fs/ksmbd/asn1.h
diff --git a/fs/cifsd/auth.c b/fs/ksmbd/auth.c
similarity index 100%
rename from fs/cifsd/auth.c
rename to fs/ksmbd/auth.c
diff --git a/fs/cifsd/auth.h b/fs/ksmbd/auth.h
similarity index 100%
rename from fs/cifsd/auth.h
rename to fs/ksmbd/auth.h
diff --git a/fs/cifsd/connection.c b/fs/ksmbd/connection.c
similarity index 100%
rename from fs/cifsd/connection.c
rename to fs/ksmbd/connection.c
diff --git a/fs/cifsd/connection.h b/fs/ksmbd/connection.h
similarity index 100%
rename from fs/cifsd/connection.h
rename to fs/ksmbd/connection.h
diff --git a/fs/cifsd/crypto_ctx.c b/fs/ksmbd/crypto_ctx.c
similarity index 100%
rename from fs/cifsd/crypto_ctx.c
rename to fs/ksmbd/crypto_ctx.c
diff --git a/fs/cifsd/crypto_ctx.h b/fs/ksmbd/crypto_ctx.h
similarity index 100%
rename from fs/cifsd/crypto_ctx.h
rename to fs/ksmbd/crypto_ctx.h
diff --git a/fs/cifsd/glob.h b/fs/ksmbd/glob.h
similarity index 100%
rename from fs/cifsd/glob.h
rename to fs/ksmbd/glob.h
diff --git a/fs/cifsd/ksmbd_server.h b/fs/ksmbd/ksmbd_server.h
similarity index 100%
rename from fs/cifsd/ksmbd_server.h
rename to fs/ksmbd/ksmbd_server.h
diff --git a/fs/cifsd/ksmbd_spnego_negtokeninit.asn1 b/fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
similarity index 100%
rename from fs/cifsd/ksmbd_spnego_negtokeninit.asn1
rename to fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
diff --git a/fs/cifsd/ksmbd_spnego_negtokentarg.asn1 b/fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
similarity index 100%
rename from fs/cifsd/ksmbd_spnego_negtokentarg.asn1
rename to fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
diff --git a/fs/cifsd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
similarity index 100%
rename from fs/cifsd/ksmbd_work.c
rename to fs/ksmbd/ksmbd_work.c
diff --git a/fs/cifsd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
similarity index 100%
rename from fs/cifsd/ksmbd_work.h
rename to fs/ksmbd/ksmbd_work.h
diff --git a/fs/cifsd/mgmt/ksmbd_ida.c b/fs/ksmbd/mgmt/ksmbd_ida.c
similarity index 100%
rename from fs/cifsd/mgmt/ksmbd_ida.c
rename to fs/ksmbd/mgmt/ksmbd_ida.c
diff --git a/fs/cifsd/mgmt/ksmbd_ida.h b/fs/ksmbd/mgmt/ksmbd_ida.h
similarity index 100%
rename from fs/cifsd/mgmt/ksmbd_ida.h
rename to fs/ksmbd/mgmt/ksmbd_ida.h
diff --git a/fs/cifsd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
similarity index 100%
rename from fs/cifsd/mgmt/share_config.c
rename to fs/ksmbd/mgmt/share_config.c
diff --git a/fs/cifsd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
similarity index 100%
rename from fs/cifsd/mgmt/share_config.h
rename to fs/ksmbd/mgmt/share_config.h
diff --git a/fs/cifsd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
similarity index 100%
rename from fs/cifsd/mgmt/tree_connect.c
rename to fs/ksmbd/mgmt/tree_connect.c
diff --git a/fs/cifsd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
similarity index 100%
rename from fs/cifsd/mgmt/tree_connect.h
rename to fs/ksmbd/mgmt/tree_connect.h
diff --git a/fs/cifsd/mgmt/user_config.c b/fs/ksmbd/mgmt/user_config.c
similarity index 100%
rename from fs/cifsd/mgmt/user_config.c
rename to fs/ksmbd/mgmt/user_config.c
diff --git a/fs/cifsd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
similarity index 100%
rename from fs/cifsd/mgmt/user_config.h
rename to fs/ksmbd/mgmt/user_config.h
diff --git a/fs/cifsd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
similarity index 100%
rename from fs/cifsd/mgmt/user_session.c
rename to fs/ksmbd/mgmt/user_session.c
diff --git a/fs/cifsd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
similarity index 100%
rename from fs/cifsd/mgmt/user_session.h
rename to fs/ksmbd/mgmt/user_session.h
diff --git a/fs/cifsd/misc.c b/fs/ksmbd/misc.c
similarity index 100%
rename from fs/cifsd/misc.c
rename to fs/ksmbd/misc.c
diff --git a/fs/cifsd/misc.h b/fs/ksmbd/misc.h
similarity index 100%
rename from fs/cifsd/misc.h
rename to fs/ksmbd/misc.h
diff --git a/fs/cifsd/ndr.c b/fs/ksmbd/ndr.c
similarity index 100%
rename from fs/cifsd/ndr.c
rename to fs/ksmbd/ndr.c
diff --git a/fs/cifsd/ndr.h b/fs/ksmbd/ndr.h
similarity index 100%
rename from fs/cifsd/ndr.h
rename to fs/ksmbd/ndr.h
diff --git a/fs/cifsd/nterr.h b/fs/ksmbd/nterr.h
similarity index 100%
rename from fs/cifsd/nterr.h
rename to fs/ksmbd/nterr.h
diff --git a/fs/cifsd/ntlmssp.h b/fs/ksmbd/ntlmssp.h
similarity index 100%
rename from fs/cifsd/ntlmssp.h
rename to fs/ksmbd/ntlmssp.h
diff --git a/fs/cifsd/oplock.c b/fs/ksmbd/oplock.c
similarity index 100%
rename from fs/cifsd/oplock.c
rename to fs/ksmbd/oplock.c
diff --git a/fs/cifsd/oplock.h b/fs/ksmbd/oplock.h
similarity index 100%
rename from fs/cifsd/oplock.h
rename to fs/ksmbd/oplock.h
diff --git a/fs/cifsd/server.c b/fs/ksmbd/server.c
similarity index 100%
rename from fs/cifsd/server.c
rename to fs/ksmbd/server.c
diff --git a/fs/cifsd/server.h b/fs/ksmbd/server.h
similarity index 100%
rename from fs/cifsd/server.h
rename to fs/ksmbd/server.h
diff --git a/fs/cifsd/smb2misc.c b/fs/ksmbd/smb2misc.c
similarity index 100%
rename from fs/cifsd/smb2misc.c
rename to fs/ksmbd/smb2misc.c
diff --git a/fs/cifsd/smb2ops.c b/fs/ksmbd/smb2ops.c
similarity index 100%
rename from fs/cifsd/smb2ops.c
rename to fs/ksmbd/smb2ops.c
diff --git a/fs/cifsd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
similarity index 100%
rename from fs/cifsd/smb2pdu.c
rename to fs/ksmbd/smb2pdu.c
diff --git a/fs/cifsd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
similarity index 100%
rename from fs/cifsd/smb2pdu.h
rename to fs/ksmbd/smb2pdu.h
diff --git a/fs/cifsd/smb_common.c b/fs/ksmbd/smb_common.c
similarity index 100%
rename from fs/cifsd/smb_common.c
rename to fs/ksmbd/smb_common.c
diff --git a/fs/cifsd/smb_common.h b/fs/ksmbd/smb_common.h
similarity index 100%
rename from fs/cifsd/smb_common.h
rename to fs/ksmbd/smb_common.h
diff --git a/fs/cifsd/smbacl.c b/fs/ksmbd/smbacl.c
similarity index 100%
rename from fs/cifsd/smbacl.c
rename to fs/ksmbd/smbacl.c
diff --git a/fs/cifsd/smbacl.h b/fs/ksmbd/smbacl.h
similarity index 100%
rename from fs/cifsd/smbacl.h
rename to fs/ksmbd/smbacl.h
diff --git a/fs/cifsd/smbfsctl.h b/fs/ksmbd/smbfsctl.h
similarity index 100%
rename from fs/cifsd/smbfsctl.h
rename to fs/ksmbd/smbfsctl.h
diff --git a/fs/cifsd/smbstatus.h b/fs/ksmbd/smbstatus.h
similarity index 100%
rename from fs/cifsd/smbstatus.h
rename to fs/ksmbd/smbstatus.h
diff --git a/fs/cifsd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
similarity index 100%
rename from fs/cifsd/transport_ipc.c
rename to fs/ksmbd/transport_ipc.c
diff --git a/fs/cifsd/transport_ipc.h b/fs/ksmbd/transport_ipc.h
similarity index 100%
rename from fs/cifsd/transport_ipc.h
rename to fs/ksmbd/transport_ipc.h
diff --git a/fs/cifsd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
similarity index 100%
rename from fs/cifsd/transport_rdma.c
rename to fs/ksmbd/transport_rdma.c
diff --git a/fs/cifsd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
similarity index 100%
rename from fs/cifsd/transport_rdma.h
rename to fs/ksmbd/transport_rdma.h
diff --git a/fs/cifsd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
similarity index 100%
rename from fs/cifsd/transport_tcp.c
rename to fs/ksmbd/transport_tcp.c
diff --git a/fs/cifsd/transport_tcp.h b/fs/ksmbd/transport_tcp.h
similarity index 100%
rename from fs/cifsd/transport_tcp.h
rename to fs/ksmbd/transport_tcp.h
diff --git a/fs/cifsd/unicode.c b/fs/ksmbd/unicode.c
similarity index 100%
rename from fs/cifsd/unicode.c
rename to fs/ksmbd/unicode.c
diff --git a/fs/cifsd/unicode.h b/fs/ksmbd/unicode.h
similarity index 100%
rename from fs/cifsd/unicode.h
rename to fs/ksmbd/unicode.h
diff --git a/fs/cifsd/uniupr.h b/fs/ksmbd/uniupr.h
similarity index 100%
rename from fs/cifsd/uniupr.h
rename to fs/ksmbd/uniupr.h
diff --git a/fs/cifsd/vfs.c b/fs/ksmbd/vfs.c
similarity index 100%
rename from fs/cifsd/vfs.c
rename to fs/ksmbd/vfs.c
diff --git a/fs/cifsd/vfs.h b/fs/ksmbd/vfs.h
similarity index 100%
rename from fs/cifsd/vfs.h
rename to fs/ksmbd/vfs.h
diff --git a/fs/cifsd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
similarity index 100%
rename from fs/cifsd/vfs_cache.c
rename to fs/ksmbd/vfs_cache.c
diff --git a/fs/cifsd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
similarity index 100%
rename from fs/cifsd/vfs_cache.h
rename to fs/ksmbd/vfs_cache.h
-- 
2.17.1

