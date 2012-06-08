---
date: '2010-02-03 04:44:00'
layout: post
slug: cvs-checkout-aborted-absolute-pathnames-invalid-for-server
status: publish
title: 'cvs [checkout aborted]: absolute pathnames invalid for server'
wordpress_id: '1030'
categories:
- Debian
- drupal
- Security
- Tips and Tricks
tags:
- cvs
- drupa update
---

Absolute Path Error:
`  cvs [checkout aborted]: absolute pathnames invalid for server (specified `/path/drupalsite/')`

Ok, I got the error above when I performed Drupal CVS update on our Debian server (newly installed CVS 1.12.13).  The same command works on other server with older CVS installation.  The issue is the reference to local cvs directory where I used absolute path (-d /path/drupalsite/), which is a bug (security hole on client side) - it was fixed on newer CVS version to use relative path.

Drupal Checkout Command:
`  cvs -z6 -d:pserver:anonymous:anonymous@cvs.drupal.org:/cvs/drupal co -r DRUPAL-6-15 -d /path/drupalsite/ drupal`

Use of Relative Path (sample)
`  cd /path
  cvs -z6 -d:pserver:anonymous:anonymous@cvs.drupal.org:/cvs/drupal co -r DRUPAL-6-15 -d drupalsite drupal`


