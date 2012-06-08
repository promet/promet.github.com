---
date: '2008-09-18 17:22:02'
layout: post
slug: run-parts-not-running-all-the-scripts-in-etccrondaily
status: publish
title: run-parts not running all the scripts in /etc/cron.daily
wordpress_id: '65'
categories:
- sysadmin
tags:
- cron
- run-parts
---

Okay, I realize that this is a simple one but it caught me by surprise nonetheless. Most of our scheduled scripts are placed in the /etc/cron.daily, /etc/cron.weekly and /etc/cron.monthly directories. After migrating some of these scripts to another server it turned out they were not being executed. After some research it came up that run-parts (or at least some implementations of it) was just skipping the files that had . in it. Our CentOS server was executing them perfectly but the Debian server just skipped them. The man page mentions it by omission:


> If  the  --lsbsysinit  option is not given then the names must consist entirely of upper and lower case letters, digits, under-scores, and hyphens.


To check what scripts will be executed call run-parts with the --test option.
