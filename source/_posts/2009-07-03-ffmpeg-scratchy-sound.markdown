---
author: gerold-mercadero
date: '2009-07-03 06:39:57'
layout: post
slug: ffmpeg-scratchy-sound
status: publish
title: Ffmpeg Scratchy Sound
wordpress_id: '776'
categories:
- ffmpeg
tags:
- ffmpeg
---

It was an issue reported by our developer as she's having trouble getting the correct parameters for video conversion using ffmpeg.  The problem is the scratchy sound when the conversion is done on our server (CentOS).  So she tried it on local (Windows) using [Pazera Converter](http://www.pazera-software.com/products/flv-to-avi-converter/) and loaded the same parameters used on the server and got the desired result.

We checked the Ffmpeg versions, and on local we have SVN-r15451 while the server have SVN-r14991.  So we upgraded our Ffmpeg on the server to the latest (at this time SVN-r19313) and this solved our problem.  I'm not sure what version of ffmpeg have this fix but atleast it should be SVN-r15451 and up. :)

You can tell the difference from the sample videos (first 5 seconds) below - both were encoded using the same parameters.

Using Ffmpeg SVN-r14991:
[flashvideo file=http://staging.powerlearning21.com/carol/gee/2b.flv /]

Using Ffmpeg SVN-r15451 and SVN-r19313:
[flashvideo file=http://staging.powerlearning21.com/carol/gee/48b.flv /] 
