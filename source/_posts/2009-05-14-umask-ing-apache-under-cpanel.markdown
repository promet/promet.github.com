---
date: '2009-05-14 18:17:02'
layout: post
slug: umask-ing-apache-under-cpanel
status: publish
title: umask 'ing apache under cPanel
wordpress_id: '644'
categories:
- cpanel
- hosting
- Security
- sysadmin
tags:
- umask
---

Ran into an issue today where a php created file was unreadable by other users or services that run under a different user.  Since this is a software originated issue the sysadmin would love for the developer to change the code to include the [chmod() php function](http://us2.php.net/chmod)  to set permission to 644 after file creation.  On the flip side when a developer sees "permission" they automatically assume it's OS related and want the sysadmin to resolve the issue. 

This time I let the developer slide and implemented a fix on system end by appending `umask 022` into /usr/local/apache/bin/envvars file and restarting apache. This will apply a umask of 022 to the default perrmission of 666 for newly created files. The result is that anytime apache creates a file be it via php or another way it will always have 644 permissions and will be world readable.
But wait the fun doesn't end there as we are running cPanel on this particular server and this env change will be lost next time Apache is rebuilt via [EasyApache](http://www.cpanel.net/documentation/easyapache/ea3custom_modvar.html). To make this change persistent create a file called umask with the digits 022 as contents in /var/cpanel/easy/apache/rawenv/
