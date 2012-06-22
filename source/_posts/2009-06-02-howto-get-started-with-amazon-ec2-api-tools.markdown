---
author: marius-ducea
date: '2009-06-02 09:57:46'
layout: post
slug: howto-get-started-with-amazon-ec2-api-tools
status: publish
title: 'HowTo: Get started with Amazon EC2 api tools'
wordpress_id: '722'
categories:
- CLI
- cloud computing
- HowTo
- sysadmin
tags:
- Amazon
- api
- aws
- ec2
---

This article is meant to be a quick quide that will introduce the things needed to **get you started with Amazon EC2**. All this information can be found in the EC2 api docs, and this is not meant to be a replacement of the documentation, just trying to show the things needed in a clear and short form.


### Getting Started


First of all you will need one [**Amazon AWS**](http://aws.amazon.com/) **account **and enable the **EC2 service**; in case you don't have this already now is the time to [create](http://www.amazon.com/gp/aws/registration/registration-form.html) your account. Once you do that you can safely return to this doc ;-)

Once you have your account working, while still on the aws site, go and create a new **X.509 certificate** (under the AWS Access Identifiers page, in the X.509 certificate section near the bottom, click Create New). Once this is done, you will want to _download locally the private key file and X.509 certificate_.


### EC2 API tools


Next you will have to [download](http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88) and install the Amazon EC2 api tools on one system (controlling machine) that will be used to start your EC2 army of servers, and control their usage. You will want to use the latest version (2009-05-15 at this time) as it will support all the features Amazon is offering for the EC2 service.

The only real dependency of the EC2 API tools is **java **(at least version 1.5) so we will want to install that first. If you are running debian you can easily do this just by running (for lenny):
`aptitude install sun-java6-jre`
while for etch you will have to use: _aptitude install sun-java5-jre_
For other distributions you can either use their internal packaging mechanism (in case they provide sun-java packages) or just download the binary from sun and install it manually.

**Extract **the EC2 APi tools (it is a zip archive called **ec2-api-tools.zip**) and move it under a folder of your preferece. I like to use **~/.ec2** for this, but you can use any folder you prefer. Also copy the **private key** and **X.509 certificate** in the same directory. Those files will look like _cert-xxx.pem_ and _pk-xxx.pem_.

Next we will have to **export some shell variables**. A good place to put this is in ~/.bashrc:
`export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=$EC2_HOME/pk-xxx.pem
export EC2_CERT=$EC2_HOME/cert-xxx.pem
#Java home for debian default install path:
export JAVA_HOME=/usr
#add ec2 tools to default path
export PATH=~/.ec2/bin:$PATH`

Finally source the file to have the changes active in your current shell session:
`source ~/.bashrc`
or just open a new shell before starting to use the API tools.


### EC2 Keypair


We will need to create one **keypair **that will be used to connect using **ssh** to the EC2 instances we will be using. We will use the **ec2-add-keypair** utility to create the key and register it with amazon:
`ec2-add-keypair my-keypair`
This will print out the private key that we will have to save in a file:
`cat > ~/.ec2/id_rsa-my-keypair
#paste the private key content
sudo chmod 600 ``~/.ec2/id_rsa-my-keypair`


### Running your first EC2 instance


Amazon EC2 uses the concept of **AMIs **= Amazon Machine Images. Any EC2 instance is started from one AMI. You can either use standard, public AMIs or create and customize your own private images. Creating or modifying existing AMIs is beyond the scope of this article, but just as a general information this is done using special AMI tools. Also before building your AMI you will want to ensure if you want to use a 'small' type of image (i386 os) or a 'large' type of instance (64bit os). These are described under[ http://aws.amazon.com/ec2/instance-types/](http://aws.amazon.com/ec2/instance-types/)

For the scope of our article we will find a standard public image and start one instance of it to see that all is working properly with the EC2 api tools. You can see all the public images using:
`ec2-describe-images -a`
(over 2,300 images ;) ). You should probably grep the result to get any useful information. There are many good public images to use, like for example the [alestic](http://alestic.com/) ones (for debian and ubuntu)
Having the AMI id of the image we want to use we are ready to start our fist EC2 instance:
`ec2-run-instances ami-e348af8a -k my-keypair`
that will start a small instance with a 32bit debian lenny server instance from alestic.com.

`ec2-describe-instances`
- this will describe the status of all the running instances, with their hostname, instance id, etc.

`ec2-authorize default -p 22`
- in order to connect to your instance you will need to customize the 'default' firewall rules for your account. The above rule will allow ssh on port 22 from anywhere. If you want to open http traffic you will have to add a rule like this:
`ec2-authorize default -p 80`

Finally we can ssh to the ec2 instance using:
`ssh -i ~/.ec2/id_rsa-my-keypair root@ec2-XXX-XXX-XXX-XXX.z-2.compute-1.amazonaws.com`
where ec2-XXX-XXX-XXX-XXX.z-2.compute-1.amazonaws.com is the actual hostname of the instance as obtained from ec2-describe-instances.

_Note_: don't forget to **stop your instance** when you no longer need it. EC2 is a service paid as you use, hence if you forget your instance running you will be billed for it ;-). You can do this by running **shutdown **inside the instance or by using:
`ec2-terminate-instances i-yourinstance`
and verify with **ec2-describe-instances** that the instance is indeed stopped.

Next step is to create/customize your own EC2 AMI images based on your needs. This will be covered in a future article. Hopefully you found this article useful, and it will get you on track quickly with Amazon EC2 api tools.
