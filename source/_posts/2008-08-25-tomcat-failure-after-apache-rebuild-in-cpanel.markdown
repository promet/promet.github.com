---
date: '2008-08-25 03:33:08'
layout: post
slug: tomcat-failure-after-apache-rebuild-in-cpanel
status: publish
title: Tomcat failure after Apache rebuild in CPanel
wordpress_id: '48'
categories:
- cpanel
tags:
- apache
- cpanel
- easyapache
- tomcat
- whm
---

After **rebuilding Apache** in CPanel using **easyapache **or **WHM **there are many things that can go wrong even if you use a stable branch of CPanel. For example _Tomcat that was installed from CPanel can fail_ after the build and even if this might look unrelated to the apache build this can happen quite frequently.

If you are running **tomcat **on a cpanel server here is what you can do to help you from losing your tomcat instance:



	
  * **backup**; newer cpanel versions backup apache, configs, etc. but they will _not care about tomcat_. This means it is your job to save the tomcat files. Here are some important folders you should save:**
/usr/local/jdk** - this is a link to the real jdk used on the system (jdk1.5.0_05 or jdk1.6.0_02 for ex.)**; **save the real jdk also, just in case...
** /usr/local/jakarta/tomcat **- this will contain all your tomcat configs, apps, logs, etc.**
/usr/sbin/starttomcat** and **/usr/sbin/stoptomcat** - scripts used to start and stop tomcat (in case you made local changes, memory tunings, etc.)


The files above can be lost during the rebuild, and it is important to have them on hand to restore tomcat if it fails starting after the apache build. For example last time this happened for us we had to fix the /usr/local/jdk link to point to the proper jdk (we use 1.5 and cpanel changed the link to 1.6) and also the startup scripts that contained various local customizations were obviously overwritten :( .

Hopefully this information will be useful for other people, and hopefully you will see it before running easyapache :-) .
