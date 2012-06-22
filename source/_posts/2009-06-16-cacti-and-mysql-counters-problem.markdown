---
author: pim-van-der-wal
date: '2009-06-16 20:46:15'
layout: post
slug: cacti-and-mysql-counters-problem
status: publish
title: Cacti and MySQL counters problem
wordpress_id: '740'
categories:
- Cacti
- monitoring
- MySQL
tags:
- Cacti
- InnoDB
- MySQL
---

We recently came across a problem with Cacti and the MySQL counters. For those of you who don't know how to integrate MySQL statistics into Cacti have a look at this: [http://code.google.com/p/mysql-cacti-templates/](http://code.google.com/p/mysql-cacti-templates/). These templates are a great way to gain some insight into how your MySQL database servers perform. The templates are actually PHP pages that query the databases through a variety of commands like SHOW STATUS and SHOW ENGINE INNODB STATUS.

The issue that we encountered was that some statistics like the InnoDB buffer pool activity were not displaying anything for one server. Other servers were displaying it just fine and other statistics for that server were also fine.

Among other things the SHOW ENGINE INNODB STATUS command shows deadlock information pertaining to the last deadlock that the InnoDB engine encountered. In some cases this information will be quite extensive and this causes a problem. The output of this command is one giant text field with a limit of 64KB. If the deadlock information is very large other information will get cut off which means certain statistics are lost. The easy fix for this is to restart the database server but in case this is not an option you can always use the innotop utility to wipe the deadlock information by causing a small deadlock.
