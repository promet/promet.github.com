---
published: true
author: gerold-mercadero
date: '2009-05-07 04:22:56'
layout: post
slug: csf-not-detecting-pop3-login-failures
status: publish
title: CSF Not Detecting POP3 Login Failures
wordpress_id: '612'
categories:
- cpanel
- firewall
- Security
tags:
- csf
- firewall
---

This is the second time that [CSF](http://configserver.com/cp/csf.html) on our Cpanel server is not detecting POP3 login failures from a dictionary attack.  The IP address was added on the ip deny list but still it was able to attempt to login on POP3.  We have our LF_POP3D set to 20 and LF_POP3D_PERM to 1 to block the ip permanently after 20 tries.  I can't remember the CSF version when this first happened, but this time we're running CSF version 4.65 and the latest is 4.67.  Of course, the usual way for me to fix the issue is to upgrade to the latest version.


