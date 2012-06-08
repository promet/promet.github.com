---
date: '2009-01-23 19:57:37'
layout: post
slug: nginx-proxy-loadbalacing
status: publish
title: nginx proxy loadbalacing
wordpress_id: '238'
categories:
- Installation
---

One of many uses of [NGINX](http://wiki.codemongers.com/Main) is http/https proxy load balancing. This guide is Debian specific so your milage with other flavors may vary. In this example we always redirect http to https.

The main nginx configation file is /etc/nginx/nginx.conf and below is a sample configuration file:





    
    <code>user www-data;
    worker_processes 5;
    
    error_log /var/log/nginx/error.log;
    pid /var/run/nginx.pid;
    
    events {
    worker_connections 1024;
    }
    
    http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    access_log /var/log/nginx/access.log;
    
    sendfile on;
    #tcp_nopush on;
    
    #keepalive_timeout 0;
    keepalive_timeout 65;
    tcp_nodelay on;
    
    #gzip on;
    
    upstream lb2 {
    server 10.0.0.10; #webserver10
    server 10.0.0.20; #webserver20
    }
    
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
    }</code>



To add a site:

**Prepare SSL**

1. Create a .pem file which contains the certificate, certificate signing request and private key in the following format(certificate request section optional):

Example: mysite.com.pem
`
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQC5EAGorvRHq1MfWliXCpsVotv9wNTblylHKb3FjJJm/BvVtXaB
KhcfFU8vJDVVFs890oKwSiemGyu1I9E/AzDWl53mhep4J+BJRODg2ehVgB4paR4t
79klgFr8ewjHYEMOh+5L6y5nx5t5CDRXY2khkKOaVAP1IXT0mvJ6vyhvmwIDAQAB
AoGALxNKSL2QeDa1o1EZHfrdrmhKK8eEngNaxbZxhrIWf8n7zqYlaf/p98c06Fn+
kxGFUEWfZvbGFTPuL1rYHH5USqLTMEw4eevft4ouxekymTMQktR1arurjQ3F8cxC
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE REQUEST-----
MIICJTCCAY4CAQAwgbYxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlh
MRAwDgYDVQQHEwdDYW1wYmVsMRowGAYDVQQKExFBbWVyaWNhbiBXaXJlbGVzczEl
MCMGA1UECxMcY295b3RlLnByb21ldGhvc3RjaGljYWdvLmNvbTEaMBgGA1UEAxMR
d3d3LmxlbnBob25lcy5jb20xITAfBgkqhkiG9w0BCQEWEmRuc0Bwcm9tZXRob3N0
LmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAuRABqK70R6tTH1pYlwqb
-----END CERTIFICATE REQUEST-----
-----BEGIN CERTIFICATE-----
MIIDPDCCAqWgAwIBAgIDCnu5MA0GCSqGSIb3DQEBBQUAME4xCzAJBgNVBAYTAlVT
MRAwDgYDVQQKEwdFcXVpZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3VyZSBDZXJ0
aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDkwMTE2MTMyNDU4WhcNMTEwMTE3MTMyNDU4
WjCBxjELMAkGA1UEBhMCVVMxGjAYBgNVBAoTEXd3dy5sZW5waG9uZXMuY29tMRMw
EQYDVQQLEwpHVDk5MDc4NTE5MTEwLwYDVQQLEyhTZWUgd3d3Lmdlb3RydXN0LmNv
bS9yZXNvdXJjZXMvY3BzIChjKTA5MTcwNQYDVQQLEy5Eb21haW4gQ29udHJvbCBW
YWxpZGF0ZWQgLSBRdWlja1NTTCBQcmVtaXVtKFIpMRowGAYDVQQDExF3d3cubGVu
-----END CERTIFICATE-----
`

2. Copy .pem file to /etc/nginx/ssl directory with 600 (-rw-------) permissions and owned by user/group root

**Create site configuration file**

1 . Site configuration file goes in /etc/nginx/site-available/ directory with the name of the site's URL.


    
    <code>server {
    listen 192.168.1.1:80;
    server_name www.mysite.com mysite.com;
    access_log /var/log/nginx/access_http.log;
    rewrite ^/(.*) https://www.mysite.com/$1 permanent;
    }
    
    #HTTPS
    server {
    listen 192.168.1.1:443;
    server_name www.mysite.com mysite.com;
    access_log /var/log/nginx/access.log;
    
    ssl on;
    ssl_certificate /etc/nginx/ssl/mysite.com.pem;
    ssl_certificate_key /etc/nginx/ssl/mysite.com.pem;
    ssl_session_timeout 5m;
    
    location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
    
    proxy_pass http://lb2/;
    proxy_redirect off;
    }
    }
    </code>



2. Place a symbolic link to configuration file in /etc/nginx/sites-enabled:

ln -s /etc/nginx/sites-available/mysite.com /etc/nginx/sites-enabled/mysite.com

3. Reload nginx configuration

/etc/init.d/nginx reload

4. Check if nginx process has started and is listening on configured IP:

netstat -alnp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 192.168.1.1:80        0.0.0.0:*               LISTEN     9593/nginx
tcp        0      0 192.168.1.1:443       0.0.0.0:*               LISTEN     9593/nginx



