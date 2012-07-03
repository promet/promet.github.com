---
published: true
comments: true
author: max-veprinsky
date: '2009-10-19 13:45:34'
layout: post
slug: change-squid-outgoing-address
status: publish
title: Change Squid outgoing address
wordpress_id: '898'
categories:
- Installation
- sysadmin
- Tips and Tricks
---

Typically [Squid](http://www.squid-cache.org) caching proxy server listen and outgoing IP address are the same. Sometimes, for various reasons we want to alter the **outgoing IP** address. The new address must first be brought up as an interface on the squid server. In squid.conf look for `tcp_outgoing_address` line, uncomment it and replace the default IP value with your new outgoing ip address and restart Squid. Your Squid server will still listen and accept connections on the current IP while all outbound traffic will originate from the new IP. This modification works with access ACL and detailed instructions can be found [here](http://www.squid-cache.org/Versions/v3/3.0/cfgman/tcp_outgoing_address.html) for latest stable branch (3.0)
