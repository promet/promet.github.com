---
comments: true
published: true
author: gerold-mercadero
date: '2010-02-15 00:42:10'
layout: post
slug: making-changes-to-drupal-core
status: publish
title: Making Changes to Drupal Core
wordpress_id: '1040'
categories:
- drupal
- HowTo
- Tips and Tricks
tags:
- drupal
---

Although we made it a standard not to make any changes to Drupal core and core modules, there are times that our developers really need to make changes to core modules in order to add the required functionality.  Cases like additional feature for 'user' or 'comment' modules and so on.  At this state we can't perform automatic update on our sites as we might overwrite the changes - so we need to do the update manually.  Well, this is ok if you maintain one or two sites, but if you have more than 100 sites then it will take you some time.

What we did to eliminate this issue and be able to update the site automatically was to create a copy of the original core modules (located in _/modules_), add our custom functionality, and put the modified copy into 'contributed' modules directory (_/sites/all/modules_).  Drupal read the modules found on _/sites/all/modules_ first and ignore the same copy (original) found on _/modules_.  Also, may want to change the module info or the package name to separate the modified modules from the original ones - ex: modified_core, custom, etc.  In the case that Drupal reads both of them, you can just disable the other one.

Here's our policy on working with Drupal modules:
  - contributed or community modules at _/sites/all/modules_
  - custom made modules at _/sites/all/modules/custom_
  - modified core modules at _/sites/all/modules/core_modified_

Hope this helps.  :) 


