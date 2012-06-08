---
date: '2012-06-05 06:23:23'
layout: post
author: gerold-mercadero
published: true
slug: gitolite-add-edit-or-delete-git-repository-name
status: publish
title: 'Gitolite: Add, Edit, or Delete Git Repository Name'
wordpress_id: '1400'
categories:
- HowTo
tags:
- git
- gitolite
---

I can't find commands in gitolite to manage repository or project name, so here's what I got from other sources.

**Add or create repository**



	
  * Add entry for new project or repository in your gitolite config (_conf/gitolite.conf_)

	
  * Commit and push your changes. this will create and initialize your new repo.


**Rename a repository**



	
  * Modify the name of repo in your gitolite config (_conf/gitolite.conf_)

	
  * Move or rename the actual directory (depending on where you install it, ex: _/home/git/repositories_) to match your changes in gitolite config.

	
  * Commit and push your changes.


**Note**: Obviously, this changes the remote url of your repo, so don't forget to change your git remote url config in your project clones.

**Delete a repository**:



	
  * Open your gitolite config and remove the project from there. commit and push your changes.

	
  * Then delete its git directory (ex: /home/git/repositories/projectname.git)

	
  * You can also remove users/keys that are no longer used


