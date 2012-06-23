---
date: '2010-04-29 08:28:22'
layout: post
author: pim-van-der-wal
published: true
slug: free-alternative-to-innodb-hot-backup
status: publish
title: Free alternative to InnoDB Hot Backup
wordpress_id: '1081'
categories:
- backup
- MySQL
tags:
- MySQL
- XtraBackup
---

I recently found out that there is a free alternative to InnoDB Hot Backup. For those of you using MySQL with the InnoDB plugin you probably know that MySQL does not provide a tool for making online non-blocking backups. InnoBase Oy, the makers of InnoDB, do provide a tool but it's not free. In fact they charge around $600 per year per server.

The tool that I'm talking about is XtraBackup by Percona. This tool is originally meant to accompany the XtraDB storage engine which in itself is a patched version of InnoDB. XtraBackup will create online non-blocking backups for both XtraDB and InnoDB databases and best of all, it's free.

For those of you who are not that familiar with MySQL backups, the standard way of doing backups is with mysqldump. This can be done with the database online but it blocks the tables it's backing up which is not acceptable for production environments. It also takes a good amount of time to restore a mysqldump since it writes out everything as SQL statements which then have to be processed again. A binary copy is much faster to restore but commonly requires the server to be stopped. The best alternative is to create an LVM snapshot of the binary files but this requires LVM to be set up and enough disk space to perform the LVM snapshot. All in all it's nice to have a free alternative although I have to add the footnote that I haven't tested it on any decently sized database to check what the performance impact is.
