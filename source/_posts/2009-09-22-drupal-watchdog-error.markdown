---
author: gerold-mercadero
date: '2009-09-22 03:36:20'
layout: post
slug: drupal-watchdog-error
status: publish
title: Drupal Watchdog Error
wordpress_id: '882'
categories:
- Installation
---

One of our Drupal sites suddenly had this "**_blank page_**" problem after user login.  So we [turned on the PHP's error reporting](http://linuxsysadminblog.com/2009/09/howto-display-php-errors-when-you-dont-have-access-to-php-ini/) and got the "**_allowed memory size of xxx bytes exhausted_**" error.  Usually this error is caused by memory limit for PHP so you just need to increase it from your _php.ini_ file or _.htaaccess, _ but in our case we had our memory limit set already to 64Mb.   Check here for more details on [how to increase  PHP memory limit](http://www.ducea.com/2008/02/14/increase-php-memory-limit/).

Upon further investigation, we found out that it was caused by a [bug on our Watchdog module](http://drupal.org/node/235891) as  we got "**_Warning: Got a packet bigger than 'max_allowed_packet' bytes query: INSERT INTO watchdog (uid, type, message, variables..._**".  You can fix this error by increasing MySQL's _max_allowed_packet_ (the default i think is 16MB).  You can do it directly from  your _my.cnf_, add "**_set-variable = max_allowed_packet=32M_**" (of course without qoutes :)) and restart you MySQL server. If you want to set this value temporarily, you can do it by logging in to your MySQL prompt and issue "**_SET GLOBAL max_allowed_packet=32M;_**".  You can check your current configuration by this command "**_mysqladmin variables | grep packet_**".  We set our max_allowed_packet to 32MB and our site went back to normal.

The reason why we experienced that error is because we originally had the max_allowed_packet set 32M **temporarily**** **and we rebooted our server so it returned to the default value.

