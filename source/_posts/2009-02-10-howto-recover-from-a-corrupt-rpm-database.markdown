---
date: '2009-02-10 06:27:13'
layout: post
slug: howto-recover-from-a-corrupt-rpm-database
status: publish
title: HowTo recover from a corrupt rpm database
wordpress_id: '317'
categories:
- Centos
- sysadmin
tags:
- Centos
- fedora
- rhel
- rpm
- yum
---

RedHat based systems (rhel/fedora/centos) use rpm/yum to install and upgrade packages. If the **rpm database gets corrupted** in some way it will break all the functionality of rpm and other tools that rely on it like yum for example. We have seen this either showing some errors on the console, or most frequently just by hanging and not performing any rpm related operations (even simple view operations like rpm -qa, or yum update, etc.). You will have to kill the processes and then find a way to rebuild your rpm database. _This post will show how to rebuild your rpm database and bring back to life your rpm command._

First we need to **backup our existing database** (just in case); this is located in **/var/lib/rpm** and depending on your distribution the content of the folder might look like this:
`/var/lib/rpm
-rw-r--r--  1 rpm  rpm   5464064 Feb  9 04:17 Basenames
-rw-r--r--  1 rpm  rpm     12288 Feb  3 05:03 Conflictname
-rw-r--r--  1 root root        0 Aug 25 02:48 __db.000
-rw-r--r--  1 root root    24576 Aug 14 04:02 __db.001
-rw-r--r--  1 root root  1318912 Aug 14 04:02 __db.002
-rw-r--r--  1 root root   450560 Aug 14 04:02 __db.003
-rw-r--r--  1 rpm  rpm   1982464 Feb  9 04:17 Dirnames
-rw-r--r--  1 rpm  rpm   5259264 Feb  9 04:17 Filemd5s
-rw-r--r--  1 rpm  rpm     24576 Feb  9 04:17 Group
-rw-r--r--  1 rpm  rpm     28672 Feb  9 04:17 Installtid
-rw-r--r--  1 rpm  rpm     45056 Feb  9 04:17 Name
-rw-r--r--  1 rpm  rpm  31707136 Feb  9 04:17 Packages
-rw-r--r--  1 rpm  rpm    339968 Feb  9 04:17 Providename
-rw-r--r--  1 rpm  rpm    106496 Feb  9 04:17 Provideversion
-rw-r--r--  1 rpm  rpm     12288 Dec  2 08:45 Pubkeys
-rw-r--r--  1 rpm  rpm    253952 Feb  9 04:17 Requirename
-rw-r--r--  1 rpm  rpm    167936 Feb  9 04:17 Requireversion
-rw-r--r--  1 rpm  rpm     86016 Feb  9 04:17 Sha1header
-rw-r--r--  1 rpm  rpm     49152 Feb  9 04:17 Sigmd5
-rw-r--r--  1 rpm  rpm     12288 Jan 15 21:09 Triggername`

Let's just **backup **all the /var/lib/rpm folder to have its original state:
`cd /var/lib
tar czvf rpmdb.tar.gz rpm`

Finally let's **rebuild **the rpm database:
`cd /var/lib/rpm
rm -f __db*
rpm --rebuilddb -vv`

After this, your rpm commands should be working again. (just try a _yum update_ or a rpm query like: _rpm -qa php_). If this will not fix it try to see what error messages you got from the above commands or from your system logs.
