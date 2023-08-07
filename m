Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798C772FD1
	for <lists+linux-cifs@lfdr.de>; Mon,  7 Aug 2023 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHGTrB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 7 Aug 2023 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjHGTqp (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 7 Aug 2023 15:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A691BF7;
        Mon,  7 Aug 2023 12:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A79621E2;
        Mon,  7 Aug 2023 19:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED32C433CC;
        Mon,  7 Aug 2023 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437192;
        bh=OzDnAOkFvdqmLBbFuJs/CLbN23QVgBEedYg5nk4xP+Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cvOqFZBtdtaUZUpcYT8YaLre5p00FbNuCj4U3qnBqbXM0xIZiA7wntOQvtwkVyYsY
         KzGPHHfNfeSagX//jmohNvYFm+rBns57CsQSi8EBkJHPSRhrZFT/BjhJZaM5mUMarX
         bymb2xPd0mApBaQcG7sD1IUhckW6N/LCVX49ha2NO5jL3KT5jPvgzVeVTUtPAxnWiK
         dM7ooX8FgUdfO8Pq4IPDz02iL29DbkONAJVmc5YAAa/XW37auYiCa14sJSBbDU2ME8
         1Yyd+iGC1KcpMynDMsQYI8CRvGycMoa1dPssmnhNbpjlfyCvisRz0YkztzSP0nrAdx
         wLRgkNq83WixQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:41 -0400
Subject: [PATCH v7 10/13] tmpfs: add support for multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-10-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OzDnAOkFvdqmLBbFuJs/CLbN23QVgBEedYg5nk4xP+Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug+f9kdguq5TMBwkHk+cBAUTkwGtaz5BtdXB
 OuPQyDsL9iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPgAKCRAADmhBGVaC
 FVU+EACRHWq/ok8Ci5soDBQDERlUIptXu4lEgbxup7TkwLUNnWrAdD6epDKSNEsW7DCyiz2IdS1
 pGFVdR0NuWmsNAsV4apdFq8utofCuuQXFkShF4CGpObdFNxDJjMvsoXKFeW/E7fgIlv1w8tvl+M
 TZtcYLa5VLnkhenORjC9b3TlE8YCfiuxsrGTC8mYBJrtx5d9p30op1+bDdzyytFLNJLQlLWj14x
 j1oAiR8gG08J92of6XhtGMD0DtCossd3jSeVrC8OYlXA4vCmfZq6JtZhAw+CoNRKb+cOARV+9B+
 SJr5nKCvKTzIuqmy7l7OMNEkKl8S2V9AJAwTild9ZW1Z2NAyOuSAeKhrWBFQMIPlWrhkCWsPn6K
 JuesJK2mMm/FyjTbn/I6u5siqSU+d61eK1yIU1rMkdJoxmydONqyifHcvL1HSrQrWIl2MdAApFE
 sPG4vDGwzddPezBep3zrdQxC6ZJab7utCrvAwfewI5O/GjTDxkX7FpjNTk1I212uzshngLd6djC
 Jrse0kdmFbO8tdzk0ywQY79OHNNTMRCNavw0Op2MIxwOIQ4yfXuQcnlaEFLrYX3pIwPe744NWnr
 cqzI6yqNIe8Y5zTQLAa6eRvH5OhjhgpJax5SPfaimHbaGB73Wa4hwyRmG2bufpcQYrEKNjYr5s0
 glVbeH5wiH7pM1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 142ead70e8c1..98cc4be7a8a8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4220,7 +4220,7 @@ static struct file_system_type shmem_fs_type = {
 #endif
 	.kill_sb	= kill_litter_super,
 #ifdef CONFIG_SHMEM
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 #else
 	.fs_flags	= FS_USERNS_MOUNT,
 #endif

-- 
2.41.0

