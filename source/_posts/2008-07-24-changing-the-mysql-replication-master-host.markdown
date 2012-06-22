---
author: pim-van-der-wal
date: '2008-07-24 10:09:22'
layout: post
slug: changing-the-mysql-replication-master-host
status: publish
title: Changing the MySQL replication master host
wordpress_id: '32'
categories:
- MySQL
tags:
- MySQL
- Replication
---

Here's a little post on how to change the master database host that the replication slave in a MySQL replication setup uses. This can happen if there is a change in network addresses or when you want to switch over to using different internal network. The main thing to keep in mind is that when you change the replication user host on the slave MySQL will think that you are now replicating from a different database. Therefore we need to force MySQL to continue replicating the changes where it left off before the change.

First we need to create a new user on the master database server with the new IP address like this:

`GRANT REPLICATION SLAVE ON *.* TO 'repl'@'10.0.0.1' IDENTIFIED BY 'password';`

The rest of the operations are on the replication slave. We need to stop the replication and figure out where to restart the replication after changing the user:

`STOP SLAVE;
SHOW SLAVE STATUS\G`

From the slave status pick out the 2 settings for Master_Log_File and Read_Master_Log_Pos. Those items will look something like this:

`Master_Log_File: mysql-bin.000101
Read_Master_Log_Pos: 591523680
`

Those settings need to be used in the following statement:

`CHANGE MASTER TO MASTER_HOST='10.0.0.1', MASTER_LOG_FILE='mysql-bin.000101', MASTER_LOG_POS=591523680;
START SLAVE;`

The "start slave" command starts the replication again. Make sure you do a "show slave status" afterwards to make sure that replication is running again without errors.
