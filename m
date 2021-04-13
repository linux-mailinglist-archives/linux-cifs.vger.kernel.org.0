Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C436C35E741
	for <lists+linux-cifs@lfdr.de>; Tue, 13 Apr 2021 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhDMTsO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 13 Apr 2021 15:48:14 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:34932 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhDMTsO (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 13 Apr 2021 15:48:14 -0400
X-Greylist: delayed 2045 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 15:48:14 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 13DJDkBL023319
        for <linux-cifs@vger.kernel.org>; Tue, 13 Apr 2021 12:13:48 -0700
Message-ID: <6075ED6A.6010603@tlinx.org>
Date:   Tue, 13 Apr 2021 12:13:46 -0700
From:   L Walsh <cifs@tlinx.org>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: multiuser access and group membership(s)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I tried the multiuser mount using domain-creds.

Surprises:

* Files owned by local accounts appeared to be owned
by 'root:root'. 

* Files in well-known-groups, seemed to
resolve ok, but didn't recognize my domain login as
being in one of those groups.

* Files with group ownership of Administrators allowed access
  regardless of permission bits (though I am in Administrators group).
 -However, files owned (showing in UID) field AdministratorsGroup
  showed up as being owned by 'root' from the linux machine  and
  didn't enable access (though some other rule might).

=== Interesting direction.

I have some disappointment in that the remote Windows machine doesn't
recognize membership in domain groups (or local groups) when
mount options use a domain account (and cifscreds contain a domain
account).

Ex.: (w/Bliss or BLISS being my local NT4-style domain
hosted on the linux box).
local group "lawgroup" on Win machine, contains

BLISS\Domain Admins
Bliss\law
BLISS\lawgroup
law  (local account)

yet to 'Bliss/law' on linux, it appears to be
owned by 'root' and doesn't enable access.

Shouldn't the smb server on the win-machine be
able to enable access via domain group membership?
Maybe I just don't have it configured correctly...?

Also noting that unix extensions don't seem to be getting
negotiated.  From mount, listed options are:
//Athenae/C/ on /athenae type cifs 
(rw,nosuid,nodev,noexec,relatime,vers=2.1,cache=strict,username=law,
domain=BLISS,uid=0,noforceuid,gid=0,noforcegid,addr=192.168.3.12,
file_mode=0755,dir_mode=0755,nocase,soft,resilienthandles,nounix,
setuids,serverino,mapchars,cifsacl,rsize=1048576,wsize=1048576,
bsize=1048576,echo_interval=60,max_credits=60000,actimeo=1,user)

Q: Is it possible to get the Win server to recognize group memberships?

I note that Privileges in the domain aren't acknowledged on
the win-file-system, though the win-user using a samba-mount
will have privs recognized.

Thanks!






