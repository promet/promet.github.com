---
author: rachel-jaro
published: true
date: '2008-11-20 08:20:29'
layout: post
slug: denial-of-service-attack-and-the-defense-in-depth-layer
status: publish
title: Denial of Service Attack and the Defense-in-Depth Layer
wordpress_id: '114'
categories:
- Security
- sysadmin
---

Security should be practiced in all area. This is where the DiD or Defense-in-Depth Layer comes in.

**Defense in Depth** is a multiple defensive strategy recommended as a secure practices by CERT and other security organizations. Security experts apply multiple defenses and countermeasures in many areas of their system or operations. There is no single generic list of the layers so it can vary on what you are trying to protect. There are 5 common layers in the DiD: Physical, Network, Host, Application and Data layer. We will discuss 4 layers in order to secure us from DoS or [Denial of Service attack](http://linuxsysadminblog.com/2008/11/denial-of-service-dos-attacks-becoming-more-common/) and those are  Network, Host and Application and Physical.

_Physical_: The physical access to the resources (including humans)

_Network_: Layer at which data is accepted into the system from the network. The primary components that make up your network infrastructure are routers, firewalls, and switches.  A well designed and properly implemented network architecture provides highly available, secure, scalable, manageable, and reliable services.

_Host_: Hosts come in two types: clients and servers. Securing both effectively requires striking a balance between the degree of hardening and the level of usability.

_Application_: For the purpose of this article, application refers to an interactive software application that uses a web browser as the user interface to typically access a database for the content or commonly called web app.

In [DoS attack](http://linuxsysadminblog.com/2008/11/denial-of-service-dos-attacks-becoming-more-common/), a vulnerability in one layer is a vulnerability in the other layers. It can attack on any level unlike other kind of attacks. Microsoft has well explained the [network, host and application threats and countermeasures](http://msdn.microsoft.com/en-us/library/aa302418.aspx#c02618429_004). The following are list of appropriate actions to address DoS:

**Network Layer**



	
  * Apply the latest service packs.

	
  * Harden the TCP/IP stack by applying the appropriate registry settings to increase the size of the TCP connection queue, decrease the connection establishment period, and employ dynamic backlog mechanisms to ensure that the connection queue is never exhausted.

	
  * Use a network Intrusion Detection System (IDS) because these can automatically detect and respond to SYN attacks.


**Host Layer**



	
  * Configure your applications, services, and operating system with denial of service in mind.

	
  * Stay current with patches and security updates.

	
  * Harden the TCP/IP stack against denial of service.

	
  * Make sure your account lockout policies cannot be exploited to lock out well known service accounts.

	
  * Make sure your application is capable of handling high volumes of traffic and that thresholds are in place to handle abnormally high loads.

	
  * Review your application's failover functionality.

	
  * Use an IDS that can detect potential denial of service attacks.


**Application Layer**



	
  * Thoroughly validate all input data at the server.

	
  * Use exception handling throughout your application's code base.

	
  * Apply the latest patches.


**Physical Layer**
The one last layer that was not given proper attention. The problem with our community is the lack of information regarding security issues. Help educate the common users on this kind of attack. An innocent employee or community can be used to execute a DDoS attack.

Again, security must be practiced in all areas of operations. DoS attack could take any form. Having DiD, if one layer fails then another layer will likely succeed.
