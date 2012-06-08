---
date: '2009-07-29 03:43:51'
layout: post
slug: task-on-amazon-ebs-on-centos-ami
status: publish
title: Task on Amazon EBS on CentOS AMI
wordpress_id: '813'
categories:
- Centos
- cloud computing
- HowTo
tags:
- Amazon
- aws
- ebs
- ec2
---

This is my second activity on using AWS - this time the use of [EBS](http://aws.amazon.com/ebs/).

**Objectives:**



	
  1. Format a new EBS (10GB) and mount it on a running instance of private AMI (created on first activity - add link/ref to old post)

	
  2. Setup a MySQL server with the datastore on EBS partition

	
  3. Setup the partition(EBS) to start at boot time of AMI


Here, I will elaborate the steps (mostly commands) and some issues that I encountered along the way.  I also included the script (below) that i used for attaching the EBS to AMI at boot time. Reference [here](http://developer.amazonwebservices.com/connect/entry.jspa?externalID=1663).  I will add an indicator on where i am running my commands, either on controling machine or on instance.  On variables or values i assumed that you already know how to get them, the ec2-describe-instances/volume..etc.  If the ec2 commands is not available on your system make sure you have the [ec2 api tools](http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88) or have your environment variables configured.
**Objective #1: Format EBS and mount on a running instance**



	
  * Run instance of private ami and take note of the zone (default is us-east-1a - not sure :))
`controlling machine$:  ec2-run-instances -z us-east-1a --key YOURKEYPAIR ami-xxxxx`

	
  * Create ebs volume with 10GB size.  Note the use of same zone so the volume can be attached to the instance above.  Check the EBS docs for more details on Zones.
`controlling machine$:  ec2-create-volume -z us-east-1a -s 10`

	
  * Attach the zone to your instance, ex: as /dev/sdh
`controlling machine$:  ec2-attach-volume -d /dev/sdh -i i-IIII1111 vol-VVVV1111`

	
  * Login to your instance and format your ebs drive on /dev/sdh. It's your choice on what filesystem to use.  For my activity, i used xfs as i was advised that it is easier/faster to increase/shrink xfs filesystem compared to ext3 - and on the above reference xfs as used.
controlling machine$:  ssh -i ssh_key root@ec2.xxxxx.amazonaws.com
(host may not be on this format, just refer to the details on your instance)
`instance$: yum install xfsprogs
instance$: modprobe xfs
instance$: mkfs.xfs /dev/sdh`

	
  * Mount the ebs volume.
instance$: mount -t xfs /dev/sdh /ebs


**Objective #2: Setup a MySQL server with the datastore on EBS partition**



	
  * Install mysql on your running instance, edit /etc/my.cnf and set the value for datadir to /ebs (my example), and start your MySQL.
`instance$: yum install mysql-server
instance$: vi /etc/my.cnf
instance$: /etc/init.d/mysqld start`

	
  * Create a sample database to test
`instance$: mysql
mysql> create database ebstest;
mysql> quit
instance$:  ls /ebs/`


**Objective #3: Setup the partition(EBS) to start at boot time of AMI**



	
  * I was advised here to create an init script that will attach the ebs volume to my running instance and i was given a sample script (for debian) that i modified to my need (for CentOS) and added some stuff.  I encountered several issues here as my init script failed to start correctly, like my environment variable is not available or incorrect paths etc.  And was able to bundle four or five times. :)  In short the script (below) does the automation, i only need to add this on my start up - so for the process, please check or continue reading the notes/comments on the script below.  Btw, I just added the section to start MySQL inside the init script, but of course you can separate them.

	
  * After creating a init script with the correct variables/filenames, bundle or create new AMI.  Commands below are summary from a video tutorial - i forgot the link :)  Run help for each command to get details on the options used, ex: 'ec2-bundle-vol -h'.
`instance$: cd /mnt
instance$: mkdir ami
instance$: ec2-bundle-vol -d /mnt/ami -k /root/.ec2/pk.xxx.pem -c /root/.ec2/cert.xxx.pem -u xxxx-xxxx-xxxx
instance$: ec2-upload-bundle -b bucket1 -m /mnt/ami/image.manifest.xml -a XXXXXX -s xxxXXXXx
controlling machine$: ec2-register bucket1/image.manifest.xml`

	
  * Test your new AMI - run new instance and check if your ebs volume is attached - goodluck!


**Init Script Here: [ mountebs](http://linuxsysadminblog.com/wp-content/uploads/2009/07/mountebs)**
