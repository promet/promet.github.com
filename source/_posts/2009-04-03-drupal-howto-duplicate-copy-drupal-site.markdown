---
published: true
comments: true
author: gerold-mercadero
date: '2009-04-03 04:48:11'
layout: post
slug: drupal-howto-duplicate-copy-drupal-site
status: publish
title: 'Drupal HowTo:  Duplicate / Copy Drupal Site'
wordpress_id: '484'
categories:
- drupal
- Installation
---

This post cover the steps to copy, transfer, or duplicate a Drupal site to new domain or from development/test site to live/production server.  This requires shell/command line access to the server/accounts.  I attached (below) some bash/shell scripts below that i used to perform these task.

**Backup**:  In case the destination site or account have existing contents, you need to backup them first or moved to separate location.

**Copy/Transfer Procedures**

**Database:**

1.) Create an sql dump of your source database (use mysqldump)
2.) Update references to domain/url and path or home directory (you can user perl/sed commands)
3.) Import to your destination database (using mysql).

**Files/Codes:**

1.)  Copy all files from your source directory or account to the destination site.
2.)  Update references to database name, database user, database password, home directory of drupal installation, and domain name or url.
3.)  Update permission and ownership of files and directories, like the sites/default/files to 777.

**Notes.** If you have CiviCRM installed and on a separate database, then you can use this guide but do not perform or update the references to url and paths.  This guide is not applicable if you have CiviCRM installation which uses the same database as the Drupal database.  CiviCRM recommended install is to use a separate database.

**Shell / Bash Scripts:**

1.)  Copy Drupal Site with CiviCRM.  [**Download here!**](http://linuxsysadminblog.com/images/2009/04/copy_drupal_with_civicrm.sh)

2.)  Copy Drupal Site without CiviCRM.  [**Download here!**](http://linuxsysadminblog.com/images/2009/04/copy_drupal_without_civicrm.sh)

**Note:** You can modify these scripts to work with sub-domains. Let me know if you have questions or suggestions or if you need help.
