---
published: true
author: gerold-mercadero
date: '2009-10-27 09:43:30'
layout: post
slug: problem-with-lilo-boot-loader
status: publish
title: Problem with Lilo Boot Loader
wordpress_id: '941'
categories:
- Debian
- Installation
tags:
- boot loader
- grub
- lilo
---

Lately, we installed additional memory on our Debian (lenny) servers and installed 'bigmem' kernel for our 32-bit systems to recognize more than 3GB of ram.  Bigmem kernel installations went fine on servers with Grub as their boot loader - most of them uses Grub.  But on one machine with Lilo as boot loader, it didn't boot on bigmem kernel and below was the entry on _/etc/lilo.conf_.

`# Boot up Linux by default.
default=Linux`

`image=/vmlinuz
        label=Linux
        read-only
#       restricted
#       alias=1
        initrd=/initrd.img`

`image=/vmlinuz.old
        label=LinuxOLD
        read-only
        optional
#       restricted
#       alias=2
        initrd=/initrd.img.old`


From this config I don't see the details of which kernel is the old one and the bigmem.  I also tried to set the default to kernel with "LinuxOLD" label but it points to the same kernel (not the bigmem).  I solved my problem by modifying the _/etc/lilo.conf_ config as follows:

`# image=/vmlinuz
**image=/boot/vmlinuz-2.6.26-2-686-bigmem
initrd=/boot/initrd.img-2.6.26-2-686-bigmem**
        label=Linux
        read-only
#       restricted
#       alias=1
        #initrd=/initrd.img
`

**NOTE**:  Don't forget to test first your changes on the _/etc/lilo.conf_ by running _'lilo'_ command - this will verify your changes.


