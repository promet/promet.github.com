---
date: '2009-04-21 20:55:06'
layout: post
slug: mysql-query-cache-good-or-bad
status: publish
title: MySQL Query Cache, Good or Bad?
wordpress_id: '536'
categories:
- MySQL
- Performance
tags:
- cache
- MySQL
- tuning
---

MySQL has a number of different caches. Most of those are dependent on the storage engine that is used. The key buffer for example caches the indexes for MyISAM tables while the caching of data is left to the OS. InnoDB has the buffer pool for both data and indexes and so on. The query cache however, is independent of the storage engine that is used. Unlike most caches it does not store records or pages of data but complete result sets and the queries that caused those results to be returned. This is a very disputable concept since the way that it works is that if any of the tables  used in a result set is modified, the whole cached result set is thrown out of the cache.

The good news is that if you have data that does not change very much the query cache can give you an enormous performance boost. It even bypasses the query optimizer so that if the query is complex even more cpu time is saved. Knowing this you can optimize your application by chopping complex queries into smaller queries that only use that data that never changes.

Of course there are some tricks to using the query cache. The first one is the size of the query cache. The default is 16MB which doesn't do much. However, keep in mind that any memory assigned to the query cache is removed from another cache so it's very important to strike a good balance. Of course the balance is very application dependent. The second parameter is the maximum allowed result set size. It really doesn't do any good to allow 16MB result sets into the cache because it would take only one badly written query to flush out the entire cache. 1MB is standard but in my personal experience queries that return 1MB of results on a frequent basis usually indicate that the software needs to be optimized.

So when is the query cache a bad thing? Well, in short, when the cache gets flushed out all the time and only adds to the overhead it's usually better to assign the memory to storage engine dependent cache. If there are constant updates and inserts to most of your tables it will invalidate the results in the query cache pretty quickly and assigning memory to it is a waste of resources.

Useful tools like [MySQL Tuner](http://wiki.mysqltuner.com/MySQLTuner) will give some quick information about the efficiency of the query cache but I do think it is a bit quick in suggesting more memory for the cache.
