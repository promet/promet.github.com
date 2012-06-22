---
author: gerold-mercadero
date: '2009-11-09 02:34:13'
layout: post
slug: cant-set-root-password-in-ubuntu
status: publish
title: Can't Set Root Password In Ubuntu
wordpress_id: '962'
categories:
- Installation
tags:
- ubuntu
---

I installed Ubuntu 9.10 (Karmic Koala) to my new laptop (HP EliteBook 6930p), and first on my to-do list is to set the root password so I can do additional package installations and configurations.  But this time, after I unlocked and set password for my root account,  i still can't login (via terminal) as root.  I even tried to set password three times just to make sure i typed it correctly.  As usual, if something is not working out of the box the next thing to do is to search for 'known issues' for laptop brand/model.  Then I found similar report on [Ubuntu Forums](http://ubuntuforums.org/showthread.php?t=1310671) from they gave a link to "[Policy on log-in-as-root tutorials](http://ubuntuforums.org/showthread.php?t=716201)" with explanation on Ubuntu's [**RootSudo** policy](https://help.ubuntu.com/community/RootSudo).  I did get a chance to look further on this as to which version it was implemented.

  So if you really need to login as root you can either use the "_**sudo -i**_" to simulate the root login (this will ask for your password and log you in as root), or enable the root account "_**sudo passwd root**_" (this will ask for your password and will prompt you to enter new root password).

