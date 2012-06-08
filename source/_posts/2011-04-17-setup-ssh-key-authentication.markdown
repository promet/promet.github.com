---
date: '2011-04-17 15:46:41'
layout: post
author: gerold-mercadero
published: true
slug: setup-ssh-key-authentication
status: publish
title: Setup SSH Key Authentication
wordpress_id: '1317'
categories:
- Centos
- HowTo
- Tips and Tricks
tags:
- key authentication
- password-less
- ssh
---

Setup ssh key authentication for password-less login between servers.  For use by ssh/sftp users or scripts.

**Source Server **(or local system)

Generate RSA key for user on this system, you can also use DSA.  This asks for key pass-phrase but you can leave it blank.

```
ssh-keygen -t rsa
```

This asks for location to place the generated key, by default it will be your home directory (_ex: /home/your_username/.ssh/_).  This generates two files:  _id_rsa_ and _id_rsa.pub_.  Content of _id_rsa.pub _is what we need to copy to destination server.

**Destination Server **(or remote server)

Check if you have the directory _.ssh_ on your home (_ex: /home/username/.ssh/_), if not, create that directory.

```
ls  ~/.ssh
mkdir  ~/.ssh
```
Check if you have existing file _authorized_keys _on your _.ssh_ directory, if not create it.

```
ls  ~/.ssh/ authorized_keys
touch   ~/.ssh/ authorized_keys
```

Copy content of _id_rsa.pub _that you created_ _from your source/local server, or execute this command from your **source/local server**:

```
scp  ~/.ssh/id_rsa.pub username@remote_host:~/.ssh/authorized_keys
```

Test your password-less login from source to destination server.
