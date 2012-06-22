---
author: max-veprinsky
date: '2009-07-22 12:44:44'
layout: post
slug: enabling-allow_url_include-locally-in-cpanel
status: publish
title: enabling allow_url_include locally in cPanel
wordpress_id: '803'
categories:
- cpanel
- hosting
- sysadmin
tags:
- include
- php
---

When using cPanel the way to enable allow_url_include directive locally (per user) is to create an **Virtual Host include**:

First create an include file:
`/usr/local/apache/conf/userdata/std/2/username/domain.com/custom.conf`

Add directive to custom.conf:
`
php_admin_flag allow_url_include On
`

Then run to enable include:
`/scripts/ensure_vhost_includes --user=username --verbose`

Alternatively, enabling allow_url_include globally (server-wide) is done by editing /usr/local/lib/php.ini and adding  "allow_url_include = On" directive to the Fopen wrapper section.
`;;;;;;;;;;;;;;;;;;                                                                                                                                           
; Fopen wrappers ;                                                                                                                                           
;;;;;;;;;;;;;;;;;;`                                                                                                                                           

`;Whether to allow the treatment of URLs (like http:// or ftp://) as files.                                                                                  
allow_url_fopen = On
**allow_url_include = On**`

and restarting apache by issuing "service httpd restart" command as root.


