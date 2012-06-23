---
published: true
author: max-veprinsky
date: '2008-10-22 18:57:50'
layout: post
slug: usb-mass-storage-buffer-io-error
status: publish
title: USB Mass Storage Buffer I/O error
wordpress_id: '91'
categories:
- Installation
---

While running rsync backups to a USB external disk I noticed an issue where the backup job would stop and /var/log/messages would spit out errors like:

Buffer I/O error on device sdb1, logical block 102630553

scsi 3:0:0:0: rejecting I/O to dead device

sd 6:0:0:0: Device not ready: <6>: Current: sense key: Not Ready

Add. Sense: Logical unit not ready, initializing command required



These errors are NOT an indication of a bad disk but rather a what seems like a bug in the Mass Storage driver where after a period of inactivity the hard disk will go into a STANDBY state while the USB interface stays active and does not report the disk state to the OS thus creating a disconnect between the OS and the physical drive. The next disk access request does not bring the disk out of STANDBY mode and the OS thinks the device is dead. The STANDBY mode is a low energy state which also stops the platters from spinning.  While there are workarounds that involve udev rules, the simplest solution is to disable or increase the timout of STANDBY mode. To turn off STANDBY timer issue the following command:

`sdparm --clear STANDBY -S <device>`

Keep in mind that this will disable the STANDBY timer and will not spindown the platters.
