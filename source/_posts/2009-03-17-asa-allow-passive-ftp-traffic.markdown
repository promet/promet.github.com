---
published: true
comments: true
author: max-veprinsky
date: '2009-03-17 15:03:56'
layout: post
slug: asa-allow-passive-ftp-traffic
status: publish
title: ASA allow passive ftp traffic
wordpress_id: '428'
categories:
- cisco
- Security
tags:
- asa
- cisco
- ftp
---

Many ftp client will try to establish a **passive** connection with a server by default. A passive connection will use a high numbered unprivileged port range greater then 1023 (**PASV**) instead of port 20 (**PORT**). Most ftp servers specify different ranges that are to be used for passive connections.

When you are managing multiple ftp servers is it rather impractical to configure specific passive port ranges for each ftp server and open these ports in the firewall. A quick and much more practical solution is to use the stateful application inspection feature of the Adaptive Security Appliance.  To set-up inspection of the FTP protocol which will dynamically allow secondary ports to pass as well as allow NAT traversal of these ports we first must create an inspection policy for all interfaces which will inspect services on their standard ports:

```
class-map global-class
match default-inspection-traffic
```

Next configure a policy map and inspection of the ftp protocol:
```
policy-map global-policy
 class global-class
  inspect ftp
```
