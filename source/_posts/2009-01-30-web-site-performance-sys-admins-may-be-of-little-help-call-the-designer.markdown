---
published: true
author: andrew-kucharski
date: '2009-01-30 01:08:24'
layout: post
slug: web-site-performance-sys-admins-may-be-of-little-help-call-the-designer
status: publish
title: Web site slow?  To improve performance - Sys Admins may be of little help -
  call the designer
wordpress_id: '286'
categories:
- Performance
---

Here are two videos by Steve Souders, former chief performance Yahoo, currently at Google.  He determined that 95% of the wait on loading the Yahoo page is after the initial apache response is sent to the browser.  Doing more research he determined that this is about a 80/20 rule on most popular web sites.  It has enlightened me as to where to look to determine why web sites are slow. 

Although this video has been around for a while, its a must for system admins who bang their heads at trying to squeeze performance  out of the 10 to 20 percent of the user wait time they are responsible for.  

Steve's Performance golden rule:

**80% to 90% of the end-user response time is spent on the front end.  Start there.**

Here is the older Yahoo video 



[Steve Souders: "High Performance Web Sites: 14 Rules for Faster Pages"](http://video.yahoo.com/watch/1040890/3880720) @ [Yahoo! Video](http://video.yahoo.com)


;

Followed by the more recent Google talk



Check out Yslow firefox plug in as well as the [IBM Page Detailer](http://www.alphaworks.ibm.com/tech/pagedetailer) - its the product he uses to map out the front end work of the browser.  Great tools to start thinking about why your website is slow or why pages are loading slow.
