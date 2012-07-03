---
author: pim-van-der-wal
published: true
comments: true
date: '2008-10-23 07:46:49'
layout: post
slug: homegrown-mysql-monitoring
status: publish
title: Homegrown MySQL monitoring
wordpress_id: '99'
categories:
- monitoring
- MySQL
- Nagios
- sysadmin
tags:
- connections
- monitoring
- MySQL
- shell
---

If you can't do it with a shell script it usually ain't worth doin', right? Of course the number and quality of monitoring tools available to sys admins has gone up dramatically. Thanks to Nagios and other great tools it's pretty easy to keep track of what's going on and where and get notified pretty quickly. But some times you just want to monitor a couple of things first to see if they are actually worth monitoring. In my case it started out as a temporary thing to keep track of a recurring problem. The number of MySQL connections would max out of from time to time and we needed to be alerted very quickly if this happened of course.

So we let crontab run a shell script every minute which just executes one command:
```
mysql -e "show processlist;" > job.tmp
```
This command will let you track all user connections at that moment. Of course a lot can happen in a minute and there's lots of stuff you won't catch, but problems that are growing will manifest themselves here. To distill the number of running connections:
```
CONNS=`cut ${SCRIPTS_DIR}/jobs.tmp -f5 | grep "Query" | wc -l | cut -f1 -d"/"`
```
The number of locked out queries:
```
LOCKED=`cut ${SCRIPTS_DIR}/jobs.tmp -f7 | grep "Locked" | wc -l | cut -f1 -d"/"`
```
The longest running query:
```
LONGRUN=`grep "Query" ${SCRIPTS_DIR}/jobs.tmp | cut -f6 | sort -n | tail -1`
```
In all these cases a simple if statement will mail the processlist in case a threshold is passed. No better way to get your attention then your mailbox filling up with an alert per minute. Besides, seeing the processlist at the time things started going wrong can be very useful in identifying the culprit.
