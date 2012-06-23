---
published: true
author: gerold-mercadero
date: '2009-05-29 07:23:23'
layout: post
slug: moving-magento-sites
status: publish
title: Moving Magento Sites
wordpress_id: '708'
categories:
- Installation
- Magento
tags:
- Magento
---

This is my first guide in moving [Magento](http://www.magentocommerce.com/) site to another site or server.  I've completed few Magento site transfers as we recently develop and host Magento sites.  I also encountered several issues in transferring sites, and searched for different 
approaches from other blog/forum sites, such as installing a new Magento instance on destination server.  I checked the official [Magento guide in moving site](http://www.magentocommerce.com/wiki/how_to/moving_magento_to_another_server) but I haven't tried it yet since my current process works fine.  This is similar to my procedures when moving other sites such as Oscommerce, Drupal, Wordpress, etc.  I assume you have ssh access to your server.

**Database:**
 - Export/dump source database. You can do it via Phpmyadmin or using mysqldump from command line.
   `mysqldump -udbuser -pdbpass dbname > filename.sql`

 - Update your database dump file before importing to destination database.  You need to change the referrences to source url/domain, path/home directory, database details such as database name in case you have tables that referrence to other tables (foriegn keys etc).  You can edit your sql file or dump file with your editor and do the search and replace.  For me i do this directly using perl/sed. 
`perl -pi -e "s/source.url/destination.url/g" filename.sql
       perl -pi -e "s/path\/to\/source\/install/path\/to\/destination\/install/g" filename.sql`
 - Import your modified database dump to destination database using phpmyadmin or via command line.  
   `mysql -udbuser -pdbpass dbname < filename.sql`

**Files:**
 - Copy all of Magento files to your destination site or server and preserve attributes
 - Empty contents of _var/cache_ and _var/session_ directories
 - Same process with database, update references to url, path, database details, and other variables that 
   differs from your source and destination server (ex: db host).
   Ex: `find /path/to/destination/site -type f -exec perl -pi -e "s/source.url/destination.url/g" {} \;
       find /path/to/destination/site -type f -exec perl -pi -e "s/path\/to\/source\/install/path\/to\/destination\/install/g" {} \;
       find /path/to/destination/site -type f -exec perl -pi -e "s/source_dbname/destination_dbname/g" {} \;
       find /path/to/destination/site -type f -exec perl -pi -e "s/source_dbuser/destination_dbuser/g" {} \;
       find /path/to/destination/site -type f -exec perl -pi -e "s/source_dbpass/destination_dbpass/g" {} \;`
 - Check if _var/_ and _media/_ directories are world-writable (777)

That's all check your new site and watch out if there are links coming from your old url.



