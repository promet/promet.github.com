---
published: true
comments: true
author: max-veprinsky
date: '2009-11-23 17:56:46'
layout: post
slug: xen-vm-mount-external-devices
status: publish
title: XEN VM mount external devices
wordpress_id: '997'
categories:
- Installation
---

Adding additional block devices to XEN guests is accomplished using xm block-attach command. In this example I am exporting an external USB hard drive that was recognized as /dev/sda1 by the hosts kernel. Important thing to keep in mind is that you must use xvdX as the guest block device name. 
```
xm block-attach 6 phy:/dev/sda1 /dev/xvda1 w
```

This command will export /dev/sda1 on host machine to guest domain 6 as `/dev/xvda1` with write permissions.

