---
date: '2009-02-04 15:54:30'
layout: post
slug: extending-the-slow-query-log
status: publish
title: Extending the slow query log
wordpress_id: '302'
categories:
- MySQL
- Performance
tags:
- MySQL
- slow query log
---

Andy posted some very good links recently to video's on how to optimize your web site. Although I spend more time optimizing the database you always have to go where the actual performance is lost. For MySQL the place to check for performance issues is the slow query log which I have mentioned in earlier posts. The limitation of this log is that a query has to take at least one second to appear in this log. This skips over queries that are executed thousands if not millions of times and which take less than a second. These queries might have just as much of a performance impact as queries that last several seconds each.

In the article below it shows how to patch the slow query log to track queries that last less than a second. Obviously you don't want to have this running continually in production because the amount of logging would be enormous but in test environments or for a limited time in production this can be very useful. Be prepared to analyse some huge amounts of data though.

[http://www.mysqlperformanceblog.com/2006/09/06/slow-query-log-analyzes-tools/](http://www.mysqlperformanceblog.com/2006/09/06/slow-query-log-analyzes-tools/)
