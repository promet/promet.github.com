---
date: '2010-06-13 00:37:48'
layout: post
slug: svnadmin-cant-open-file-svndbfsfs-conf-no-such-file-or-directory
status: publish
title: 'svnadmin: can''t open file ''svn/db/fsfs.conf'': No such file or directory'
wordpress_id: '1105'
categories:
- svn
- Tips and Tricks
---

While working on setting up a _backup script for a subversion repository_ I encountred an interesting problem. I've done this before many times, on different repos, and haven't seen any issues, but in this case the backup command that is using the built-in **svnadmin hotcopy** command was failing with this error:
`svnadmin hotcopy --clean-logs /svn/repo/ /backup/repo/
svnadmin: Can't open file '/svn/repo/db/fsfs.conf': No such file or directory`

Hmm... looking at the respective path I can see that the command is not lying and that file **fsfs.conf** is indeed not present. I could find a file **fs-type** but not fsfs.conf. So my only assumption was that this is an _older_ repository created with an _older svn version_ than the one we were running currently. Checking the existing svn version I got:
`svn --version
svn, version 1.6.11 (r934486)
compiled Apr 20 2010, 00:24:22`
and the fact that this repo was very old (~2009) made my assumption sound correct. Ok, now what? Well in this situation my first thought was to use the **svnadmin upgrade** command; from the manual it looked like this is what I needed to fix this issue:

_"svnadmin help upgrade
upgrade: usage: svnadmin upgrade REPOS_PATH_

_Upgrade the repository located at REPOS_PATH to the latest supported
schema version._

_This functionality is provided as a convenience for repository
administrators who wish to make use of new Subversion functionality
without having to undertake a potentially costly full repository dump
and load operation.  As such, the upgrade performs only the minimum
amount of work needed to accomplish this while still maintaining the
integrity of the repository.  It does not guarantee the most optimized
repository state as a dump and subsequent load would."_

After I've made a manual backup archive of the repo (a simple tar.gz of the repo folder) I ran the upgrade command sure this is going to fix my issue:
`svnadmin upgrade /svn/repo/`
and after it completed, I verified that svn was still working as expected and checked for the fsfs.conf file. But that was **not created**... Hmm... Let's try the hotcopy command anyway:
`svnadmin hotcopy --clean-logs /svn/repo/ /tmp/repo/
svnadmin: Can't open file '/svn/repo/db/fsfs.conf': No such file or directory`
the exact same error.

Trying to understand what the fsfs.conf file contains I just created a new repository to see if it gets created. Indeed my v1.6.11 of svn created the file for a new repo, and after copying it to the location of my existing repository (as it was basically just an empty file) my issue was fixed and the hotcopy command started working. Here is the content of the file as created by my svn version, that I copied in the older repo to fix this problem:


    
    <code>cat fsfs.conf
    ### This file controls the configuration of the FSFS filesystem.
    
    [memcached-servers]
    ### These options name memcached servers used to cache internal FSFS
    ### data.  See http://www.danga.com/memcached/ for more information on
    ### memcached.  To use memcached with FSFS, run one or more memcached
    ### servers, and specify each of them as an option like so:
    # first-server = 127.0.0.1:11211
    # remote-memcached = mymemcached.corp.example.com:11212
    ### The option name is ignored; the value is of the form HOST:PORT.
    ### memcached servers can be shared between multiple repositories;
    ### however, if you do this, you *must* ensure that repositories have
    ### distinct UUIDs and paths, or else cached data from one repository
    ### might be used by another accidentally.  Note also that memcached has
    ### no authentication for reads or writes, so you must ensure that your
    ### memcached servers are only accessible by trusted users.
    
    [caches]
    ### When a cache-related error occurs, normally Subversion ignores it
    ### and continues, logging an error if the server is appropriately
    ### configured (and ignoring it with file:// access).  To make
    ### Subversion never ignore cache errors, uncomment this line.
    # fail-stop = true
    
    [rep-sharing]
    ### To conserve space, the filesystem can optionally avoid storing
    ### duplicate representations.  This comes at a slight cost in performace,
    ### as maintaining a database of shared representations can increase
    ### commit times.  The space savings are dependent upon the size of the
    ### repository, the number of objects it contains and the amount of
    ### duplication between them, usually a function of the branching and
    ### merging process.
    ###
    ### The following parameter enables rep-sharing in the repository.  It can
    ### be switched on and off at will, but for best space-saving results
    ### should be enabled consistently over the life of the repository.
    # enable-rep-sharing = false</code>



Hopefully this will help others seeing the same issue I was experiencing.
