---
published: true
comments: true
author: max-veprinsky
date: '2009-02-09 17:10:53'
layout: post
slug: upgrade-to-java-se-6-update-12-on-fedora-10
status: publish
title: 'Upgrade to Java SE 6 update 12 on Fedora 10 '
wordpress_id: '309'
categories:
- desktop
- Installation
tags:
- asdm
- fedora
- java
---

After our ASA units were updated to the latest version of ASDM my **Java** client would no longer connect to ASDM. An upgrade to the latest version of Java was in order. Since fedora yum repository does not yet offer the latest version of Java I downloaded the latest rpm variant of **JDK** from http://java.sun.com/javase/downloads/index.jsp

The install steps are:

Grand executable permission to installer file
```
chmod +x jdk-6u12-linux-i586-rpm.bin
```

Run installer file
```
./jdk-6u12-linux-i586-rpm.bin
```

Rename symbolic links pointing to old java programs
```
cd /etc/alternatives
mv java java_old
mv javaws java_old
mv keytool keytool_old
```

Create new symbolic links
```
cd /etc/alternatives
ln -s /usr/java/latest/bin/java java
ln -s /usr/java/latest/bin/javaws javaws
ln -s /usr/java/latest/bin/keytool keytool
```

Verify that new java version is installed
```
javaws
Java(TM) Web Start 1.6.0_12 
Usage: javaws [run-options] 	
 	javaws [control-options]
```
