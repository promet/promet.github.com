---
author: gerold-mercadero
date: '2009-01-14 05:48:39'
layout: post
slug: compile-mplayermencoder-with-xvid-and-h264-codec-support
status: publish
title: Compile Mplayer/Mencoder with Xvid and H264 codec support
wordpress_id: '208'
categories:
- Installation
---

Default Mplayer installation autodetects Xvid, H264 and other codecs.  So if you have Xvid and H264 codecs installed your mencoder and mplayer should support it, unless you disable them during compilation.  In order to have your Mencoder and Mplayer support Xvid and H264 you need to install them first and then compile/re-compile Mencoder/Mplayer.




**Install [Xvid](http://www.xvid.org/). **Xvid is a free software MPEG-4 ASP compliant video codec.






  * download the latest release from [Xvid.org](http://www.xvid.org/Downloads.43.0.html), during this time of post the latest stable release is 1.2.1.  

_wget http://downloads.xvid.org/downloads/xvidcore-1.2.1.tar.gz_


  * Unpack tarball file:  

_tar xzpf xvidcore-1.2.1.tar.gz_


  * Go to build/generic folder:  

_cd xvidcore-1.2.1/build/generic/_



  * Build and install  

_./configure  

make  

make install_




**Note**:  At this point you can recompile your Mplayer/Mencoder to have Xvid support - in case you don't want to have H264 support.




**Install [H264](http://developers.videolan.org/x264.html)**.  H264/x264 is a library for creating H.264 video. MPlayer sources are updated whenever an x264 API change occurs, so it is always suggested to use MPlayer from Subversion.  At this time of post x264 in on development release only.




Using [GIT](http://git-scm.com) - download [1.6.1](http://www.kernel.org/pub/software/scm/git/git-1.6.1.tar.gz).






  * Get the latest x264 source using git:  

_git clone git://git.videolan.org/x264.git_


  * Build and install:  

_cd x264  

./configure  

make  

make install_




If you don't have GIT and don't want to install it, you can use the daily snapshot.






  * Download the latest snapshot(tarball) [here](ftp://ftp.videolan.org/pub/videolan/x264/snapshots/):  

_wget ftp://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20090113-2245.tar.bz2_


  * Extract tarball  

_bzip2 -cd x264-snapshot-20090113-2245.tar.bz2 | tar xvf -  

cd x264-snapshot-20090113-2245_


  * Build and install  

_./configure  

make  

make install_




**Compile/Re-compile Mplayer**:




You can use the latest release version of [Mplayer](http://www3.mplayerhq.hu/MPlayer/releases/) for Xvid only but there are issues during build on x264, as it is not updated.  It's better to re-compile Mplayer from their SVN.






  * Checkout the latest version:  

_svn checkout svn://svn.mplayerhq.hu/mplayer/trunk mplayer_


  * Build and install:  

_cd mplayer  

./configure  

make  

make install_




**NOTE:** This install process was tested on Centos 5.2.



