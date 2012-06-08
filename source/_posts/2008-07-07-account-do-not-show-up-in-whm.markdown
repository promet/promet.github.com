---
date: '2008-07-07 06:58:48'
layout: post
slug: account-do-not-show-up-in-whm
status: publish
title: Account list missing from WHM
wordpress_id: '29'
categories:
- hosting
tags:
- cpanel
- whm
---

**Issue: Hosting account do not show up in WHM
**

Cause: /etc/trueuserdomains file which holds a list of account on the server is empty
Solution: restore contents of /etc/trueuserdomains and update cpanel with /scripts/upcp

    
    linuxsysadminblog.com: linsysad
