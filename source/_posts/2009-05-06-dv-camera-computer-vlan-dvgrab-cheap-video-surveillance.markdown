---
date: '2009-05-06 13:21:04'
layout: post
slug: dv-camera-computer-vlan-dvgrab-cheap-video-surveillance
status: publish
title: dv camera + computer + vlan + dvgrab = cheap video surveillance
wordpress_id: '586'
categories:
- Down Time
- monitoring
- Security
---

In the day and age of high definition many are upgrading their video recording gear to the latest harddrive or flash based hi def video cameras. Unlike auto dealerships consumer electronics retailers don't offer trade in options for your old stuff.  In the green / renewable mindset we can put these no longer used video cameras to good use as video surveillance devices perfect for keeping an eye on your own or others property.




On the hardware side you need a [DV camera](http://linuxsysadminblog.com/?attachment_id=596) with firewire port (IEEE 1394), firewire port equipped Pentium 4 or equivalent pc or laptop with loaded with Fedora 9 or 10 and a  firewire cable to connect camera to the computer. For software we will only need [dvgrab](http://freshmeat.net/projects/dvgrab/) and [VLC](http://www.videolan.org)




Install dvgrab from Fedora update repo:  

`yum install dvgrab`




Install vlc from rpmfusion repo:  

`sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm  

sudo yum install vlc`




Set DV camera audio to 16bit (default is 12 bit) to avoid garbled audio.




[![audio16bit](http://linuxsysadminblog.com/wp-content/uploads/2009/05/audio16bit.jpg)](http://linuxsysadminblog.com/2009/05/dv-camera-computer-vlan-dvgrab-cheap-video-surveillance/audio16bit/)




Turn on and connect video camera to computer and you should see something like this in /var/log/dmesg:  

`firewire_core: created device fw1: GUID 0800460102721e20, S100`




To test that we are able to grab video/audio from camera and display in VLC player pipe output of dvgrab into vlc.




`sudo dvgrab - -noavc -nostop | vlc - --no-sub-autodetect-file :demux=rawdv`  

After issuing this command you should see a 720x480 video feed with 16bit 48000Hz audio stream in vlc on your desktop




[![vlcwindow1](http://linuxsysadminblog.com/wp-content/uploads/2009/05/vlcwindow1.png)](http://linuxsysadminblog.com/2009/05/dv-camera-computer-vlan-dvgrab-cheap-video-surveillance/vlcwindow1/)




Now we setup vlc as a streaming server so that we can view the video/audio when away. Streaming a 720x480 video stream is a bit overkill as the video quality on the DV camera is pretty good when vlc streams video at lower resolutions like 320x240, I also reduce the audio quality to save on bandwidth. Here I used "cvlc" or command vlc to avoid opening a vlc window and "&" to put process into background.




`sudo dvgrab - -noavc -nostop | cvlc - --no-sub-autodetect-file :demux=rawdv --sout '#transcode{vcodec=mp4v,vb=600,acodec=mp3,ab=56,scale=1,width=320,height=240,channels=2}:duplicate{dst=std{access=http,mux=ts,dst=192.168.1.102:3323}}' & `




To view the feed locally via vlc open a http network location on ip and port you specified in the `dst=` section of the command above.




[![vlcopen](http://linuxsysadminblog.com/wp-content/uploads/2009/05/vlcopen.png)](http://linuxsysadminblog.com/2009/05/dv-camera-computer-vlan-dvgrab-cheap-video-surveillance/vlcopen/)




To view your feed from the Internet you will need to either configure vlc to stream on an outside interface or configure port forwarding.




[![ddwrt](http://linuxsysadminblog.com/wp-content/uploads/2009/05/ddwrt.png)](http://linuxsysadminblog.com/2009/05/dv-camera-computer-vlan-dvgrab-cheap-video-surveillance/ddwrt/)



