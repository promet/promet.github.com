---
author: andrew-kucharski
date: '2008-11-10 14:56:10'
layout: post
slug: denial-of-service-dos-attacks-becoming-more-common
status: publish
title: Denial of Service (DoS) attacks becoming more common
wordpress_id: '103'
categories:
- hosting
tags:
- DoS
- virus
---

Within a week I had seen the term DOS or Denial of Service being mentioned in two mainstream publications, the WJS and more recently in this article - [Internet Attacks Grow More Potent](http://www.nytimes.com/2008/11/10/technology/internet/10attacks.html?th&emc=th) -  by the Wall Street Journal.


> “We’re definitely seeing more targeted attacks toward e-commerce sites,” said Danny McPherson, chief security officer for Arbor Networks. “Most enterprises are connected to the Internet with a one-gigabit connection or less. Even a two-gigabit D.D.O.S. attack will take them offline.”


We have some experiences with this of course, luckily none of our customers was a targe of a DoS but if anyone on your network or even a datacenter is - you will most likely notice a latency at best and a DoS yourself.

Most of the research I have seen on how to deal with a DoS attack points to the helplessness of the smaller DC and the hardware they have in order to deal with this.  They mostly have to work with the downstream providers to help them filter out the traffic.

Keep the NOC number handy and remember to evengalize the application of personal firewalls and viruse software on windows machines... we dont want them to be an angry zombie mob.
