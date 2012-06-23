---
published: true
author: gerold-mercadero
date: '2009-05-12 11:51:25'
layout: post
slug: install-imagemagick-and-imagick-on-cpanel-server
status: publish
title: Install ImageMagick and Imagick on Cpanel Server
wordpress_id: '621'
categories:
- Centos
- cpanel
- Installation
tags:
- cpanel
- imagemagick
- imagick
- php extension
---

Here's a quick how-to for installing **[ImageMagick](http://www.imagemagick.org/script/index.php)** and **[Imagick](http://pecl.php.net/package/imagick)** on Cpanel server.  I will cover only the procedure using the Cpanel built-in scripts, although you can also install it the usual way (rpm or source install).  [ImageMagick](http://www.imagemagick.org/script/index.php)  is the application for working with images while the [Imagick](http://pecl.php.net/package/imagick) is a PHP extention to modify/create images using the ImageMagick API.  

**Installation:**

**ImageMagick**
  Check first if it's installed:
  `/scripts/checkimagemagick`
  Proceed with Installation:
  `/scripts/installimagemagick`
  Installation will take a couple minutes as it will install other packages needed by ImageMagick.  After the installation, you can check your ImageMagick version:
  `/usr/bin/convert --version`
  It will give you something like:
  _Version: ImageMagick 6.4.8 2009-05-11 Q16 OpenMP http://www.imagemagick.org
  Copyright: Copyright (C) 1999-2009 ImageMagick Studio LLC_

**Imagick**
  Go to **WHM -> Software -> Module Installers -> PHP Pecl **(manage). On the box below "**Install a PHP Pecl**" enter "**imagick**" and click "**Install Now**" button - that's all.  

Restart Apache and check your _**phpinfo**_ page to see the details of Imagick and ImageMagick as well.  See linked images for reference:  [image1](http://linuxsysadminblog.com/images/2009/05/install.jpg), [image2](http://linuxsysadminblog.com/images/2009/05/installed.jpg).

**Uninstall:**

If you decide to uninstall it's as easy as the installation process:
ImageMagick: ` /scripts/cleanimagemagick`
Imagick:  **WHM -> Software -> Module Installers -> PHP Pecl** (manage). Click on **Uninstall** button for Imagick.
