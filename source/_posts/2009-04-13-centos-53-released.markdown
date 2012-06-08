---
date: '2009-04-13 10:37:29'
layout: post
slug: centos-53-released
status: publish
title: CentOS 5.3 released
wordpress_id: '525'
categories:
- Installation
---

CentOS recently released distro version 5.3 During updating from 5.2 "rpmdb: **unable to lock mutex**: Invalid argument" error may be displayed. This can be resolved by updating glibc first.
`yum clean all && yum update glibc\* && yum update`

Check out [release notes](http://wiki.centos.org/Manuals/ReleaseNotes/CentOS5.3) for other important information regarding this release.
