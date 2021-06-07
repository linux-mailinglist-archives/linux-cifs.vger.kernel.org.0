Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9C39E046
	for <lists+linux-cifs@lfdr.de>; Mon,  7 Jun 2021 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGP1f (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 7 Jun 2021 11:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhFGP1e (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 7 Jun 2021 11:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623079542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KSxFuzdvnaSD/hQDMG5nZuMDfjyv6JLJ1uBuMDxyf4w=;
        b=BVA+rkg6q3zZvveARTy3b5nE1jOivm6TeeuT/yrLutEgJsv3CFPBNVzAebH3mQK8yp99za
        RCKrCw6rQzxrRfutE615ekmoU928j55LoOlFS3rGcuKwZkMvajNVynXMxG1nWwmCIo9r63
        Yd+23MjPGm9GIMc9sWt3ZKpFA9TzOh4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-voUYxbCrN7aW9A44TBlGtw-1; Mon, 07 Jun 2021 11:25:41 -0400
X-MC-Unique: voUYxbCrN7aW9A44TBlGtw-1
Received: by mail-io1-f69.google.com with SMTP id l15-20020a5e820f0000b02904bd1794d00eso2790403iom.7
        for <linux-cifs@vger.kernel.org>; Mon, 07 Jun 2021 08:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KSxFuzdvnaSD/hQDMG5nZuMDfjyv6JLJ1uBuMDxyf4w=;
        b=jYF63gB0hI1m90DSyuTGZmS+9uAqHQzCHh7zfp6yp2ybHAQuD8+7gOMQGkL7t9fg/y
         M3m3rCPsLLknXOjcsfEJaibtdOGIKZr6gCk8CGTSOKp78BCKsuf/wOWITL24LTRF+P44
         STZZsXNlILcOYP8Qpl50LdcS+c4X8zNkYltMEWC9h6bVzYFapjlwVnyPOIYozUa8VP8d
         MkybinIAxoPCsdMitUrEVBFfiAQzl08qWcWUx9EfXYX3j8jXGrlVcJBfc5xrmkYZxsQB
         5aGQDJ4mybSI00lJ1/NqyeqVNILDH3AYkgzXQ7G7AHkg+7PzmiT1Jvl+mC+/JY9iAEif
         wUxA==
X-Gm-Message-State: AOAM531Uqd3pxCfgBSeXTTYa09Rcxh/J6vtAFQC3aOJI3s6/JqwMHV3D
        emh3YQFhezWWgucI2BriGknhiG6jYg5ULK51ams8Gdly3/aTiCpZ+7oHmtFnNsiebmrb1vHIBlq
        TJuhF3fpQNwq0dtHuHKFZSYCiy+o/rbVrt7Gz0A==
X-Received: by 2002:a5d:914f:: with SMTP id y15mr15048615ioq.196.1623079540933;
        Mon, 07 Jun 2021 08:25:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/M3bz/PQUDGYbDG+aY0xrQFE30oh++RR0qeAAsrGmKMF4B+tsXTrhjQM/a17+qcHJYmHtq1gZlqV7aQlUGzo=
X-Received: by 2002:a5d:914f:: with SMTP id y15mr15048603ioq.196.1623079540738;
 Mon, 07 Jun 2021 08:25:40 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Ahring Oder Aring <aahringo@redhat.com>
Date:   Mon, 7 Jun 2021 11:25:30 -0400
Message-ID: <CAK-6q+hS29yoTF4tKq+Xt3G=_PPDi9vmFVwGPmutbsQyD2i=CA@mail.gmail.com>
Subject: quic in-kernel implementation?
To:     netdev@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, Leif Sahlberg <lsahlber@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

as I notice there exists several quic user space implementations, is
there any interest or process of doing an in-kernel implementation? I
am asking because I would like to try out quic with an in-kernel
application protocol like DLM. Besides DLM I've heard that the SMB
community is also interested into such implementation.

- Alex

