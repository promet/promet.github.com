---
comments: true
date: '2010-09-30 14:23:51'
layout: post
author: andrew-kucharski
published: true
slug: a-day-in-the-life-of-facebook-operations
status: publish
title: A Day in the Life of Facebook Operations
wordpress_id: '1145'
categories:
- Performance
---

Notes from the "A Day in the Life of Facebook Operations" presentation by Tom Cook, Systems Engineer, Facebook at [Surge2010](http://omniti.com/surge/2010) conference.

So far this is the most attended session.  Standing room only available only before it start.

What does facebook sysadmins have to support?



	
  * Monthly 700 million minutes of time spent on fb

	
  * 6billion pieces of content updated

	
  * 3 billion photos

	
  * 1 million connect implementations

	
  * 1/2 billion active users


Infrastructure Growth

	
  * fb reached a limit on leasing datacenter space

	
  * fb is building their own http://www.facebook.com/prinevilledatacenter

	
  * currently serving out of california and Virginia


Initially a LAMP stack.  LB -> Web Servers -> Services/Memcached/Databases

Originally facebook was a simple Apache PHP site.  When fb started hitting a limit on this, they started compiling PHP into C++ ([HipHop](http://developers.facebook.com/blog/post/358) for PHP).

FB claims to be the biggest memcache deployment in the world.  They server 300 Terbytes of memcached data out of memory.

[MySQL improvement](http://www.facebook.com/MySQLatFacebook)s contributed back is flashcache.

Services supported



	
  * News Feed

	
  * Search

	
  * Cache


Service implementation languages

	
  * C++

	
  * PHP - front end

	
  * python

	
  * Ruby

	
  * Java

	
  * erlang (chat room)


How do they talk between these?  Json?  SOAP?  No, fb implemented Thrift - ligtwaith software framework for cross language development, a common glue behind all facebook systems.

For Systems, what does fb have to worry about on a daily basis?

	
  * deployment

	
  * monitoring

	
  * data manaement

	
  * Core operating updates


Facebook OS is.... CentOS!

Systems Management

	
  * Configuration Management

	
  * CFengine for system management

	
  * On Demand


Deployments

	
  * Web Push - new code gets deployed to fb at least once a day.  Its a coordinated push, everyone is aware, notification happens to dev team.  Everyone sites on IRC during the push.  It is undestood by engineers and the rest of the company

	
    * push software built over on-demand control tools

	
    * code distributed via internal BitTorrent swarm

	
    * php gets compiled, the few hundred MB binary gets rapidly pushed bia bit torrent.

	
    * it takes one minute to push across the entire network




	
  * Backend Deployments - only Engineering and Operations.  Engineers write, test and display

	
    * Quickly make performance decisions

	
    * Expose changes to subset of real traffic

	
    * No 'commit and quit'

	
    * Deeply involved in moving services to production

	
    * Ops 'embeded' into engineering teams




	
  * Heavy Change logging - pin pointing code to every push and change


Monitoring and Metrics of servers and performance at facebook

	
  * [Ganglia](http://ganglia.sourceforge.net/) - aggregated metrics

	
    * fast

	
    * straightforward

	
    * nested grids & pools

	
    * over 5 million monitored metrics




	
  * facebook inhouse monitoring system


Monitoring - facebook still uses [Nagios](http://www.nagios.org/)!

To manage complexity and the number of alarms and systems monitoring the fb team uses aggregation.  Initially alarms were managed by email.

Scribe - high performance logging application.  Initially used syslog.  Also used Hadoop and Hive.

How does it work and gets done?



	
  * clear delineation of dependencies and responsibilities

	
  * Constant Failure

	
  * Servers were the first line of defense, then started focusing on racks

	
  * Now is focused on clusters.  Logical delineation based on function (web, db, feed, etc)

	
  * Next stage is datacenters - what to do if a natural disaster strikes?

	
  * Constant Communication - information is shared constantly.

	
    * IRC

	
    * lots of automated bots, get and set data

	
    * internal news updates

	
    * "Headers" on internal tools

	
    * Change log/feeds




	
  * Small teams


Interesting fact - each fb server gets an update on average every eight minutes.

Busiest day for FB is day after halloween :)

URLS to check out:

[facebook.com/engineering](http://www.facebook.com/Engineering)

[facebook.com/opensource](http://developers.facebook.com/opensource/)
