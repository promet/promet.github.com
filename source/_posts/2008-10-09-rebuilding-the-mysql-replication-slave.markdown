---
author: pim-van-der-wal
comments: true
published: true
date: '2008-10-09 14:16:26'
layout: post
slug: rebuilding-the-mysql-replication-slave
status: publish
title: MySQL replication problems
wordpress_id: '68'
categories:
- monitoring
- MySQL
- Replication
tags:
- '1062'
- MySQL
- Replication
- slave
---

We are using a replication setup for our databases. The master database takes care of all the transactions and the slave database is used for hot standby, making backups and running reports. Running mysqldump for backups locks the main tables one by one (we're using the MyISAM storage engine) and was causing user interruptions. Hence using the replication slave for this is quite effective but it makes it very important to monitor the replication lag. If the replication stops the backups fall behind and suddenly the hot standby is not so hot anymore. A second problem is that the reports are reporting on stale data.

Recently our master database server decided it was time for a break and spontaneusly rebooted. Since the server immediately came back up and started all services correctly production was only interrupted for a couple of minutes. A little later alerts started coming in that the replication lag was growing. It turns out the replication slave had gotten confused and was processing old replication logs. This means that transactions from a month ago were being processed again. This could be measured in several ways. The lag was showing a number of seconds equivalent to about a month This meant that the records it was trying to insert already existed and we were getting the 1062 MySQL error. This means that the primary key already exists and the new insert cannot complete. This stops replication dead in its tracks. The second way to see that old transactions are being processed is to look when the duplicate records were originally inserted. This is not always possible, but in this case there was a timestamp in the records.

Our conclusion was that we needed to take two actions. First of all we needed to rebuild the replication slave database and restart replication from scratch. To do this you have to lock the entire database while making a mysqldump (FLUSH TABLES WITH READ LOCK).  This would lock out users for 10 to 15 minutes which is unacceptable during the daytime so we decided to execute this later in the evening when fewer users were online. The second action was to let the replication catch up so that we would have a reasonably consistent database in the mean time. This was done by adding the following line to the MySQL configuration file:
```
slave-skip-errors=1062
```
After that the replication slave server was restarted and the database caught up in 2 hours of processing. The reason we considered this an intermediate solution is that we don't delete many records. The applications execute mainly updates and inserts to modify data. As long as the latest updates are executed last the data will be in decent shape. After that we rebuilt the complete slave database at a more convenient time and all was well again.....
