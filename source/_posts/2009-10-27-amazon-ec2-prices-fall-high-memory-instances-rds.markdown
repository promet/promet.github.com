---
published: true
author: max-veprinsky
date: '2009-10-27 09:50:58'
layout: post
slug: amazon-ec2-prices-fall-high-memory-instances-rds
status: publish
title: Amazon EC2 prices fall + High Memory Instances + RDS
wordpress_id: '942'
categories:
- Installation
---

Amazon announced a couple of cool new things this morning. Standard and High CPU Linux/UNIX EC2 instances hourly prices in the US and Europe have dropped by 15% and will go into effect November 1st. 2 new types of EC2 instance is now available called "High-Memory". High-Memory Instances are designed to be used with memory-intensive workloads such as databases, caching, and rendering, and are optimized for low-latency, high-throughput performance.     

* Double Extra Large: 34.2 GB memory, 13 ECU (4 virtual cores with 3.25 ECU each), 850 GB storage, 64-bit platform ($1.20 per hour)
* Quadruple Extra Large: 68.4 GB memory, 26 ECU (8 virtual cores with 3.25 ECU each), 1690 GB storage, 64-bit platform ($2.40 per hour)

Also Amazon entered it's [Relational Database Service](http://aws.amazon.com/rds/) into public [Amoxil Online](http://antibiotics-shop.com/item.php?id=252)  beta. This new service makes it easy to set up, operate, and scale MySQL relational databases in the cloud via simple API calls.

    * Simple to Deploy - Quickly create a new production-ready relational database with a simple API call.
    * Managed - Amazon RDS handles generic, time-consuming database management tasks, such as patch management and backup.
    * Compatible - All of your existing MySQL database tools, applications, and drivers will still work.
    * Scalable - With a simple API call you can scale the compute and storage resources available to your database to meet your business needs and application load.
    * Reliable - Amazon RDS runs on the same highly reliable infrastructure used by other Amazon Web Services. Amazon RDS also gives you additional peace of mind by providing an automated database backup facility.
    * Inexpensive - You pay very low rates and only for the resources you actually consume. There are no long-term contracts or up-front commitments to use Amazon RDS.
