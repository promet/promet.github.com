---
author: max-veprinsky
date: '2008-07-29 09:11:15'
layout: post
slug: virtual-desktop-in-gnome-222-fedora-core-9
status: publish
title: Virtual desktop in Gnome 2.22 / Fedora Core 9
wordpress_id: '34'
categories:
- desktop
tags:
- display
- fc9
- gnome
- virtual
- xorg
---

Trying to figure out how to put your second monitor and dual port graphics card to good use in FC9? How about creating a virtual desktop that will span the second monitor. Resist the urge to edit xorg.conf and think about the layout or position the second monitor will take. I like to have my 1600x1200 display right of the 1280x960 laptop display.

Since I want the virtual desktop to span both screens horizontally I need to specify a virtual screen of 2880x1200. I derived at this number by adding the the pixel length of both displays together (1280+1600) and the pixel height of the biggest monitor (1200).

In xorg.conf I added "Virtual 2880 1200" in the Section "Screen"

Section "Screen"
Identifier "Screen0"
Device     "Videocard0"
DefaultDepth     24
SubSection "Display"
Viewport   0 0
Depth     24
Virtual   2880 1200
EndSubSection

Now restart Xorg by pressing Ctrl-Alt-Backspace and run gnome-display-properties to adjust the position of the screen (left of right) and set the proper resolution. Be sure to uncheck "Mirror Screen"
