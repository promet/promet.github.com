---
date: '2009-05-13 15:57:22'
layout: post
slug: howto-delete-all-emails-from-the-postfix-queue
status: publish
title: HowTo delete all emails from the postfix queue
wordpress_id: '636'
categories:
- sysadmin
tags:
- postfix
---

I must admit that **postfix **queue management is definitely not the simplest one. I often get asked how you can **remove all the emails** that are in the _mail queue on a postfix server_ (probably to delete a spamming abuse or some error, or whatever). This should be something very simple to do right? And actually it is very simple. All you have to do is to run as root:
`postsuper -d ALL`
or using sudo:
`sudo postsuper -d ALL`
this will delete instantly all the emails in the queue **without any warning** (be sure you know what you are doing when running this) and will just output the result (_xxx messages deleted_).
