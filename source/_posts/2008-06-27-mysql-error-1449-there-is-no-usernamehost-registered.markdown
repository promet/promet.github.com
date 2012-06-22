---
author: pim-van-der-wal
date: '2008-06-27 07:53:31'
layout: post
slug: mysql-error-1449-there-is-no-usernamehost-registered
status: publish
title: MySQL error 1449 "There is no 'username'@'host' registered"
wordpress_id: '27'
categories:
- MySQL
tags:
- MySQL
- Replication
- Triggers
---

The error message in the title occurs in a combination of circumstances. If you have 2 MySQL databases, one master and one slave in a replicating setup and you use triggers you may encounter this error. Although it is not necessary for the slave database to have the same users as the master for replication to work it is required for triggers to work. The triggers get fired at both the master and the slave and use the username of the user that caused the trigger to execute. So if user user@localhost is present at the master then the same user needs to be added to the slave. The privileges don't have to be the same as long as the user has enough access on the slave to complete the trigger.

The biggest problem with this is that it causes replication to stop dead in its tracks. After adding the user to the slave database the replication needs to be restarted with the following MySQL command:

`START SLAVE;`

After that check for errors with the following MySQL command:

`SHOW SLAVE STATUS\G`

Depending on how long replication has been suspended it may take some time for the slave to catch up. This will not be shown in the replication status.
