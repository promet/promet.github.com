---
author: pim-van-der-wal
published: true
date: '2009-02-17 10:09:35'
layout: post
slug: cloud-computing-scenarios-for-database-servers
status: publish
title: Cloud computing scenario's for database servers
wordpress_id: '322'
categories:
- Down Time
- hosting
- MySQL
- Performance
- Replication
tags:
- Amazon
- cloud
- database
- ec2
- MySQL
---

We've been investigating the possibilities of using cloud computing for our clients. Especially Amazon EC2 has the potential to be be really effective in offering flexible, pay-as-you-go computing. From my own perspective I have been looking at how to use cloud computing in combination with MySQL and I must say that I'm a bit sceptical about the effectiveness of cloud computing in replacing the primary database server. First off there does not seem to be that much in the way of performance data for this type of installation. Can a cloud server really offer the I/O performance necessary to replace a dedicated database server? And even if the performance is equal, what is the main advantage? Scaling web sites is done by adding more servers in most cases but the same approach only works for database servers when clusters are used. So in what other scenario's does cloud computing give us an edge?

**Temporary reporting servers
**Create a one time copy of an existing production database server to run specific heavy reports. This is ideal for monthly reports since the server only needs to be up and running for several hours per month.

**Backup database server
**This is a backup solution where the server is only allocated once there is a problem with the primary server which makes a lot of sense because the client only pays for the server once it is used. One downside to this scenario is that the server has to created and loaded with the latest backup which will result in a decent amount of downtime but at least all of this can be automated. A bigger problem is the loss of data since the latest backup.For our high availability sites we have a standby database server replicating all changes from the master so we can switch over at a moment's notice without losing any data.

**Migrations
**Performing a migration or a system upgrade usually brings some downtime. Promoting a standby system to primary creates a single point of failure so it makes sense to create a remporary standby of the standby.

**Development branches and testing environments
**For development branches we usually only need an extra database for a short amount of time although truth be told, those database are not very large in general so we tend to put them on the same development database server anyway. The same is true for testing and QA. These activities usually occur in cycles which means that they are very attractive targets for cloud based servers.

**Alternative data center
**Yes, it happened to us once that our datacenter went off line due to a very heavy attack. Instead of finding another data center for these eventualities it could be useful to have cloud based backup servers defined. However, this requires the extra effort of keeping these instances up to date for this eventuality. Additionally, DNS caching will stop the switch from being instantaneous. A geographical load balancing solution would be the answer to that but at that point the cost for preparing for this eventuality will have to be compared to the loss due to down time.
