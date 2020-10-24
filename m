Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB90297F67
	for <lists+linux-cifs@lfdr.de>; Sun, 25 Oct 2020 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762385AbgJXWVi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 24 Oct 2020 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762434AbgJXWVi (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 24 Oct 2020 18:21:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748BC0613D2
        for <linux-cifs@vger.kernel.org>; Sat, 24 Oct 2020 15:21:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x16so5646457ljh.2
        for <linux-cifs@vger.kernel.org>; Sat, 24 Oct 2020 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GohKUonJ7N1paG8eAuFTyC8T9y5DUDzomRt1iM3eOIc=;
        b=u4/q4bcXMKv+H1nrQ5270UFMDTayxgLIzbFp2ZUMXQUYb9V7AfqPInYnwSbFEwZKjn
         Lsly3MkL0VwWMArDuLMKWOiBW6idsNi7IuXgCTF9hs3CvEYM7GetDstNDSPTp+Ivp1bv
         usN462WdM0mYc5y2Gk2ml54INY1YjTAeBDfJAkGX7xVHjxXdPCacNTlIOXE/7ZK6g7nQ
         bC/0q0GME7L674U5e9Ew/YGk5W7XImSSJBrU4fQUlRGw7LCiMjZWMB98ED7eBo+UVLal
         D1GTeYf+Lu31uOf34TBQYVTYiXaqaEhxfsfur6Wijk0CDG9HUSbbXWbGL8IYTgoxrAkd
         ZA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GohKUonJ7N1paG8eAuFTyC8T9y5DUDzomRt1iM3eOIc=;
        b=Wk15BbIM3zf6oGwBwBdmwPRJTB/umbHVjo84XtZ94JOXxasISKN3gj6k2yPiDg6SNO
         jfsVrmn7H+gOTAFi4i1pJUD8I1uzNxWg/xVg9OfMhChN1JANrhVxPXdlM3Zw5xH/7nWG
         wtxQXNMoxmBYjmqljMARLJ4cjvbkbvPztQGKcFDiSK93mLS5Qedj+Gp+2ZBGAlGelqVX
         mhvCihr3SE2fjCKSdyWYIaB9l1/tDw+tz0/7W1pniUSscfYppYGM+rmPcuAjEXbn4L+A
         kavNUmlfqLCWwbbrC6Osm68NwJ7BCmDy3OZPhsT1aY0WmS9qlM13WJ8MY1lyOcoJ3w9J
         7JYA==
X-Gm-Message-State: AOAM530m+OJxj3RYuIs8Yku/4XiFNgPmDCJjOZrylSDoxgweqCtMX9hJ
        BYmUxy+UYP0Psn1a4K8pqRyyFTANeSC/OrxT63/ibHG9FiU=
X-Google-Smtp-Source: ABdhPJy95Bq5ddYQbHzJizxodxjWP3bq7rle9SBcs2iwbSsbimEJYP5tQ4b9488rFY3v/U7xXRRSA01QpW2pDfUORR8=
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr2904124lji.26.1603578094774;
 Sat, 24 Oct 2020 15:21:34 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 24 Oct 2020 17:21:23 -0500
Message-ID: <CAH2r5mvTDPJLQQLWaUUvFdMj4sOv4VKWG3JhVw=CwcxV6NhY+A@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Please pull the following changes since commit
0613ed91901b5f87afcd28b4560fb0aa37a0db13:

  Merge tag '5.10-rc-smb3-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2020-10-23 11:41:39 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.10-rc-smb3-fixes-part2

for you to fetch changes up to aef0388aa92c5583eeac401710e16db48be4c9ac:

  cifs: update internal module version number (2020-10-23 23:41:49 -0500)

----------------------------------------------------------------
add support for stat of various special file types (WSL reparse points
for char, block, fifo)

unit test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/406
----------------------------------------------------------------
Steve French (4):
      smb3: add support for stat of WSL reparse points for special file types
      smb3: remove two unused variables
      smb3: add some missing definitions from MS-FSCC
      cifs: update internal module version number

 fs/cifs/cifsfs.h    |   2 +-
 fs/cifs/cifsglob.h  |   4 +++
 fs/cifs/inode.c     |  44 +++++++++++++++++++++-----
 fs/cifs/smb2inode.c |  12 ++++----
 fs/cifs/smb2ops.c   | 130
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2pdu.h   |  31 +++++++++++++++++++
 fs/cifs/smb2proto.h |   3 ++
 fs/cifs/smbfsctl.h  |   2 ++
 8 files changed, 213 insertions(+), 15 deletions(-)

--
Thanks,

Steve
