---
date: '2011-05-05 21:07:16'
comments: true
layout: post
author: marius-ducea
published: true
slug: howto-install-apc-on-cpanelwhm
status: publish
title: HowTo Install APC on CPanel/WHM
wordpress_id: '1338'
categories:
- cpanel
- Installation
tags:
- apc
- cpanel
- whm
---

**CPanel** includes support in their installer for **eaccelerator**; still, for some strange reason they don't include support for **[APC](http://pecl.php.net/package/APC)** also. So, if you want to install APC on your CPanel powered server, you will have to go back at the command line and install it manually.

Here are the steps needed to install the latest version of APC (3.1.8 at the time of writing this article; please check for the latest version available when you are reading this and make the changes accordingly):
```
cd /usr/local/src
wget http://pecl.php.net/get/APC-3.1.8.tgz
tar -zxvf APC-3.1.8.tgz
cd APC-3.1.8
phpize
./configure --enable-apc --enable-apc-mmap --with-apxs --with-php-config=/usr/local/bin/php-config
make
make install
```

Next, activate the apc module in **php.ini** by adding something like this:
```
extension="apc.so"
apc.enabled=1
apc.shm_segments=1
apc.shm_size=128
```

Finally, you will have to _restart apache_ and after that the APC module should be activated and in use. Hopefully, this will help you enable APC on your CPanel server in some very simple steps in less that 5minutes.
