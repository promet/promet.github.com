---
published: true
comments: true
author: gerold-mercadero
date: '2008-09-11 18:22:37'
layout: post
slug: nagios-plugin-check_hparray-error
status: publish
title: 'Nagios Plugin:  check_hparray Error'
wordpress_id: '58'
categories:
- Installation
- monitoring
- Nagios
---

We have [check_hparray plugin](http://www.nagiosexchange.org/cgi-bin/page.cgi?g=2508.html;d=1) installed on all of our HP servers, running CentOS, for monitoring hardware raid via 
[HP Array Configuration Utility CLI](ftp://ftp.hp.com/pub/softlib2/software1/pubsw-linux/p414707558/v47111/hpacucli-8.10-2.noarch.txt) (hpacucli) tool, and we have [NRPE](http://nagios.sourceforge.net/docs/nrpe/NRPE.pdf) installed as well for this check from our remote Nagios server.

Yesterday we've setup another HP server and installed NRPE, check_hparray, and hpacucli, same process used on previous installations.  NRPE worked fine locally and from the Nagios server as the local disk space check was configured properly, but when we tried check_hparray we got "check_hparray Error".  This error can have different causes like invalid slot value used or problems with permissions on executing hpacucli command.

We reviewed our setup and installations and we have the same settings (based on setup with other servers).

We run check_hparray from NRPE we got the error:

```
[root@web161 nagios]# /usr/local/nagios/libexec/check_nrpe -H localhost -c check_raid
check_hparray Error.
```

and it worked fine if run `check_hparray` command directly:

```
[root@web161 nagios]# /usr/local/nagios/libexec/check_hparray -s 1
RAID OK - (Smart Array P400 in Slot 1 array A logicaldrive 1 (546.8 GB, RAID 1+0, OK))
```

Both of the commands above were tested using root and nagios users and they have the same results.  Then we enabled NRPE DEBUG option to get details on the problem:

edit: `/usr/local/nagios/etc/nrpe.cfg`

```
# DEBUGGING OPTION
# This option determines whether or not debugging messages are logged to the
# syslog facility.
# Values: 0=debugging off, 1=debugging on

debug=1
```

and by looking on the system logs we saw the problem with our sudo:

```
Sep  10 04:11:35 hostname sudo:   root : TTY=pts/2 ; PWD=/var/log ; USER=root ; COMMAND=/usr/sbin/hpacucli controller slot=1 ld all show
Sep  10 04:12:55 hostname sudo:   nagios : sorry, you must have a tty to run sudo ; TTY=unknown ; PWD=/ ; USER=root ; COMMAND=/usr/sbin/hpacucli controller slot=1 ld all show"
```

and the solution was to comment out in `/etc/sudoers` file the line:

```
_Defaults    requiretty_
```
