---
date: '2009-04-21 21:26:41'
layout: post
slug: hawaii-comes-to-our-datecenter
status: publish
title: Hawaii comes to our datecenter.
wordpress_id: '538'
categories:
- hosting
- monitoring
---

Aside from missing coconut trees and hula girls distinguishing our data center from Hawaii was pretty tough this afternoon. It was HOT, so hot in fact that I was sweating while sitting in just a cotton tee-shirt. I kept drifting away into a daydream where that failed 20 ton Liebert A/C unit was running. Soon however reality set in... the a/c wasn't running, our 42U cabinet packed with 35U worth of server, switch and router gear was overheating and a slave Mysql database server wasn't having this all this heat! The poor thing turned itself off  and after 5 hour cool down time I still get error: 1610 Temperature violation detected

[![1610 temparature violation](http://linuxsysadminblog.com/wp-content/uploads/2009/04/toohot.jpg)](http://linuxsysadminblog.com/wp-content/uploads/2009/04/toohot.jpg)



While promises of having the A/C unit up and running soon were being thrown at me I wasn't biting. Shutting down 3 non-essential servers did help things a bit.  The database servers with their 15K rpm disks were running their internal fans at nearly 100% coping with the heat. At this point I was starting to feel a little bit upbeat picturing what would happen if the servers were not servers and just consumer grade PC's turned into servers. If you are reading this you must know what burned power supplies smell like! At some point I knew the A/C unit would be fixed and I would be able to re-power up the non-essential servers. Monitoring temperatures inside the cabinet would be nice, but we don't have such a [useful device](http://www.pcmeasure.com/sensors.php). Next best thing was internal temperature sensors inside a direct attach storage array which has 6 sensors: 4 in the front and 2 in back. [Cacti](http://www.cacti.net/) proved invaluable as I could monitor what was going on and most importantly see if the datacenter made good on their promise. Each raise in temperature indicates a period when the A/C was not working or working poorly.

[caption id="attachment_543" align="alignnone" width="628" caption="temp_graph"][![temp_graph](http://linuxsysadminblog.com/wp-content/uploads/2009/04/array_temps.png)](http://linuxsysadminblog.com/2009/04/hawaii-comes-to-our-datecenter/array_temps/)[/caption] 
