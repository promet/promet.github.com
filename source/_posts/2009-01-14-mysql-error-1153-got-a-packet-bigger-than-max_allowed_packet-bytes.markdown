---
published: true
author: gerold-mercadero
date: '2009-01-14 21:43:46'
layout: post
slug: mysql-error-1153-got-a-packet-bigger-than-max_allowed_packet-bytes
status: publish
title: 'Mysql Error 1153: Got a packet bigger than ''max_allowed_packet'' bytes '
wordpress_id: '219'
categories:
- Installation
---

I got this error while importing large database dump from command line.
     _ERROR 1153 (08S01) at line XXX: Got a packet bigger than 'max_allowed_packet' bytes_

I searched and found out that it is related to the default _max_allowed_packet_ which is _16M_, so i need to increase this setting from Mysql:

1.) **Change setting on my.cnf and restart mysql:**
    _set-variable = max_allowed_packet=32M
    /etc/init.d/mysql restart_

Or;

2.) **Change setting temporarily.  Login to MySQL and issue:**
    _SET GLOBAL max_allowed_packet=1000000000;_
    **Note:**  You may want to restart your Mysql to reload your previous/default settings.

