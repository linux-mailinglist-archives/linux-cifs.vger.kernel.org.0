Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA641385C2
	for <lists+linux-cifs@lfdr.de>; Sun, 12 Jan 2020 11:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgALKDX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 12 Jan 2020 05:03:23 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:36849 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbgALKDX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 12 Jan 2020 05:03:23 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 05:03:22 EST
IronPort-SDR: uTOV4cOtPAcwmlHOCJDJRQZ7ywWf+zxK6Bir+FPi84MOLo3yn/zTFLueApvfKIxu10R81wOuS4
 qjwCf6fgTERg==
IronPort-PHdr: =?us-ascii?q?9a23=3Ap6Qh2xX9lsSxtj+N+huYsjVyeHfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Ht8tkgFKBZ4jH8fUM07OQ7/m7HzZesd3Z7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIphJ6o+1h?=
 =?us-ascii?q?fEoGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+23RjcB+kb5Urwikpx1/2oLZfoaVNOBmfqPaZ9MVX3?=
 =?us-ascii?q?ZBUdhIWyNfBIOwdpcCD/YdPelCs4b9p0UBrR6gCgmqGOPj0yFHhnnv0aM91O?=
 =?us-ascii?q?QhFx/J3Qw5E90QtnTfsdH5OakOXeypyaXFyyjIYfFL1jfn8IXGfBAvoeuSU7?=
 =?us-ascii?q?xzbMTexlUgGQzeg1WMq4HqIy+Z2vgRv2SF6edrSOKhi3QgqwF0ujWh3Nkjip?=
 =?us-ascii?q?XXiYIP11vL9SJ5wIA6JdalT0N7ecCrEIdOuCGAOYp2RcUiQ25ztSY60b0Joo?=
 =?us-ascii?q?K0cDIWx5Qgwh7TcfyHc4uR7x/lSe2fIi94iWp7dL6ihRu+61Wsx+PgWsWuzl?=
 =?us-ascii?q?pHoTBJn9fMu30Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk//Kn6+XjYrX8uJCcM5N4hw7kPqQwncywHP43Mg?=
 =?us-ascii?q?YJX2id5+uwzqPs/VbhTLVLiP05jLXZvYjEKcgGpKO1GRJZ34g/5xqlETur38?=
 =?us-ascii?q?4UkHcHIV5dfRKIlYnpO1XAIPDiCve/hkyhkC91yPDaILLhGJvMLn/FkLfuZr?=
 =?us-ascii?q?t961VcxxEvwtxF+51UDbQBLOjzWk/yrNDYFAM2MxSow+b7D9VwzoceWWOJAq?=
 =?us-ascii?q?+EP6LeqEOH5uMhI+mXf4IVpjn9JOY/5/L0jn82h0Udfa+30psTcny4Ge5mI0?=
 =?us-ascii?q?rKKUbr19MAF3oa+wE/QvfCllKPS3hQamy0UqZ64Ss0W7irFYPSeof4uLGd0T?=
 =?us-ascii?q?3zIZpQaSgSEl2QHG33cIOLW/QMcyiZCsBkmz0AE7OmTtly+wupsVrCxqZqNK?=
 =?us-ascii?q?Lr/SsX/cb72cR4/fLUkx4a9Sd+BIKW1GTLT2IizTBAfCM/wK0q+B818VyEy6?=
 =?us-ascii?q?Ut2KQAGA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HaBgBp7RpemCMYgtkUBjMYGwEBAQE?=
 =?us-ascii?q?BAQEFAQEBEQEBAwMBAQGBaAUBAQELAQEBGggBgSWBTVIgEpNQgU0fg0OLY4E?=
 =?us-ascii?q?Agx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4M?=
 =?us-ascii?q?EgksBATOFSZhCAY0EDQ0ChR2CSgQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggG?=
 =?us-ascii?q?CfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYg?=
 =?us-ascii?q?DhE6BfaM3V3QBgR5xMxqCJhqBIE8YDYgbji1AgRYQAk+LOoIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2HaBgBp7RpemCMYgtkUBjMYGwEBAQEBAQEFAQEBEQEBA?=
 =?us-ascii?q?wMBAQGBaAUBAQELAQEBGggBgSWBTVIgEpNQgU0fg0OLY4EAgx4VhgcUDIFbD?=
 =?us-ascii?q?QEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNC?=
 =?us-ascii?q?wYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOFSZhCA?=
 =?us-ascii?q?Y0EDQ0ChR2CSgQKgQmBGiOBNgGMGBqBQT+BIyGCKwgBggGCfwESAWyCSIJZB?=
 =?us-ascii?q?I1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ+BCYgDhE6BfaM3V3QBg?=
 =?us-ascii?q?R5xMxqCJhqBIE8YDYgbji1AgRYQAk+LOoIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="323312437"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 10:58:02 +0100
Received: (qmail 24140 invoked from network); 12 Jan 2020 05:00:19 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-cifs@vger.kernel.org>; 12 Jan 2020 05:00:19 -0000
Date:   Sun, 12 Jan 2020 06:00:18 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-cifs@vger.kernel.org
Message-ID: <28397188.460702.1578805219449.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

