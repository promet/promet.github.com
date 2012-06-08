---
date: '2008-08-26 17:39:10'
layout: post
slug: enabling-and-using-the-slow-query-log-in-mysql
status: publish
title: Enabling and using the slow query log in MySQL
wordpress_id: '53'
categories:
- MySQL
- Performance
tags:
- MySQL
- slow query log
- tuning
---

By special request here is a post about the MySQL slow query log. MySQL has a wonderful feature that lets you keep track of all queries that took longer than a certain time to complete. To enable it simply add the following line to your my.cnf file:

`log-slow-queries = [path to the log file]`

Secondly it is very useful to specify the minimum amount of time a query should take before being considered a slow query. Again, simply add the following line to your my.cnf file:

`long_query_time = [minimum time in seconds for query]`

Unfortunately you do have to restart MySQL for this to catch on, but once you do you will have a very powerful and simple tool for optimizing your queries. After letting it run for while and using the application that is accessing it open the log file and you will see entries like this:

`# Time: 080826 15:33:48
# User@Host: testuser[testuser] @  [10.0.0.1]
# Query_time: 2  Lock_time: 0  Rows_sent: 0  Rows_examined: 628951
select * from customers where customers_email_address = 'test@test.com' and customers_sites_id = '1';`

As you can see the limit has been set pretty low (1 second to be exact) because the Query_time is 2 seconds. Still, most simple queries should not last more than a fraction of a second. The complete query is shown here and the number of rows that MySQL examined to get the result. The fact that the number is pretty high (628951) means that no index was used. The next step is to take this query and run the EXPLAIN command on it to verify whether an index was used or not. If that is the problem than the simple solution is to add an index for this column if this query is used often.

The second way to extract useful information from the slow query log is to look for repeated queries. This will mainly occur in web applications where the user can hit the refresh button to restart the query. If the first one did not complete quickly enough you can bet the second one won't fare any better while the first one is still running. Seeing the same query appearing several times is a good sign that the query needs to be optimized.
