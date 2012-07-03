---
published: true
comments: true
author: gerold-mercadero
date: '2009-05-21 04:20:35'
layout: post
slug: install-gnupg-php-extension-in-cpanel
status: publish
title: Install GNUPG PHP extension in Cpanel
wordpress_id: '674'
categories:
- Centos
- cpanel
- Installation
tags:
- Centos
- gnupg
- gpg
- pear
- pecl
- php extension
---

Here's my quick howto on installing [GNUPG](http://us2.php.net/manual/en/book.gnupg.php) PHP Pecl extension ([pecl docs](http://pecl.php.net/package/gnupg/docs)) in Cpanel.  Please note that this covers only the installation process and no further details on setting up gpg keys or using the function with extension or sample PHP scripts.

Installation process is very straightforward provided you met the requirements like php-pear, gnupg, libgpg-error, and gpgme.  You can install it directly from `WHM -> Module Installers -> PHP Pecl`, enter `gnupg` and click the Install button.  You can do the same via shell with this command `pecl install gnupg`.  Then restart your Apache.  Be sure to double check if the extension was added to you `php.ini`.

On Cpanel servers most of the requirements are present, like `php-pear` (if you compiled your apache/php with pear), `gnupg, libgpg-error`, etc, except for [_gpgme_](http://www.gnupg.org/gpgme.html) which is the main library used by `gnupg` extension.  Our system is running CentOS 4.7 with latest STABLE branch of Cpanel (S35075 at this time of writing), PHP 5.2.9 with pear and libgpg-error (version 1.0-1 only).  Only missing requirement was `gpgme` which i installed from source as it was not available on our default yum repository.  You can also install it from other repositories like `centos.karan.org`.  At this time the latest `gpgme` version is [1.1.8](http://www.gnupg.org/download/index.en.html#gpgme) but I installed version 1.1.2 because it's the latest version compatible with our libgpg.

I also encountered an error library path when I check the extension,
```
error while loading shared libraries: libgpgme.so.11: cannot open shared object file: No such file or directory
```
so I had to add `/usr/local/lib` to `/etc/ld.so.conf` and run `ldconfig`, so that libraries in this directory are detected automatically.

