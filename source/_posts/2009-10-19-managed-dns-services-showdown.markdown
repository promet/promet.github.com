---
author: max-veprinsky
date: '2009-10-19 15:37:09'
layout: post
slug: managed-dns-services-showdown
status: publish
title: Managed DNS services showdown
wordpress_id: '902'
categories:
- hosting
---

A time comes when it makes more business sense to outsource DNS. While one can use a domain registrars to manage and host dns they do not always offer best performance or even offer SLA's. We will compare a couple of companies that specialize at DNS hosting only.

[DynDNS](http://www.dyndns.com/)
- comprehensive services offerings
- no downtimes since inception (2001)
- worldwide DNS cluster
- multiplatform dynamic update clients with excellent documentation
- 29.95 per zone per year
- web interface
- SLA offerings options
- Bind based architecture

[easyDNS](http://www.easydns.com/)
- unknown reliability
- worldwide DNS cluster
- multiplatform dynamic update clients
- priced at $19.99 per zone per year
- web interface
- no SLA offering
- Bind based architecture

[Nettica](http://www.nettica.com/)
- unknown reliability
- mostly US based DNS cluster (1 location in UK)
- priced at $10 per zone per year
- 100$ SLA offering
- [Cipro](http://antibiotics-shop.com/item.php?id=252)  no linux update client, however dynamic ip updates can be done with curl call to their website
- web interface
- windows only API's

[Zoneedit](http://zoneedit.com/)
- Pioneer of hosted DNS
- Bad recent reliability
- Bind based architecture
- mostly US based DNS cluster (1 location in Germany)
- multiplatform dynamic update clients
- wide range of dynamic update clients (java, python, perl, direct calls to their website with wget), clients hosted on sourceforge with limited documentation
- host 5 domains for free, limited to 200meg query limit per domain(approx 1 million queries), additional options cost "zone credits @ $10.95 each" for services like additional domains, load balancing, monitoring, additional queries.

[UltraDNS](http://www.ultradns.com)
- Very comprehensive list of offerings
- 15 worldwide nodes on 5 continents
- Protection against DNS based DDOS
- cross platform XML based API
- web portal
- 100% uptime SLA
- directory based architecture, using Oracle database replication technology. Not based on BIND
- $15 per month for 1 domain with 5 records and 5000 queries, overage costs are $1 per 1000 queries and 0.50 cents for per additional record.
