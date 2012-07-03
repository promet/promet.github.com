---
comments: true
published: true
date: '2008-06-04 05:38:20'
layout: post
slug: install-subversion-on-centos-with-cpanel
status: publish
title: Install Subversion on CentOS with Cpanel
wordpress_id: '6'
categories:
- Installation
author: gerold-mercadero
---

To install Subversion (SVN) login to your server (shell) and execute:

```
yum install subversion
```

If `perl-URI` is not installed edit `/etc/yum.conf` and remove `perl*` then execute:

```
yum install perl-URI
```

Restore `perl*` on `/etc/yum.conf`.
