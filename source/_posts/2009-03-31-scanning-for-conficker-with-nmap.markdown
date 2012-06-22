---
author: max-veprinsky
date: '2009-03-31 00:31:23'
layout: post
slug: scanning-for-conficker-with-nmap
status: publish
title: Scanning for Conficker with Nmap
wordpress_id: '477'
categories:
- Installation
---

While [Conficker](https://www.honeynet.org/files/KYE-Conficker.pdf) is not a new worm it has been getting much press lately. Even though [Redmond](http://www.microsoft.com) released a [patch](http://www.microsoft.com/technet/security/Bulletin/MS08-067.mspx) late October it is estimated that 5 to 10 million PC have been infected. The industry has been aware of this worm for some time and has mounted a fairly impressive counter attack. Microsoft issued a 250K dollar bounty for developers of Conficker, major anti-virus vendors have added definitions for detection and removal of the worm, OpenDNS introduces a feature that aid sysadmins in detecting infected machines and today with the help of [HoneyNet Project](http://honeynet.org) security researches discovered Conficker's fingerprint which makes it possible for tool such as Nmap, Nessus to detect the worm remotely.  This discovery come just in time as the latest variant of the worm "Conficker C" is programmed to lay dormant unlike the previous generations where identification of the worm was possible by monitoring outbound traffic.

Why just in time you may ask? Well because the worm is said to become active on April 1st. It is unknown if all infected PC will be used for bad deeds. I'm sure no one needs a reminder of the SQL Slammer worm of 2003/2004 where 5 of the 11 root DNS servers went down, ATM's where knocked offline due to massive DDOS attacks. I understand the symbolism of April 1st being April fools day, but as the doctor always says: It's far easier to prevent then to treat.

Using the [latest development version of Nmap](http://download.insecure.org/nmap-dist/nmap-4.85BETA4-1.i386.rpm) one would run a command to scan systems for Conficker signature.
`nmap -PN -T4 -p139,445 -n -v --script=smb-check-vulns --script-args safe=1 [targetnetworks]`

Or by updating your [Nessus](http://www.nessus.org) server's plugins `nessus-update-plugins` create and run a scan that includes [plugin id #36036](http://www.nessus.org/plugins/index.php?view=single&id=36036) (if you don't pay for Nessus Professional feed you will have to wait 7 days to receive the plugin)

Be mindful that Conficker can also spread via [sneakernet](http://en.wikipedia.org/wiki/Sneakernet), configuring your anti-virus client to scan all attached/removable extenal memory storage devices is always a great idea.
