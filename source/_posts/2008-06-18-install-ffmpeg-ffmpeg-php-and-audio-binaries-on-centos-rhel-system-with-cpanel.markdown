---
comments: true
date: '2008-06-18 05:08:29'
layout: post
slug: install-ffmpeg-ffmpeg-php-and-audio-binaries-on-centos-rhel-system-with-cpanel
status: publish
title: Install ffmpeg ffmpeg-php and Audio Binaries on CentOS / RHEL System with Cpanel
wordpress_id: '24'
categories:
- Installation
tags:
- ffmpeg
author: gerold-mercadero
published: true
---

FFMPEG is an open source application that allows you to convert video and audio files easily between a variety of different formats.  It supports most industry-standard codec and can convert from one file format to another quickly and easily.  This guide is intented for the installatiion of ffmpeg, ffmpeg-php, mplayer, mencoder, lame mp3 encoder, flvtool2, libVorbis, and libogg and tested on CentOS5 and RHEL3 systems with Cpanel.

**To start:**
```
cd /usr/src
```

**Download MPlayer and Codes, FlvTool2, Lame, and ffmpeg-php:**

**MPlayer codecs** ([check for latest release](http://www3.mplayerhq.hu/MPlayer/releases/codecs/)):
```
wget http://www3.mplayerhq.hu/MPlayer/releases/codecs/essential-20071007.tar.bz2
```
**MPlayer** ([check for latest release](http://www3.mplayerhq.hu/MPlayer/releases/)):
```
wget http://www4.mplayerhq.hu/MPlayer/releases/MPlayer-1.0rc2.tar.bz2
```
**FlvTool2** ([check for latest release](http://rubyforge.org/frs/?group_id=1096)):
```
wget http://rubyforge.org/frs/download.php/17497/flvtool2-1.0.6.tgz
```
**Lame MP3 Encoder** ([check for latest release](http://sourceforge.net/projects/lame/)):
```
wget http://easynews.dl.sourceforge.net/sourceforge/lame/lame-3.97.tar.gz
```
**FFMPEG-PHP** ([check for latest release](http://sourceforge.net/projects/ffmpeg-php/)):
```
wget http://nchc.dl.sourceforge.net/sourceforge/ffmpeg-php/ffmpeg-php-0.5.3.1.tbz2<
```

**Extract downloaded files:**
```
tar -zxvf flvtool2-1.0.6.tgz
tar -zxvf lame-3.97.tar.gz
bunzip2 essential-20071007.tar.bz2;  tar xvf essential-20071007.tar
bunzip2 MPlayer-1.0rc2.tar.bz2; tar xvf MPlayer-1.0rc2.tar
bunzip2 ffmpeg-php-0.5.3.1.tbz2; tar xvf ffmpeg-php-0.5.3.1.tar
```

**Create and import the Codecs directory:**
```
mkdir /usr/local/lib/codecs/
mv essential-20071007/* /usr/local/lib/codecs/
chmod -Rf 755 /usr/local/lib/codecs/
```

**Install Subversion and Ruby using Yum:**
```
yum install subversion
```
_You may need to open SVN port 3690_
```
yum install ruby
```
_If you’re on cPanel you can alternatively use `/scripts/installruby`_
```
yum install ncurses-devel
```

**Get FFMPEG and MPlayer from SVN:**
```
svn checkout svn://svn.mplayerhq.hu/ffmpeg/trunk ffmpeg
svn checkout svn://svn.mplayerhq.hu/mplayer/trunk mplayer
```

**Install LAME:**
```
cd /usr/src/lame-3.97
./configure && make && make install
```

**Install libOgg and libVorbis:**
```
yum install libogg.i386 libvorbis.i386 libvorbis-devel.i386
```

**Install flvtool2:**
```
cd /usr/src/flvtool2-1.0.6/
ruby setup.rb config
ruby setup.rb setup
ruby setup.rb install
```

**Install MPlayer:**
```
cd /usr/src/MPlayer-1.0rc2
./configure && make && make install
```

**Install ffMPEG:**
```
cd /usr/src/ffmpeg/
mkdir tmp
chmod 777 tmp
export TMPDIR=./tmp
./configure --enable-libmp3lame --enable-libvorbis --disable-mmx --enable-shared
echo '#define HAVE_LRINTF 1' >> config.h
make && make install
export TMPDIR=/tmp
```

**Finalize the codec setup:**
```
ln -s /usr/local/lib/libavformat.so.50 /usr/lib/libavformat.so.50
ln -s /usr/local/lib/libavcodec.so.51 /usr/lib/libavcodec.so.51
ln -s /usr/local/lib/libavutil.so.49 /usr/lib/libavutil.so.49
ln -s /usr/local/lib/libmp3lame.so.0 /usr/lib/libmp3lame.so.0
ln -s /usr/local/lib/libavformat.so.51 /usr/lib/libavformat.so.51
```

**You may get an error about a library path not being found, if so, run:**
```
export LD_LIBRARY_PATH=/usr/local/lib
```

**Install FFMPEG-PHP:**
```
cd /usr/src/ffmpeg-php-0.5.0/
phpize
./configure && make && make install
ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
ln -s /usr/local/bin/mplayer /usr/bin/mplayer
```

**Add extension to php.ini (find the correct php.ini file):**
```
[ffmpeg]
extension_dir=/usr/local/lib/php/extensions/no-debug-non-zts-20060613/
extension=ffmpeg.so
```

**Restart Apache and check that the module is loaded in PHP:**
```
/etc/init.d/httpd restart
```

**Test** `ffmpeg` **from command line and if you get this errors: **
```
ffmpeg: error while loading shared libraries: libavformat.so.51:...
```

**execute:** `echo "/usr/local/lib" >>/etc/ld.so.conf ` **and reload library cache with** `ldconfig -v`

**Verify ffmpeg installation:**
```
php -r 'phpinfo();' | grep ffmpeg
```

**If you get the following results then FFMPEG and all it's components are installed correctly:**
```
ffmpeg
ffmpeg support (ffmpeg-php) => enabled
ffmpeg-php version => 0.5.3.1
ffmpeg-php gd support  => enabled
ffmpeg.allow_persistent => 0 => 0
ffmpeg.show_warnings => 0 => 0
```
