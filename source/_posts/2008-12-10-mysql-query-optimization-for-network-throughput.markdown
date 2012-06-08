---
date: '2008-12-10 10:42:46'
layout: post
slug: mysql-query-optimization-for-network-throughput
status: publish
title: MySQL query optimization for network throughput
wordpress_id: '155'
categories:
- MySQL
- Performance
tags:
- Cyber Monday
- MySQL
- optimization
- traffic
---

It's a bit of a long title for a blog post but the point I want to make is that not every query optimization is aimed at making the query faster. As a case in point we have a client that has a web shop and their network traffic between the web servers and the database servers has been sizable to say the least. There was a good amount of old code that probably worked pretty well when the shop just started out and had small amounts of data. Now the shop has grown certain queries suddenly don't perform so good anymore.

On any weekday around lunch time network traffic between web and data servers was around 80Mb/s. On a 100Mb/s connection that is dangerously high and to address this we've been in the process of modifying queries that do a SELECT *. There really hardly ever is a reason to do a SELECT * except when you have very flexible code that automatically deals with extra columns. That was not the case with this application.

On Cyber Monday we found that traffic for this shop was touching 100Mb/s and web site performance really suffered. As a temporary measure we switched the database server to a 1Gb/s connection but both web servers stayed on 100Mb/s connections.

Looking at the slow query log and mtop revealed a ton of similar queries:
`
# User@Host: username[username] @  [10.0.0.123]
# Query_time: 2  Lock_time: 0  Rows_sent: 1948  Rows_examined: 2047
SELECT * FROM sites, sites_to_bundle WHERE sites_to_bundle.sites_id = sites.sites_id AND sites.site_name ='shop1';`

In and by them selves these queries look pretty harmless. 2000 rows is not that much. Maybe more than is needed but not enough to choke up the network either. The problem turns out to be that this query was executed several times for each page in the check out process. The database server was not overloaded since it had the whole result set in its cache, but it had to transfer 2MB of data for each request. When a developer investigated it turned out that only one 2 digit value of the entire result set was used.

We rewrote query and pushed to production on that same day. Yes, I know that a previous blog post tells us not to do that but in this case I'm glad we did. Network traffic dropped below 10Mb/s and the web site was flying. Below is the Cacti graph that shows that difference. Shortly after 15:00 we implemented the optimization and traffic dropped dramatically.

[caption id="attachment_162" align="alignnone" width="500" caption="Network traffic decrease after query optimization"][![](http://linuxsysadminblog.com/wp-content/uploads/2008/12/network_traffic_improvement.png)](http://linuxsysadminblog.com/wp-content/uploads/2008/12/network_traffic_improvement.png)[/caption] 
