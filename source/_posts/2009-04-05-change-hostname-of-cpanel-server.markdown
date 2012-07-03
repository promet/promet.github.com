---
published: true
comments: true
author: gerold-mercadero
date: '2009-04-05 07:19:16'
layout: post
slug: change-hostname-of-cpanel-server
status: publish
title: Change Hostname of Cpanel Server
wordpress_id: '498'
categories:
- cpanel
---

This task is very simple and can be done in two steps:
1.)  Login as root and change your server hostname:
```
hostname newhos.name.tld
```

**Note:**  Don't forget to create an A entry for your new hostname, otherwise you will get a popup message during WHM login.

2.)  Issue `/usr/local/cpanel/cpkeyclt` to update your Cpanel License Key, otherwise you will get Invalid License when you login to WHM/Cpanel interface.
