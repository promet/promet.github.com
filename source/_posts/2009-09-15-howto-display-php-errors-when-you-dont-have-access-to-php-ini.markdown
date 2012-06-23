---
published: true
author: marius-ducea
date: '2009-09-15 07:10:34'
layout: post
slug: howto-display-php-errors-when-you-dont-have-access-to-php-ini
status: publish
title: HowTo display PHP errors when you don't have access to php.ini
wordpress_id: '867'
categories:
- Centos
- CLI
- Debian
- HowTo
- sysadmin
- Tips and Tricks
tags:
- php
---

If you are using a shared server, or just have a limited account on your company servers, you might **not have access** to your php configuration file **php.ini** (this is usually found under _/etc/php.ini_ in rhel/centos and _/etc/php5/apache2/php.ini_ in debian/ubuntu). Still, in many situations it might be needed to **enable php errors** in the browser so you can see what is the actual problem instead of an empty page (if the server has error reporting disabled as most production systems should have).

In order to enable error reporting for your php script or application include inside your code the following lines:
`error_reporting(E_ALL);
ini_set("display_errors", 1);`
and this will result in displaying in the browser any errors your application might have.

ps: once you are done with this and fixed the issue, don't forget to remove the error reporting lines, as we don't want our users/clients to see errors in the browser in case something went wrong.
