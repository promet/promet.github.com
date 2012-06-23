---
published: true
author: marius-ducea
date: '2008-11-25 06:16:59'
layout: post
slug: upgrading-to-trac-011
status: publish
title: Upgrading to Trac 0.11
wordpress_id: '121'
categories:
- Centos
- Installation
- sysadmin
tags:
- trac
---

This article will outline the steps necessary to perform the **upgrade **from an older version of **trac **(normally 0.10 that many people are still running) to the latest stable branch **0.11** (more precisely 0.11.2 available at this time). The [TracUpgrade](http://trac.edgewall.org/wiki/0.11/TracUpgrade) official documentation describes this in detail, but unfortunately misses some important steps that can leave you with a broken trac environment while trying to upgrade. Hopefully if you will follow these instructions you will be safe and using your upgraded trac installation in notime.


### 1. Backup your existing installation


This is obvious, but many times ignored. Here are the key locations of a normal trac 0.10 installation that you will need to save:
**/usr/lib/python2.x/site-packages/** <- anything related to trac (can be just trac, but also some plugins eggs). You will normally run python2.4 meaning this will be: /usr/lib/python2.4/site-packages; If you use other versions please change accordingly.
**/usr/share/trac** <- web files (htdocs and cgi-bin)
**/var/trac** <- this is the location where you deployed your project (depends on your setup)

Just save them, in case you will need them later. I would also **disable all the plugins** you might be using in trac. Now you should remove the files from _/usr/lib/python2.x/site-packages/_ and _/usr/share/trac_ that are **related to trac**. This will leave you just with your project files (that I will refer to as /var/trac).


### 2. Install the new trac version


Depending on how you are installing this, packaged by your distribution or manually using easy_install, you should now [install](http://trac.edgewall.org/wiki/0.11/TracInstall) the new version of trac.

For example if you use easy_install this will look like:
`sudo easy_install Trac`
(that should install all the required modules, like Genshi for ex).

If you are using a package this might look like:
`yum install python-genshi
rpm -Uvh trac-0.11.2.1-1.el5.rf.noarch.rpm`
on a rpm based distro (using the [RPMforge](https://rpmrepo.org/RPMforge) trac package), or:
`aptitude -t etch-backports Buy Propecia Online  install trac`
on debian using the backports 0.11 version.


### 3. Upgrade your Trac Environment


Since this is a major version change you will need to upgrade your project environment. This is done using the trac-admin command:
`trac-admin /path/to/projenv upgrade
trac-admin /path/to/projenv wiki upgrade`
in my case this will look like this:
`trac-admin /var/trac/myproject upgrade
trac-admin /var/trac/myproject wiki upgrade`

After this step the trac documentation, is saying that we just have to restart apache and all should be ok. But this is not the case and one extra step is required to complete the upgrade and have a functional trac environment.


### 4. Deploying web files


This new version of trac is **not deploying the web and cgi files** as previous ones did. Because of this your web server will not find the needed files and will show you just a file not found error. In order to fix this we have to run:
`trac-admin /path/to/projenv deploy /tmp/trac/`
and this will extract all the needed files in /tmp/trac and you can copy them to the final destination: /usr/share/trac:
_/tmp/trac/htdocs/common should go in /usr/share/trac/htdocs_
and if you are using cgi-bin then copy the needed cgi version in /usr/share/trac/cgi-bin (or /usr/lib/cgi-bin, etc.) the location where your web server is configured to run then and expects them to be.


### 5. Reinstall plugins, etc.


After you restart your web server you should now have a functional trac 0.11 installation. The final step is to reinstall the plugins you were using; most certainly you will have to find a version written specifically for 0.11 as the old 0.10 version will not run. Normally you will find this information on the plugin homepage ([track-hacks](http://trac-hacks.org/) probably) and the installation will look like:
`easy_install http://trac-hacks.org/svn/accountmanagerplugin/trunk`

Hopefully this article will help you to upgrade safely to trac 0.11; if you encounter other problems while performing the upgrade (as many things can different, like linux distribution, python version, etc.) please check the [trac docs/tickets](http://trac.edgewall.org/) or feel free to post a comment bellow with your problem.
