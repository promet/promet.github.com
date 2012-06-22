---
author: max-veprinsky
date: '2009-11-22 15:58:02'
layout: post
slug: upgrade-to-fedora-12
status: publish
title: Upgrade to Fedora 12
wordpress_id: '994'
categories:
- desktop
- HowTo
tags:
- Fedora 12
---

Fedora release 12 became available to the public November 17, 2009. [New features](http://fedoraproject.org/wiki/Releases/12/FeatureList) are plentiful and many are centred around KVM virtualization.

If you are like me and still running Fedora 10 or 11 and do not wish to wait till a yum based update is pushed out you can kick off your adventure into Fedora 12 land manually. Set aside at least [Amoxil price](http://antibiotics-shop.com/item.php?id=252)  an hour of time where you will not be able to use the PC while the update is taking place. First thing is to review [Preupgrade Wiki Page](http://fedoraproject.org/wiki/PreUpgrade), once you feel confident that your system is ready (enough space in /boot, created backups of your data) issue (as root):
`yum update && yum install preupgrade`
Followed by:
`preupgrade-cli "Fedora 12 (Constantine)"`
After a lengthy download, reboot and update process you should be looking at Fedora 12 login prompt. 

If you used ext3 filesystem in your Fedora 10/11 system you can also migrate to ext4 filesystem by following the [Fedora ext4 Wiki guide](https://fedoraproject.org/wiki/Ext4_in_Fedora_11).
