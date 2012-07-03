---
author: pim-van-der-wal
published: true
comments: true
date: '2008-09-04 07:41:00'
layout: post
slug: when-mysql-starts-counting-sheep
status: publish
title: When MySQL starts counting sheep
wordpress_id: '56'
categories:
- monitoring
- MySQL
- Performance
tags:
- connections
- garbage collector
- MySQL
- sleep
---

We encountered a situation recently where the number of connections to our MySQL database started creeping up slowly but steadily. Strangely enough all the connections were in sleep mode and the database was not being stressed. The number of connections first reached 30 where it normally stays below 20 and started triggering our monitoring scripts. After another hour the number of connections had reach 40 and this trend continued. All connections were coming from the same server which was visible in the show processlist output:

`
+---------+------------+-------------------+-------------+
| Id      | User       | Host              | Command     |
+---------+------------+-------------------+-------------+
|      26 | repl       | 10.0.0.23:32795   | Binlog Dump |
| 1074631 | sfront  | 10.0.0.32:49906   | Sleep       |
| 1085681 | sfront     | 10.0.0.32:50823   | Sleep       |
| 1085932 | sfront     | 10.0.0.32:46255   | Sleep       |
| 1091130 | sfront     | 10.0.0.32:39273   | Sleep       |
| 1092442 | sfront     | 10.0.0.32:42023   | Sleep       |
| 1106425 | sfront     | 10.0.0.222:38971  | Query       |
+---------+------------+-------------------+-------------+
`

The MySQL documentation defines the sleep mode as: 

`
The thread is waiting for the client to send a new statement to it.
`

The application running on the offending server was a Java application and luckily the only application on that server. A new module in this application was monitoring a setting in the database in a loop with 5 second breaks. The problem was caused by inefficient use use of database connections. In each loop a new connection would be opened, a new prepared statement created and a new resultset generated. None of these were explicitly closed by the application. Now, because Java has a built in garbage collecter these objects would be cleaned automatically in time, but apparently the rate of creating new connections was just slightly higher than the rate of garbage collection so the number of connections rose with about 10 per hour. Although our maximum number of connections is set rather high this would not have caused a problem for another couple of days but we would eventually have maxed out.

The solution was to have the developer nicely close all the database components and reuse were possible. After this the application has been consistently showing just one database connection.
