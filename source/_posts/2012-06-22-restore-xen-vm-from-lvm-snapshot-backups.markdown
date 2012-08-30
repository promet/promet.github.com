---
layout: post
title: "Restore Xen VM from LVM Snapshot Backups"
date: 2012-06-22 20:21
comments: true
author: gerold-mercadero
slug: restore-xen-vm-from-lvm-snapshot-backups
categories: [backup, Debian, HowTo, Storage]
tags: [lvm, restore, xen]
published: true
---


What's the use of backups if you can't restore from them? ;)

In the previous post on "Backup Xen with LVM and Rsnapshot" we worked on creating backups of Xen (guest/domain) VMs with LVM, and here we'll cover the process of restoring from these backups.

What is covered here:

Restoring specific files or directories
Doing "bare-metal" type of restore. We will re-create the VM from our rsnapshot backups.
Restore Process:

1.) Restoring specific files or directories only

While this restore scenario is a no-brainer, still I'll just want to mention it here as well.  Basically this one is the usual copying of files (via cp, scp, ftp, rsync, etc) from your source or backup server to the destination server.

2.) "Bare-metal" restore (creates complete vm image from backup).

Overview of "bare-metal" restore process:

create, format, and mount logical volumes to use on the vm that you want to restore or re-create, based on its original vm disk properties such as size, names, etc.
copy all files from backup location to the newly mounted lvm disk

<!--more-->
adjust necessary xen vm configs (if any, like new ip address) and start/create the vm using the volume with restored contents or files, and you're done.
In the restore example below I'll refer to the vm as "domain.com" and we will restore the backups to a different volume with the same config as the original.  Then we'll start the vm, domain.com, using the restored volume.

Here's the sample VM configuration that we will use.
orignal vm disks: /dev/vg0/domain.com-disk (10GB) and /dev/vg0/domain.com-swap (512MB)
backup located at "/backup" of host machine
disks configurations to use on restored vm: /dev/vg0/domain-restore.com-disk (10GB) and /dev/vg0/domain-restore.com-swap (512MB)
To start we determine the virtual machine  to restore as well as the backup to use  for restore.

Then we'll create logical volumes with the same values as the running volumes as defined in our /etc/xen/domain.com.cfg.  Please note that you don't have to re-create the swap disk if you want, but in this example we'll just create another one.

```
    lvcreate -L 10G -n domain-restore.com-disk vg0
    lvcreate -L 512M -n domain-restore.com-swap vg0
```
Format the "-disk" and mount it somewhere on host machine (ex: /backup-restore) and copy backup files into it, and unmount it after copying.

```
    mkfs -t ext3 -v /dev/vg0/domain-restore.com-disk
    mkdir /backup-restore
    mount /dev/vg0/domain-restore.com-disk /backup-restore
    cp -rpfv /backup/domain.com-disk/* /backup-restore/
    umount /dev/vg0/domain-restore.com-disk
    rmdir /backup-restore
```
We now have the volume that contains the restored files at /dev/vg0/domain-restore-disk and ready to use by our domain.com VM.

Let's shutdown "domain.com" machine and change its disk configuration to use the new/restored volume.

```
xm shutdown domain.com
```

Then we'll update our vm xen config to let our "domain.com" vm use the "domain-restore-disk".  We'll modify /etc/xen/original.domain.com.cfg and change the disks to point to new volumes with restored contents.

From:
```
'phy:/dev/vg0/domain.com-disk,xvda2,w',
'phy:/dev/vg0/domain.com-swap,xvda1,w',
```

To:
```
'phy:/dev/vg0/domain-restore.com-disk,xvda2,w',
'phy:/dev/vg0/domain-restore.com-swap,xvda1,w',
```

Start our domain.com machine on its restored contents.

```
xm create /etc/xen/domain.com.cfg
```

That's all - you should have your vm running from its restored state! If everything is not ok you can quickly configure your vm to use the original volumes and restart it.

If you do not want to touch your live machine, you can just create another vm with the same config as the live one, create new volumes and restore your backups to that vm.
