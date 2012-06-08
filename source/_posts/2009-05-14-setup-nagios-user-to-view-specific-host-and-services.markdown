---
date: '2009-05-14 19:29:00'
layout: post
slug: setup-nagios-user-to-view-specific-host-and-services
status: publish
title: Setup Nagios User to View Specific Host and Services
wordpress_id: '654'
categories:
- HowTo
- monitoring
- Nagios
- Tips and Tricks
tags:
- Add new tag
- monitoring
- Nagios
- nagios users
---

This guide will help you setup Nagios user to have limited access to host and service checks.  It is helpful when you want to allow your customers or clients to view and receive alerts on their servers and services, like for dedicated servers.

**Procedure:**

  **Contacts: ** Create new contact definitions for your client.
  `	define contact{
        contact_name                    customer1
        alias                           Customer One Admin
        service_notification_period     24x7
        host_notification_period        24x7
        service_notification_options    c,r
        host_notification_options       d,r
        service_notification_commands   notify-service-by-email
        host_notification_commands      notify-host-by-email
        email                           customer1@domain.tld
    }  `

  **Groups:  **Create contact groups or you can add the new contact for you existing group, depending on the checks that you want to allow.  
`	define contactgroup {
        contactgroup_name               Dedicated-Server1-Admins
        alias                           Admins for Server 1
        members                         customer1,hostingadmins
	}`

  **Hosts / Services: **  Use the new Contact Group with customers email and your main admin.  Note that i used the existing Host Groups but you create new HostGroups if you want.
`	define host {
        use                            generic-host
        host_name                      Server1
        alias                          Server1
        address                        10.0.0.2  // private or public ip
        hostgroups                     DedicateServers
        check_command                  check-host-alive
        contact_groups                 Dedicated-Server1-Admins
        check_period                   24x7
        max_check_attempts             10
        notification_interval          480
        notification_period            24x7
        notification_options           d,r
        notifications_enabled          1
	}
    define service {
        use                            generic-service
        host_name                      Server1
        service_description            HTTP
        is_volatile                    0
        check_period                   24x7
        max_check_attempts             3
        normal_check_interval          5
        retry_check_interval           3
        contact_groups                 Dedicated-Server1-Admins
        notification_interval          480
        notification_period            24x7
        notification_options           w,u,c,r
        check_command                  check_http
        notifications_enabled          1
	}`

  In my case, I created a new group and add our admin contacts and customers, then update the contact groups for hosts and services.  You can also create a new definitions for hosts, contacts, groups, and services with different names for the clients if you don't want to edit your existing definitions.
  
  **Htaccess: ** Lastly, you need to add htaccess user to your htpasswd file (htpasswd.users).  Username should match the name on your Contact.  In this sample it is customer1. ** [Update]** If you've implemented "[Digest Authentication](http://nagios.sourceforge.net/docs/3_0/cgisecurity.html)" you need to update your digest file instead of the htpasswd.
  
  Don't forget to restart you Nagios.

