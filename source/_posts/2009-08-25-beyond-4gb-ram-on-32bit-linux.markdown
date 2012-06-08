---
date: '2009-08-25 17:04:08'
layout: post
slug: beyond-4gb-ram-on-32bit-linux
status: publish
title: Beyond 4GB ram on 32bit Linux
wordpress_id: '839'
categories:
- Installation
---

Thinking of upgrading your 32 bit Linux machine beyond 4GB of memory?  Consider the following:

Does your CPU support Physical Address Extension to address beyond 4GB? Here is how to check:

`grep pae /proc/cpuinfo
flags		: fpu vme de pse tsc msr **pae** mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
`

If you see "pae" flag returned install a PAE kernel and reboot. On CentOS 5.x as root:

`yum install kernel-PAE.`uname -m` && reboot`

Do you have a single process that may need to address more than 4 GB of RAM? If so, you need to use a 64bit kernel. Check to see if your cpu supports 64bit instructions.

`grep lm /proc/cpuinfo
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx **lm** constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm ida
`

if you see "lm" flag then your cpu supports 64bit instructions, it is possible to upgrade your current distro to 64bits which is normally not supported by most distro's or reinstall the entire thing from scratch.
