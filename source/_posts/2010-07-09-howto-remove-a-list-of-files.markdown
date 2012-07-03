---
comments: true
date: '2010-07-09 16:33:28'
layout: post
author: marius-ducea
published: true
slug: howto-remove-a-list-of-files
status: publish
title: HowTo remove a list of files
wordpress_id: '1116'
categories:
- CLI
- HowTo
- sysadmin
- Tips and Tricks
tags:
- bash
- tips
---

Here is a quick tip on how to remove a list of files. Let's say you have the list of files inside a file called **files_to_remove**. Usually I would do something like this:
    LIST=\`cat files_to_remove\`
and then
    ls -al $LIST
just to check what is in the list and if it looks good.

And finally:
    rm -vf $LIST
