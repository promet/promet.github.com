---
date: '2011-04-11 10:24:29'
layout: post
author: gerold-mercadero
published: true
slug: moving-drupal-site-with-civicrm
status: publish
title: Moving Drupal site with CiviCRM
wordpress_id: '1300'
categories:
- drupal
- HowTo
- Installation
- Tips and Tricks
tags:
- civicrm
- drupal
---

The common headache for beginners who try to move their Drupal site with CiviCRM is the CiviCRM configuration on new location or domain.  I did this countless times and dealt with different problems before.  I've read many online tutorials and how-tos, and I finally have my notes which is working for me everytime i move Drupal and CiviCRM site.

Let's assume you already moved the databases (separate database for Drupal and CiviCRM as a recommended setup) and the files to new location and have set the correct file permissions as well.  Here is the part that you need for your CiviCRM to work on new location and domain:



	
  * access your database and empty `civicrm.domain:config_backend`.  You see this anywhere with CiviCRM guide.

	
  * update database details, site path/directory, and domain on `civicrm.settings.php`

	
  * emtpy `sites/default/files/civicrm/template_c` (or make this entire dir writable by web user)

	
  * login to you new Drupal site and visit these urls:
`http://sitename/civicrm/menu/rebuild?reset=1`
	`http://sitename/civicrm/admin/setting/updateConfigBackend?reset=1`
      **Note:** This will rebuild the settings for you - if not, repeat/review all the above steps.

