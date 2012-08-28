---
layout: post
title: "Integrate Sendgrid with Redmine"
author: greg-palmier
date: 2012-08-09 17:03
comments: true
slug: integrate-redmine-with-sendgrid
tags:
- redmine
- sendgrid
categories:
- redmine
- sendgrid
published: true
---

One thing everybody wants when deploying applications is integrating them with other applications or services.  Two popular apps and services out there for small businesses that manage project management and email are Redmine and SendGrid.  


### Prerequisites

1. A working Redmine install.
2. A sendgrid email address.  Let's say we have something like redmine@yourdomain.com that we want Redmine to send emails from.
3. Here are a few gems I put on sporatically when researching email integration, so make sure you have them.  Jump to where your redmine install is located (e.g. /var/www/redmine) and do the following:

```
# gem install mail json sendgrid
```
The core of this funcionality is provided by the sendgrid gem which originates from here: [https://github.com/stephenb/sendgrid](https://github.com/stephenb/sendgrid). 

#### Redmine Configuration File

If your Redmine install is something like /var/www/redmine, your configuration file will be /var/www/redmine/config/configuration.yml.  If you have a relatively clean Redmine install, chances are you might not have one or it's a default template with a lot of examples.  You might find an example detailing how to integrate with GMail in the example file.  Our set up will be similar.  Paste the following into your configuration.yml file and change the necessary parameters.

```
production:
  delivery_method: :smtp
  smtp_settings:
    tls: true
    enable_starttls_auto: true
    address: "smtp.sendgrid.net"
    port: 587
    authentication: :plain
    domain: "yourdomain.com"
    user_name: "sendgrid_auth_name"
    password: "sendgrid_auth_password"
```
   
Now if you already had a configuration.yml file for the install you jumped into, there are overrides which show up as a blank section at the end which will prevent this integration from working. It might look like:

```
production:
```

Remove empty sections like this.  You can edit things towards the beginning of your config file all day long and these blank sections will override your settings.

### Redmine Settings

Through your web browser, go to Administration -> Settings, and click the "Email Notifications" Tab.
 
1.  Set the emission email address field to: redmine@yourdomain.com (the sendgrid account you created).
2.  Fix your footer URL to match your domain so users can go directly to their account settings.
3.  Test your settings by clicking the link "Send a test email" in the lower right hand corner.

### Troubleshooting

If you are getting auth errors, make sure you are just using your user_name parameter in the configuration.yml file (i.e. just "redmine").

If you think you can't reach the service, try this quick connection test:

```
$ telnet smtp.sendgrid.net 587
```
If successful, you'll see some response like this:

```
$ telnet smtp.sendgrid.net 587
Trying 50.97.69.147...
Connected to smtp.sendgrid.net.
Escape character is '^]'.
220 mi1 ESMTP service ready
```

