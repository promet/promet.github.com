---
date: '2009-01-06 07:59:42'
layout: post
slug: flvtool2-not-injecting-metadata-video-length
status: publish
title: FLVTool2 not injecting metadata (video length)
wordpress_id: '195'
categories:
- Installation
---

Okay, I'll make this short, we have several servers with Ffmpeg and later we found out that one of them is having problem on video conversion as it does not add the video length to the output file.  This issue was caused by older version of Flvtool2, version 1.0.5 RC6 and below.  So I upgraded my installation to latest release which is 1.0.6 final (this is the latest version at the time of this post).

You can check for the latest release at [RubyForge](http://rubyforge.org/frs/?group_id=1096).

Upgrade process is easy, same as the installation process, and if you need help visit our detailed guide on **"[Installing ffmpeg and its components](http://linuxsysadminblog.com/2008/06/install-ffmpeg-ffmpeg-php-and-audio-binaries-on-centos-rhel-system-with-cpanel/)"** and look for Flvtool2 section.

If you're still having problem after Flvtool2 upgrade check your Ruby installation as you may need to update it as well.  If you're on a Cpanel server you can use Cpanel's Ruby install script at "_/scripts/installruby_".
