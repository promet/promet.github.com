---
published: true
author: gerold-mercadero
date: '2009-06-29 07:52:12'
layout: post
slug: my-first-amazon-ec2-setup-centos-ami
status: publish
title: My First Amazon EC2 Setup (CentOS AMI)
wordpress_id: '761'
categories:
- Centos
- cloud computing
- HowTo
- Storage
tags:
- Amazon
- aws
- Centos
- cloud
- cloud computing
- ec2
- java
---

Here's my first try working with Amazon Web Services. Covered tasks are the following:
- getting familiar with AWS, specially EC2 and S3.
- working with EC2 instance using CentOS image - search, start/stop, and do some customization of an instance
- create AMIs (private) and start instance from it.
-  S3 buckets - upload files.

I based my instructions on previous post on [**Howto Get Started With Amazon EC2 API Tools**](http://linuxsysadminblog.com/2009/06/howto-get-started-with-amazon-ec2-api-tools/), so I won't give details on some steps.  And this post will cover mainly the steps taken to complete my objectives above.

To start, I signed up for an account and enabled EC2 and S3 services, and generate X509 certificate.  Next, I selected a test server running CentOS 5.3 with Cpanel and installed _java_ (openjdk 1.6, using _yum_) as a requirement.  

Then, download [EC2 API Tools](http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88) and extract to my working directory at _/myhome/.ec2/_ and upload your private key and x509 certificates. Don't forget to follow the filename format of cert-xxx.pem and pk-xx.pem.

Export shell variables (posted on the previous post) and specify the correct private and x509 path.  Then run source /myhome/.bashrc or open new terminal to load new environment variables.

Setup EC2 keypair. At first i used the certificate from different account but i got the error below: 
`Client.AuthFailure: AWS was not able to validate the provided access credentials`
I searched for this error and one suggestion is to chmod your certificate and key files to 600 but it didn't help me.  My problem is on our account because one of my teammates changed our account password and probably generated new keys.  Anyway, this is where i signed up for a new account and proceeded without issues.

Search for the AMIs to use.  Following the steps listed on the instructions, I tried several AMI's (start/stop processes).  I observed some AMI's took longer to start compare to others but i have no idea why :).  Btw, you can also search for AMI's, and start/stop them from Amazon Management Console (EC2 Dashboard).

My next task is to create my private AMIs and here's a good video tutorial on [Customizing an existing AMI and create your own AMI from it](http://s3.amazonaws.com/awsVideos/CustomizeAnExistingAMI/wmv/Customize an Existing AMI.wmv).  From this part that I need to setup my S3 bucket or directory to store my AMI.  There's a Firefox addon called [S3Fox](https://addons.mozilla.org/en-US/firefox/addon/3247) that my friend suggested but unfortunately i can't install it on my Firefox due to some errors.  I found and tried this [BucketExplorer](http://www.bucketexplorer.com/) for creating my S3 Bucket.  Btw, this one is commercial and you can try it for 30 days.  I haven't checked for other apps.  :)

Back to creating my private AMI based on the above video, I ran into issue with ec2-bundle-vol command as it is not included on the AMI that i used, so i search for other AMIs that includes the EC2 Tools and found one from RightScale (CentOS5V1_10.img.manifest.xml).

After this i was able to complete my private AMI and start new instance from it using the above steps without any issues.

