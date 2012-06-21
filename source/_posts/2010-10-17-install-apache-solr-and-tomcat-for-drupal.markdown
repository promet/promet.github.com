---
date: '2010-10-17 05:10:55'
layout: post
author: gerold-mercadero
published: true
slug: install-apache-solr-and-tomcat-for-drupal
status: publish
title: Install Apache Solr and Tomcat for Drupal
wordpress_id: '1129'
categories:
- Centos
- drupal
- Drupal performance
- HowTo
- Installation
tags:
- apachesolr
- solr
- tomcat
---

Here's my quick install guide for Solr, Tomcat, and Drupal ApacheSolr module for multiple sites.  Mostly I based the steps below from the following sites: [wiki.apache.org](http://wiki.apache.org/solr/SolrTomcat) and [drupalconnect.com](http://www.drupalconnect.com/blog/steve/configuring-apache-solr-multi-core-drupal-and-tomcat-ubuntu-910).

**Detailed Setup:**



	
  * Drupal 6.19

	
  * ApacheSolr module 6-1.1

	
  * Apache Solr PHP Client Library: Rev.22

	
  * Solr 1.4.1

	
  * Tomcat 6.0.29

	
  * SunJDK 6update21

	
  * RHEL5.5x64



**Install Process: Tomcat**



	
  * Create _solr_ user

	
  * Download [Tomcat6](http://tomcat.apache.org/download-60.cgi)

	
  * Extract to _/opt/tomcat_  _**this will be the $CATALINA_HOME directory, you can use any dir you want_

	
  * Edit _/opt/tomcat/conf/tomcat-users.xml_ to enable Tomcat login.  See comments in this file.

```
<role rolename="manager"/>
<role rolename="admin"/>
<user username="tomcat" password="tomcat" roles="manager,admin"/>
```



	
  * Test run your Tomcat:  _/opt/tomcat/bin/catalina.sh run_.  Chown all Tomcat files to _solr_ user (`chown -R solr.solr /opt/tomcat`).  Default server setting will use _port 8080_, to customized edit the file _/opt/tomcat/conf/server.xml_.  If you encounter error on "_BASEDIR environment variable is not defined correctly..._", check permissions of _.sh_ files inside _/opt/tomcat/bin/_ and make them executable (`chmod 755 /opt/tomcat/bin/*.sh`).


	
  * Add startup (init) script.  Copy this [Tomcat6 init file](http://wiki.apache.org/solr/SolrTomcat?action=AttachFile&do=view&target=tomcat6) from Apache.org to _/etc/init.d/tomcat6_.  Check and update variables like Java home, Tomcat directory, etc, if needed.  Add to startup `/sbin/chkconfig --add tomcat6` and `/sbin/chkconfig tomcat6 on`.  Dependencies: redhat-lsb (or lsb-base?)


	
  * Visit your Tomcat Admin page.  ex _http://localhost:8080_



**Install Process: Solr**



	
  * Download [Solr](http://mirrors.igsobe.com/apache/lucene/solr/)

	
  * Extract to temporary location, ex: _/opt/apache-solr-1.4.1_

	
  * Copy _/opt/apache-solr-1.4.1/dist/apache-solr-1.4.1.war_ to _/opt/tomcat/webapps/solr.war_

	
  * Copy _/opt/apache-solr-1.4.1/example/solr_ directory to _/opt/tomcat/solr  **this will be the $SOLR_HOME directory, you can use any dir you want_

	
  * Create file _/opt/tomcat/conf/Catalina/localhost/solr.xml_ with the following configuration.  Make sure paths are correct.


```
<Context docBase="/opt/tomcat/webapps/solr.war" debug="0" privileged="true" allowLinking="true" crossContext="true">
<Environment name="solr/home" type="java.lang.String" value="/opt/tomcat/solr" override="true" />
</Context>
```

**Install Process: ApacheSolr Drupal module and SolrPHP client**



	
  * Install/enable [Drupal ApacheSolr](http://drupal.org/project/apachesolr) module. Drush, CVS, or traditional install - whatever you want.  Example: _/var/www/site1/sites/all/modules/apachesolr_

	
  * Download [SolrPHP client library](http://code.google.com/p/solr-php-client/)


**Configure Solr for Multi-Core Setup**



	
  * Copy _/var/www/site1/sites/all/modules/apachesolr/schema.xml_ to _/opt/tomcat/solr/conf/schema.xml_

	
  * Copy _/var/www/site1/sites/all/modules/apachesolr/solrconfig.xml_ to _/opt/tomcat/solr/conf/solrconfig.xml_

	
  * Copy _/opt/apache-solr-1.4.1/example/multicore/solr.xml_ to _/opt/tomcat/solr/solr.xml_

	
  * Create directory for each site and copy _/opt/tomcat/solr/conf _ directory to each of them. Example:


    mkdir /opt/tomcat/solr/site1
    mkdir /opt/tomcat/solr/site2
    cp -r /opt/tomcat/solr/conf /opt/tomcat/solr/site1/
    cp -r /opt/tomcat/solr/conf /opt/tomcat/solr/site2/



	
  * Edit _/opt/tomcat/solr/solr.xml_ with the following config:

```
<?xml version="1.0" encoding="UTF-8" ?>
<solr persistent="false">
<cores adminPath="/admin/cores">
<core name="site1" instanceDir="site1" />
<core name="site1" instanceDir="site2" />
</cores>
</solr>
```

  * Start or Restart Tomcat: _/etc/init.d/tomcat6 start_
	
  * Visit _http://localhost:8080/_ and go to you Solr App


**Configure Drupal site:**

	
  * Go to ApacheSolr settings _http://localhost/admin/settings/apachesolr_

	
  * Save your config and if all is good you'll see message: _Your site has contacted the Apache Solr server._

```
Solr host name: localhost
Solr port: 8080
Solr path (for site1): /solr/site1
```
	
  * Configure your search index.


