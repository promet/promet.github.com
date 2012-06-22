---
author: max-veprinsky
date: '2008-07-07 07:04:42'
layout: post
slug: apache-wont-start-with-error-965
status: publish
title: 'Apache won''t start due to error #965'
wordpress_id: '30'
categories:
- hosting
tags:
- apace
---

**Issue: Apache does not start, gives the following error
**

    
    965 File size limit exceeded$HTTPD -DSSL


Cause: Apache Log or Domain Log file exceeded 2GB
Solution: Rotate offending log file by tar/gzip'ing
