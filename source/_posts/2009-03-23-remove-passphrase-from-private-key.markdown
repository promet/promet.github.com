---
author: gerold-mercadero
date: '2009-03-23 01:56:12'
layout: post
slug: remove-passphrase-from-private-key
status: publish
title: Remove passphrase from private key
wordpress_id: '453'
categories:
- Installation
tags:
- ssl
---

We have several SSL to transfer to our new load-balancer (Nginx) and all of the private keys contain passphrase.  During Nginx (same with Apache) service restart it requires to enter the passphrase of all certificates, so we need to remove it.

This task is very simple, you only need to issue this command:

`/usr/sbin/openssl rsa -in privkey_with_passphrase.key -out privkey_without_passphrase.key`

******_This will prompt you to enter the current passphrase_.

