---
published: true
author: gerold-mercadero
date: '2009-11-24 01:08:23'
layout: post
slug: apache-now-supports-multiple-ssl-on-single-ip-address
status: publish
title: Apache Now Supports Multiple SSL on Single IP Address
wordpress_id: '999'
categories:
- hosting
- News
tags:
- apache
- ssl
---

With the release of Apache 2.2.12, we can now configure multiple SSL sites in one IP address.  It is available of you have Server Name Indication (SNI) extension for OpenSSL.  Visit TechRepublic's post on "[Configure Apache to support multiple SSL sites on a single IP address](http://blogs.techrepublic.com.com/opensource/?p=987)" for details and vhost sample configuration.  And for complete reference please refer to this page "[SSL with Virtual Hosts Using SNI](http://wiki.apache.org/httpd/NameBasedSSLVHostsWithSNI)" and [Apache mod_ssl documentation](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html#sslstrictsnivhostcheck).

We'll try this on our server and hopefully offer this to our shared hosting clients who wants SSL but not interested in paying extra for a dedicated ip address.  :)


