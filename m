Return-Path: <linux-cifs+bounces-687-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CB826A3E
	for <lists+linux-cifs@lfdr.de>; Mon,  8 Jan 2024 10:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BB91C222A1
	for <lists+linux-cifs@lfdr.de>; Mon,  8 Jan 2024 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B51118C;
	Mon,  8 Jan 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOIaUch/"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57B10799
	for <linux-cifs@vger.kernel.org>; Mon,  8 Jan 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso1646930f8f.0
        for <linux-cifs@vger.kernel.org>; Mon, 08 Jan 2024 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704913; x=1705309713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y29ZjWS+kMxK2hHYGSpll/bK2F92ct4CoCPibAWT7g8=;
        b=zOIaUch/6Dq+YyeHYAy9WW0oNPnFrtRNLgfv5OxBMfSlFJIhvLUpGEpamyR3LO90Na
         bqPrakEwgFzCW/wPg97dB0wx6bdVixs8sLCXwBvszUMd5ZSwwdGgwpYXjojCvd38HSjh
         S4dmxe7VH2c5uoqEyO9APb0jedksgMc5iyrIAPJw7a2CHgo2j8i0SnbKkPLUIZshBQ4B
         c0S1seboX9JMV6ROsDKm2t/p3Ac2oLfu1rjaQCM0jpjnsZj0g9czeO753rBXk9v3qPAk
         Ou2ti5FjcwusRvk4McFQdd6tzEcs1BSxKUFGj9UrnjRPh8f61IELQZVr2573WhPCCTeM
         mUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704913; x=1705309713;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y29ZjWS+kMxK2hHYGSpll/bK2F92ct4CoCPibAWT7g8=;
        b=hAyBGl2qEyD/E7vXE0gWbyuc5hDdPcfwsqaLrSBrsGRmcDd/SfgJ5F0s4LndjiR8e2
         cYl5etgNv1QfzYVbxhAX3IjLLjNNF15DR/Po++Rb/r30nAAuGyB8Kk2GQkqCYyov6bAH
         iRhDRr69ozyPd20amWoMpsINn8br2k8zUt7k27Q6kf8hjULXENwfe2CMT2QqEMtMFmIS
         bD7LOTuEMYZTS8HJt5fvnnRW0nVKXFJivSUTw1C9jYqNl3h3mhUD+OweNOqwd0lV6++1
         k2Yj2lH4w9jnyBPlUkBHAyYQotfCGtQIKh7BkCVQJ2Sc4L/jXCX57km6lL8lkKakTQKs
         8tfg==
X-Gm-Message-State: AOJu0Yw9yzDf9IZKvooxXqZz21D0h3tP+2IOgf1Frejwj+BPNEpuJLkj
	6unHcq4IfDWUqytL3Ie8sW6Tj0VmeNfTngcdvB4HsIgEUi4=
X-Google-Smtp-Source: AGHT+IEcM1W8EH04zf4EmzgY+xU5a9CPXqgAsul1BoLblvAd/N5+wWUE8d/RH22ujaG7vEybe6rZtA==
X-Received: by 2002:adf:e848:0:b0:336:6db8:a00c with SMTP id d8-20020adfe848000000b003366db8a00cmr1329791wrn.26.1704704912925;
        Mon, 08 Jan 2024 01:08:32 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b00336e15fbc85sm7227038wrm.82.2024.01.08.01.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:08:32 -0800 (PST)
Date: Mon, 8 Jan 2024 12:08:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
Message-ID: <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
X-Mailer: git-send-email haha only kidding

The return values for cifs_chan_update_iface() didn't match what the
documentation said and nothing was checking them anyway.  Just make it
a void function.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/cifsproto.h |  2 +-
 fs/smb/client/sess.c      | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index afbab86331a1..a841bf4967fa 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -656,7 +656,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
 			  struct TCP_Server_Info *server);
 void
 cifs_disable_secondary_channels(struct cifs_ses *ses);
-int
+void
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int
 SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 775c6a4a2f4b..f7b216dd06b2 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -356,10 +356,9 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
 
 /*
  * update the iface for the channel if necessary.
- * will return 0 when iface is updated, 1 if removed, 2 otherwise
  * Must be called with chan_lock held.
  */
-int
+void
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 {
 	unsigned int chan_index;
@@ -368,20 +367,19 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
-	int rc = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
 	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
 		spin_unlock(&ses->chan_lock);
-		return 0;
+		return;
 	}
 
 	if (ses->chans[chan_index].iface) {
 		old_iface = ses->chans[chan_index].iface;
 		if (old_iface->is_active) {
 			spin_unlock(&ses->chan_lock);
-			return 1;
+			return;
 		}
 	}
 	spin_unlock(&ses->chan_lock);
@@ -394,7 +392,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
 		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
-		return 0;
+		return;
 	}
 
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
@@ -434,7 +432,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
-		rc = 1;
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}
@@ -449,7 +446,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		}
 
 		spin_unlock(&ses->iface_lock);
-		return 0;
+		return;
 	}
 
 	/* now drop the ref to the current iface */
@@ -478,13 +475,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	chan_index = cifs_ses_get_chan_index(ses, server);
 	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
 		spin_unlock(&ses->chan_lock);
-		return 0;
+		return;
 	}
 
 	ses->chans[chan_index].iface = iface;
 	spin_unlock(&ses->chan_lock);
 
-	return rc;
+	return;
 }
 
 /*
-- 
2.42.0


