---
published: true
comments: true
author: gerold-mercadero
date: '2008-11-25 09:39:23'
layout: post
slug: cpanel-adding-custom-configuration-to-httpdconf
status: publish
title: 'Cpanel:  Adding custom configuration to httpd.conf'
wordpress_id: '126'
categories:
- cpanel
- Installation
tags:
- apache
- cpanel
---

Recently, Cpanel implemented their standard way of adding custom changes to virtualhost configuration to preserve custom changes after an upgrade or Apache rebuild.

Here are the two common situations of adding custom changes:

**1.)  Changes added inside a `<VirtualHost>`**

This is very simple as we only need to create a single file that will contain our changes.  But we need to understand the correct location on where to place this file so that our changes will be read properly.

There are several cases of adding these changes and below are some samples and the coresponding directory where to put them:

* One virtualhosts (either SSL or standard)

Apache1/SSL:  `/usr/local/apache/conf/userdata/ssl/1/<cpanel_user>/<domain>/<filename>.conf`
Apache1/Standard:   `/usr/local/apache/conf/userdata/std/1/<cpanel_user>/<domain>/<filename>.conf`
Apache2/SSL:   `/usr/local/apache/conf/userdata/ssl/2/<cpanel_user>/<domain>/<filename>.conf`
Apache2/SSL:   `/usr/local/apache/conf/userdata/std/2/<cpanel_user>/<domain>/<filename>.conf`

* All virtualhosts (both SSL and standard)

`Apache 1/2:   /usr/local/apache/conf/userdata/<something>.conf`

* All SSL virtualhost or all Standard virtualhost

Apache 1/2 - all SSL:  `/usr/local/apache/conf/userdata/ssl/<filename>.conf`
Apache 1/2 - all Standard:   `/usr/local/apache/conf/userdata/std/<filename>.conf`

* If you need to put the above changes on a specific Apache version you can put them this way:

Apache 1 - all SSL:   `/usr/local/apache/conf/userdata/ssl/1/<filename>.conf`
Apache 2 - all Standard:  `/usr/local/apache/conf/userdata/std/2/<filename>.conf`

The same process is followed on subdomains, like on one of my implementation i added a custom virtualhost in a subdomain to take effect on standard (http), so i put it on this directory:
`/usr/local/apache/conf/userdata/ssl/2/gerold/mysubdomain.gerold.com/custom.conf`

Take note that you also need to create the directories like *ssl*, *std*, *1*, *2*, or *mysubdomain.gerold.com*" in order to have the correct directory structure/path.

You can verify if your custom changes were added correctly using this command:
```
/scripts/verify_vhost_includes
```

**Then, update the include files**:

For changes concerning single account/user you can use this command:
```
/scripts/ensure_vhost_includes --user=<username>
```
And for all users run:
```
/scripts/ensure_vhost_includes --all-users
```

And finally, restart Apache (`/etc/init.d/httpd restart`)

**2.)  Changes added outside a `<VirtualHost>`**

Adding custom changes outside of virtualhost can be done in different ways, like creating a templates or using the include editor.
On my example, i will discuss using Include editor as i usually used this on some of our client sites.

**Cpanel have three ways to place our custom changes using Include editor, these are:**

* **Pre-Main Include** - this is placed at the top of the httpd.conf file
Location:  `/etc/httpd/conf/includes/pre_main_1.conf`
* **Pre-VirtualHost Include** - codes in this file are added before the first Vhost configuration
Location:  `/etc/httpd/conf/includes/pre_virtualhost_1.conf`
* **Post-VirtualHost Include** - codes in this file are added at the end of httpd.conf
Location:  `/etc/httpd/conf/includes/post_virtualhost_1.conf`

So to add our changes we can go to WHM:  `Main >> Service Configuration >> Apache Setup >> Include Editor`, and select where you want to place your custom changes (*pre-main, pre-vhost, or post-vhost*).
You can also edit directly the files (*pre_main_1.conf, pre_virtualhost_1.conf, post_virtualhost_1.conf*) located at `/etc/httpd/conf/includes/`.
Finally, restart Apache (`/etc/init.d/httpd restart`) for changes to take effect.

**NOTE: For complete referrence please refer to[ Cpanel Docs](http://www.cpanel.net/support/docs/ea/ea3/customdirectives.html).**
