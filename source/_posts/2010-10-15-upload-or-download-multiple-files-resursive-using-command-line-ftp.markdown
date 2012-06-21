---
date: '2010-10-15 06:30:30'
layout: post
author: gerold-mercadero
published: true
slug: upload-or-download-multiple-files-resursive-using-command-line-ftp
status: publish
title: Upload or Download Multiple Files (recursive) using Command-line FTP
wordpress_id: '1168'
categories:
- Installation
tags:
- ftp
- lftp
---

Problem is I can't upload directory including sub-directories and files using command-line ftp.   I searched for similar problem and looks like you can't do this using command line ftp, unless you create a script.   One solution I found is the use of "[lftp](http://lftp.yar.ru/)".

    \# lftp ftp_host
    \> user ftp_user ftp_pass
    \> mirror source target      (download entire directory tree)
    \> mirror -R source target  (reverse mirror; upload entire directory tree)

Usefull when transferring files between servers where you only have ftp access.

