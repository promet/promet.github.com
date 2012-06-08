---
date: '2011-04-01 14:36:15'
layout: post
author: marius-ducea
published: true
slug: apc-should-be-enabled-by-default
status: publish
title: APC should be enabled by default
wordpress_id: '1261'
categories:
- Drupal performance
- hosting
tags:
- apc
- Drupal performance
- hosting
- Performance
- php
---

**PHP is slow**. This should not be a huge revelation for any of us, and this is not because PHP is a bad programing language, or because Python or Ruby are better. This is because it is an [_interpreted language_](http://en.wikipedia.org/wiki/Interpreted_language). Every time you execute a PHP script it is going to do the exact same thing and interpret your code and then execute it over and over. This is obviously slow and doesn't compare with any compiled language like C++ for example. But we don't want to write in C++ for our webapps, right? and we would like to use the PHP simplicity as many other open source products and developers; what can we do then? We can very easily enable any of the opcode cache available: [**APC**](http://pecl.php.net/package/APC), [**eaccelerator**](http://eaccelerator.net/) or [**xcache**](http://xcache.lighttpd.net/) (I'm not aware of something similar for python or ruby, but if it exists you should probably use it also). An **opcode cache** or **PHP accelerator**, will cache the compiled form of the php scripts speeding up dramatically their execution time. Many people have done this a long time as they needed to improve the performance of their sites, and get results up to 20x speed up from plain PHP. A very simple step-by-step intro on how you can install APC can be found on this [older post](http://linuxsysadminblog.com/2010/03/enabledisable-apc-on-virtual-host-level/).

Now here is the question a good friend of mine asked me a while ago: **why is APC not enabled by default?** Why do people have to do an extra step to install an external module for this (that many don't). And my answer at that time was that opcode caches are not perfect, and depending by how you write your code they might cause problems and have it no longer functioning correctly. I think I was quite happy with my answer as myself I would always install an opcode cache on any high traffic site I managed from day one (most of the time APC, but also eaccelerator) and many time even running comparisons between them to see if one of them is faster. Still even today, in most of the **performance projects** we completed, we found people don't do this, and they **don't have APC installed and enabled**. There are some tricks on how to tune APC and improve even better its performance but here I'm talking just to have it installed. This is why I think that APC should be enabled by default everywhere (not only by 'high traffic' sites). It should give PHP scripts a boost of performance and if you really have problems with it you can disable it on a vhost or directory level very simple just by adding in .htaccess:
`php_flag apc.cache_by_default On
`

I'm hoping more and more people will do this so we can focus on more serious performance problems in our PHP webapps. I don't see why not, because this is very simple and there are plenty of [howto's](http://www.google.com/search?q=howto+php+apc) available. Still if you need help, and you would like us to do it for you, please [contact us](http://www.prometsource.com/contact) and let us speed up your site.

Note: if you have done this many years ago and want somethign even faster for your PHP code you should take a look at [**HipHop**](https://github.com/facebook/hiphop-php/wiki/) the project from Facebook to **compile your php scripts** (actually transforms PHP source code into highly optimized C++ and then uses g++ to compile it to machine code) and run them as executables (but this is going to be much harder to implement, but still a very interesting project to keep an eye).
