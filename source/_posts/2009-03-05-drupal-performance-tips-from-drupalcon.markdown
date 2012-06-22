---
author: andrew-kucharski
date: '2009-03-05 12:27:21'
layout: post
slug: drupal-performance-tips-from-drupalcon
status: publish
title: Drupal performance tips from DrupalCon
wordpress_id: '397'
categories:
- drupal
- monitoring
- Performance
---

Still reporting from DrupalCon. So far there have been a number of sessions I have attended. Here are some highlights from those sessions on how to increase performance on your drupal site.



	
  * Look at the number of requests a page makes to the server

	
  * Use yslow to measure page rendering (often a page performance is perceived, not just based on the server response time)



	
  * Remove search, use alternate solutions such as Apache Solr or Google Search API

	
  * Use CDN as much as possible

	
  * Use Reverse Proxy Cache and memcache

	
  * Obviously use drupal cache


Some other notes that are somewhat related to drupal performance and site performance management in a clustered hosting environment.

**Manual updates and rollback**

OLD WAY: tar, move/copy untar restart services

OLD WAY: rsync

BETTER WAY: [Capistrano ](http://www.capify.org/)

**Managing systems:**

BETTER WAY: [bcfg2](http://trac.mcs.anl.gov/projects/bcfg2)

**Monitoring Tools**



	
  * Capacity Load: analyzing trends, predicting load, checking results of configuration and software changes ([cacti](http://www.cacti.net/), [munin](http://munin.projects.linpro.no/))

	
  * Failure: analyzing downtime, notification ([nagios](http://www.nagios.org/) - using **nrpe** agents to monitor diverse services (do we use it this way?) , hyperin)


Use monitoring tools to closely observe cluster replication and cashing as the failures in this area are the most difficult to solve.
