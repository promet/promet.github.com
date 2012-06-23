---
published: true
author: max-veprinsky
date: '2009-07-06 15:25:20'
layout: post
slug: install-truecrypt-on-fedora-10
status: publish
title: Install TrueCrypt on Fedora 10
wordpress_id: '786'
categories:
- desktop
- HowTo
- Installation
- Security
tags:
- Fedora 10
---

[TrueCrypt](http://www.truecrypt.org) is an open source encryption application, it has an ability to create hidden encrypted containers and file systems/volumes, it is portable and cross platform compatible. It allows to use cascading cyphers and encrypts/decrypts files on the fly. Be sure to read the [FAQ](http://www.truecrypt.org/faq) and [documentation](http://www.truecrypt.org/docs/) before fully committing your files to TrueCrypt.

- install via yum:
sudo yum install fuse fuse-devel wx_Base wx_GTK wx_GTK-devel

- download source code package:
http://www.truecrypt.org/downloads2

tar -zxvf TrueCrypt\ 6.2a\ Source.tar.gz
cd truecrypt-6.2a-source

- Download RSA Security Inc. PKCS #11 Cryptographic Token Interface files
wget ftp://ftp.rsasecurity.com/pub/pkcs/pkcs-11/v2-20/pkcs11.h
wget ftp://ftp.rsasecurity.com/pub/pkcs/pkcs-11/v2-20/pkcs11f.h
wget ftp://ftp.rsasecurity.com/pub/pkcs/pkcs-11/v2-20/pkcs11t.h

- build package
make

- copy binary to /usr/bin
cd Main
sudo chown root:root truecrypt && sudo cp truecrypt /usr/bin

- copy icon files to icon repository
cd ../Resources/Icons
sudo chown root:root * && sudo cp * /usr/share/icons

One last order of business is to setup your sudoers file to so that TrueCrypt does not complain about requiring tty for sudo command needed to mount encrypted volumes. There are 2 ways of doing that:
1. The less secure way -- disable requiretty globally by adding an exclamation mark in front of requretty,
`# Defaults specification
#
# Disable "ssh hostname sudo ", because it will show the password in clear.
#         You have to run "ssh -t hostname sudo ".
#
Defaults    !requiretty`

2. The more secure way especially for multi-user environments -- create user alias called WHEELUSERS, assign users to this user alias:
`## User Aliases
## These aren't often necessary, as you can use regular groups
## (ie, from files, LDAP, NIS, etc) in this file - just use %groupname
## rather than USERALIAS
# User_Alias ADMINS = jsmith, mikem
User_Alias      WHEELUSERS = max`

-- Create a defaults entry for user alias disabling requiretty.
`
# Defaults specification
#
# Disable "ssh hostname sudo ", because it will show the password in clear.
#         You have to run "ssh -t hostname sudo ".
#
Defaults    requiretty
# added for truecrypt requiretty complaint
Defaults:WHEELUSERS     !requiretty`

Video below is a walk through of creating a TrueCrypt desktop short-cut and creation of encrypted container.


