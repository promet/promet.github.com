---
published: true
comments: true
author: max-veprinsky
date: '2009-10-21 15:10:13'
layout: post
slug: php-5-2-9-on-rhel5-x-for-drupal-6
status: publish
title: php 5.2.9 on RHEL5.x (for Drupal 6)
wordpress_id: '907'
categories:
- drupal
- HowTo
- Installation
tags:
- drupal
- php
- rhel
---

Latest version of **PHP** available for RHEL5.x is 5.1.6 and no new RedHat releases are coming as packaging has ceased. You can get PHP 5.3 for RHEL5 from [Remi](http://blog.famillecollet.com/pages/Config-en), but it it's incompatible with latest versions of Drupal, Civicrm or many modules so we need the a 5.2X branch of PHP. This requires building php from source or using rpmbuild and source rpm. I was able to use [Koji's](http://kojipkgs.fedoraproject.org/packages/php/5.2.9/1.fc9/src/php-5.2.9-1.fc9.src.rpm) FC9 php5.2.9 src.rpm to rebuild for RHEL5 and here is how.


Install rpm-build package.
`sudo yum install rpm-build`

Create build env in your home directory (mine is called 'max'), do NOT build as root user. I used 'rpm' directory as the build location.
`mkdir -p rpm/{SOURCES,SRPMS,SPECS,BUILD,RPMS}`

Create .rpmmacros file which will identify the build location.
`echo "%_topdir /home/max/rpm" > .rpmmacros`

Download php5.2.9 rpm source file, i used FC9 version as it is closest to RHEL5.
`wget http://kojipkgs.fedoraproject.org/packages/php/5.2.9/1.fc9/src/php-5.2.9-1.fc9.src.rpm`

To rebuild php5.2.9 FC9 source RPM for RHEL5.x into binary RPM's we need to make sure build dependences have been satisfied. I created a file called "php-deps" which contains the build dependencies to be installed via YUM.
`
bzip2-devel
curl-devel
db4-devel
gmp-devel
httpd-devel
pam-devel
libstdc++-devel
openssl-devel
sqlite-devel
zlib-devel
pcre-devel
readline-devel
libtool
gcc-c++
krb5-devel
libc-client-devel
cyrus-sasl-devel
openldap-devel
mysql-devel
postgresql-devel
unixODBC-devel
libxml2-devel
net-snmp-devel
libxslt-devel
libxml2-devel
mhash-devel
ncurses-devel
libXpm-devel
libjpeg-devel
`

Install build dependencies via yum
`sudo yum install -y `cat php-deps``

Finally perform the build, this could take some time depending on speed of your machine. If everything goes well many php*.rpm files will  be created in rpm/RPMS/"arch-type"/ folder. "arch-type" is the hardware-platform of your machine which will match "uname -i" command (mine is i386)
`rpmbuild --rebuild php-5.2.9-1.fc9.src.rpm`

Now you can install the resulting RPM's manually but a better way is to create a local YUM repository.
Install createrepo application via YUM.
`sudo yum info createrepo`

Create a repository location directory and copy your newly generated php5.2.9 RPM files into it.
`sudo mkdir /opt/local-repository && cp /home/max/rpm/RPMS/i386/* /opt/local-repository`

Initialize the local repository and catalog the files copied there. (run this command anytime you add/remove files from your local repository directory)
`sudo createrepo /opt/local-repository/`

Configure your local repository with yum by creating a file in /etc/yum.repos.d called "local-repository.repo"
containing:
`[local-repository]
name=RHEL5 $releasever - Local Repo
baseurl=file:///opt/local-repository/
enabled=0
gpgcheck=0
#gpgkey=file:///path/to/you/RPM-GPG-KEY
`

Update yum to register local repository
`sudo yum update`

Update php using your new rpm files via the local repository
`sudo yum --enablerepo=local-repository update php`

Restart apache
`sudo /etc/init.d/httpd restart`

Verify PHP version
`php -v`





