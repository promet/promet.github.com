---
date: '2011-04-12 14:41:17'
layout: post
author: gerold-mercadero
published: true
slug: setup-sftp-only-access-redhat-based-distro
status: publish
title: Setup SFTP-Only Access (Redhat-based Distro)
wordpress_id: '1310'
categories:
- Centos
- HowTo
- Installation
- Tips and Tricks
tags:
- sftp-only
---

Setup sftp-only access on default Redhat/CentOS install.  Use built-in _sftp-server_ which is non-chrooted and easy to setup.

**Server: **Locate sftp-server binary and add to your list of valid shells on the system.

```
which sftp-server
```

Note:   This will most likely give you this: _/usr/libexec/openssh/sftp-server_

```
echo /usr/libexec/openssh/sftp-server >> /etc/shells
```

Note:  You may want to backup your /etc/shells first

**User Accounts**:  Add or modify accounts to use sftp-server.

**New User**

```
useradd -s /usr/libexec/openssh/sftp-server  sftponlyuser
```

Note:  Important parameter there is the _“-s /usr/libexec/openssh/sftp-server"_, which sets the default shell for this account.   By default you will have “_/bin/bash_”.

**Existing User:**

```
vi /etc/passwd
```

**_ _** Find the user that you want to configure for sftp only access and edit its shell.  For exampleyou will see a line “_username:x:500:500::/home/username:/bin/bash” _ change "_/bin/bash_" to "_/usr/libexec/openssh/sftp-server_" and save.  Note: _ Y_ou may want to backup your /etc/passwd file as well.
