---
published: true
comments: true
author: marius-ducea
date: '2009-08-25 06:05:25'
layout: post
slug: using-wildcards-in-nginx-valid_referers
status: publish
title: Using wildcards in nginx valid_referers
wordpress_id: '833'
categories:
- HowTo
- sysadmin
- Tips and Tricks
tags:
- nginx
- tips
---

This quick post will show how we can easily allow only certain http referrers see some location using [**nginx**](http://nginx.net/). This might be useful for example if you are using nginx as a static content provider and want to not allow everyone hot-linking your images and only your own sites. Doing something like this in nginx is very simple and we could start with a configuration like this (from _nginx.conf_):

    
    <code>location /images {
    	valid_referers   none  blocked  server_names  mydomain.com www.mydomain.com;
    	if ($invalid_referer) {
    		return   403;
    	}
    	... else serve the content
    }</code>


This works fine in this simple case; but what if we need to list more sub-domains? like images.mydomain.com an static.mydomain.com, etc? It would be nice to be able to use a regexp for this, right? Fortunately nginx has support for this and this can be done using a valid_referers line like:
`valid_referers   none  blocked  server_names  ~(mydomain.com)`

And this will match all the subdomains *.mydomain.com. Going even further you might want to allow google as a referrer for you content. Still google has so many subdomains and even different domains (like google.com, google.de, etc.) For this we could add ~(google.) and have our final configuration look like this:

    
    <code>location /images {
    	valid_referers   none  blocked  server_names  ~(mydomain.com|google.);
    	if ($invalid_referer) {
    		return   403;
    	}
    	... else serve the content
    }</code>


This simple example shows how powerful the configuration of nginx is and how easy it is to do things that are rather impossible with other similar softwares.
