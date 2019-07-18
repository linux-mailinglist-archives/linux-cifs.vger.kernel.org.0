Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645E76C91B
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Jul 2019 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGRGKK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 18 Jul 2019 02:10:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37908 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfGRGKK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 18 Jul 2019 02:10:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so12083120pfn.5
        for <linux-cifs@vger.kernel.org>; Wed, 17 Jul 2019 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PtGwMuu24px8SgWAoKZoSyeeLBl3hXrKT8ZqcK+pJqo=;
        b=A3PYJmBV41c20pYlHgso6YmlDH9gS7r3sUrcgZccxICKPulJv7PAwtM5uqXN+ZPA/D
         bKjXTiFxvW21Su9tWoVUP1bnqbVi6tBbKQjvywb/48OgfjMphWfSN6pCs7gSgxHzwZ/N
         t4s/i5OqWmXktRRuKssFcTKILOGdmt54WgilCV+PpYojTBuh+RUkCMEQpnw6WEQhIdoz
         +l75MnRTfN0MFsto2HBKQkcPBJhwrlXOMCet6uu+F/+86R6M1Z+jRh9V8HZSXstZ2X06
         Fi8uWTIFC2ULFp70qA/8d/pwdguCEOdgqrsv1z/FKMlbZ9pH2Im2whS6OO2gRNOnhDnk
         H6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PtGwMuu24px8SgWAoKZoSyeeLBl3hXrKT8ZqcK+pJqo=;
        b=AE5VfVdicl/KZhAed4Zx5vOvHb+hErat52JFB2wFzw8THFSWvf6G0IO95FrWGQGf27
         SJPP54o3TpAUMTUSnxQvfoWJCTzUYlpucokPjQq4quxx62ahtKfu00fzWcc4VbNKFESv
         jcZYxDvm6Phj/T4+4FuZvBQBrKscvmu9HN8ttwTP2Uctvy6CHll3v6wR3QM36C83ka5S
         aP7o5jaRSjYCym9DXEvNcR4SeJCiZrdnqOnFK2cQsY+VblCstCPe8uUS87FRWSuxXCfo
         Wds4uD1ZUR9AAhzwpulC9YkWCkyCVHvpTzcf2iK74bKlU9DfPbVuUyTO8HA+kdMO5I3F
         mHgQ==
X-Gm-Message-State: APjAAAXjaun/igQDI9+NjoEtqAb9yhwgeE7pVRByyiySGSUMYKdixR2j
        r8Fvg93oKAOmUKa44ZTVWi2IyR5/Ezkgb5Es8VQ9pk+G76k=
X-Google-Smtp-Source: APXvYqzsSBh9tGBWJhONNFfFWJzPdjvpm0mUZJ1PH5pzr7fPiDZGoYYG/R8qi3qPEzjp8lJWaNAvBPrYhJtYVzAUCps=
X-Received: by 2002:a65:6454:: with SMTP id s20mr45876632pgv.15.1563430209482;
 Wed, 17 Jul 2019 23:10:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 18 Jul 2019 01:10:02 -0500
Message-ID: <CAH2r5ms6cYqfZvjwJ4m=U4bWktxERb6uz8-RSOaf7B9rzdUg6g@mail.gmail.com>
Subject: [GIT PULL] CIFS/SMB3 Fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Please pull the following changes since commit
0ecfebd2b52404ae0c54a878c872bb93363ada36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/4.3-rc-smb3-fixes

for you to fetch changes up to e9630660bd9253b3ed3926e18278b740cf218365:

  smb3: smbdirect no longer experimental (2019-07-15 22:36:51 -0500)

----------------------------------------------------------------
smb3/cifs fixes (3 for stable) and improvements including much faster
encryption (SMB3.1.1 GCM)

----------------------------------------------------------------
Aurelien Aptel (2):
      cifs: add missing GCM module dependency
      smb3: minor cleanup of compound_send_recv

Colin Ian King (1):
      cifs: fix typo in debug message with struct field ia_valid

Hariprasad Kelam (1):
      fs: cifs: cifsssmb: Change return type of convert_ace_to_cifs_ace

Kefeng Wang (1):
      fs: cifs: Drop unlikely before IS_ERR(_OR_NULL)

Paulo Alcantara (SUSE) (1):
      cifs: Properly handle auto disabling of serverino option

Ronnie Sahlberg (6):
      cifs: always add credits back for unsolicited PDUs
      cifs: Fix a race condition with cifs_echo_request
      cifs: refactor and clean up arguments in the reparse point parsing
      cifs: fix parsing of symbolic link error response
      cifs: fix crash in cifs_dfs_do_automount
      cifs: fix crash in smb2_compound_op()/smb2_set_next_command()

Steve French (14):
      SMB3: Add SMB3.1.1 GCM to negotiated crypto algorigthms
      SMB3.1.1: Add GCM crypto to the encrypt and decrypt functions
      Fix match_server check to allow for auto dialect negotiate
      smb3: if max_credits is specified then display it in /proc/mounts
      cifs: Fix check for matching with existing mount
      cifs: simplify code by removing CONFIG_CIFS_ACL ifdef
      CIFS: Fix module dependency
      add some missing definitions
      smb3: Allow query of symlinks stored as reparse points
      smb3: add new mount option to retrieve mode from special ACE
      smb3: do not send compression info by default
      smb3: Send netname context during negotiate protocol
      SMB3: query inode number on open via create context
      smb3: smbdirect no longer experimental

YueHaibing (1):
      cifs: Use kmemdup in SMB2_ioctl_init()

 fs/cifs/Kconfig         |  18 ++----
 fs/cifs/Makefile        |   3 +-
 fs/cifs/cifs_debug.c    |   2 -
 fs/cifs/cifs_fs_sb.h    |   6 ++
 fs/cifs/cifsfs.c        |  14 +++--
 fs/cifs/cifsglob.h      |   7 ++-
 fs/cifs/cifssmb.c       |  16 +-----
 fs/cifs/connect.c       |  61 ++++++++++++++++-----
 fs/cifs/dfs_cache.c     |   2 +-
 fs/cifs/inode.c         |   8 +--
 fs/cifs/misc.c          |   1 +
 fs/cifs/smb1ops.c       |   3 +-
 fs/cifs/smb2inode.c     |  12 ++++
 fs/cifs/smb2ops.c       | 143 +++++++++++++++++++++++++++++++++---------------
 fs/cifs/smb2pdu.c       |  96 +++++++++++++++++++++++++++-----
 fs/cifs/smb2pdu.h       |  36 ++++++++++--
 fs/cifs/smb2transport.c |  10 +++-
 fs/cifs/transport.c     |  46 ++++++++--------
 fs/cifs/xattr.c         |   4 --
 19 files changed, 335 insertions(+), 153 deletions(-)


-- 
Thanks,

Steve
