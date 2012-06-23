---
published: true
author: gerold-mercadero
date: '2009-02-24 04:00:33'
layout: post
slug: nagios-how-to-check-if-remote-process-is-running
status: publish
title: 'Nagios:  How to check if remote process is running'
wordpress_id: '362'
categories:
- monitoring
- Nagios
tags:
- Nagios
---

We have a monitoring server running [Nagios](http://www.nagios.org/) and we needed to add checks for Nginx process on a new server.  Basically, you only need to install NRPE to monitor services, processes, disk space, load, etc on your remote machine.  Check the [NRPE docummention](http://nagios.sourceforge.net/docs/nrpe/NRPE.pdf) for complete reference and here's a quick [NRPE installation guide for Debian](http://sysbible.org/x/2008/11/10/how-to-install-nagios-nrpe-under-debian-linux/).

For my objective i only need to check if Nginx process is running and will use the check_procs.  NRPE and Nagios Plugins were installed and i can check the Nginx process locally using the following commands:


`/usr/local/nagios/libexec/check_procs -c 1:30 -C nginx`
wherein :
`-c 1:30` <-- refers to the Critical range for number of Nginx processes. If there process count is below 1 and above 30 this will send me a Critical notice.  If you wan to add a Warning level you can use "-w 1:25" - adjust the number of processes for you needs.
` -C nginx` <-- this will check for the command name (nginx)

**NOTE:** For complete reference on this check and other samples please refer to the [NagiosWiki](http://nagioswiki.org/wiki/Plugin:check_procs) page.

Below are my configurations:

NRPE(remote):  _/etc/nagios/nrpe_local.cfg_
`command[check_nginx]=/usr/local/nagios/libexec/check_procs -c 1:30 -C nginx`

Nagios(host):  _/usr/local/nagios/etc/objects/localhost.cfg_
`define service {
use                            generic-service         ; Name of service template to use
host_name                      HOST/IPADDRESS
service_description            CHECK_NGINX
check_period                   24x7
max_check_attempts             3
normal_check_interval          5
retry_check_interval           3
contact_groups                 Admins
notification_interval          480
notification_period            24x7
notification_options           w,u,c,r
check_command                  check_nrpe!check_nginx
notifications_enabled          1
}`

Nagios version is 3.0.  Nagios monitoring and remote server are running Debian Etch.
