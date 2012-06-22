---
author: marius-ducea
date: '2009-01-27 06:18:17'
layout: post
slug: howto-upgrade-asdm-using-cli-on-cisco-asa5500
status: publish
title: HowTo upgrade ASDM using CLI on Cisco ASA5500
wordpress_id: '261'
categories:
- CLI
- Security
- sysadmin
tags:
- asa
- asdm
- cisco
- firewall
- Security
---

This post will show how you can easily upgrade **ASDM **(Cisco Adaptive Security Device Manager for ASA) to the latest version on a **Cisco ASA5500** firewall using the command line interface. In order to do this you will need the latest asdm image (you will need a proper cisco cco user and contract to download this) from [http://www.cisco.com/cgi-bin/tablebuild.pl/asa](http://www.cisco.com/cgi-bin/tablebuild.pl/asa) ; at this time the latest version available is **6.1.5.51** (asdm-61551.bin). You will also need a method to serve this file to the firewall, and normally this is done using a local **tftp server** (but you can also use an ftp, or even http server).

After you have the above things prepared, from the ASA cli (in exec mode) you have to run:
`copy tftp flash
Address or name of remote host []? <- 192.168.1.1
Source filename []? <- asdm-61551.bin
Destination filename [asdm-61551.bin]? <- enter`
This will download the asdm firmware on the firewall flash.

Now you just have to enable the new version, from configure mode:
`configure terminal
asdm image disk0:/asdm-61551.bin
exit
write mem`

And finally you will have to reboot the ASA in order for the change to become active:
`reload`

_Note: replace the asdm filename with the one you are actually upgrading (might be a newer one for ex.) and also use the proper ip for your tftp server._
