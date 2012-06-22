---
author: max-veprinsky
date: '2009-03-10 16:13:30'
layout: post
slug: running-asdm-client-from-your-linux-desktop
status: publish
title: Running ASDM client from your Linux desktop
wordpress_id: '419'
categories:
- cisco
- desktop
tags:
- asdm
- fedora
- java
---

For those of us who use Linux as a desktop replacement for Windows would find it nice to be able to run the ASDM client natively. If you haven't upgraded your ASA/PIX to the **latest ASDM** you should do so. The steps are described [here](http://linuxsysadminblog.com/2009/01/howto-upgrade-asdm-using-cli-on-cisco-asa5500/).

Once you do upgrade your PIX/ASA to the latest version you may run into another issue where your bundled version of java not connect with ASDM. The remedy for this if you are using Fedora 10 can be [found here](http://linuxsysadminblog.com/2009/02/upgrade-to-java-se-6-update-12-on-fedora-10/).

Now assuming that you have asdm loaded and opened access to outside over port 4443 with:
`http server enable 4443
http 0.0.0.0 0.0.0.0 outside`

You can connect to your PIX/ASA over port 4443 and download the asdm.jnlp file to your pc via web browser at https://external_ip_of_asa:4443 

Once you posses the asdm.jnlp file issue `**javaws asdm.jnlp**` in terminal. Upon successful login this will create .asdm folder in your home directory with files inside, as well as a desktop shortcut. After this the asdm.jnlp is no longer needed and can be erased. 

