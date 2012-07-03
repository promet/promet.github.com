---
comments: true
date: '2010-02-16 09:05:00'
layout: post
author: gerold-mercadero
published: true
slug: mail-relay-issue-on-cpanel-server
status: publish
title: Mail Relay Issue on Cpanel Server
wordpress_id: '1050'
categories:
- Centos
- hosting
- Security
- sysadmin
tags:
- exim
- relayers
---

I noticed lots of email being relayed on one of our shared hosting server, CentOS5 with Cpanel and running Exim, and the strange thing is that the email server (MX) for these accounts are pointing to Google (GoogleApps), and we have correct entries for _localdomains_ and _remotedomains_ for these account.  The relayers (_'From'_ server/address) looks like spam anyway.  From the mail logs I noticed that the relayed messages have '_fixed_login_' and key ('_rsa-sha1_') for their authentications.

Since the mail server for these accounts are pointing to other servers, I deleted all the email accounts, forwarders, mailinglists, etc.  After this I've seen sending error/failure messages from mail logs of the said accounts  It shows '_fixed_login authenticator failed for hostxx' [535 Incorrect authentication data]_.

