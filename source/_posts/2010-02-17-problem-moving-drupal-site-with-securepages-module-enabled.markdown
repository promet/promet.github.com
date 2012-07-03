---
comments: true
date: '2010-02-17 07:41:23'
layout: post
author: gerold-mercadero
published: true
slug: problem-moving-drupal-site-with-securepages-module-enabled
status: publish
title: Problem Moving Drupal Site With SecurePages Module Enabled
wordpress_id: '1058'
categories:
- drupal
- HowTo
- Tips and Tricks
tags:
- drupal
- securepages
---

I made a copy of Drupal6 site with [SecurePages](http://drupal.org/project/securepages) module installed and configured.  This module is configured to redirect all or certain pages to https - depending on your configurations.  For our setup we usually include the login and admin sections to redirect to https.

The problem is on the copied site that is on a new domain as we cannot login and go to the admin section because it redirect back to the source/original site.  What we need is either disable the securepages module or update the domains.  To do this, you need to access your database (ex: phpmyadmin, etc), go to _variable_ table, and search for _securepages_ configurations. 

If you want to disable the module change:
```
securepages_enable  s:1:"**1**";
```
to
```
securepages_enable  s:1:"**0**";
```

Or if you want to update the domain change:
```
securepages_basepath s:30:"http://**www.domain.com**";
securepages_basepath_ssl s:31:"https://**www.domain.com**";
```
to
```
securepages_basepath s:30:"http://**www.newdomain.com**";
securepages_basepath_ssl s:31:"https://**www.newdomain.com**";
```

After making the above changes **don't forget** to run the update.php (`http://www.newdomain.com/update.php`)

If you want to uninstall the module, try removing the securepages directory and run update.php.
