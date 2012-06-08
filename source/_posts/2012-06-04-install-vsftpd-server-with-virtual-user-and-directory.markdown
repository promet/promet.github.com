---
date: '2012-06-04 09:15:33'
layout: post
author: gerold-mercadero
published: true
slug: install-vsftpd-server-with-virtual-user-and-directory
status: publish
title: Install vsftpd Server With Virtual User and Directory
wordpress_id: '1372'
categories:
- Debian
- HowTo
- Installation
tags:
- vsftpd
---

Here's a summary for [vsftpd](http://vsftpd.beasts.org) setup with virtual user and directory in Debian.  It's probably the same process on other Debian-based distros as well as Redhat-based distros. No need to define what's vsftpd and what's virtual users - let's just proceed to the setup. :)

Install VSFTPD:

`aptitude install vsftpd`

Choose what method to use for virtual user authentication.  Let's use pam passwd module (libpam-pwdfile), I guess this is the most common and easy to setup.  You can also use libpam-mysql if you want to manage your ftp users via mysql database, like if you want integrate it with your application that's using mysql as backend.

`aptitude install libpam-pwdfile`

Next create your password file (example: _/etc/vsftpd_users.conf_) which contain the list of virtual users and password hash.  You can use [htpasswd](http://httpd.apache.org/docs/2.0/programs/htpasswd.html) that's included in Apache or go to this website, [htaccesstools.com](http://www.htaccesstools.com/htpasswd-generator/) to generate the list of users and passwords.

Once you have the list of users (example: _demo1_ and _demo2_), you have to create their virtual directory as well, let's say I want to set ftp users home directory inside _/home/ftpusers_.  This will be their home directory and they can't see or navigate outside of their home dir. Make sure they're writable as well.

`mkdir /home/ftpusers /home/ftpusers/demo1 /home/ftpusers/demo2`

Then update your vsftpd config (_/etc/vsftpd.conf_) and make sure you have the configs below enabled. Please take note that some of these configs might me enabled by default.  Also, you might want to read the detailed description on _/etc/vsftpd.conf_ file about the configurations that you want to enable/disable, example: allow local system users to connect to ftp, disable anonymous ftp access, welcome message, and so on.

`listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
virtual_use_local_privs=YES
guest_enable=YES
user_sub_token=$USER
local_root=/home/vsftpd/$USER
`
Finally update the pam config (/etc/pam.d/vsftpd) with the lines below and remote or comment out existing lines in there.

`auth    required pam_pwdfile.so pwdfile /etc/vsftpd_users.conf
account required pam_permit.so
`
Restart vsftpd and connect to your ftp server:

`/etc/init.d/vsftpd restart`
