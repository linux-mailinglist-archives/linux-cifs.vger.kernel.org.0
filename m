Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3811DB29
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Dec 2019 01:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfLMAd3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 12 Dec 2019 19:33:29 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:33877 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbfLMAd3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 12 Dec 2019 19:33:29 -0500
Received: by mail-lf1-f51.google.com with SMTP id l18so659567lfc.1
        for <linux-cifs@vger.kernel.org>; Thu, 12 Dec 2019 16:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K/vLH1P8OZgnzmJE/pnChuQbX7BvyCp8b3bBCfA6orQ=;
        b=EQop5GZCxKd9r9B8j7q5yKlJQ7MIWvHYEi3n5QLUXf5opTrN6yRNXIyju7ZGqn46DC
         HFpgtm6UlATSJ8wa/CVBeTtrs0FDnxrop4ON15ZEa0dBU5HD60qCOtj+mKKCFajgDf2J
         6GvYEEZTog5ise3fETwMlriQV7WdrC2AewhR9c+IML1CUVxpnWCCb8H2ig/0VLsy2IJ2
         07nikyp+xTkYipbUq18I0Osw81MjwQDRv+CsK1BPrPDGMJ/JncQcBJT1EM04Kr6Cv7m5
         DTbxwMFCIfnJFDL7CezZSOO3JfBoAS3g2kMIQgPS5q4h90SF3e1KZsaxZo1g6PgcapPr
         sDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K/vLH1P8OZgnzmJE/pnChuQbX7BvyCp8b3bBCfA6orQ=;
        b=n3nCmG/hGf72WPL/rb++7OsZ0ixA9VkDA5t61cn18nLFZuQPPmzL1WDErqGJ9XOBlB
         7UIHGEA+tNyO7HEPO0Z+2tN9+kKDKEoh2wT1uGOvv1/0vGRh0Ll58Pi9mWQWlzatrJ+h
         CbkzkHpzsV5aO1O73D8rJUchkCyVoDEGJXGS570nT4D2Y05+k+en/HPUMQN0ZJHQIjRU
         QU43pBdtKCWfrgO9MEh5Wb2wBJYBZXI6uk07nZXZDW1bkoH2EqwlNKX4wd2QBh9z4Ob6
         tOOy924FvAzFAKl4J87pTbI6AAL6SqkdddeyNt8k0kvvVVXq23mp4+ODiQk88VsxTj4e
         n0+g==
X-Gm-Message-State: APjAAAUQDttcoO4zug6CrId68t1y9g7f4Rhoy29RMuGpIKX4JNMyT+Us
        UGHQM+9ZIFra9tlV9dnqY48SPRElh+aLueBYuA==
X-Google-Smtp-Source: APXvYqzXlICQ6kUR7wVJ5+A2HSzD4JK0ey26jvBBNPorVe7pjxpacKxVhLhKzsFhLSLGnikh/1cZ/rd96XqDBC4UW68=
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr7195943lfq.173.1576197202310;
 Thu, 12 Dec 2019 16:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20191014170738.21724-1-aaptel@suse.com>
In-Reply-To: <20191014170738.21724-1-aaptel@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Thu, 12 Dec 2019 16:33:10 -0800
Message-ID: <CAKywueRKp_-AdguE2DNdUZFQ-_FXstMoA0Cd4iUWWOdwQGdZqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] smbinfo: rewrite in python
To:     Aurelien Aptel <aaptel@suse.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Kenneth Dsouza <kdsouza@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D0=BF=D0=BD, 14 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 10:07, Aurelien Ap=
tel <aaptel@suse.com>:
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  Makefile.am |    3 +-
>  smbinfo     |  779 +++++++++++++++++++++++++++++++++++
>  smbinfo.c   | 1296 -----------------------------------------------------=
------
>  3 files changed, 780 insertions(+), 1298 deletions(-)
>  create mode 100755 smbinfo
>  delete mode 100644 smbinfo.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 8291b99..33a420c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -80,8 +80,7 @@ setcifsacl.rst: setcifsacl.rst.in
>  endif
>
>  if CONFIG_SMBINFO
> -bin_PROGRAMS +=3D smbinfo
> -smbinfo_SOURCES =3D smbinfo.c
> +bin_SCRIPTS =3D smbinfo
>  rst_man_pages +=3D smbinfo.1
>  endif
>
> diff --git a/smbinfo b/smbinfo
> new file mode 100755
> index 0000000..1be82c7
> --- /dev/null
> +++ b/smbinfo
> @@ -0,0 +1,779 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +#
> +# smbinfo is a cmdline tool to query SMB-specific file and fs
> +# information on a Linux SMB mount (cifs.ko).
> +#
> +# Copyright (C) 2019 Aurelien Aptel <aaptel@suse.com>
> +# Copyright (C) 2019 Ronnie Sahlberg <lsahlberg@redhat.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +# GNU General Public License for more details.
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
> +
> +import os
> +import re
> +import argparse
> +import fcntl
> +import struct
> +import stat
> +import datetime
> +
> +VERBOSE =3D False
> +
> +# ioctl ctl codes
> +CIFS_QUERY_INFO          =3D 0xc018cf07
> +CIFS_ENUMERATE_SNAPSHOTS =3D 0x800ccf06
> +CIFS_DUMP_KEY            =3D 0xc03acf08
> +
> +# large enough input buffer length
> +INPUT_BUFFER_LENGTH =3D 16384
> +
> +# cifs query flags
> +PASSTHRU_QUERY_INFO =3D 0x00000000
> +PASSTHRU_FSCTL      =3D 0x00000001
> +
> +DIR_ACCESS_FLAGS =3D [
> +    (0x00000001, "LIST_DIRECTORY"),
> +    (0x00000002, "ADD_FILE"),
> +    (0x00000004, "ADD_SUBDIRECTORY"),
> +    (0x00000008, "READ_EA"),
> +    (0x00000010, "WRITE_EA"),
> +    (0x00000020, "TRAVERSE"),
> +    (0x00000040, "DELETE_CHILD"),
> +    (0x00000080, "READ_ATTRIBUTES"),
> +    (0x00000100, "WRITE_ATTRIBUTES"),
> +    (0x00010000, "DELETE"),
> +    (0x00020000, "READ_CONTROL"),
> +    (0x00040000, "WRITE_DAC"),
> +    (0x00080000, "WRITE_OWNER"),
> +    (0x00100000, "SYNCHRONIZER"),
> +    (0x01000000, "ACCESS_SYSTEM_SECURITY"),
> +    (0x02000000, "MAXIMUM_ALLOWED"),
> +    (0x10000000, "GENERIC_ALL"),
> +    (0x20000000, "GENERIC_EXECUTE"),
> +    (0x40000000, "GENERIC_WRITE"),
> +    (0x80000000, "GENERIC_READ"),
> +]
> +
> +FILE_ACCESS_FLAGS =3D [
> +    (0x00000001, "READ_DATA"),
> +    (0x00000002, "WRITE_DATA"),
> +    (0x00000004, "APPEND_DATA"),
> +    (0x00000008, "READ_EA"),
> +    (0x00000010, "WRITE_EA"),
> +    (0x00000020, "EXECUTE"),
> +    (0x00000040, "DELETE_CHILD"),
> +    (0x00000080, "READ_ATTRIBUTES"),
> +    (0x00000100, "WRITE_ATTRIBUTES"),
> +    (0x00010000, "DELETE"),
> +    (0x00020000, "READ_CONTROL"),
> +    (0x00040000, "WRITE_DAC"),
> +    (0x00080000, "WRITE_OWNER"),
> +    (0x00100000, "SYNCHRONIZER"),
> +    (0x01000000, "ACCESS_SYSTEM_SECURITY"),
> +    (0x02000000, "MAXIMUM_ALLOWED"),
> +    (0x10000000, "GENERIC_ALL"),
> +    (0x20000000, "GENERIC_EXECUTE"),
> +    (0x40000000, "GENERIC_WRITE"),
> +    (0x80000000, "GENERIC_READ"),
> +]
> +
> +FILE_ATTR_FLAGS =3D [
> +    (0x00000001, "READ_ONLY"),
> +    (0x00000002, "HIDDEN"),
> +    (0x00000004, "SYSTEM"),
> +    (0x00000010, "DIRECTORY"),
> +    (0x00000020, "ARCHIVE"),
> +    (0x00000080, "NORMAL"),
> +    (0x00000100, "TEMPORARY"),
> +    (0x00000200, "SPARSE_FILE"),
> +    (0x00000400, "REPARSE_POINT"),
> +    (0x00000800, "COMPRESSED"),
> +    (0x00001000, "OFFLINE"),
> +    (0x00002000, "NOT_CONTENT_INDEXED"),
> +    (0x00004000, "ENCRYPTED"),
> +    (0x00008000, "INTEGRITY_STREAM"),
> +    (0x00020000, "NO_SCRUB_DATA"),
> +]
> +
> +FILE_MODE_FLAGS =3D [
> +    (0x00000002, "WRITE_THROUGH"),
> +    (0x00000004, "SEQUENTIAL_ONLY"),
> +    (0x00000008, "NO_INTERMEDIATE_BUFFERING"),
> +    (0x00000010, "SYNCHRONOUS_IO_ALERT"),
> +    (0x00000020, "SYNCHRONOUS_IO_NONALERT"),
> +    (0x00001000, "DELETE_ON_CLOSE"),
> +]
> +
> +ALIGN_TYPES =3D [
> +    (0, "BYTE_ALIGNMENT"),
> +    (1, "WORD_ALIGNMENT"),
> +    (3, "LONG_ALIGNMENT"),
> +    (7, "QUAD_ALIGNMENT"),
> +    (15, "OCTA_ALIGNMENT"),
> +    (31, "32_bit_ALIGNMENT"),
> +    (63, "64_bit_ALIGNMENT"),
> +    (127, "128_bit_ALIGNMENT"),
> +    (255, "254_bit_ALIGNMENT"),
> +    (511, "512_bit_ALIGNMENT"),
> +]
> +
> +COMPRESSION_TYPES =3D [
> +    (0x0000, "NONE"),
> +    (0x0002, "LZNT1"),
> +]
> +
> +CONTROL_FLAGS =3D [
> +    (0x8000, "SR"),
> +    (0x4000, "RM"),
> +    (0x2000, "PS"),
> +    (0x1000, "PD"),
> +    (0x0800, "SI"),
> +    (0x0400, "DI"),
> +    (0x0200, "SC"),
> +    (0x0100, "DC"),
> +    (0x0080, "DT"),
> +    (0x0040, "SS"),
> +    (0x0020, "SD"),
> +    (0x0010, "SP"),
> +    (0x0008, "DD"),
> +    (0x0004, "DP"),
> +    (0x0002, "GD"),
> +    (0x0001, "OD"),
> +]
> +
> +ACE_TYPES =3D [
> +    (0x00, "ALLOWED"),
> +    (0x01, "DENIED"),
> +    (0x02, "AUDIT"),
> +    (0x03, "ALARM"),
> +    (0x04, "ALLOWED_COMPOUND"),
> +    (0x05, "ALLOWED_OBJECT"),
> +    (0x06, "DENIED_OBJECT"),
> +    (0x07, "AUDIT_OBJECT"),
> +    (0x08, "ALARM_OBJECT"),
> +    (0x09, "ALLOWED_CALLBACK"),
> +    (0x0a, "DENIED_CALLBACK"),
> +    (0x0b, "ALLOWED_CALLBACK_OBJECT"),
> +    (0x0c, "DENIED_CALLBACK_OBJECT"),
> +    (0x0d, "AUDIT_CALLBACK"),
> +    (0x0e, "ALARM_CALLBACK"),
> +    (0x0f, "AUDIT_CALLBACK_OBJECT"),
> +    (0x10, "ALARM_CALLBACK_OBJECT"),
> +    (0x11, "MANDATORY_LABEL"),
> +    (0x12, "RESOURCE_ATTRIBUTE"),
> +    (0x13, "SCOPED_POLICY_ID"),
> +]
> +
> +ACE_FLAGS =3D [
> +    (0x80, "FAILED_ACCESS"),
> +    (0x40, "SUCCESSFUL_ACCESS"),
> +    (0x10, "INHERITED"),
> +    (0x08, "INHERIT_ONLY"),
> +    (0x04, "NO_PROPAGATE_INHERIT"),
> +    (0x02, "CONTAINER_INHERIT"),
> +    (0x01, "OBJECT_INHERIT"),
> +]
> +
> +CIPHER_TYPES =3D [
> +    (0x00, "SMB3.0 CCM encryption"),
> +    (0x01, "CCM encryption"),
> +    (0x02, "GCM encryption"),
> +]
> +
> +def main():
> +    #
> +    # Global options and arguments
> +    #
> +
> +    ap =3D argparse.ArgumentParser(description=3D"Display SMB-specific f=
ile information using cifs IOCTL")
> +    ap.add_argument("-V", "--verbose", action=3D"store_true", help=3D"ve=
rbose output")
> +    subp =3D ap.add_subparsers(help=3D"sub-commands help")
> +    subp.required =3D True
> +    subp.dest =3D 'subcommand'
> +
> +    #
> +    # To add a new sub-command xxx, add a subparser xxx complete with
> +    # help, options and/or arguments and implement cmd_xxx()
> +    #
> +
> +    sap =3D subp.add_parser("fileaccessinfo", help=3D"Prints FileAccessI=
nfo for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_fileaccessinfo)
> +
> +    sap =3D subp.add_parser("filealigninfo", help=3D"Prints FileAlignInf=
o for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filealigninfo)
> +
> +    sap =3D subp.add_parser("fileallinfo", help=3D"Prints FileAllInfo fo=
r a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_fileallinfo)
> +
> +    sap =3D subp.add_parser("filebasicinfo", help=3D"Prints FileBasicInf=
o for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filebasicinfo)
> +
> +    sap =3D subp.add_parser("fileeainfo", help=3D"Prints FileEAInfo for =
a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_fileeainfo)
> +
> +    sap =3D subp.add_parser("filefsfullsizeinfo", help=3D"Prints FileFsF=
ullSizeInfo for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filefsfullsizeinfo)
> +
> +    sap =3D subp.add_parser("fileinternalinfo", help=3D"Prints FileInter=
nalInfo for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_fileinternalinfo)
> +
> +    sap =3D subp.add_parser("filemodeinfo", help=3D"Prints FileModeInfo =
for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filemodeinfo)
> +
> +    sap =3D subp.add_parser("filepositioninfo", help=3D"Prints FilePosit=
ionInfo for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filepositioninfo)
> +
> +    sap =3D subp.add_parser("filestandardinfo", help=3D"Prints FileStand=
ardInfo for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_filestandardinfo)
> +
> +    sap =3D subp.add_parser("fsctl-getobjid", help=3D"Prints the objecti=
d of the file and GUID of the underlying volume.")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_fsctl_getobjid)
> +
> +    sap =3D subp.add_parser("getcompression", help=3D"Prints the compres=
sion setting for the file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_getcompression)
> +
> +    sap =3D subp.add_parser("setcompression", help=3D"Sets the compressi=
on level for the file")
> +    sap.add_argument("type", choices=3D['no','default','lznt1'])
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_setcompression)
> +
> +    sap =3D subp.add_parser("list-snapshots", help=3D"List the previous =
versions of the volume that backs this file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_list_snapshots)
> +
> +    sap =3D subp.add_parser("quota", help=3D"Prints the quota for a cifs=
 file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_quota)
> +
> +    sap =3D subp.add_parser("secdesc", help=3D"Prints the security descr=
iptor for a cifs file")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_secdesc)
> +
> +    sap =3D subp.add_parser("keys", help=3D"Prints the decryption inform=
ation needed to view encrypted network traces")
> +    sap.add_argument("file")
> +    sap.set_defaults(func=3Dcmd_keys)
> +
> +    # parse arguments
> +    args =3D ap.parse_args()
> +
> +    # act on any global options
> +    if args.verbose:
> +        global VERBOSE
> +        VERBOSE =3D True
> +
> +    # call subcommand function
> +    args.func(args)
> +
> +class QueryInfoStruct:
> +    def __init__(self,
> +                 info_type=3D0, file_info_class=3D0, additional_informat=
ion=3D0,
> +                 flags=3D0, input_buffer_length=3D0, output_buffer_lengt=
h=3D0):
> +        self.info_type =3D info_type
> +        self.file_info_class =3D file_info_class
> +        self.additional_information =3D additional_information
> +        self.flags =3D flags
> +        self.input_buffer_length =3D input_buffer_length
> +        self.output_buffer_length =3D output_buffer_length
> +        buf_size =3D max(self.input_buffer_length, self.output_buffer_le=
ngth)
> +        self.input_buffer =3D bytearray(buf_size)
> +
> +    def pack_input(self, fmt, offset, *vals):
> +        struct.pack_into(fmt, self.input_buffer, offset, *vals)
> +
> +    def ioctl(self, fd, out_fmt=3DNone):
> +        buf =3D bytearray()
> +        buf.extend(struct.pack("IIIIII",
> +                               self.info_type,
> +                               self.file_info_class,
> +                               self.additional_information,
> +                               self.flags,
> +                               self.input_buffer_length,
> +                               self.output_buffer_length))
> +        in_len =3D len(buf)
> +        buf.extend(self.input_buffer)
> +        fcntl.ioctl(fd, CIFS_QUERY_INFO, buf, True)
> +        if out_fmt:
> +            return struct.unpack_from(out_fmt, buf, in_len)
> +        else:
> +            return buf[in_len:]
> +
> +def flags_to_str(flags, bitlist, verbose=3DNone):
> +    if verbose is None:
> +        verbose =3D VERBOSE
> +
> +    if not verbose:
> +        return "0x%08x"%flags
> +
> +    out =3D []
> +    for bit, name in bitlist:
> +        if flags & bit:
> +            out.append(name)
> +
> +    return "0x%08x (%s)"%(flags, ",".join(out))
> +
> +def type_to_str(typ, typelist, verbose=3DNone):
> +    if verbose is None:
> +        verbose =3D VERBOSE
> +
> +    if not verbose:
> +        return "0x%08x"%typ
> +
> +    s =3D "Unknown"
> +    for val, name in typelist:
> +        if typ =3D=3D val:
> +            s =3D name
> +
> +    return "0x%08x (%s)"%(typ, s)
> +
> +def cmd_fileaccessinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D8, input_b=
uffer_length=3D4)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        info =3D os.fstat(fd)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_fileaccessinfo(buf, info)
> +
> +def print_fileaccessinfo(buf, info):
> +    flags =3D struct.unpack_from('<I', buf, 0)[0]
> +    if stat.S_ISDIR(info.st_mode):
> +        print("Directory access flags:", flags_to_str(flags, DIR_ACCESS_=
FLAGS))
> +    else:
> +        print("File/Printer access flags:", flags_to_str(flags, FILE_ACC=
ESS_FLAGS))
> +
> +def cmd_filealigninfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D17, input_=
buffer_length=3D4)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filealigninfo(buf)
> +
> +def print_filealigninfo(buf):
> +    mask =3D struct.unpack_from('<I', buf, 0)[0]
> +    print("File alignment: %s"%type_to_str(mask, ALIGN_TYPES))
> +
> +def cmd_fileallinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D18, input_=
buffer_length=3DINPUT_BUFFER_LENGTH)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        info =3D os.fstat(fd)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filebasicinfo(buf)
> +    print_filestandardinfo(buf[40:])
> +    print_fileinternalinfo(buf[64:])
> +    print_fileeainfo(buf[72:])
> +    print_fileaccessinfo(buf[76:], info)
> +    print_filepositioninfo(buf[80:])
> +    print_filemodeinfo(buf[88:])
> +    print_filealigninfo(buf[92:])
> +
> +def win_to_datetime(smb2_time):
> +    usec =3D (smb2_time / 10) % 1000000
> +    sec  =3D (smb2_time - 116444736000000000) // 10000000
> +    return datetime.datetime.fromtimestamp(sec + usec/10000000)
> +
> +def cmd_filebasicinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D4, input_b=
uffer_length=3D40)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filebasicinfo(buf)
> +
> +def print_filebasicinfo(buf):
> +    ctime, atime, wtime, mtime, attrs =3D struct.unpack_from('<QQQQI', b=
uf, 0)
> +    print("Creation Time: %s"%win_to_datetime(ctime))
> +    print("Last Access Time: %s"%win_to_datetime(atime))
> +    print("Last Write Time: %s"%win_to_datetime(wtime))
> +    print("Last Change Time: %s"%win_to_datetime(mtime))
> +    print("File Attributes: %s"%flags_to_str(attrs, FILE_ATTR_FLAGS))
> +
> +def cmd_fileeainfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D7, input_b=
uffer_length=3D4)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_fileeainfo(buf)
> +
> +def print_fileeainfo(buf):
> +    size =3D struct.unpack_from('<I', buf, 0)[0]
> +    print("EA Size: %d"%size)
> +
> +def cmd_filefsfullsizeinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x2, file_info_class=3D7, input_b=
uffer_length=3D32)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        total, caller_avail, actual_avail, sec_per_unit, byte_per_sec =
=3D qi.ioctl(fd, CIFS_QUERY_INFO, '<QQQII')
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print("Total Allocation Units: %d"%total)
> +    print("Caller Available Allocation Units: %d"%caller_avail)
> +    print("Actual Available Allocation Units: %d"%actual_avail)
> +    print("Sectors Per Allocation Unit: %d"%sec_per_unit)
> +    print("Bytes Per Sector: %d"%byte_per_sec)
> +
> +def cmd_fileinternalinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D6, input_b=
uffer_length=3D8)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_fileinternalinfo(buf)
> +
> +def print_fileinternalinfo(buf):
> +    index =3D struct.unpack_from('<Q', buf, 0)[0]
> +    print("Index Number: %d"%index)
> +
> +
> +def cmd_filemodeinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D16, input_=
buffer_length=3D4)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filemodeinfo(buf)
> +
> +def print_filemodeinfo(buf):
> +        mode =3D struct.unpack_from('<I', buf, 0)[0]
> +        print("Mode: %s"%flags_to_str(mode, FILE_MODE_FLAGS))
> +
> +def cmd_filepositioninfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D14, input_=
buffer_length=3D8)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filepositioninfo(buf)
> +
> +def print_filepositioninfo(buf):
> +    offset =3D struct.unpack_from('<Q', buf, 0)[0]
> +    print("Current Byte Offset: %d"%offset)
> +
> +def cmd_filestandardinfo(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x1, file_info_class=3D5, input_b=
uffer_length=3D24)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print_filestandardinfo(buf)
> +
> +def print_filestandardinfo(buf):
> +    nalloc, eof, nlink, del_pending, del_dir =3D struct.unpack_from('<QQ=
IBB', buf, 0)
> +    print("Allocation Size: %d"%nalloc)
> +    print("End Of File: %d"%eof)
> +    print("Number of Links: %d"%nlink)
> +    print("Delete Pending: %d"%del_pending)
> +    print("Delete Directory: %d"%del_dir)
> +
> +def guid_to_str(buf):
> +    return "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x"%struct.unp=
ack_from('<ISSBBBBBBBB', buf, 0)
> +
> +def cmd_fsctl_getobjid(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x9009c, file_info_class=3D5, fla=
gs=3DPASSTHRU_FSCTL, input_buffer_length=3D64)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print("Object-ID: %s"%guid_to_str(buf))
> +    print("Birth-Volume-ID: %s"%guid_to_str(buf[16:]))
> +    print("Birth-Object-ID: %s"%guid_to_str(buf[32:]))
> +    print("Domain-ID: %s"%guid_to_str(buf[48:]))
> +
> +def cmd_getcompression(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x9003c, flags=3DPASSTHRU_FSCTL, =
input_buffer_length=3D2)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        ctype =3D qi.ioctl(fd, CIFS_QUERY_INFO, '<H')[0]
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    ctype_name =3D "UNKNOWN"
> +    for val, name in COMPRESSION_TYPES:
> +        if ctype =3D=3D val:
> +            ctype_name =3D name
> +            break
> +    print("Compression: %d (%s)"%(ctype, ctype_name))
> +
> +def cmd_setcompression(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x9c040, flags=3DPASSTHRU_FSCTL, =
output_buffer_length=3D2)
> +    type_map =3D {'no': 0, 'default': 1, 'lznt1': 2}
> +    qi.pack_input('<H', 0, type_map[args.type])
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +class SnapshotArrayStruct:
> +    def __init__(self,
> +                 nb_snapshots=3D0,
> +                 nb_snapshots_returned=3D0,
> +                 snapshot_array_size=3D12):
> +        self.nb_snapshots =3D nb_snapshots
> +        self.nb_snapshots_returned =3D nb_snapshots_returned
> +        self.snapshot_array_size =3D snapshot_array_size
> +        self.snapshot_array =3D []
> +
> +    def ioctl(self, fd, op):
> +        buf =3D bytearray()
> +        buf.extend(struct.pack("III",
> +                               self.nb_snapshots,
> +                               self.nb_snapshots_returned,
> +                               self.snapshot_array_size))
> +
> +        buf.extend(bytearray(16 + self.snapshot_array_size))
> +        fcntl.ioctl(fd, op, buf, True)
> +
> +        out =3D SnapshotArrayStruct()
> +        out.nb_snapshots, out.nb_snapshots_returned, out.snapshot_array_=
size =3D struct.unpack_from('III', buf, 0)
> +        data =3D buf[12:]
> +
> +        for gmt in re.findall(rb'''@([^\x00]+)''', data):
> +            d =3D datetime.strptime("@GMT-%Y.%m.%d-%H.%M.%S")
> +            out.snapshot_array.append(d)
> +
> +        return out
> +
> +def datetime_to_smb(dt):
> +    ntfs_time_offset =3D (369*365 + 89) * 24 * 3600 * 10000000
> +    return datetime.datetime.timestamp(dt) * 10000000 + ntfs_time_offset
> +
> +def cmd_list_snapshots(args):
> +    sa1req =3D SnapshotArrayStruct()
> +    sa1res =3D None
> +    sa2req =3D None
> +    sa2res =3D None
> +
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        sa1res =3D sa1req.ioctl(fd, CIFS_ENUMERATE_SNAPSHOTS)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    if sa1res.nb_snapshots =3D=3D 0:
> +        return
> +
> +    sa2req =3D SnapshotArrayStruct(nb_snapshots=3Dsa1res.nb_snapshots, s=
napshot_array_size=3Dsa1res.snapshot_array_size)
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        sa2res =3D sa2req.ioctl(fd, CIFS_ENUMERATE_SNAPSHOTS)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +
> +    print("Number of snapshots: %d Number of snapshots returned: %d"%(sa=
2res.nb_snapshots, sa2res.nb_snapshots_returned))
> +    print("Snapshot list in GMT (Coordinated UTC Time) and SMB format (1=
00 nanosecond units needed for snapshot mounts):")
> +    for i, d in enumerate(sa2res.snapshot_array):
> +        print("%d) GMT: %s\n   SMB3: %d"%(i, d, datetime_to_smb(d)))
> +
> +class SID:
> +    def __init__(self, buf, off=3D0):
> +        rev, sublen =3D struct.unpack_from('BB', buf, off+0)
> +        off +=3D 2
> +        auth =3D 0
> +        subauth =3D []
> +        for i in range(6):
> +            auth =3D (auth << 8)|buf[off]
> +            off +=3D 1
> +        for i in range(sublen):
> +            subauth.append(struct.unpack_from('<I', buf, off))
> +            off +=3D 4
> +
> +        self.rev =3D rev
> +        self.auth =3D auth
> +        self.subauth =3D subauth
> +
> +    def __str__(self):
> +        auth =3D ("0x%x" if self.auth >=3D 2**32 else "%d")%self.auth
> +        return  "S-%d-%s-%s"%(self.rev, auth, '-'.join(["%d"%x for x in =
self.subauth]))
> +
> +class ACE:
> +    def __init__(self, buf, off=3D0, is_dir=3DFalse):
> +        self.typ, self.flags, self.size =3D struct.unpack_from('<BBH', b=
uf, off)
> +        self.is_dir =3D is_dir
> +        if self.typ not in [0,1,2]:
> +            self.buf =3D buf[4:]
> +        else:
> +            self.mask =3D struct.unpack_from('<I', buf, off+4)[0]
> +            self.sid =3D SID(buf, off+8)
> +
> +    def __str__(self):
> +        s =3D []
> +        s.append("Type: %s" % type_to_str(self.typ, ACE_TYPES))
> +        s.append("Flags: %s" % flags_to_str(self.flags, ACE_FLAGS))
> +        if self.typ not in [0,1,2]:
> +            s.append("<%s>"%(" ".join(["%02x"%x for x in self.buf])))
> +        else:
> +            s.append("Mask: %s"%flags_to_str(self.mask, (DIR_ACCESS_FLAG=
S if self.is_dir else FILE_ACCESS_FLAGS)))
> +            s.append("SID: %s"%self.sid)
> +        return ", ".join(s)
> +
> +def cmd_quota(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x04, input_buffer_length=3DINPUT=
_BUFFER_LENGTH)
> +    qi.pack_input('BBI', 0,
> +                  0, # return single
> +                  1, # restart scan
> +                  0, # sid list length
> +                  )
> +    qi.output_buffer_length =3D 16
> +    buf =3D None
> +
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    off =3D 0
> +    while off < len(buf):
> +        next_off =3D struct.unpack_from('<I', buf, off+ 0)[0]
> +        sid_len  =3D struct.unpack_from('<I', buf, off+ 4)[0]
> +        atime    =3D struct.unpack_from('<Q', buf, off+ 8)[0]
> +        qused    =3D struct.unpack_from('<Q', buf, off+16)[0]
> +        qthresh  =3D struct.unpack_from('<Q', buf, off+24)[0]
> +        qlimit   =3D struct.unpack_from('<Q', buf, off+32)[0]
> +        sid =3D SID(buf, off+40)
> +
> +        print("SID Length: %d"%sid_len)
> +        print("Change Time: %s"%win_to_datetime(atime))
> +        print("Quota Used: %d"%qused)
> +        print("Quota Threshold:", ("NO THRESHOLD" if qthresh =3D=3D 0xff=
ffffffffffffff else "%d"%qthresh))
> +        print("Quota Limit:", ("NO LIMIT" if qlimit =3D=3D 0xfffffffffff=
fffff else "%d"%qlimit))
> +        print("SID: %s"%sid)
> +
> +        if next_off =3D=3D 0:
> +            break
> +        off +=3D next_off
> +
> +def cmd_secdesc(args):
> +    qi =3D QueryInfoStruct(info_type=3D0x03,
> +                         additional_information=3D0x7, # owner, group, d=
acl
> +                         input_buffer_length=3DINPUT_BUFFER_LENGTH)
> +    buf =3D None
> +    info =3D None
> +
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        info =3D os.fstat(fd)
> +        buf =3D qi.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    is_dir =3D stat.S_ISDIR(info.st_mode)
> +    rev, ctrl, off_owner, off_group, off_dacl =3D struct.unpack_from('<B=
xHIIxxxxI', buf, 0)
> +
> +    print("Revision: %d"%rev)
> +    print("Control: %s"%flags_to_str(ctrl, CONTROL_FLAGS))
> +    if off_owner:
> +        print("Owner: %s"%SID(buf, off_owner))
> +    if off_group:
> +        print("Group: %s"%SID(buf, off_group))
> +    if off_dacl:
> +        print("DACL:")
> +        rev, count =3D struct.unpack_from('<BxxxH', buf, off_dacl)
> +        off_dacl +=3D 8
> +        for i in range(count):
> +              ace =3D ACE(buf, off_dacl, is_dir=3Dis_dir)
> +              print(ace)
> +              off_dacl +=3D ace.size
> +
> +
> +class KeyDebugInfoStruct:
> +    def __init__(self):
> +        self.suid =3D bytearray()
> +        self.cipher =3D 0
> +        self.auth_key =3D bytearray()
> +        self.enc_key =3D bytearray()
> +        self.dec_key =3D bytearray()
> +
> +    def ioctl(self, fd):
> +        buf =3D bytearray()
> +        buf.extend(struct.pack("=3D 8s H 16s 16s 16s", self.suid, self.c=
ipher,
> +                               self.auth_key, self.enc_key, self.dec_key=
))
> +        fcntl.ioctl(fd, CIFS_DUMP_KEY, buf, True)
> +        (self.suid, self.cipher, self.auth_key,
> +         self.enc_key, self.dec_key) =3D struct.unpack_from('=3D 8s H 16=
s 16s 16s', buf, 0)
> +
> +def bytes_to_hex(buf):
> +    return " ".join(["%02x"%x for x in buf])
> +
> +def cmd_keys(args):
> +    kd =3D KeyDebugInfoStruct()
> +    try:
> +        fd =3D os.open(args.file, os.O_RDONLY)
> +        kd.ioctl(fd)
> +    except Exception as e:
> +        print("syscall failed: %s"%e)
> +        return False
> +
> +    print("Session Id: %s"%bytes_to_hex(kd.suid))
> +    print("Cipher: %s"%type_to_str(kd.cipher, CIPHER_TYPES, verbose=3DTr=
ue))
> +    print("Session Key: %s"%bytes_to_hex(kd.auth_key))
> +    print("Encryption key: %s"%bytes_to_hex(kd.enc_key))
> +    print("Decryption key: %s"%bytes_to_hex(kd.dec_key))
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> diff --git a/smbinfo.c b/smbinfo.c
> deleted file mode 100644
> index 636f1bd..0000000
> --- a/smbinfo.c
> +++ /dev/null
> @@ -1,1296 +0,0 @@
> -/*
> - * smbinfo
> - *
> - * Copyright (C) Ronnie Sahlberg (lsahlberg@redhat.com) 2018
> - * Copyright (C) Aurelien Aptel (aaptel@suse.com) 2018
> - *
> - * Display SMB-specific file information using cifs IOCTL
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA
> - */
> -
> -#ifdef HAVE_CONFIG_H
> -#include "config.h"
> -#endif /* HAVE_CONFIG_H */
> -
> -#include <endian.h>
> -#include <errno.h>
> -#include <getopt.h>
> -#include <sys/ioctl.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <stdint.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <time.h>
> -#include <unistd.h>
> -#include <inttypes.h>
> -
> -#define CIFS_IOCTL_MAGIC 0xCF
> -
> -/* query_info flags */
> -#define PASSTHRU_QUERY_INFO     0x00000000
> -#define PASSTHRU_FSCTL          0x00000001
> -
> -struct smb_query_info {
> -       uint32_t   info_type;
> -       uint32_t   file_info_class;
> -       uint32_t   additional_information;
> -       uint32_t   flags;
> -       uint32_t   input_buffer_length;
> -       uint32_t   output_buffer_length;
> -       /* char buffer[]; */
> -} __packed;
> -
> -#define SMB3_SIGN_KEY_SIZE 16
> -struct smb3_key_debug_info {
> -       uint64_t Suid;
> -       uint16_t cipher_type;
> -       uint8_t auth_key[16]; /* SMB2_NTLMV2_SESSKEY_SIZE */
> -       uint8_t smb3encryptionkey[SMB3_SIGN_KEY_SIZE];
> -       uint8_t smb3decryptionkey[SMB3_SIGN_KEY_SIZE];
> -} __attribute__((packed));
> -
> -#define CIFS_QUERY_INFO _IOWR(CIFS_IOCTL_MAGIC, 7, struct smb_query_info=
)
> -#define CIFS_DUMP_KEY _IOWR(CIFS_IOCTL_MAGIC, 8, struct smb3_key_debug_i=
nfo)
> -#define INPUT_BUFFER_LENGTH 16384
> -
> -int verbose;
> -
> -static void
> -usage(char *name)
> -{
> -       fprintf(stderr, "Usage: %s [-V] <command> <file>\n"
> -               "-V for verbose output\n"
> -               "-h display this help text\n"
> -               "-v print smbinfo version\n"
> -               "Commands are\n"
> -               "  fileaccessinfo:\n"
> -               "      Prints FileAccessInfo for a cifs file.\n"
> -               "  filealigninfo:\n"
> -               "      Prints FileAlignInfo for a cifs file.\n"
> -               "  fileallinfo:\n"
> -               "      Prints FileAllInfo for a cifs file.\n"
> -               "  filebasicinfo:\n"
> -               "      Prints FileBasicInfo for a cifs file.\n"
> -               "  fileeainfo:\n"
> -               "      Prints FileEAInfo for a cifs file.\n"
> -               "  filefsfullsizeinfo:\n"
> -               "      Prints FileFsFullSizeInfo for a cifs share.\n"
> -               "  fileinternalinfo:\n"
> -               "      Prints FileInternalInfo for a cifs file.\n"
> -               "  filemodeinfo:\n"
> -               "      Prints FileModeInfo for a cifs file.\n"
> -               "  filepositioninfo:\n"
> -               "      Prints FilePositionInfo for a cifs file.\n"
> -               "  filestandardinfo:\n"
> -               "      Prints FileStandardInfo for a cifs file.\n"
> -               "  fsctl-getobjid:\n"
> -               "      Prints the objectid of the file and GUID of the un=
derlying volume.\n"
> -               "  getcompression:\n"
> -               "      Prints the compression setting for the file.\n"
> -               "  setcompression <no|default|lznt1>:\n"
> -               "      Sets the compression level for the file.\n"
> -               "  list-snapshots:\n"
> -               "      List the previous versions of the volume that back=
s this file.\n"
> -               "  quota:\n"
> -               "      Prints the quota for a cifs file.\n"
> -               "  secdesc:\n"
> -               "      Prints the security descriptor for a cifs file.\n"
> -               "  keys:\n"
> -               "      Prints the decryption information needed to view e=
ncrypted network traces.\n",
> -               name);
> -       exit(1);
> -}
> -
> -static void
> -short_usage(char *name)
> -{
> -       fprintf(stderr, "Usage: %s [-v] [-V] <command> <file>\n"
> -               "Try 'smbinfo -h' for more information.\n", name);
> -       exit(1);
> -}
> -
> -static void
> -win_to_timeval(uint64_t smb2_time, struct timeval *tv)
> -{
> -       tv->tv_usec =3D (smb2_time / 10) % 1000000;
> -       tv->tv_sec  =3D (smb2_time - 116444736000000000) / 10000000;
> -}
> -
> -struct bit_string {
> -       unsigned int bit;
> -       char *string;
> -};
> -
> -struct bit_string directory_access_mask[] =3D {
> -       { 0x00000001, "LIST_DIRECTORY" },
> -       { 0x00000002, "ADD_FILE" },
> -       { 0x00000004, "ADD_SUBDIRECTORY" },
> -       { 0x00000008, "READ_EA" },
> -       { 0x00000010, "WRITE_EA" },
> -       { 0x00000020, "TRAVERSE" },
> -       { 0x00000040, "DELETE_CHILD" },
> -       { 0x00000080, "READ_ATTRIBUTES" },
> -       { 0x00000100, "WRITE_ATTRIBUTES" },
> -       { 0x00010000, "DELETE" },
> -       { 0x00020000, "READ_CONTROL" },
> -       { 0x00040000, "WRITE_DAC" },
> -       { 0x00080000, "WRITE_OWNER" },
> -       { 0x00100000, "SYNCHRONIZER" },
> -       { 0x01000000, "ACCESS_SYSTEM_SECURITY" },
> -       { 0x02000000, "MAXIMUM_ALLOWED" },
> -       { 0x10000000, "GENERIC_ALL" },
> -       { 0x20000000, "GENERIC_EXECUTE" },
> -       { 0x40000000, "GENERIC_WRITE" },
> -       { 0x80000000, "GENERIC_READ" },
> -       { 0, NULL }
> -};
> -
> -struct bit_string file_access_mask[] =3D {
> -       { 0x00000001, "READ_DATA" },
> -       { 0x00000002, "WRITE_DATA" },
> -       { 0x00000004, "APPEND_DATA" },
> -       { 0x00000008, "READ_EA" },
> -       { 0x00000010, "WRITE_EA" },
> -       { 0x00000020, "EXECUTE" },
> -       { 0x00000040, "DELETE_CHILD" },
> -       { 0x00000080, "READ_ATTRIBUTES" },
> -       { 0x00000100, "WRITE_ATTRIBUTES" },
> -       { 0x00010000, "DELETE" },
> -       { 0x00020000, "READ_CONTROL" },
> -       { 0x00040000, "WRITE_DAC" },
> -       { 0x00080000, "WRITE_OWNER" },
> -       { 0x00100000, "SYNCHRONIZER" },
> -       { 0x01000000, "ACCESS_SYSTEM_SECURITY" },
> -       { 0x02000000, "MAXIMUM_ALLOWED" },
> -       { 0x10000000, "GENERIC_ALL" },
> -       { 0x20000000, "GENERIC_EXECUTE" },
> -       { 0x40000000, "GENERIC_WRITE" },
> -       { 0x80000000, "GENERIC_READ" },
> -       { 0, NULL }
> -};
> -
> -static void
> -print_bits(uint32_t mask, struct bit_string *bs)
> -{
> -       int first =3D 1;
> -
> -       if (!verbose)
> -               return;
> -
> -       while (bs->string) {
> -               if (mask & bs->bit) {
> -                       printf("%s%s", first?"":",", bs->string);
> -                       first =3D 0;
> -               }
> -               bs++;
> -       }
> -       if (!first)
> -               printf(" ");
> -}
> -
> -static void
> -print_guid(uint8_t *sd)
> -{
> -       uint32_t u32;
> -       uint16_t u16;
> -       int i;
> -
> -       memcpy(&u32, &sd[0], 4);
> -       printf("%08x-", le32toh(u32));
> -
> -       memcpy(&u16, &sd[4], 2);
> -       printf("%04x-", le16toh(u16));
> -
> -       memcpy(&u16, &sd[6], 2);
> -       printf("%04x-", le16toh(u16));
> -
> -       printf("%02x%02x-", sd[8], sd[9]);
> -       for (i =3D 0; i < 6; i++)
> -               printf("%02x", sd[10 + i]);
> -}
> -
> -static void
> -print_objidbuf(uint8_t *sd)
> -{
> -       printf("Object-ID: ");
> -       print_guid(&sd[0]);
> -       printf("\n");
> -
> -       printf("Birth-Volume-ID: ");
> -       print_guid(&sd[16]);
> -       printf("\n");
> -
> -       printf("Birth-Object-ID: ");
> -       print_guid(&sd[32]);
> -       printf("\n");
> -
> -       printf("Domain-ID: ");
> -       print_guid(&sd[48]);
> -       printf("\n");
> -}
> -
> -static void
> -fsctlgetobjid(int f)
> -{
> -       struct smb_query_info *qi;
> -       struct stat st;
> -
> -       fstat(f, &st);
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 64);
> -       memset(qi, 0, sizeof(qi) + 64);
> -       qi->info_type =3D 0x9009c;
> -       qi->file_info_class =3D 0;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 64;
> -       qi->flags =3D PASSTHRU_FSCTL;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -       print_objidbuf((uint8_t *)(&qi[1]));
> -
> -       free(qi);
> -}
> -
> -static void
> -print_getcompression(uint8_t *sd)
> -{
> -       uint16_t u16;
> -
> -       memcpy(&u16, &sd[0], 2);
> -       u16 =3D le16toh(u16);
> -
> -       printf("Compression: ");
> -       switch (u16) {
> -       case 0:
> -               printf("(0) NONE\n");
> -               break;
> -       case 2:
> -               printf("(2) LZNT1\n");
> -               break;
> -       default:
> -               printf("(%d) UNKNOWN\n", u16);
> -               break;
> -       }
> -}
> -
> -static void
> -getcompression(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 2);
> -       memset(qi, 0, sizeof(qi) + 2);
> -       qi->info_type =3D 0x9003c;
> -       qi->file_info_class =3D 0;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 2;
> -       qi->flags =3D PASSTHRU_FSCTL;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -       print_getcompression((uint8_t *)(&qi[1]));
> -
> -       free(qi);
> -}
> -
> -static void
> -setcompression(int f, uint16_t level)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 2);
> -       memset(qi, 0, sizeof(qi) + 2);
> -       qi->info_type =3D 0x9c040;
> -       qi->file_info_class =3D 0;
> -       qi->additional_information =3D 0;
> -       qi->output_buffer_length =3D 2;
> -       qi->flags =3D PASSTHRU_FSCTL;
> -
> -       level =3D htole16(level);
> -       memcpy(&qi[1], &level, 2);
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       free(qi);
> -}
> -
> -static void
> -print_fileaccessinfo(uint8_t *sd, int type)
> -{
> -       uint32_t access_flags;
> -
> -       memcpy(&access_flags, &sd[0], 4);
> -       access_flags =3D le32toh(access_flags);
> -
> -       if (type =3D=3D S_IFDIR) {
> -               printf("Directory access flags 0x%08x: ", access_flags);
> -               print_bits(access_flags, directory_access_mask);
> -       } else {
> -               printf("File/Printer access flags 0x%08x: ", access_flags=
);
> -               print_bits(access_flags, file_access_mask);
> -       }
> -       printf("\n");
> -}
> -
> -static void
> -fileaccessinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -       struct stat st;
> -
> -       fstat(f, &st);
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 4);
> -       memset(qi, 0, sizeof(qi) + 4);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 8;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 4;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_fileaccessinfo((uint8_t *)(&qi[1]), st.st_mode & S_IFMT);
> -       free(qi);
> -}
> -
> -static void
> -print_filealigninfo(uint8_t *sd)
> -{
> -       uint32_t mask;
> -
> -       memcpy(&mask, &sd[0], 4);
> -       mask =3D le32toh(mask);
> -
> -       printf("File alignment: ");
> -       if (mask =3D=3D 0)
> -               printf("BYTE_ALIGNMENT");
> -       else if (mask =3D=3D 1)
> -               printf("WORD_ALIGNMENT");
> -       else if (mask =3D=3D 3)
> -               printf("LONG_ALIGNMENT");
> -       else if (mask =3D=3D 7)
> -               printf("QUAD_ALIGNMENT");
> -       else if (mask =3D=3D 15)
> -               printf("OCTA_ALIGNMENT");
> -       else if (mask =3D=3D 31)
> -               printf("32_bit_ALIGNMENT");
> -       else if (mask =3D=3D 63)
> -               printf("64_bit_ALIGNMENT");
> -       else if (mask =3D=3D 127)
> -               printf("128_bit_ALIGNMENT");
> -       else if (mask =3D=3D 255)
> -               printf("254_bit_ALIGNMENT");
> -       else if (mask =3D=3D 511)
> -               printf("512_bit_ALIGNMENT");
> -
> -       printf("\n");
> -}
> -
> -static void
> -filealigninfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 4);
> -       memset(qi, 0, sizeof(qi) + 4);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 17;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 4;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filealigninfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -struct bit_string file_attributes_mask[] =3D {
> -       { 0x00000001, "READ_ONLY" },
> -       { 0x00000002, "HIDDEN" },
> -       { 0x00000004, "SYSTEM" },
> -       { 0x00000010, "DIRECTORY" },
> -       { 0x00000020, "ARCHIVE" },
> -       { 0x00000080, "NORMAL" },
> -       { 0x00000100, "TEMPORARY" },
> -       { 0x00000200, "SPARSE_FILE" },
> -       { 0x00000400, "REPARSE_POINT" },
> -       { 0x00000800, "COMPRESSED" },
> -       { 0x00001000, "OFFLINE" },
> -       { 0x00002000, "NOT_CONTENT_INDEXED" },
> -       { 0x00004000, "ENCRYPTED" },
> -       { 0x00008000, "INTEGRITY_STREAM" },
> -       { 0x00020000, "NO_SCRUB_DATA" },
> -       { 0, NULL }
> -};
> -
> -static void
> -print_filebasicinfo(uint8_t *sd)
> -{
> -       struct timeval tv;
> -       uint64_t u64;
> -       uint32_t u32;
> -
> -       memcpy(&u64, &sd[0], 8);
> -       win_to_timeval(le64toh(u64), &tv);
> -       printf("Creation Time %s", ctime(&tv.tv_sec));
> -
> -       memcpy(&u64, &sd[8], 8);
> -       win_to_timeval(le64toh(u64), &tv);
> -       printf("Last Access Time %s", ctime(&tv.tv_sec));
> -
> -       memcpy(&u64, &sd[16], 8);
> -       win_to_timeval(le64toh(u64), &tv);
> -       printf("Last Write Time %s", ctime(&tv.tv_sec));
> -
> -       memcpy(&u64, &sd[24], 8);
> -       win_to_timeval(le64toh(u64), &tv);
> -       printf("Last Change Time %s", ctime(&tv.tv_sec));
> -
> -       memcpy(&u32, &sd[32], 4);
> -       u32 =3D le32toh(u32);
> -       printf("File Attributes 0x%08x: ", u32);
> -       print_bits(u32, file_attributes_mask);
> -       printf("\n");
> -}
> -
> -static void
> -filebasicinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 40);
> -       memset(qi, 0, sizeof(qi) + 40);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 4;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 40;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filebasicinfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -print_filestandardinfo(uint8_t *sd)
> -{
> -       uint64_t u64;
> -       uint32_t u32;
> -
> -       memcpy(&u64, &sd[0], 8);
> -       printf("Allocation Size %" PRIu64 "\n", le64toh(u64));
> -
> -       memcpy(&u64, &sd[8], 8);
> -       printf("End Of File %" PRIu64 "\n", le64toh(u64));
> -
> -       memcpy(&u32, &sd[16], 4);
> -       printf("Number Of Links %" PRIu32 "\n", le32toh(u32));
> -
> -       printf("Delete Pending %d\n", sd[20]);
> -       printf("Delete Directory %d\n", sd[21]);
> -}
> -
> -static void
> -filestandardinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 24);
> -       memset(qi, 0, sizeof(qi) + 24);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 5;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 24;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filestandardinfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -print_fileinternalinfo(uint8_t *sd)
> -{
> -       uint64_t u64;
> -
> -       memcpy(&u64, &sd[0], 8);
> -       printf("Index Number %" PRIu64 "\n", le64toh(u64));
> -}
> -
> -static void
> -fileinternalinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 8);
> -       memset(qi, 0, sizeof(qi) + 8);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 6;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 8;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_fileinternalinfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -struct bit_string file_mode_mask[] =3D {
> -       { 0x00000002, "WRITE_THROUGH" },
> -       { 0x00000004, "SEQUENTIAL_ONLY" },
> -       { 0x00000008, "NO_INTERMEDIATE_BUFFERING" },
> -       { 0x00000010, "SYNCHRONOUS_IO_ALERT" },
> -       { 0x00000020, "SYNCHRONOUS_IO_NONALERT" },
> -       { 0x00001000, "DELETE_ON_CLOSE" },
> -       { 0, NULL }
> -};
> -
> -static void
> -print_filemodeinfo(uint8_t *sd)
> -{
> -       uint32_t u32;
> -
> -       memcpy(&u32, &sd[32], 4);
> -       u32 =3D le32toh(u32);
> -       printf("Mode 0x%08x: ", u32);
> -       print_bits(u32, file_mode_mask);
> -       printf("\n");
> -}
> -
> -static void
> -filemodeinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 4);
> -       memset(qi, 0, sizeof(qi) + 4);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 16;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 4;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filemodeinfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -print_filepositioninfo(uint8_t *sd)
> -{
> -       uint64_t u64;
> -
> -       memcpy(&u64, &sd[0], 8);
> -       printf("Current Byte Offset %" PRIu64 "\n", le64toh(u64));
> -}
> -
> -static void
> -filepositioninfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 8);
> -       memset(qi, 0, sizeof(qi) + 8);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 14;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 8;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filepositioninfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -print_fileeainfo(uint8_t *sd)
> -{
> -       uint32_t u32;
> -
> -       memcpy(&u32, &sd[0], 4);
> -       printf("Ea Size %" PRIu32 "\n", le32toh(u32));
> -}
> -
> -static void
> -fileeainfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 4);
> -       memset(qi, 0, sizeof(qi) + 4);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 7;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 4;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_fileeainfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -print_filefullsizeinfo(uint8_t *sd)
> -{
> -       uint32_t u32;
> -       uint64_t u64;
> -
> -       memcpy(&u64, &sd[0], 8);
> -       printf("Total Allocation Units: %" PRIu64 "\n", le64toh(u64));
> -
> -       memcpy(&u64, &sd[8], 8);
> -       printf("Caller Available Allocation Units: %" PRIu64 "\n",
> -              le64toh(u64));
> -
> -       memcpy(&u64, &sd[16], 8);
> -       printf("Actual Available Allocation Units: %" PRIu64 "\n",
> -              le64toh(u64));
> -
> -       memcpy(&u32, &sd[24], 4);
> -       printf("Sectors Per Allocation Unit: %" PRIu32 "\n", le32toh(u32)=
);
> -
> -       memcpy(&u32, &sd[28], 4);
> -       printf("Bytes Per Sector: %" PRIu32 "\n", le32toh(u32));
> -}
> -
> -static void
> -filefsfullsizeinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + 32);
> -       memset(qi, 0, sizeof(qi) + 32);
> -       qi->info_type =3D 0x02;
> -       qi->file_info_class =3D 7;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D 32;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filefullsizeinfo((uint8_t *)(&qi[1]));
> -       free(qi);
> -}
> -
> -static void
> -fileallinfo(int f)
> -{
> -       struct smb_query_info *qi;
> -       struct stat st;
> -
> -       fstat(f, &st);
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + INPUT_BUFFER_LENGTH=
);
> -       memset(qi, 0, sizeof(qi) + INPUT_BUFFER_LENGTH);
> -       qi->info_type =3D 0x01;
> -       qi->file_info_class =3D 18;
> -       qi->additional_information =3D 0;
> -       qi->input_buffer_length =3D INPUT_BUFFER_LENGTH;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_filebasicinfo((uint8_t *)(&qi[1]));
> -       print_filestandardinfo((uint8_t *)(&qi[1]) + 40);
> -       print_fileinternalinfo((uint8_t *)(&qi[1]) + 64);
> -       print_fileeainfo((uint8_t *)(&qi[1]) + 72);
> -       print_fileaccessinfo((uint8_t *)(&qi[1]) + 76, st.st_mode & S_IFM=
T);
> -       print_filepositioninfo((uint8_t *)(&qi[1]) + 80);
> -       print_filemodeinfo((uint8_t *)(&qi[1]) + 88);
> -       print_filealigninfo((uint8_t *)(&qi[1]) + 92);
> -       // SMB2 servers like Win16 does not seem to return name info
> -       free(qi);
> -}
> -
> -static void
> -print_sid(unsigned char *sd)
> -{
> -       int i;
> -       uint32_t subauth;
> -       uint64_t idauth;
> -
> -       if (sd[0] !=3D 1) {
> -               fprintf(stderr, "Unknown SID revision\n");
> -               return;
> -       }
> -
> -       idauth =3D 0;
> -       for (i =3D 0; i < 6; i++)
> -               idauth =3D (idauth << 8) | sd[2 + i];
> -
> -       printf("S-1-%" PRIu64, idauth);
> -       for (i =3D 0; i < sd[1]; i++) {
> -               memcpy(&subauth, &sd[8 + 4 * i], 4);
> -               subauth =3D le32toh(subauth);
> -               printf("-%u", subauth);
> -       }
> -}
> -
> -static void
> -print_ace_type(uint8_t t)
> -{
> -       switch(t) {
> -       case 0x00: printf("ALLOWED"); break;
> -       case 0x01: printf("DENIED"); break;
> -       case 0x02: printf("AUDIT"); break;
> -       case 0x03: printf("ALARM"); break;
> -       case 0x04: printf("ALLOWED_COMPOUND"); break;
> -       case 0x05: printf("ALLOWED_OBJECT"); break;
> -       case 0x06: printf("DENIED_OBJECT"); break;
> -       case 0x07: printf("AUDIT_OBJECT"); break;
> -       case 0x08: printf("ALARM_OBJECT"); break;
> -       case 0x09: printf("ALLOWED_CALLBACK"); break;
> -       case 0x0a: printf("DENIED_CALLBACK"); break;
> -       case 0x0b: printf("ALLOWED_CALLBACK_OBJECT"); break;
> -       case 0x0c: printf("DENIED_CALLBACK_OBJECT"); break;
> -       case 0x0d: printf("AUDIT_CALLBACK"); break;
> -       case 0x0e: printf("ALARM_CALLBACK"); break;
> -       case 0x0f: printf("AUDIT_CALLBACK_OBJECT"); break;
> -       case 0x10: printf("ALARM_CALLBACK_OBJECT"); break;
> -       case 0x11: printf("MANDATORY_LABEL"); break;
> -       case 0x12: printf("RESOURCE_ATTRIBUTE"); break;
> -       case 0x13: printf("SCOPED_POLICY_ID"); break;
> -       default: printf("<UNKNOWN>");
> -       }
> -       printf(" ");
> -}
> -
> -struct bit_string ace_flags_mask[] =3D {
> -       { 0x80, "FAILED_ACCESS" },
> -       { 0x40, "SUCCESSFUL_ACCESS" },
> -       { 0x10, "INHERITED" },
> -       { 0x08, "INHERIT_ONLY" },
> -       { 0x04, "NO_PROPAGATE_INHERIT" },
> -       { 0x02, "CONTAINER_INHERIT" },
> -       { 0x01, "OBJECT_INHERIT" },
> -       { 0, NULL }
> -};
> -
> -static void
> -print_mask_sid_ace(unsigned char *sd, int type)
> -{
> -       uint32_t u32;
> -
> -       memcpy(&u32, &sd[0], 4);
> -       printf("Mask:0x%08x ", le32toh(u32));
> -       if (type =3D=3D S_IFDIR)
> -               print_bits(le32toh(u32), directory_access_mask);
> -       else
> -               print_bits(le32toh(u32), file_access_mask);
> -       printf("SID:");
> -       print_sid(&sd[4]);
> -       printf("\n");
> -}
> -
> -static int
> -print_ace(unsigned char *sd, int type)
> -{
> -       uint16_t size;
> -       int i;
> -
> -       printf("Type:0x%02x ", sd[0]);
> -       if (verbose) {
> -               print_ace_type(sd[0]);
> -       }
> -
> -       printf("Flags:0x%02x ", sd[1]);
> -       print_bits(sd[1], ace_flags_mask);
> -
> -       memcpy(&size, &sd[2], 2);
> -       size =3D le16toh(size);
> -
> -       switch (sd[0]) {
> -       case 0x00:
> -       case 0x01:
> -       case 0x02:
> -               print_mask_sid_ace(&sd[4], type);
> -               break;
> -       default:
> -               for (i =3D 0; i < size; i++)
> -                       printf("%02x", sd[4 + i]);
> -       }
> -
> -       printf("\n");
> -       return size;
> -}
> -
> -static void
> -print_acl(unsigned char *sd, int type)
> -{
> -       int i, off;
> -       uint16_t count;
> -
> -       if ((sd[0] !=3D 2) && (sd[0] !=3D 4)) {
> -               fprintf(stderr, "Unknown ACL revision\n");
> -               return;
> -       }
> -
> -       memcpy(&count, &sd[4], 2);
> -       count =3D le16toh(count);
> -       off =3D 8;
> -       for (i =3D 0; i < count; i++)
> -               off +=3D print_ace(&sd[off], type);
> -}
> -
> -struct bit_string control_bits_mask[] =3D {
> -       { 0x8000, "SR" },
> -       { 0x4000, "RM" },
> -       { 0x2000, "PS" },
> -       { 0x1000, "PD" },
> -       { 0x0800, "SI" },
> -       { 0x0400, "DI" },
> -       { 0x0200, "SC" },
> -       { 0x0100, "DC" },
> -       { 0x0080, "DT" },
> -       { 0x0040, "SS" },
> -       { 0x0020, "SD" },
> -       { 0x0010, "SP" },
> -       { 0x0008, "DD" },
> -       { 0x0004, "DP" },
> -       { 0x0002, "GD" },
> -       { 0x0001, "OD" },
> -       { 0, NULL }
> -};
> -
> -static void
> -print_control(uint16_t c)
> -{
> -       printf("Control: 0x%04x ", c);
> -       print_bits(c, control_bits_mask);
> -       printf("\n");
> -}
> -
> -static void
> -print_sd(uint8_t *sd, int type)
> -{
> -       int offset_owner, offset_group, offset_dacl;
> -       uint16_t u16;
> -
> -       printf("Revision:%d\n", sd[0]);
> -       if (sd[0] !=3D 1) {
> -               fprintf(stderr, "Unknown SD revision\n");
> -               exit(1);
> -       }
> -
> -       memcpy(&u16, &sd[2], 2);
> -       print_control(le16toh(u16));
> -
> -       memcpy(&offset_owner, &sd[4], 4);
> -       offset_owner =3D le32toh(offset_owner);
> -       memcpy(&offset_group, &sd[8], 4);
> -       offset_group =3D le32toh(offset_group);
> -       memcpy(&offset_dacl, &sd[16], 4);
> -       offset_dacl =3D le32toh(offset_dacl);
> -
> -       if (offset_owner) {
> -               printf("Owner: ");
> -               print_sid(&sd[offset_owner]);
> -               printf("\n");
> -       }
> -       if (offset_group) {
> -               printf("Group: ");
> -               print_sid(&sd[offset_group]);
> -               printf("\n");
> -       }
> -       if (offset_dacl) {
> -               printf("DACL:\n");
> -               print_acl(&sd[offset_dacl], type);
> -       }
> -}
> -
> -static void
> -secdesc(int f)
> -{
> -       struct smb_query_info *qi;
> -       struct stat st;
> -
> -       fstat(f, &st);
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + INPUT_BUFFER_LENGTH=
);
> -       memset(qi, 0, sizeof(qi) + INPUT_BUFFER_LENGTH);
> -       qi->info_type =3D 0x03;
> -       qi->file_info_class =3D 0;
> -       qi->additional_information =3D 0x00000007; /* Owner, Group, Dacl =
*/
> -       qi->input_buffer_length =3D INPUT_BUFFER_LENGTH;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_sd((uint8_t *)(&qi[1]), st.st_mode & S_IFMT);
> -       free(qi);
> -}
> -
> -static void
> -print_quota(unsigned char *sd)
> -{
> -       uint32_t u32, neo;
> -       uint64_t u64;
> -       struct timeval tv;
> -       int i, off =3D 0;
> -
> -one_more:
> -       memcpy(&u32, &sd[off], 4);
> -       neo =3D le32toh(u32);
> -
> -       memcpy(&u32, &sd[off + 4], 4);
> -       u32 =3D le32toh(u32);
> -       printf("SID Length %d\n", u32);
> -
> -       memcpy(&u64, &sd[off + 8], 8);
> -       win_to_timeval(le64toh(u64), &tv);
> -       printf("Change Time %s", ctime(&tv.tv_sec));
> -
> -       memcpy(&u64, &sd[off + 16], 8);
> -       u64 =3D le32toh(u64);
> -       printf("Quota Used %" PRIu64 "\n", u64);
> -
> -       memcpy(&u64, &sd[off + 24], 8);
> -       u64 =3D le64toh(u64);
> -       if (u64 =3D=3D 0xffffffffffffffff)
> -               printf("Quota Threshold NO THRESHOLD\n");
> -       else
> -               printf("Quota Threshold %" PRIu64 "\n", u64);
> -
> -       memcpy(&u64, &sd[off + 32], 8);
> -       u64 =3D le64toh(u64);
> -       if (u64 =3D=3D 0xffffffffffffffff)
> -               printf("Quota Limit NO LIMIT\n");
> -       else
> -               printf("Quota Limit %" PRIu64 "\n", u64);
> -
> -       printf("SID: S-1");
> -       u64 =3D 0;
> -       for (i =3D 0; i < 6; i++)
> -               u64 =3D (u64 << 8) | sd[off + 42 + i];
> -       printf("-%" PRIu64, u64);
> -
> -       for (i =3D 0; i < sd[off + 41]; i++) {
> -               memcpy(&u32, &sd[off + 48 + 4 * i], 4);
> -               u32 =3D le32toh(u32);
> -               printf("-%u", u32);
> -       }
> -       printf("\n\n");
> -       off +=3D neo;
> -
> -       if (neo !=3D 0)
> -               goto one_more;
> -}
> -
> -static void
> -quota(int f)
> -{
> -       struct smb_query_info *qi;
> -       char *buf;
> -       int i;
> -
> -       qi =3D malloc(sizeof(struct smb_query_info) + INPUT_BUFFER_LENGTH=
);
> -       memset(qi, 0, sizeof(struct smb_query_info) + INPUT_BUFFER_LENGTH=
);
> -       qi->info_type =3D 0x04;
> -       qi->file_info_class =3D 0;
> -       qi->additional_information =3D 0; /* Owner, Group, Dacl */
> -       qi->input_buffer_length =3D INPUT_BUFFER_LENGTH;
> -
> -       buf =3D (char *)&qi[1];
> -       buf[0] =3D 0; /* return single */
> -       buf[1] =3D 1; /* restart scan */
> -
> -       /* sid list length */
> -       i =3D 0;
> -       memcpy(&buf[4], &i, 4);
> -
> -       qi->output_buffer_length =3D 16;
> -
> -       if (ioctl(f, CIFS_QUERY_INFO, qi) < 0) {
> -               fprintf(stderr, "ioctl failed with %s\n", strerror(errno)=
);
> -               exit(1);
> -       }
> -
> -       print_quota((unsigned char *)(&qi[1]));
> -       free(qi);
> -}
> -
> -
> -struct smb_snapshot_array {
> -       int32_t number_of_snapshots;
> -       int32_t number_of_snapshots_returned;
> -       int32_t snapshot_array_size;
> -       char snapshot_data[0];
> -};
> -
> -
> -#define GMT_NAME_LEN 24 /* length of a @GMT- name */
> -#define GMT_FORMAT "@GMT-%Y.%m.%d-%H.%M.%S"
> -
> -#define NTFS_TIME_OFFSET ((unsigned long long)(369*365 + 89) * 24 * 3600=
 * 10000000)
> -
> -static void print_snapshots(struct smb_snapshot_array *psnap)
> -{
> -       int current_snapshot_entry =3D 0;
> -       char gmt_token[GMT_NAME_LEN + 1] =3D {0};
> -       int i;
> -       int j =3D 0;
> -       struct tm tm;
> -       unsigned long long dce_time;
> -
> -       printf("Number of snapshots: %d Number of snapshots returned: %d\=
n",
> -               psnap->number_of_snapshots,
> -               psnap->number_of_snapshots_returned);
> -       printf("Snapshot list in GMT (Coordinated UTC Time) and SMB forma=
t (100 nanosecond units needed for snapshot mounts):");
> -       for (i =3D 0; i < psnap->snapshot_array_size; i++) {
> -               if (psnap->snapshot_data[i] =3D=3D '@') {
> -                       j =3D 0;
> -                       current_snapshot_entry++;
> -                       printf("\n%d) GMT:", current_snapshot_entry);
> -               }
> -               if (psnap->snapshot_data[i] !=3D 0) {
> -                       gmt_token[j] =3D psnap->snapshot_data[i];
> -                       j++;
> -               }
> -               if (j =3D=3D GMT_NAME_LEN) {
> -                       printf("%s", gmt_token);
> -                       j =3D 0;
> -                       strptime(gmt_token, GMT_FORMAT, &tm);
> -                       dce_time =3D timegm(&tm) * 10000000 + NTFS_TIME_O=
FFSET;
> -                       printf("\n   SMB3:%llu", dce_time);
> -               }
> -       }
> -       printf("\n");
> -}
> -
> -static void
> -dump_keys(int f)
> -{
> -       struct smb3_key_debug_info keys_info;
> -       uint8_t *psess_id;
> -
> -       if (ioctl(f, CIFS_DUMP_KEY, &keys_info) < 0) {
> -               fprintf(stderr, "Querying keys information failed with %s=
\n", strerror(errno));
> -               exit(1);
> -       }
> -
> -       if (keys_info.cipher_type =3D=3D 1)
> -               printf("CCM encryption");
> -       else if (keys_info.cipher_type =3D=3D 2)
> -               printf("GCM encryption");
> -       else if (keys_info.cipher_type =3D=3D 0)
> -               printf("SMB3.0 CCM encryption");
> -       else
> -               printf("unknown encryption type");
> -
> -       printf("\nSession Id:  ");
> -       psess_id =3D (uint8_t *)&keys_info.Suid;
> -       for (int i =3D 0; i < 8; i++)
> -               printf(" %02x", psess_id[i]);
> -
> -       printf("\nSession Key: ");
> -       for (int i =3D 0; i < 16; i++)
> -               printf(" %02x", keys_info.auth_key[i]);
> -       printf("\nServer Encryption Key: ");
> -       for (int i =3D 0; i < SMB3_SIGN_KEY_SIZE; i++)
> -               printf(" %02x", keys_info.smb3encryptionkey[i]);
> -       printf("\nServer Decryption Key: ");
> -       for (int i =3D 0; i < SMB3_SIGN_KEY_SIZE; i++)
> -               printf(" %02x", keys_info.smb3decryptionkey[i]);
> -       printf("\n");
> -}
> -
> -#define CIFS_ENUMERATE_SNAPSHOTS _IOR(CIFS_IOCTL_MAGIC, 6, struct smb_sn=
apshot_array)
> -
> -#define MIN_SNAPSHOT_ARRAY_SIZE 16 /* See MS-SMB2 section 3.3.5.15.1 */
> -
> -static void
> -list_snapshots(int f)
> -{
> -
> -       struct smb_snapshot_array snap_inf;
> -       struct smb_snapshot_array *buf;
> -
> -       /*
> -        * When first field in structure we pass in here is zero, cifs.ko=
 can
> -        * recognize that this is the first query and that it must set th=
e SMB3
> -        * FSCTL response buffer size (in the request) to exactly 16 byte=
s
> -        * (which is required by some servers to process the initial quer=
y)
> -        */
> -       snap_inf.number_of_snapshots =3D 0;
> -       snap_inf.number_of_snapshots_returned =3D 0;
> -       snap_inf.snapshot_array_size =3D sizeof(struct smb_snapshot_array=
);
> -
> -       /* Query the number of snapshots so we know how much to allocate =
*/
> -       if (ioctl(f, CIFS_ENUMERATE_SNAPSHOTS, &snap_inf) < 0) {
> -               fprintf(stderr, "Querying snapshots failed with %s\n", st=
rerror(errno));
> -               exit(1);
> -       }
> -
> -       if (snap_inf.number_of_snapshots =3D=3D 0)
> -               return;
> -
> -       /* Now that we know the size, query the list from the server */
> -
> -       buf =3D malloc(snap_inf.snapshot_array_size + MIN_SNAPSHOT_ARRAY_=
SIZE);
> -
> -       if (buf =3D=3D NULL) {
> -               printf("Failed, out of memory.\n");
> -               exit(1);
> -       }
> -       /*
> -        * first parm is non-zero which allows cifs.ko to recognize that =
this is
> -        * the second query (it has to set response buf size larger)
> -        */
> -       buf->number_of_snapshots =3D snap_inf.number_of_snapshots;
> -
> -       buf->snapshot_array_size =3D snap_inf.snapshot_array_size;
> -
> -       if (ioctl(f, CIFS_ENUMERATE_SNAPSHOTS, buf) < 0) {
> -               fprintf(stderr, "Querying snapshots failed with %s\n", st=
rerror(errno));
> -               exit(1);
> -       }
> -
> -       print_snapshots(buf);
> -       free(buf);
> -}
> -
> -static int
> -parse_compression(const char *arg)
> -{
> -       if (!strcmp(arg, "no"))
> -               return 0;
> -       else if (!strcmp(arg, "default"))
> -               return 1;
> -       else if (!strcmp(arg, "lznt1"))
> -               return 2;
> -
> -       fprintf(stderr, "compression must be no|default|lznt1\n");
> -       exit(10);
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -       int c;
> -       int f;
> -       int compression =3D 1;
> -
> -       if (argc < 2) {
> -               short_usage(argv[0]);
> -       }
> -
> -       while ((c =3D getopt_long(argc, argv, "c:vVh", NULL, NULL)) !=3D =
-1) {
> -               switch (c) {
> -               case 'c':
> -                       compression =3D parse_compression(optarg);
> -                       break;
> -               case 'v':
> -                       printf("smbinfo version %s\n", VERSION);
> -                       return 0;
> -               case 'V':
> -                       verbose =3D 1;
> -                       break;
> -               case 'h':
> -                       usage(argv[0]);
> -                       break;
> -               default:
> -                       short_usage(argv[0]);
> -               }
> -       }
> -
> -       if (optind >=3D argc -1)
> -               short_usage(argv[0]);
> -
> -       if ((f =3D open(argv[optind + 1 ], O_RDONLY)) < 0) {
> -               fprintf(stderr, "Failed to open %s\n", argv[optind + 1]);
> -               exit(1);
> -       }
> -
> -       if (!strcmp(argv[optind], "fileaccessinfo"))
> -               fileaccessinfo(f);
> -       else if (!strcmp(argv[optind], "filealigninfo"))
> -               filealigninfo(f);
> -       else if (!strcmp(argv[optind], "fileallinfo"))
> -               fileallinfo(f);
> -       else if (!strcmp(argv[optind], "filebasicinfo"))
> -               filebasicinfo(f);
> -       else if (!strcmp(argv[optind], "fileeainfo"))
> -               fileeainfo(f);
> -       else if (!strcmp(argv[optind], "filefsfullsizeinfo"))
> -               filefsfullsizeinfo(f);
> -       else if (!strcmp(argv[optind], "fileinternalinfo"))
> -               fileinternalinfo(f);
> -       else if (!strcmp(argv[optind], "filemodeinfo"))
> -               filemodeinfo(f);
> -       else if (!strcmp(argv[optind], "filepositioninfo"))
> -               filepositioninfo(f);
> -       else if (!strcmp(argv[optind], "filestandardinfo"))
> -               filestandardinfo(f);
> -       else if (!strcmp(argv[optind], "fsctl-getobjid"))
> -               fsctlgetobjid(f);
> -       else if (!strcmp(argv[optind], "getcompression"))
> -               getcompression(f);
> -       else if (!strcmp(argv[optind], "setcompression"))
> -               setcompression(f, compression);
> -       else if (!strcmp(argv[optind], "list-snapshots"))
> -               list_snapshots(f);
> -       else if (!strcmp(argv[optind], "quota"))
> -               quota(f);
> -       else if (!strcmp(argv[optind], "secdesc"))
> -               secdesc(f);
> -       else if (!strcmp(argv[optind], "keys"))
> -               dump_keys(f);
> -       else {
> -               fprintf(stderr, "Unknown command %s\n", argv[optind]);
> -               exit(1);
> -       }
> -
> -       close(f);
> -       return 0;
> -}
> --
> 2.16.4
>

Great work, thanks!

I am planning to merge this for the next after next release since it
doesn't add new functionality but also bring some risk. So, we will
have time to catch possible regressions here.

--
Best regards,
Pavel Shilovsky
