---
published: true
comments: true
author: gerold-mercadero
date: '2009-09-14 20:15:46'
layout: post
slug: hpacucli-error-while-loading-shared-libraries-libstdc-libc6-2-2-so-3
status: publish
title: 'hpacucli: error while loading shared libraries: libstdc++-libc6.2-2.so.3'
wordpress_id: '859'
categories:
- Debian
- Installation
---

**Problem:** I got this error when installing [**hpacucli**](http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&swItem=MTX-66b08e49c28f4bd49f4641ed80&jumpid=reg_R1002_USEN) on Lenny and i can't find it on my default repo.  Others have similar problem.

**Solution: ** I just installed a package directly from **[packages.debian.org](http://packages.debian.org/etch/i386/libstdc++2.10-glibc2.2/download)** and this worked fine for my hpacucli in Lenny.

Any idea why this library is not included anymore?
