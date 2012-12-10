---
layout: post
title: "Xen: Add Extra Partitions to Guest OS"
date: 2012-11-21 18:55
author: gerold-mercadero
published: true
comments: true
categories:
- xen
---


Here's one way to add and mount additional LVM partition in xen guest machines.

1.)  Create logical partition and format it.  Example below creates "40GB" partition and "ext3" format in "vg0" volume group.

```
lvcreate -L 40G -n extra_storage vg0
mkfs -t ext3 -v /dev/vg0/extra_storage
```

2.)  Update xen config to add new partition to guest os.  Assign device name to it, example "xvda3".  Then re-create the VM to recognize the new partition/device. Note: reboot doesn't read the new xen configuration.

```
disk        = [
        'phy:/dev/vg0/extra_storage,xvda3,w',
```

3.)  After you reboot, login to VM and mount the new partition.  New drive or partition shoud be in "/dev/xvda3."

```
  mount /dev/xvda3 /extra_space
```

Add it to "/etc/fstab" to automount on reboot.

```
  /dev/xvda3 /extra_space ext3 noatime,nodiratime,errors=remount-ro 0 1
```