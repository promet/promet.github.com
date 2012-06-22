---
author: gerold-mercadero
date: '2009-06-29 05:39:10'
layout: post
slug: moving-drupalcivicrm-sites
status: publish
title: Moving Drupal / Civicrm Sites
wordpress_id: '743'
categories:
- Centos
- cloud computing
- HowTo
- Storage
tags:
- civicrm
- drupal
---

In this guide i will provide the steps in moving Drupal sites with CiviCRM - with Drupal and CiviCRM in one or separate databases.  I will outline the steps and sample commands but won't give much details, so feel free to ask if you need any clarifications.  Also, refer to my previous guide on "[HowTo Duplicate or Copy Drupal Site](http://linuxsysadminblog.com/2009/04/drupal-howto-duplicate-copy-drupal-site/)" for detailed instructions, commands, and sample shell scripts.

**Moving Files:**




  * Copy Drupal file and preserve mode (ownerships, permissions, etc)
Example: `cp -rp drupal_source drupal_destination`
Review your directory permissions on sites/default/files, sites/default/files/civicrm, and other directories.



  * Update references to Drupal url, path, and database details (name, user, pass, and host). Sample commands below using grep:
`find /path/to/drupal -type f -exec perl -pi -e "s/example.com/example2.com/g" {} \;
find /path/to/drupal -type f -exec perl -pi -e "s/public_html\/example/public_html\/example2/g" {} \;
find /path/to/drupal -type f -exec perl -pi -e "s/db_name/db_name2/g" {} \;
find /path/to/drupal -type f -exec perl -pi -e "s/db_user/db_user2/g" {} \;
find /path/to/drupal -type f -exec perl -pi -e "s/db_pass/db_pass2/g" {} \;`




**Moving Database/s:**

**Case 1:  Combined CiviCRM and Drupal Database.**




  * Create sql dump of source database.  
     Example: `mysqldump -Q -udb_user -pdbpass db_name > db_name.sql`


  * Import to destination database. 
    Example: `mysql -udb_user2 -pdbpass2 db_name2 < db_name.sql`


  * Update references to Drupal url, path, and database details (name, user, pass, and host) of non-CiviCRM tables.  You can use PhpMyAdmin to export this tables, then do the search/replace process on your local editor, and upload back the updates sql.  You can also dump the tables from using command line (but you'll have a long list of tables) and do the grep (same as above) and re-import the updated sql file.


  * Update CiviCRM configurations from Drupal Admin section.  You need to update the "Resource URLs" and "Directories".  
    _CiviCRM Admin Settings:  Administer Civicrm > Global Settings > Directories    (or use the direct url:  /civicrm/admin/setting/path?reset=1)
    CiviCRM Admin Settings:  Administer Civicrm > Global Settings > Resource Urls  (or use the direct url:  /civicrm/admin/setting/url?reset=1)_



  * Optional:  You can empty Sessions and Cache tables if you want.



**Case 2:  Separate CiviCRM and Drupal Database **(recommended install for CiviCRM).
Process for this setup is almost the same as Case 1, the difference is on the import process for databases.  I'll just provide the complete info below.




  * Create sql dump of source databases.  
   Examples:
`   mysqldump -Q -udb_user -pdbpass db_name_drupal > db_name_drupal.sql
   mysqldump -Q -udb_user -pdbpass db_name_civicrm > db_name_civicrm.sql
`


  * Import directly the CiviCRM database.  
     Example: `mysql -udb_user2 -pdbpass2 db_name2_civicrm < db_name_civicrm.sql`


  * Update CiviCRM configurations from Drupal Admin section.  You need to update the "Resource URLs" and "Directories".  
    _CiviCRM Admin Settings:  Administer Civicrm > Global Settings > Directories    (or use the direct url:  /civicrm/admin/setting/path?reset=1)
    CiviCRM Admin Settings:  Administer Civicrm > Global Settings > Resource Urls  (or use the direct url:  /civicrm/admin/setting/url?reset=1)_



  * Update references to Drupal url, path, and database details (name, user, pass, and host) of Drupal database dump.
`perl -pi -e "s/example.com/example2.com/g"  db_name_drupal.sql
perl -pi -e "s/public_html\/example/public_html\/example2/g"  db_name_drupal.sql`


  * Import the Drupal database.
    Example: `mysql -udb_user2 -pdbpass2 db_name2_drupal < db_name_drupal.sql`


  * Optional:  You can empty Sessions and Cache tables if you want.



That's All!
