---
date: '2010-07-09 19:49:17'
layout: post
author: gerold-mercadero
published: true
slug: debian-ftp-archive-for-etch-archive-debian-org
status: publish
title: Debian FTP archive for Etch - archive.debian.org
wordpress_id: '1110'
categories:
- Debian
tags:
- Debian
---

**Debian Etch** has been discontinued for a while now, and in an ideal world everyone has upgraded to **lenny** a long time ago. Still, this is not always possible and there are some systems out there that are still running etch, some for a good reason, some just because their admins are lazy ;) . Recently we worked on a project with such a system that was still running etch, and the devs on the team told us  that all is working perfect but they are no longer able to install new packages using apt tools. Hmm... let's see.

And indeed running apt update was giving a  **404 error**, as the etch files are no longer in the main ftp archive (on ftp.debian.org):

`apt-get update
Ign http://ftp.debian.org etch Release.gpg
Ign http://ftp.debian.org etch Release
Ign http://ftp.debian.org etch/main Packages
Ign http://ftp.debian.org etch/non-free Packages
Ign http://ftp.debian.org etch/contrib Packages
Err http://ftp.debian.org etch/main Packages
404 Not Found [IP: 130.89.149.226 80]
Err http://ftp.debian.org etch/non-free Packages
404 Not Found [IP: 130.89.149.226 80]
Err http://ftp.debian.org etch/contrib Packages
404 Not Found [IP: 130.89.149.226 80]
Fetched 4B in 1s (3B/s)
Reading package lists... Done
W: Couldn't stat source package list http://ftp.debian.org etch/main Packages (/var/lib/apt/lists/ftp.debian.org_debian_dists_etch_main_binary-i386_Packages) - stat (2 No such file or directory)
W: Couldn't stat source package list http://ftp.debian.org etch/non-free Packages (/var/lib/apt/lists/ftp.debian.org_debian_dists_etch_non-free_binary-i386_Packages) - stat (2 No such file or directory)
W: Couldn't stat source package list http://ftp.debian.org etch/contrib Packages (/var/lib/apt/lists/ftp.debian.org_debian_dists_etch_contrib_binary-i386_Packages) - stat (2 No such file or directory)
W: You may want to run apt-get update to correct these problems`

and the apt sources line causing this error was (from **/etc/apt/sources.list**):
`deb http://ftp.debian.org/debian/ etch main non-free contrib`

We could not upgrade the machine because of internal constrains, and this was not even the scope of our project, but we needed to install some new debian packages we had to point the apt sources to a new place and this is to the **archive.debian.org** that continues (and will continue) to have the etch files. Basically our new apt sources became:
`deb http://archive.debian.org/debian/ etch main non-free contrib`
and this made it possible to complete our project and install the needed libraries. A few weeks after we finished the project we were hired for a new project to perform the upgrade to lenny, but this is a different storry.

I hope you found this post useful, in case for some reason you are _still running etch and need to find a proper etch mirror to install new softwares as needed_. Of course I would urge you to upgrade to lenny, or even to squeeze if possible, as etch is no longer supported, you have no longer security patches, etc.
