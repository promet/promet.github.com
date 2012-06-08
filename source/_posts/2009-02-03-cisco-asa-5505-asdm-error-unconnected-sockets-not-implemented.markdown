---
date: '2009-02-03 07:53:51'
layout: post
slug: cisco-asa-5505-asdm-error-unconnected-sockets-not-implemented
status: publish
title: 'Cisco ASA 5505 ASDM error: Unconnected Sockets Not Implemented'
wordpress_id: '295'
categories:
- Security
- sysadmin
tags:
- cisco
- Security
- sysadmin
---

If you run a version of **Java JRE newer than v6 Update 10** (latest at this time is _V6 Update 12_) and see this error when trying to connect to a Cisco ASA ASDM interface:
**“ASDM is unable to continue loading. Click OK to exit from ASDM.
Unconnected sockets not implemented.”**
then you are probably running an older ASA software (6.1.5 released on 09-OCT-2008 and older ones have this issue) and you need to upgrade in order to fix this issue. Any version newer than **6.1.5.51** (that is the latest one available at this time) will work as expected. This version was released by Cisco to fix this issue on 16-DEC-2008.

The upgrade is simple and you can use my [step by step guide](http://linuxsysadminblog.com/2009/01/howto-upgrade-asdm-using-cli-on-cisco-asa5500/) for this; just keep in mind you will have to reboot do activate the upgrade. After this, your ASDM should be working again.
