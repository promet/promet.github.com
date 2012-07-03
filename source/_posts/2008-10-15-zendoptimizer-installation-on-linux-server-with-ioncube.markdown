---
published: true
comments: true
author: gerold-mercadero
date: '2008-10-15 08:46:16'
layout: post
slug: zendoptimizer-installation-on-linux-server-with-ioncube
status: publish
title: ZendOptimizer Installation on Linux Server with IonCube
wordpress_id: '74'
categories:
- Installation
tags:
- ZendOptimizer
---

ZendOptimizer installation is very short and can be done with the following steps:

1.)  Get the latest release from **[Zend](http://www.zend.com/en/products/guard/downloads)**, available file format is *tar.gz* (ex:  `ZendOptimizer-3.3.0a-linux-glibc23-x86_64.tar.gz`).

2.)  Extract the tarball at `/usr/local/src/`.
```
cd /usr/local/src/
tar xzpf ZendOptimizer-3.3.0a-linux-glibc23-x86_64.tar.gz
```

3.)  Go to the extracted Zend directory and run the install script to launch Zend Optimizer installer.  Follow instructions.
```
cd ZendOptimizer-3.3.0a-linux-glibc23-x86_64/
./install
```

After the installation most likely Apache will not start even if ZendOptimizer said that it restarted successfully, and you will get this error if you check PHP version (`php -v`):
```
PHP Fatal error:  [ionCube Loader] The Loader must appear as the first entry in the php.ini file in Unknown on line 0
```
The usual scenario is that the ZendOptimizer includes were added at the end of `php.ini` file while the IonCube on the include directory at `/etc/php.d/ioncube-loader.ini`.

**You have two options to fix the issue**:

**Option 1.  Place both of the IonCube and ZendOptimizer includes in php.ini file.**

Move the contents of `/etc/php.d/ioncube-loader.ini` and put it into `/etc/php.ini`, above the ZendOptimizer lines.  Sample code:
```
zend_extension=/usr/lib64/php4/php_ioncube_loader_lin_4.3_x86_64.so

[Zend]
zend_extension_manager.optimizer=/usr/local/Zend/lib/Optimizer-3.3.0
zend_extension_manager.optimizer_ts=/usr/local/Zend/lib/Optimizer_TS-3.3.0
zend_optimizer.version=3.3.0a
zend_extension=/usr/local/Zend/lib/ZendExtensionManager.so
zend_extension_ts=/usr/local/Zend/lib/ZendExtensionManager_TS.so
```

Restart Apache ( `/etc/init.d/httpd restart` ).

**Option 2.  Place the ZendOptimizer includes on PHP's include directory.**

Create a `.ini` file (ex: `zendoptimizer.ini`) inside PHP's include directory at `/etc/php.d/`, and move the ZendOptimizer lines (sample below) from `/etc/php.ini`.
```
[Zend]
zend_extension_manager.optimizer=/usr/local/Zend/lib/Optimizer-3.3.0
zend_extension_manager.optimizer_ts=/usr/local/Zend/lib/Optimizer_TS-3.3.0
zend_optimizer.version=3.3.0a
zend_extension=/usr/local/Zend/lib/ZendExtensionManager.so
zend_extension_ts=/usr/local/Zend/lib/ZendExtensionManager_TS.so
```

PHP includes are loaded in alphabetical order so be sure to name your ZendOptimizer include file like `zendoptimizer.ini` so that this will be loaded after `ioncube-loader.ini`.

Restart Apache ( `/etc/init.d/httpd restart` ).
