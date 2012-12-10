---
layout: post
slug: debian-6-backup-xen-with-lvm-and-rsnapshot
title: "Debian 6: Backup Xen with LVM and Rsnapshot"
date: 2012-06-22 05:38
comments: true
author: gerold-mercadero
categories: [backup, Debian, HowTo, Installation]
tags: [lvm, restore, xen]
published: true
---


This is a draft of my installation process which is mainly based from this blog:  [Efficient Xen Backups Using LVM and Rsnapshot](http://backdrift.org/efficient-xen-backups-using-lvm-and-rsnapshot).

Our setup is on Debian 6 server with 2TB disk running 10 vpses. We followed the above guide with notes on errors we encountered, mostly rsnapshot related. We are keeping daily backup locally, on a separate partition, and copies them to our remote server every week.

The Setup (mostly defaults):
vg path is /dev
vg name is vg0

Setup Process:

Create logical partition to store backups locally.  Size is 100GB and named it backups.  Format it with ext3 and mounted it to /backups.

```
lvcreate -L 100G -n backups vg0
mkfs -t ext3 -v /dev/vg0/backups
mkdir /backups
mount /dev/vg0/backups /backups
```

Install and configure rsnapshot.  Make sure you use TAB correctly as it will complain or give you an error if you don't.

```
aptitude install rsnapshot
vi /etc/rsnapshot.conf
```

Here's my rsnapshot config changes and/or additions:
<!--more-->
```
snapshot_root /backups/    #this is a mounted partition
interval daily 1    # i removed all other schedule and one daily copy only
linux_lvm_cmd_lvcreate /sbin/lvcreate
linux_lvm_cmd_lvremove /sbin/lvremove
linux_lvm_cmd_mount /bin/mount
linux_lvm_cmd_umount /bin/umount
linux_lvm_snapshotsize 2G
linux_lvm_snapshotname rsnapshot
linux_lvm_vgpath /dev
linux_lvm_mountpath /mnt/lvm-snapshot
# Backups Tasks for all VMs
backup lvm://vg0/vm_1_name_disk/ vm_1_name_disk/
backup lvm://vg0/vm_2_name_disk/ vm_2_name_disk/
backup lvm://vg0/vm_10_name_disk/ vm_10_name_disk/
```

Schedule daily backup task in crontab (/etc/crontab). Note that rsnapshot is in /usr/bin/rsnapshot on Debian.

```
01 01 * * * root /usr/bin/rsnapshot daily
```

You can then run the rsnapshot task to make sure everything is working, from your config file to creating and mounting lvm snapshots. Execution time depends on number of vms and their size. You can ran them individually if needed.

```
/usr/bin/rsnapshot daily
```

Then I setup another backup task from remote backup server to pick up our local backups at /backups. You can also configure rsnapshot to backup your snapshots directly to your remote backup location (usiang rsync/ssh), depends on how you want to backup your data.
