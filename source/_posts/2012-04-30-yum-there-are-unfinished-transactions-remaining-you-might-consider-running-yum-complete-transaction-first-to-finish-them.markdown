---
date: '2012-04-30 07:34:45'
layout: post
author: gerold-mercadero
published: true
slug: yum-there-are-unfinished-transactions-remaining-you-might-consider-running-yum-complete-transaction-first-to-finish-them
status: publish
title: 'YUM: There are unfinished transactions remaining. You might consider running
  yum-complete-transaction first to finish them.'
wordpress_id: '1357'
categories:
- Centos
tags:
- yum
---

Yum Error:
`There are unfinished transactions remaining. You might consider running yum-complete-transaction first to finish them.`

With _unfinished transactions_, yum refers to any incomplete or aborted transactions, such as package installations or updates.  Obviously, yum wants you to run `yum-complete-transaction` command to fix the problem.  If you can't find _yum-complete-transaction_ on your system, probably you don't have the package "_yum-utils_" installed, so install it first with `yum install yum-utils`.

If you run _yum-complete-transaction_ command, it will find and resolve the latest corrupted/aborted transaction and try to complete or fix it, and you have to run it again until all issues are fixed.  Running that command will tell you how many transactions are left to complete, package name, and so on.  Try running `/usr/sbin/yum-complete-transaction --help` for options in using this commands.




