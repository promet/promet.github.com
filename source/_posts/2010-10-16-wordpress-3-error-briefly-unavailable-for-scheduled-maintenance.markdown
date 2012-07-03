---
comments: true
date: '2010-10-16 18:51:31'
layout: post
author: gerold-mercadero
published: true
slug: wordpress-3-error-briefly-unavailable-for-scheduled-maintenance
status: publish
title: 'WordPress 3 Error: Briefly unavailable for scheduled maintenance. Check back
  in a minute.'
wordpress_id: '1184'
categories:
- wordpress
tags:
- wordpress
---

You'll get this error when Wordpress automatic update process, via svn or admin, fail or is incomplete.  It leaves the file named "_.maintenance_" on your home or root directory, with info on maintenance.

Sample content of .maintenance file: `<?php $upgrading = 1282258195; ?>`

Just delete or rename that file and resume your update process, or you may want to restore your backup first and re-start the update process.  Of course, check what cause the failed or incomplete update. :)
