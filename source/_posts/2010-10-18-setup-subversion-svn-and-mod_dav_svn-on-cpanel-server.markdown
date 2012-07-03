---
comments: true
date: '2010-10-18 06:00:06'
layout: post
author: gerold-mercadero
published: true
slug: setup-subversion-svn-and-mod_dav_svn-on-cpanel-server
status: publish
title: Setup Subversion (SVN) and mod_dav_svn on Cpanel Server
wordpress_id: '1180'
categories:
- Centos
- cpanel
- Installation
- svn
tags:
- cpanel
- dav
- subversion
- svn
---

Quick install guide for SVN with mod_dav_svn (http/https) repository access on Cpanel server running CentOs5.

**Configure Cpanel for SVN**

Recompile Apache/PHP (_WHM -> Software -> EasyApache_) and enable support for the following:

* Dav (_Among other things mod_dav can be used by DAV enabled Frontpage clients instead of FP extensions_)
* BerkeleyDB.  **Note**: BerkeleyDB support ("_--with-berkeley-db_") is not enabled by default in EasyApache so you need to add this manually to your EasyApache config using [this guide](http://docs.cpanel.net/twiki/bin/view/EasyApache3/CustomConfigureFlags) or [this one](http://community.eapps.com/showthread.php?271-Adding-subversion-support-to-Apache).

**Install Subversion and mod_dav_svn**

Install subversion using yum (_yum install subversion_) or install it from source.  At this time CentOS repo version is 1.4.x and the latest from source is 1.6.x.

**Install and enable mod_dav_svn in Cpanel**

* Install mod_dav_svn using yum (_yum install mod_dav_svn_) - version 1.4.x same as subersion above.
* Load mod_dav_svn module to Apache.  Go to _WHM -> Service Configuration -> Apache Configuration -> Include Editor -> Pre-Main Include_.   Select either "_All Versions_" or your current Apache version (ex: "_2.2.16_") from drop-down list.  Or you can edit their corresponding file directly:
	* All Versions:  _/usr/local/apache/conf/includes/pre_main_global.conf_
	* Apache 2.2.16: _/usr/local/apache/conf/includes/pre_main_2.conf_
* Add the codes below and click "_Update_" button to save config. This will restart Apache if no error on your configuration.
```
<IfModule mod_dav.c>
LoadModule dav_svn_module /usr/lib/httpd/modules/mod_dav_svn.so
LoadModule authz_svn_module /usr/lib/httpd/modules/mod_authz_svn.so
</IfModule>
```

**Create repository and add http access (ex: http://domain.com/svn)**

* Create your repository: `svnadmin create /path/to/svn/repos`
* Add the code below to your domain's custom include file.  You need to create this file based on [this guide](http://www.cpanel.net/documentation/easyapache/customdirectives.html) to preserve when you recompile Apache/PHP.
  Example file (Apache2,standard/non-ssl):  `/usr/local/apache/conf/userdata/std/2/cpanl_user/domain.com/svn.conf`
  File Contents:
```
    <Location /svn>
    #  mod dav svn support and location of svn repo files
    DAV svn
    SVNPath /path/to/svn/repos
    # authentication for security, create using htpasswd
    AuthType Basic
    AuthName "SVN Access"
    AuthUserFile /path/to/file/containing/user.pass
    Require valid-user
    # added for permissions/access
    Order allow,deny
    Allow from all
    </Location>
```
