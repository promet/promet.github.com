---
date: '2008-06-14 03:32:03'
layout: post
slug: installing-php-mcrypt-module-via-dynamic-module
status: publish
title: Installing PHP Mcrypt module via dynamic module
wordpress_id: '23'
categories:
- CLI
tags:
- CLI
- mcrypt
- php
author: marius-ducea
published: true
---

Considering that you have an existing php installation compiled from sources, it is very easy to add afterwards _new php modules_, outside the php binary. This can be achieved without any interruption of the web services, and requires just the following steps:


### 1. Ensure you have the mcrypt libraries and development tools.


For example on a rhel system you will have to install: **libmcrypt **and **libmcrypt-devel.** If you can't find those on your repos, _dag _has rpms for all rhel releases.


### 2. Compile the mcrypt module:


Assuming you have your php sources inside /usr/local/php, you have to:
`cd /usr/local/php
cd ext/mcrypt
phpize
./configure
make
make install`
just as on any 3rd party php module.


### 3. Finally activate the module in your php.ini


by adding the line:
`extension=mcrypt.so`
you will also want to restart your apache service in order to see the new php module installed.
