Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22D04162CC
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Sep 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhIWQP3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 23 Sep 2021 12:15:29 -0400
Received: from wolff.to ([98.103.208.27]:33538 "HELO wolff.to"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S231233AbhIWQP2 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 23 Sep 2021 12:15:28 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 12:15:28 EDT
Received: (qmail 2370 invoked by uid 500); 23 Sep 2021 15:55:10 -0000
Date:   Thu, 23 Sep 2021 10:55:10 -0500
From:   Bruno Wolff III <bruno@wolff.to>
To:     linux-cifs@vger.kernel.org
Subject: setcifsacl: Shouldn't 0x0 be a valid mask?
Message-ID: <20210923155510.GA2171@wolff.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I was looking at using S-1-2-3-4 to take away rights via ownership and 
granting no access (but not denying it either) makes sense as access 
is granted via group membership. Microsofts documentation seems to 
suggest the a 0x0 mask is valid.
Quote from 
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd125370(v=ws.10)?redirectedfrom=MSDN
"When you add the Owner Rights security principal to objects, you can 
specify what permissions are given to the owner of an object. For example 
you can specify in the access control entry (ACE) of an object that the 
owner of a particular object is given Read permissions or you can specify 
NULL permissions to an object, which grants the owner of the object no 
permissions."

Here is example output:
# setcifsacl -a "ACL:S-1-2-3-4:0x0/0x0/0x0" bruno-test
verify_ace_mask: Invalid mask 0x0 (value 0x0)

Besides the owner rights case, I think this might also make sense in an ACL 
to break inheritence, though in that case there might be other ways to 
do that.

Unless having a 0x0 mask actually breaks things, it doesn't seem that 
it is a good idea to prohibit it.
