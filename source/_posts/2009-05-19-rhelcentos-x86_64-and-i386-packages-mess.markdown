---
published: true
comments: true
author: marius-ducea
date: '2009-05-19 04:30:51'
layout: post
slug: rhelcentos-x86_64-and-i386-packages-mess
status: publish
title: rhel/centos x86_64 and i386 packages mess...
wordpress_id: '665'
categories:
- Centos
- CLI
- sysadmin
tags:
- Centos
- redhat
- rhel
- rpm
- yum
---

Anyone running **centos/rhel** **x86_64** systems has probably noticed that redhat has a strange way to install a mix of i386 and x86_64 rpms on such a systems. This is how **redhat **is using the 64bit architecture in a mixed way to be able to support also i386 applications. This is completely different from how for example **debian **does this where you will not see by default any i386 libraries or duplicate applications installed (you can install and use ia32 libraries for compatibility reasons but the user is in full control on this process). The way how this works in rhel is **confusing**; let's take a simple example (the commands are taken from a clean centos5.3 install with the base packages selected): let's see what version of ncurses we have on the system:
`rpm -qa | grep ncurses
ncurses-5.5-24.20060715
ncurses-5.5-24.20060715`
what? why is this listed twice? hmm... Running: _rpm -qi ncurses-5.5-24.20060715_ will also list the package twice (but doesn't show the difference). We can assume one is **i386 **and one is **x86_64** right? but we can't see this.

To overcome this issue, and at least have **rpm report the proper versions** we have to add in our **rpmmacros **file a new line like: _"%_query_all_fmt %%{name}-%%{version}-%%{release}.%%{arch}"_ that will add to the rpm output the architecture and allow us to see the this:

    
    <code lang="bash">cat >> ~/.rpmmacros
    %_query_all_fmt %%{name}-%%{version}-%%{release}.%%{arch}</code>


and now running the same command will return a more intuitive and meaningful:
`rpm -qa | grep ncurses        
ncurses-5.5-24.20060715.x86_64
ncurses-5.5-24.20060715.i386`

This doesn't fix anything in how yum will install duplicate programs or libraries, but at least it will allow us to see the full name of the packages in rpm commands. Theoretically people should be able to add into **yum.conf **(this is the default anyway, so you might have it already):
`exactarch=1`
and **yum **will install by default the packages of the arch it is running on (x86_64 in our case). Still, this will not prevent i386 dependencies to show up and be installed. In case you want to completely ignore other arch packages add in the **[main] **section of **/etc/yum.conf **to exclude all 32bit packages,:
`exclude=*.i386 *.i586 *.i686`
and this will completely exclude them completely from yum operations. Please use this with care, and only if you have a full understanding of the implications to exclude those packages.

Even if you don't exclude the 32bit packages as shown above, it is a good idea to add the **arch **to all yum operations (like install, remove, etc.), like:
`yum install ncurses.x86_64`

Hopefully you found this post useful, and have now a better understanding on how rhel/centos use the i368 and x86_64 packages and libraries with rpm and yum on a 64bit installation.
