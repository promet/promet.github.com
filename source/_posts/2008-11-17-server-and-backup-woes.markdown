---
author: pim-van-der-wal
published: true
date: '2008-11-17 08:31:58'
layout: post
slug: server-and-backup-woes
status: publish
title: Server and backup woes
wordpress_id: '101'
categories:
- cpanel
- Down Time
- hosting
- monitoring
- MySQL
- sysadmin
tags:
- backup
- cpanel
- reboot
- repository
- rm
- server
- undelete
---

Looking back it seems like most posts on this blog are helpful tips and not reports of problems we encountered. Not that we don't have any problems but we mostly report our solutions instead of the actual problems. Of course now and again a problem comes along that doesn't have a solution ready to copy-paste into a blog post. A week ago a wrong modification in a shell script resulted in the deletion of a good number of files before we caught it. The command below ended up being run with 2 empty variables:

`rm -fr ${DIR}/${SUBDIR}`

_Hint: add the following alias for all users to prevent this: alias rm='rm --preserve-root''_

We were lucky in two ways. First off, this was not a production server, just a development and testing server and secondly the databases and web sites on that server were unaffected. That's where the good news ended and Murphy's Law kicked in. A couple of days before we found that our backup server had a corrupt filesystem on its RAID array. Since we did not have enough space available on other servers to place all the backups on other servers we temporarily suspended (you guessed it) the backups of the development and testing server.




### To undelete or not to undelete


To get back up and running we immediately closed off access to the server and considered how we could recover the deleted files. Unfortunately undeleting files on an ext3 file system can only be done under certain circumstances. If the deleted files are still opened by some process the lsof utility can help as is documented on some web sites (just Google "ext3 undelete lsof") but for larger scale undeletes the first step is to create an image of the partition in question. That image can then be searched for inode entries which can be very useful for finding specific files. However, if you want perform a more general undelete this method is a lot less useful because the file names will not be recovered.

Apart from the limited usefulness that creating this image would yield it would have taken several hours to complete during which development and testing would be at a standstill. We decided not to do this and instead take our losses instead. It is important to note what data we were losing at that point. Among the missing directories were some binary directories (/usr/sbin and such) which were easily recoverable by copying them from similarly configured servers. The most important missing data was the version control repository and a custom scripts directory. All the history of changes in the repository was lost but the latest state of the code was easily restored. We copied the latest code from the developer who had last performed a complete update (which is a part of the daily development process) and put that code into the repository again. Since the versions did not match up anymore after that (all code versions were reinitialized) all developers had to retrieve the complete set of code files again and copy their latest versions over it to keep working.

Although this is definitely a loss for us the impact is limited by the fact that we keep copies of all released code. These copies were unaffected on the server in question but are also present on other servers. If need be we can go through that history to track down a change, but the comments are gone and it's not a process the developers can do themselves.


### Rebooting the server


After all this we were left with one task, rebooting that server. Since we did not know exactly what got deleted this might give us some severe problems. This was scheduled for a quiet night with several system admins present. Unfortunately our hand was forced when a change in the iptables configuration caused a kernel panic. Rebooting the server revealed several more problems, the main one being the privileges on the /tmp directory. This resulted in Apache not being able to write session info there and MySQL not being able to write temporary data either. This was quickly solved of course. Without going into too many details the final action we took was to update our Cpanel. This reinstalled many missing scripts and binaries.

I bet you're wondering why we don't use off site backups. Well, we do actually. The problem is that this involves copying many gigabytes over a limited line so we made a selection of what needed to be copied and we focused mainly on all our production servers. The main purpose of our off site backups is to recover production servers in case our data center becomes unavailable.


### Conclusions


It's been an annoying experience and it's hard to draw positive lessons from mr. Murphy's teachings but all in all it could have been a lot worse. Production was not down or affected and even testing and development impact was pretty limited. The main things on our agenda after this are to review our backup strategy for essential locations and reviewing the use of root privileges on our servers. Although we use non-root users most of the time there are tasks that are made a lot quicker by changing to root. We all know the danger of this and need to be a lot more aware of it.
