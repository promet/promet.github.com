---
date: '2008-06-04 05:11:20'
layout: post
slug: install-wordpress-with-subversion
status: publish
title: Install Wordpress with Subversion
wordpress_id: '1'
categories:
- Installation
author: gerold-mercadero
---

To install Wordpress with Subversion you need shell access to your server and have Subversion installed.  To start, login to your server (shell) and go to directory where you want to install Wordpress and execute this command:

svn co http://svn.automattic.com/wordpress/trunk/ .

Copy `wp-config-sample.php` to `wp-config.php`.   Edit `wp-config.php` and enter database details.  Access your blog url to complete installation.
