Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51762D0D
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Jul 2019 02:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfGIA0e (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Jul 2019 20:26:34 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45694 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGIA0e (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Jul 2019 20:26:34 -0400
Received: by mail-lf1-f50.google.com with SMTP id u10so12114106lfm.12
        for <linux-cifs@vger.kernel.org>; Mon, 08 Jul 2019 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4gUtk/SdD3BFcckA+JAJd5lvOV1LDJcX/BWqZbDgN5w=;
        b=BCbhFfmVO1yENCcrPWAgFMkFuYhVU/HUZ5YivldZh+RJOq0tldCkA4zDJZRa8bHySh
         ZDkHHI9Jzlwo7ymSjz5MRI42nxb3Lz82RndNzBSF3Tp1WfYZ59xxZLYOv/4rINenYFZP
         8BjwiN2QK43WDQEDimfoqCjYh2MIkXaxLlGCNmTkUiB0O54eggIUtfB3UqCM3PXlytxy
         VBv4tgk9hcXmmjlxiwflw1mVjq+2PsqxYQT/ab1LaOv/7fSh0HStgqm3/vVOjSfn3W7w
         eAnjUw7lVZE8w3CeNESQmacOcBrtNyXRJ8qXImQdjQt2u9f1equIL/Nu4wEMLEIqTItd
         6OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4gUtk/SdD3BFcckA+JAJd5lvOV1LDJcX/BWqZbDgN5w=;
        b=QiqOmOunf8DuGPg4eM5NSckgwooAJ4DO/5KP6IeaTmFaWwS3YitQbA2E77gik/sLPY
         83bFuhCWqW9xuRzf8izoM4ZW51sKtEqAF8QQBt7ic1pKTEscZ18PsPGn3rxbkeC5x7qt
         CrSM2zA/nhVzLgADM692Gveo3SURcdDQTb47GWN8bcuf2fUiydTBvfy5khN6hiFEWVhr
         NSw4qxnsRNo66CgwWmPCKGC9myOdEEqWlYnBm7kE4rgdIJNoeb9UGUSauiKbcHc003GF
         atDiNjQQEqfKVmsHmbhx9WuJO2Me23vPxGmE/8XEZfZIhouKbZOe7DA0xVZS3c41pVGc
         7Hcw==
X-Gm-Message-State: APjAAAUqbdDnx5w6EmzU3DQM6m5xnfDxTGoS85VgoLsSywImWAYWJx7T
        hR/TWCVYGGZ8laCJAj2IAzvoRFLjBqeSL7r+7S+o9WzCm4A=
X-Google-Smtp-Source: APXvYqwfM+FmQdcDhOPzfJXRsZsQmGEjwdRjEUriZ0o6FEnT+SXb36bByJzPTZrvKVbkV6l6lnSwsEXIGPoCYhlX+t0=
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr10665291lfp.35.1562631991550;
 Mon, 08 Jul 2019 17:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAO3V83L1Q9jCLBsjHgFE1jw2PPi_sHtQz4geDKC4jEPWkhNYBg@mail.gmail.com>
In-Reply-To: <CAO3V83L1Q9jCLBsjHgFE1jw2PPi_sHtQz4geDKC4jEPWkhNYBg@mail.gmail.com>
From:   Wout Mertens <wout.mertens@gmail.com>
Date:   Tue, 9 Jul 2019 02:26:20 +0200
Message-ID: <CAO3V83+iZRAQRZ5YzivPS3di0QM=-dJOg8rnVK1icUuuESd+=g@mail.gmail.com>
Subject: Fwd: mount.cifs fails but smbclient succeeds
To:     linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

I need to mount a file server that I only have credentials for and
know nothing about.

I have a completely vanilla setup without /etc/smb.conf, nor any Samba
service running; only the samba client binaries are installed. The
credentials are domain, username, password; Kerberos is not being used
as confirmed by the smbclient debug output.

When I connect using

    smbclient -A credentials.txt //corp.local/mnt

it works fine. The name corp.local resolves using DNS and I can browse
the datastore.

When I mount using

 mount -vvvvv -t cifs //corp.local/mnt --verbose
-overs=3,credentials=credentials.txt,sec=ntlmssp /mnt

I see that I get a STATUS_BAD_NETWORK_NAME back. If I change the
credentials, I get a logon error, and if I change the mount name, I
get a missing file error. So it seems that the path and the
credentials are correct. If I change the version to 1, it fails in
some other way. If I change the sec to ntlm, it complains about
authentication.

Any suggestions? This is driving me crazy :-/

Many thanks!

Wout.
