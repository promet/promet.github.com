---
published: true
author: max-veprinsky
date: '2008-10-20 17:55:18'
layout: post
slug: anti-virus-software-alone-not-enough
status: publish
title: anti-virus software alone not enough
wordpress_id: '80'
categories:
- Installation
tags:
- anti-virus
- avast
- avg
- noscript
---

As a part of PCI compliance and general Internet usage safe practices a company wide anti-virus policy is not just a good idea but a must. Today a number of free and fee-based subscription anti-virus clients are available for the Windows platform which in is use by 99 percent of Promet employees. The remaining 1 percent do not use Windows as their day to day OS hence this document will not apply.

Of the 20+ anti virus client available this day I will review the free AVG and Avast! clients  with which I have spent some time testing and working with. Neither clients introduced any sluggishness to the system and are fairly transparent in day to day operation. The test rig is an average consumer grade PC with 1 GB of system memory, Pentium 4 2.66Ghz, 80GB disk running Windows XP with Service Pack 2.









Functionality / protection






	
  * 


AVG Basic: file 	scanning, spyware, POP/IMAP




	
  * 


Avast! Personal:  file scanning, POP/IMAP, webmail, IM, P2P, network










Scan speed (measuring initial filesystem scan of 23.8GB)






	
  * 


AVG Basic: 1H 57M




	
  * 


Avast! Personal: 33M










Resident memory usage






	
  * 


AVG Basic: 50MB




	
  * 


Avast! Personal: 60MB






Next we will look at virus detection performance of these 2 clients as well as other more popular variants.

Detection rates against Windows viruses, macros, worms, scripts, backdoors, trojans and other malware:


	
  * 


AVG: 98.3 %




	
  * 


Kaspersky: 97.8




	
  * 


Avast!: 97.2




	
  * 


Symantec:  96.9%




	
  * 


McAfee: 93.6 %










Detection rates against high polymorphic viruses (32/Bakaver.A, W32/Etap.D,W32/Insane.A, W32/Stepan.E, W32/Tuareg.H, W32/Zelly.A, W32/Zmist.B  and W32/Zmist.D. )






	
  * 


AVG: 81.1%




	
  * 


Kaspersky: 100%




	
  * 


Avast!: 89.1%




	
  * 


Symantec: 100%




	
  * 


McAfee: 99.7%






Source: http://www.av-comparatives.org/seiten/ergebnisse/report17.pdf

No single anti-virus product offers complete protection against Internet threats. A combination of anti-virus and web browser embedded object blocker can provide fairly comprehensive solution. Unlike the past where nearly all virus infection occurred via e-mail attachments which contained malicious executable files, macros embedded into MS Office documents or even non-executable files containing virus payloads today a user can become easily infected by visiting a website. Unknown to the user a embedded javascript applets, flash containers can infect a system simply by loading them via web browser. Most often these embedded objects do not have a place on the screen or are called from hidden frames. In this situation  anti-virus software would not stop such objects from loading therefore a need for an embedded script blocker is required. The best and easiest to use plug in is available for the Mozilla Firefox (and browsers based on it) called NoScript. This add-on default behaviour is to block all browser embedded items letting the user decide which to allow.



Examples:

[http://www.symantec.com/security_response/writeup.jsp?docid=2003-090514-4048-99](http://www.symantec.com/security_response/writeup.jsp?docid=2003-090514-4048-99)
[http://www.symantec.com/security_response/writeup.jsp?docid=2002-011011-3021-99](http://www.symantec.com/security_response/writeup.jsp?docid=2002-011011-3021-99) 
[http://www.viruslist.com/en/viruses/encyclopedia?virusid=25834](http://www.viruslist.com/en/viruses/encyclopedia?virusid=25834)

Avast! Personal offers more features, faster scanning speeds, better detection rates. Combining Avast! Personal with a browser script blocker such as NoScript offers a more comprehensive virus prevention/detection solution.

[http://www.avg.com/](http://www.avg.com/)
[http://www.avast.com/](http://www.avast.com/)

