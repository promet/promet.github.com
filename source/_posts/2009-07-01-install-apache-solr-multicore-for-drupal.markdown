---
author: gerold-mercadero
date: '2009-07-01 10:14:11'
layout: post
slug: install-apache-solr-multicore-for-drupal
status: publish
title: Install Apache Solr Multicore for Drupal
wordpress_id: '770'
categories:
- drupal
- HowTo
- Installation
tags:
- apachesolr
- drupal
- solr
---

Yesterday I received new installation request from developers to install ApacheSolr module for Drupal.  Check this **[link](http://drupal.org/project/apachesolr)** for more details on Apache Solr Search Integration.  Since this is new to me I spent some time on searching and doing test installations.  To make it short below is my setup on our shared hosting server running CentOS with Cpanel.

Type: Multi-core  (for possible use on other Drupal sites)
Java Servlet Container: Jetty (built-in on Solr)
Drupal version: 6
Java: 1.6

I based this guide plainly from this [Drupal  page](http://drupal.org/node/484800), and I made this summary for my own future reference.

**Process:**

**You need to have the Java installed first.**

**1)  ApacheSolr Drupal Module**

**1.1)** [**Download**](http://drupal.org/project/apachesolr) and install ApacheSolr module to your site/s. Traditional download, extract, and enable method.
**1.2)** [**Download**](http://code.google.com/p/solr-php-client/) SolrPHPClient (PHP library) and extract the the files inside of your ApacheSolr Drupal module.
Example: `sites/all/modules/apachesolr/SolrPhpClient`

**2) Solr:**

**2.1)** Select a directory where you want to put your Solr files as long as it is not accessible to the web.
Example: `/home/solr`
**2.2)** [**Download**](http://people.apache.org/builds/lucene/solr/nightly/) nightly build of Solr and extract to your selected directory.
Example: `/home/solr/apache-solr-nightly`
**2.3)** Copy _example_ directory to another directory like _drupal_.
Example:
`cp -r /home/solr/apache-solr-nightly/example /home/solr/apache-solr-nightly/drupal`
**2.4)** Copy _schema.xml_ and _solrconfig.xml_ files from your ApacheSolr Drupal module.
`cp /path_to_site/sites/all/modules/apachesolr/schema.xml /home/solr/apache-solr-nightly/drupal/schema.xml
cp /path_to_site/sites/all/modules/apachesolr/solrconfig.xml /home/solr/apache-solr-nightly/drupal/solrconfig.xml`
**2.5)** Copy "`/home/solr/apache-solr-nightly/drupal/multicore/solr.xml`" to "`/home/solr/apache-solr-nightly/drupal/solr/solr.xml`"
**2.6)** Create directory for each site that will use the ApacheSolr inside "`/home/solr/apache-solr-nightly/drupal/solr`" and copy
`/home/solr/apache-solr-nightly/drupal/conf` to each of them.
Example:
`mkdir /home/solr/apache-solr-nightly/drupal/solr/site_drupalsite1
cp -r /home/solr/apache-solr-nightly/drupal/conf /home/solr/apache-solr-nightly/drupal/solr/site_drupalsite1/
mkdir /home/solr/apache-solr-nightly/drupal/solr/site_drupalsite2
cp -r /home/solr/apache-solr-nightly/drupal/conf /home/solr/apache-solr-nightly/drupal/solr/site_drupalsite2/`
**2.7)** Edit `/home/solr/apache-solr-nightly/drupal/solr.xml` and add the details/path of your site/s.
Example:
`<cores adminPath="/admin/cores">
<core name="drupalsite1" instanceDir="site_drupalsite1" />
<core name="drupalsite2" instanceDir="site_drupalsite2" />
</cores>`
**2.8)** Start the Jetty servlet container.
`cd /home/solr/apache-solr-nightly/drupal/
java -jar start.jar`
**2.9) **Finally, visit _Drupal Admin_ settings for ApacheSolr module to set the correct Solr path.  
Example:
`Drupal Site1:  /solr/drupalsite1
Drupal Site2:  /solr/drupalsite2`

That's it - we now have our complete ApacheSolr search integration.  Check the ApacheSolr documentation for more details on using this module.

Solr server is started manually and to make it running on start up or if you want to be able to start/stop/restart the server, please refer to this **[blog post](http://19thstreetdesign.com/blog/2009.02.04/installing-apache-solr-drupal-6)**.

To add new sites (new sites with ApacheSolr module) just repeat steps 1 and 2.6 - 2.9, and restart the Solr server.
