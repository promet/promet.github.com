---
published: true
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

1.)  Get the latest release from **[Zend](http://www.zend.com/en/products/guard/downloads)**, available file format is  "tar.gz" (ex:  ZendOptimizer-3.3.0a-linux-glibc23-x86_64.tar.gz).

2.)  Extract the tarball at /usr/local/src/.

_ cd /usr/local/src/_
_tar xzpf ZendOptimizer-3.3.0a-linux-glibc23-x86_64.tar.gz_

3.)  Go to the extracted Zend directory and run the install script to launch Zend Optimizer installer.  Follow instructions.

_cd ZendOptimizer-3.3.0a-linux-glibc23-x86_64_/
_./install_

After the installation most likely Apache will not start even if ZendOptimizer said that it restarted successfully, and you will get this error if you check PHP version (_php -v_):

_**PHP Fatal error:  [ionCube Loader] The Loader must appear as the first entry in the php.ini file in Unknown on line 0
**_
The usual scenario is that the ZendOptimizer includes were added at the end of php.ini file while the IonCube on the include directory at /etc/php.d/ioncube-loader.ini.



You have two options to fix the issue:

**Option 1.  Place both of the IonCube and ZendOptimizer includes in php.ini file.**
Move the contents of _/etc/php.d/ioncube-loader.ini_ and put it into _/etc/php.ini_, above the ZendOptimizer lines.  Sample code:

**_zend_extension=/usr/lib64/php4/php_ioncube_loader_lin_4.3_x86_64.so

[Zend]
zend_extension_manager.optimizer=/usr/local/Zend/lib/Optimizer-3.3.0
zend_extension_manager.optimizer_ts=/usr/local/Zend/lib/Optimizer_TS-3.3.0
zend_optimizer.version=3.3.0a
zend_extension=/usr/local/Zend/lib/ZendExtensionManager.so
zend_extension_ts=/usr/local/Zend/lib/ZendExtensionManager_TS.so
_**
Restart Apache ( _/etc/init.d/httpd restart_ ).

**Option 2.  Place the ZendOptimizer includes on PHP's include directory.**
Create a  .ini file (_ex: zendoptimizer.ini_) inside PHP's include directory at _/etc/php.d/_, and move the ZendOptimizer lines (sample below) from _/etc/php.ini_.

_**[Zend]
zend_extension_manager.optimizer=/usr/local/Zend/lib/Optimizer-3.3.0
zend_extension_manager.optimizer_ts=/usr/local/Zend/lib/Optimizer_TS-3.3.0
zend_optimizer.version=3.3.0a
zend_extension=/usr/local/Zend/lib/ZendExtensionManager.so
zend_extension_ts=/usr/local/Zend/lib/ZendExtensionManager_TS.so
**_
PHP includes are loaded in alphabetical order so be sure to name your ZendOptimizer include file like _zendoptimizer.ini_ so that this will be loaded after _ioncube-loader.ini_.
Restart Apache ( _/etc/init.d/httpd restart_ ).
