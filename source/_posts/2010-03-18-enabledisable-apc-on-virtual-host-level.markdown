---
date: '2010-03-18 16:53:29'
layout: post
slug: enabledisable-apc-on-virtual-host-level
status: publish
title: Enable/Disable APC on virtual host level
wordpress_id: '1069'
categories:
- Performance
- sysadmin
- Tips and Tricks
tags:
- apc
- php
- tips
---

[**APC**](http://pecl.php.net/package/APC) (Alternative PHP Cache) is a free, open, and robust framework for caching and optimizing PHP intermediate code. **APC** is a great tool to speed up a php driven site and I can't even think of a big site running on a php framework without an _opcode cache_ (other good choices are **eaccelerator** or **xcache**). Why would not everyone want to use this? The reason why this is not enabled by default everywhere is because in certain situations it can break things. Most peoples will not see any problems, but still, if you run a server with many clients sharing the same apache service this might be a problem (as the apc module loading it is a server-wide config). This post will show how we can use APC globally and disable it for some vhosts (that might have a problem with using APC) or the reverse to just use it one a special vhost that might need this.

I'll assume that you have installed apc already, if this is not the case this will probably be something as simple as running
`pecl install apc`
or downloading the archive from pecl and running:
`phpize; ./configure; make; make install`

The APC extension needs to be enabled either in **php.ini** or in one included file with a line like this:
`extension=apc.so`
there are many other parameters that apc can be fine tuned (see the official doc for more info), but without any other change, just with this line apc will be enabled on all the vhosts on the server.

**Disabling some vhosts from using APC**
- if we want to disable APC for a particular vhost we just have to add to the vhost config or to .htaccess:
`php_flag apc.cache_by_default Off`

**Enabling APC only on some vhosts**
- if we want to have APC disabled by default globally we will have in php.ini:

    
    <code>extension=apc.so
    [apc]
    apc.cache_by_default=0 # disable by default
    ... other apc settings...</code>


and we will enable APC for the particular vhost config or using .htaccess using:
`php_flag apc.cache_by_default On`

Hopefully you found this post useful and this will give you a reason to use APC with more confidence knowing that you have the granularity to disable/enable it as needed in a shared environment.
