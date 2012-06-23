---
published: true
author: gerold-mercadero
date: '2008-08-05 11:46:25'
layout: post
slug: drupal-filebrowser-configuration-issue
status: publish
title: Drupal filebrowser configuration issue
wordpress_id: '38'
categories:
- Installation
---

We have experienced a strange issue with our Drupal filebrowser module installation. We’re getting repeated error messages about open_basedir restriction in effect.
_
# warning: file_exists() [function.file-exists]: open_basedir restriction in effect. File(/file-folder.png) is not within the allowed path(s): (/home/username:/usr/lib/php:/usr/local/lib/php:/tmp) in /home/username/public_html/modules/filebrowser/filebrowser.module on line 338.
# warning: file_exists() [function.file-exists]: open_basedir restriction in effect. File(/file-default.png) is not within the allowed path(s): (/home/username:/usr/lib/php:/usr/local/lib/php:/tmp) in /home/username/public_html/modules/filebrowser/filebrowser.module on line 338.
_

After several checks on our account setup we found the issue was caused by our configuration in filebrowser module. There are only two values to set for Filebrowser: “Root directory” and “Icons directory”. Since we forgot to set the value for “Icons directory” and left it empty, this caused the open_basedir restriction issue. Because the module couldn't find the location of the icon directory, it tries to blame the open_basedir restriction settings. 




