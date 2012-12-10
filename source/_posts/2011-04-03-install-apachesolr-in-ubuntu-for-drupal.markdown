---
comments: true
date: '2011-04-03 14:26:25'
layout: post
author: gerold-mercadero
published: true
slug: install-apachesolr-in-ubuntu-for-drupal
status: publish
title: Install ApacheSolr in Ubuntu for Drupal
wordpress_id: '1259'
categories:
- drupal
- HowTo
- Installation
---

I've written few Drupal ApacheSolr install guides here and this one is basically an install draft for Ubuntu.

**Environment: **  [Ubuntu 10.10](http://www.ubuntu.com/), Apache, PHP, MySQL, [Drupal 6.20](http://drupal.org)

**Things to install / setup**:   [Solr](http://apache.rediris.es/lucene/solr/), [Tomcat6](http://tomcat.apache.org/download-60.cgi), [ApacheSolr module for Drupal](http://drupal.org/project/apachesolr), and [SolrPHPClient library](http://code.google.com/p/solr-php-client/)

**1.)  Install Tomcat and setup your Tomcat admin user.**

```
aptitude install tomcat6 tomcat6-admin tomcat6-common tomcat6-user
vi /etc/tomcat6/tomcat-users.xml
	<role rolename="admin"/>
	<role rolename="manager"/>
	<user username="tomcat" password="password" roles="admin,manager"/>
/etc/init.d/tomcat6 restart
```

If all is good you will be able to access Tomcat admin at `http://hostname:8080`.  Default page will show with links to admin section, etc.

**2.)  Install Solr**

```
wget http://apache.rediris.es/lucene/solr/1.4.1/apache-solr-1.4.1.zip
```
[_check for updates_](http://apache.rediris.es/lucene/solr/)
```
unzip apache-solr-1.4.1.zip
mkdir /usr/share/tomcat6/webapps
cp apache-solr-1.4.1/dist/apache-solr-1.4.1.war /usr/share/tomcat6/webapps/solr.war
cp -r apache-solr-1.4.1/example/solr /usr/share/tomcat6/solr
vi /etc/tomcat6/Catalina/localhost/solr.xml
	<Context docBase="/usr/share/tomcat6/webapps/solr.war" debug="0" privileged="true" allowLinking="true" crossContext="true">
	<Environment name="solr/home" type="java.lang.String" value="/usr/share/tomcat6/solr" override="true" />
	</Context>
chown -R tomcat6.tomcat6 /var/lib/tomcat6
/etc/init.d/tomcat6 restart
```

You should see Solr access on your Tomcat admin/manager page (`http://hostname:8080/manager/html`).

**3.)  Connect Drupal Site to Solr (multi-core setup)**

I already have a Drupal site with ApacheSolr module installed and SolrPHPclient library.

```
cp /path/drupal_site/sites/all/modules/apachesolr/schema.xml /usr/share/tomcat6/solr/conf/schema.xml
cp /path/drupal_site/sites/all/modules/apachesolr/solrconfig.xml /usr/share/tomcat6/solr/conf/solrconfig.xml
cp apache-solr-1.4.1/example/multicore/solr.xml /usr/share/tomcat6/solr/
mkdir /usr/share/tomcat6/solr/site_sample1
cp -r /usr/share/tomcat6/solr/conf /usr/share/tomcat6/solr/site_sample1/conf
vi /usr/share/tomcat6/solr/solr.xml
	<core name="site1" instanceDir="site_sample1" />
chown -R tomcat6:root /usr/share/tomcat6/solr/
/etc/init.d/tomcat6 restart
```

Visit ApacheSolr settings of your Drupal admin and enter the configuration:
```
Solr Hostname: localhost
Solr Port: 8080
Solr Path: /solr/site1
```

**To add new site to Solr:**
```
mkdir /usr/share/tomcat6/solr/site_sample2
cp -r /usr/share/tomcat6/solr/conf /usr/share/tomcat6/solr/site_sample2/conf
vi /usr/share/tomcat6/solr/solr.xml
	<core name="site2" instanceDir="site_sample2" />
```

That's All.
