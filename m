Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB826C75C
	for <lists+linux-cifs@lfdr.de>; Wed, 16 Sep 2020 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgIPSZW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 16 Sep 2020 14:25:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgIPSXo (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 16 Sep 2020 14:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B7EFACE3;
        Wed, 16 Sep 2020 10:57:07 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, sribhat.msa@outlook.com
Subject: Re: [PATCH][SMB3] mount.cifs: use SUDO_UID env variable for cruid
In-Reply-To: <CANT5p=oiTY63d5yVyywiTrCqpAmvaugMVVpQRV7RT7ZA9HU2+Q@mail.gmail.com>
References: <CANT5p=oiTY63d5yVyywiTrCqpAmvaugMVVpQRV7RT7ZA9HU2+Q@mail.gmail.com>
Date:   Wed, 16 Sep 2020 12:56:51 +0200
Message-ID: <87r1r2ugzw.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> This is a fix for the scenario of a krb5 user running a "sudo mount".
> Even if the user has cred cache populated, when the mount is run using
> sudo, uid switches to 0. So cred cache for the root user will be
> searched for, unless cruid is specified explicitly. This fix checks
> for cruid=$SUDO_UID as a fallback option, when the mount fails with
> ENOKEY.

The idea seems good.

> @@ -2053,7 +2066,24 @@ int main(int argc, char **argv)
>  		parsed_info = NULL;
>  		fprintf(stderr, "Unable to allocate memory: %s\n",
>  				strerror(errno));
> -		return EX_SYSERR;
> +		rc = EX_SYSERR;
> +		goto mount_exit;
> +	}
> +
> +	reinit_parsed_info = 
> +		(struct parsed_mount_info *) malloc(sizeof(*reinit_parsed_info));
> +	if (reinit_parsed_info == NULL) {
> +		fprintf(stderr, "Unable to allocate memory: %s\n",
> +				strerror(errno));
> +		rc = EX_SYSERR;
> +		goto mount_exit;
> +	}
> +
> +	options = calloc(options_size, 1);
> +	if (!options) {
> +		fprintf(stderr, "Unable to allocate memory.\n");
> +		rc = EX_SYSERR;
> +		goto mount_exit;

This function later forks, so if you allocate before the fork, you need
to free in parent and in the child.
> @@ -2228,6 +2252,7 @@ mount_retry:
>  				if (nextaddress)
>  					*nextaddress++ = '\0';
>  			}
> +			memset(options, 0, sizeof(*options));
>  			goto mount_retry;

Altho not wrong this is a bit misleading as options is a char*. If you
do a memset do it option_size, or do options[0] = 0;

>  		case ENODEV:
>  			fprintf(stderr,
> @@ -2250,6 +2275,21 @@ mount_retry:
>  				already_uppercased = 1;
>  				goto mount_retry;
>  			}

Need to reset options again before goto I guess. Maybe reset option
after the retry label?

>  	}
> -	free(options);
> -	free(orgoptions);
> -	free(mountpoint);
> +	if (reinit_parsed_info)
> +		free(reinit_parsed_info);
> +	if (options)
> +		free(options);
> +	if (orgoptions)
> +		free(orgoptions);
> +	if (mountpoint)
> +		free(mountpoint);
>  	return rc;

free(NULL) is defined to be a no-op, you don't need the checks.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
