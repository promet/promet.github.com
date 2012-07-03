---
published: true
comments: true
author: marius-ducea
date: '2009-08-17 04:25:05'
layout: post
slug: using-svnssh-with-a-non-standard-ssh-port
status: publish
title: Using svn+ssh with a non-standard ssh port
wordpress_id: '829'
categories:
- CLI
- HowTo
- sysadmin
- Tips and Tricks
tags:
- ssh
- subversion
- svn
---

Many people use [**subversion**](http://subversion.tigris.org/) over ssh for a simple and secure way to work on remotely hosted svn repositories. This is normally as simple as running:
`svn co svn+ssh://user@server/repo .`

If the remote ssh server is **not running on the default ssh port** (tcp 22) then this needs a little tweaking to get it working. Normally I was expecting that adding a custom entry for the svn server in the _/etc/ssh/ssh_config_ file with the appropriate port would make this work on the fly without changing the command line; or if not, adding the ssh port in 'telnet like' way: _server:port_ would make a difference. Still none of those worked and in order to get this working I had to dig into the subversion documentation on how we can define a special tunnel.

We can define a new tunnel in the svn configuration file (**.subversion/config**):
`[tunnels]
sshtunnel = ssh -p <port>`

And after this we can use svn as usual but with a url like **svn+sshtunnel://** :
`svn co svn+sshtunnel://user@server/repo .`
