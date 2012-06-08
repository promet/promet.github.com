---
date: '2010-10-14 06:15:25'
layout: post
author: gerold-mercadero
published: true
slug: delete-duplicate-packages-in-centos
status: publish
title: Remove Duplicate Packages in CentOS
wordpress_id: '1163'
categories:
- Centos
- HowTo
tags:
- Centos
- yum
---

I got a package dependency issue when updating our 64-bit CentOS server, which was caused by two perl packages installed (i386 and x86_64).
`
perl i386     4:5.8.8-32.el5_5.1     installed     28 M
perl     x86_64   4:5.8.8-32.el5_5.1     installed     34 M
`
I tried to remove it using rpm command but didn't work (maybe i just don't know the correct params with rpm).  My solution to remove package was using yum "_remove package_name.architecture_".   Ex:  `yum remove perl.i386`

Any other shortcuts in deleting duplicate packages?

