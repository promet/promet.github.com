---
published: true
comments: true
author: gerold-mercadero
date: '2009-03-09 23:55:43'
layout: post
slug: htaccessmod_rewrite-force-url-to-use-sslhttps
status: publish
title: Force url to use SSL/https
wordpress_id: '405'
categories:
- hosting
tags:
- htaccess
---

In some cases you would want to have your site use SSL (https://) at all times you can do this by using:

**1.)  Using Htaccess/mod_rewrite. **You only need to create a _.htaccess_ file on your home directory and add the codes below:
```
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{HTTPS} !=on
RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]
</IfModule>
```

The above codes may not work on other Apache/php setup but i'm not sure what's the exact configuration variable for that.  

Anyway, here are my alternatives.  Either of them is fine if you're running http and https on standard ports (http=80, https=443), otherwise change the value to your custom http or https port.  Change _domain.com_ to your domain.
```
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{SERVER_PORT} ^**80**$
RewriteRule ^(.*)$ https://**domain.tld**/$1 [R,L]
</IfModule>

<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{SERVER_PORT} !^443$
RewriteRule ^(.*)$ https://**domain.tld**/$1 [L,R]
</IfModule>
```

**2.) PHP function. **If your site use PHP you can redirect the url to SSL/https using this function:
```
<?php
function ForceHTTPS(){
if( $_SERVER['HTTPS'] != ``"on")   {
//if( $_SERVER['SERVER_PORT'] == 80 )   {  _**<<-- use this line if the above will not work.**_``
$new_url = "https://" . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI'];
header(``"``Location: $new_url``"``);
exit; }
}
?>
```

If you are using an application/script wherein you can enter the settings for site url (either from database or config file), it is better to use that settings.

Let me know if you run into issues, maybe i can help.  :)
