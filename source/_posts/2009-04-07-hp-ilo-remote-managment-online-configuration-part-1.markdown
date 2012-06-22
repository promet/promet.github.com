---
author: max-veprinsky
date: '2009-04-07 16:54:28'
layout: post
slug: hp-ilo-remote-managment-online-configuration-part-1
status: publish
title: HP ILO remote managment online configuration PART 1
wordpress_id: '510'
categories:
- Installation
- monitoring
- sysadmin
tags:
- hp
- ilo
- remote managment
---

Many mainstream oem server iron manufacturers (dell, supermicro, sun, ibm) offer remote management options. HP's variant is called iLO or **Integrated Lights Out **and is standard on 3oo/500/Blade line of servers. Newer generation (G5 and up) servers come with iLO 2 which offers hardware video acceleration and network encryption.  Normally iLO is setup before booting the server as ip address/user assignments need to accommodated. This can be done remotely as well with minimal pain. This guide assumes the server is HP dl360 G5 running rhel5 /centos 5 64 and you have root access to the server.  This guide would apply to other HP servers that support [iLO](http://h18000.www1.hp.com/products/servers/management/ilo/) / [iLO2](http://h18013.www1.hp.com/products/servers/management/iloadv2/index.html).

1. [Download](http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1121486&prodNameId=3288144&swEnvOID=4004&swLang=8&mode=2&taskId=135&swItem=MTX-4142b198b9cb475f99658a7caf) and install latest (8.2.0-236) iLO kernel module.

`rpm -ivh hp-ilo-8.2.0-236.rhel5.x86_64.rpm
service hp-ilo start`

check that the module loaded properly

`[root@server ~]$ lsmod
Module                  Size  Used by
hpilo                  43280  0`

2. [Download](http://ftp.hp.com/pub/softlib2/software1/sc-linux-fw-ilo/p1285463034/v51280/CP010302.scexe) and install latest (1.70 B) iLO firmware.

`[root@server ~]$ sh CP010302.scexe`

`FLASH_iLO2 v1.10 for Linux (Jan 12 2009)
Copyright 2009 Hewlett-Packard Development Company, L.P.
Firmware image: ilo2_170.bin
Current iLO 2 firmware version  1.29; Serial number ILOUSM1234567
`
`Component XML file: CP010302.xml
CP010302.xml reports firmware version 1.70
This operation will update the firmware on the
iLO 2 in this server with version 1.70.
Continue (y/N)?y
Current firmware is 1.29 (Feb 28 2007 17:09:41)
Firmware image is 0x270000 bytes
Committing to flash part...
******** DO NOT INTERRUPT! ********
Flashing completed!
Attempting to reset device.
Succeeded.`

3. [Download](http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1121486&prodNameId=3288144&swEnvOID=4004&swLang=8&mode=2&taskId=135&swItem=MTX-5292ccda1fef4040b1f14cf85d) and install latest (8.2.0-285) hp-OpenIPMI device driver.

`rpm -ivh 8.2.0-285.rhel5.x86_64.rpm`

4. [Download](http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1121486&prodNameId=3288144&swEnvOID=4004&swLang=8&mode=2&taskId=135&swItem=MTX-9994deee7e854c48934baeb2e5) and install latest (1.9.0-3) HP Lights-Out Online Configuration utility.

`rpm -ivh hponcfg-1.9.0-3.noarch.rpm`

5. **Optional** [Download](http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1121486&prodNameId=3288144&swEnvOID=4004&swLang=8&mode=2&taskId=135&swItem=MTX-6843fb2d2e524c9690b30b6c30) latest (2.10) SmartStart Scripting Toolkit to your pc.

The hponcfg utility allows configuration of iLO embedded server. All configuration is passed to iLO in XML format. Refer to SmartStart Scripting Toolkit for command reference.

In part 2 a sample configuration file will be prepared to provide access to iLO from outside even if the management port is not connected to the network.
