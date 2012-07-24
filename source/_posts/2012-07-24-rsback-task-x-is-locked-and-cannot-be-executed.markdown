---
layout: post
title: "rsback: task x is locked and cannot be executed"
date: 2012-07-24 16:40
comments: true
author: gerold-mercadero
published: true
categories:
- HowTo
tags:
- rsback
- backup
---


*Rsback Error*:
```
  rsback: [date/time] *** task 'x' is locked and cannot be executed.
```

I got the above error when I was trying to re-run the rsback task that I previously killed its schedule backup process.  I had issue with the server being backup so I had to terminate the process.

This error shows up and prevents the backup task from running because the lock file is still present, which indicats that a process could still be running.  In order to fix this you need to remove the lock file and re-run the backup task.  Look at your rsback config (_/etc/rsback/rsback.conf_) to find out the location of your rsback lock files, default is "_lock_dir = /var/lock/subsys_".  In there you will see rsback lock files as "_rsback.backup_task_name.lock_", and just delete that file.

For those who doesn't know or heard of [rsback](http://sourceforge.net/projects/rsback/) below is a short description from sourceforge.

  _rsback makes rotating backups using the common rsync program combined with hard-link copies on Unix-based backup hosts. This results in a fast and disk space saving backup technique._


