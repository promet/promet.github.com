---
published: true
comments: true
author: max-veprinsky
date: '2009-05-27 19:25:06'
layout: post
slug: nginx-rewrite-to-index
status: publish
title: nginx rewrite to index
wordpress_id: '704'
categories:
- hosting
tags:
- nginx
- rewrite
---

Looking to rewrite all file requests to index?

```
location / {
root /var/www/nginx-default;
index index.html;
if (!-e $request_filename) {
rewrite . /index.html last;
}
}
```
