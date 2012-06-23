---
published: true
author: marius-ducea
date: '2008-12-16 05:05:17'
layout: post
slug: howto-change-the-timezone-on-rhelcentos
status: publish
title: HowTO change the timezone on RHEL/CentOS
wordpress_id: '166'
categories:
- Centos
- CLI
tags:
- Centos
- rhel
- tips
---

Linux systems traditionally keep the definition of their **timezone **in **/etc/localtime**. This is a binary file with the timezone info, and if we want to change it we need to find the appropriate timezone file from **/usr/share/zoneinfo** and copy it over the one from /etc or just link to it. Once you change it, you will need to **restart **any daemons or applications that use the timezone as they might still use the old one.

Still on **RHEL/Centos** based systems this is not enough, and even if apparently all seems to work as expected, there might be some applications still using the old timezone. This is happening if they read the timezone definition from the rhel specific file: **/etc/sysconfig/clock**
`cat /etc/sysconfig/clock
ZONE="America/Chicago"
UTC=true
ARC=false`

We also need to update the **ZONE **field in **/etc/sysconfig/clock** to be sure that all occurrences of the old timezone are changed and everything on the system will use the new setting.

_Note_: you _don't need to restart the system_ to activate this change, but you will have to **restart **the applications using the timezone so they can read the updated information.
