---
author: pim-van-der-wal
published: true
date: '2009-07-14 20:52:38'
layout: post
slug: syntax-error-on-mysql-replication-slave-error-1064
status: publish
title: Syntax error on MySQL replication slave (error 1064)
wordpress_id: '797'
categories:
- MySQL
- Replication
tags:
- error
- MySQL
- Replication
---

Here's an interesting one, what if you have a MySQL replication setup and the slave stops replicating with a syntax error? The slave should be executing the exact same commands as the master, right? Well, as it turns out, yes and no. There is a bug in MySQL that has been fixed in 5.0.56 according to the [bug report](http://bugs.mysql.com/bug.php?id=26489). It's a long story and it's worth the read but what happens is that a timeout in the network connection between the master and the slave can cause the master to resend part of packet that it sent before. The slave handled the previous packet correctly so it's not expecting a resend and as a result it starts writing some garbage to the relay log (which is where it stored the statements it will execute). The SQL command gets mangled in the process and when the slave tries to execute it, voila, a syntax error.

To fix this you can use the CHANGE MASTER command to set the slave to the master bin log file and position that shows up in the SHOW SLAVE STATUS output. Make sure you use the Relay_Master_Log_File and Exec_Master_Log_Pos fields since they indicate what position in the master binlog the slave actually thought it was executing. Keep in mind that corruption and its effects are hard to predict. It will definitely be useful to compare the master and slave afterward using the [MaatKit ](http://www.maatkit.org/)tools.

As some more background, the server log will be probably show and error like this to indicate there was a network error:
[ERROR] Error reading packet from server: Lost connection to MySQL server during query (server_errno=2013)

And finally, if you do read the entire bug thread you will notice that the original developer of MySQL also has an opinion on this.
