---
date: '2009-04-23 04:22:31'
layout: post
slug: monitoring-drupal-sites-with-nagios
status: publish
title: Monitoring Drupal Sites With Nagios
wordpress_id: '549'
categories:
- Centos
- drupal
- Installation
- monitoring
- Nagios
---

There is a [**module**](http://drupal.org/project/nagios) released for monitoring [Drupal](http://drupal.org/) sites with [Nagios](http://www.nagios.org/).  Monitoring includes the check if your site is up and running, check for new updates on Drupal core, security, and modules, database updates, write permission on "files" directory,  check if cron is running on the specified period, and other sections of your Drupal site.  It is intended and helpful to those maintain large number of Drupal sites.

At this time of writing, this module is still on a development version and there's no guarantee that the installation guide will work out-of-the-box with your system.  And this post will mainly cover my own installation process on our Nagios monitoring server running on Debian and Nagios version 3.0, and Drupal version 6.x sites on web servers running CentOS 5.x.

**Installation**:
My installation is based on the included README file and with some adjustments to my liking.

**Install the Drupal Module:**



	
  * Download the Nagios module from [Drupal project page](http://drupal.org/project/nagios).

	
  * Install the module to your Drupal site just like the other modules.  Download tarball, extract to modules directory ex: **_sites/all/modules/_**, go to **_admin->build->modules_** and enable the module.

	
  * Configure your Nagios module and set the site's UniqueID and Cron duration.

**UniqueID** is your site identifier to be used by the Nagios (_check_drupal_) to authorize the service check and for security purposes.  The author also suggests the use of MD5 or SHA1 string. Refer to README for more info on this parameter.

**Cron Duration** - you need to supply the interval of your cron job that checks for Drupal updates.  This value should match with your cron settings, ex: daily or every 3 hours..etc.


**Configure Nagios checks:**



	
  * Copy the plugin file (**_check_drupal_**) found on the **_nagios-plugin_** directory of the module, to your Nagios plugins directory where the other Nagios check commands are located - in my case it's on **_/usr/local/nagios/libexec/_** (CentOS).

If your Nagios installation is on a different machine than your Drupal server, you need to copy the _**check_drupal**_ file in there.  You can also put it on the same server with Drupal sites and use NRPE instead.

On my CentOS machine i received an error on **_check_drupal_** regarding the location of _**basename**_ file - it's on _**/bin/basename**_.  You can edit the _**check_drupal**_ file directly to adjust the path to _**basename**_.
`./check_drupal: line 14: /usr/bin/basename: No such file or directory.`

	
  * **Add command, host, hostgroup, and service definition:**

**Command **(commands.cfg):  I made small modification on the given commands from the README file to match my setup.
`define command{
command_name  check_drupal
command_line  $USER1$/check_drupal -H $ARG1$ -U $ARG2$ -t $ARG3$
}
`
**HostGroup**:  I created a new Host group because we have other service checks on our server such as SSH, HTTP, LOAD, etc and I want to separate my checks for Drupal sites.
`define hostgroup {
hostgroup_name  Drupal
alias           Drupal Sites
members         MyWebServer
}
`
**Host:** I defined new host for Drupal sites so i can configure and group my them on the same host where they belong.
`define host {
host_name                      MyWebServer
display_name                   MyWebServer
address                        HOSTNAME/IP ADDRESS HERE
hostgroups                     Drupal
check_command                  check-host-alive
contact_groups                 Admins
check_period                   24x7
max_check_attempts             10
notification_interval          480
notification_period            24x7
notification_options           d,r
notifications_enabled          1
}
`
**Service:** Below is my service checks definition for checking Drupal sites, i only need to copy this and change supply parameters for domain, unique key and the timeout.
` define service {
service_description            DRUPAL_SITE 1
host_name                      MyWebServer
check_period                   24x7
max_check_attempts             3
normal_check_interval          5
retry_check_interval           3
contact_groups                 Admins
notification_interval          480
notification_period            24x7
notification_options           w,u,c,r
check_command                  check_drupal!mysite.example.com!mykeyhere!5
notifications_enabled          1
}
`


If your installation and configuration is correct you will get the Nagios service status similar below.  It indicates number of modules, themes, users, nodes, etc.

`DRUPAL OK, ADMIN:OK, CRON:OK
SAN=0;SAU=0;NOD=12;USR=7;MOD=23;THM=9`

On my initial tests i received Nagios status (below) different than the above info and it was caused by my Apache configuration because i have a default Nagios installation before on my server that hosts my Drupal sites.

`HTTP returned an error code. HTTP:   HTTP/1.1 301 Moved Permanently`
So you need to check first the url of your Nagios module installation ex:  http://mysamplesite.com/nagios/, this will give you:

`Nagios status page
nagios=UNKNOWN, DRUPAL:UNKNOWN=Unauthorized`
