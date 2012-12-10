---
layout: post
title: "HowTo: Bulk Import DNS Zones to Softlayer DNS using Cpanel"
date: 2012-11-13 01:08
comments: true
author: gerold-mercadero
published: true
status: publish
categories:
- cpanel
- HowTo
- dns
---

This guide covers the process for doing bulk import of existing DNS zones from a Cpanel or BIND server to Softlayer's DNS servers (*ns1/ns2.softlayer.com*).  This is useful if you need to add hundreds of zones, if for example you are moving your DNS hosting servers to Softlayer's free DNS hosting.  Currently, Softlayer doesn't have a tool to do bulk import of zones with existing records. Although you can create a default zone template and bulk add zones but this doesn't fit for existing zones.

### Requirements:

1.) DNS zones on a Cpanel server (WHM or DNSOnly).

If you are not using a Cpanel server then you can stand up a Cpanel VPS this process and install Cpanel DNSOnly as it is free or install Cpanel WHM and automatically it will have 15-day trial license, or you can get a one month WHM VPS license for $15/month.
DNSOnly should be fine and easier/faster to install but you cannot view the DNS zones from its UI, although you can view or edit the zone files directly (*ex: /var/named/domain.db*).
Then import your zones to Cpanel server. There are lots of guides or discussions online in doing this. Some mentioned that you can move the named.conf and zone files as-is and adjust the formatting to match Cpanel's.
In our case we were running Cpanel server so we copied straight our "/var/named/*.db" files to Cpanel DNSOnly to import zones.

2.) Softlayer API key for your account.

  You will need this later to connect your Cpanel DNS server in a cluster setup with Softlayer's DNS servers. Cpanel have DNS cluster functionality with SoftLayer and VPS.NET.

### The Import Process:

1.) Configure your Cpanel DNS cluster to connect to Softlayer's DNS servers.
<!--more-->
- Login to Cpanel WHM or DNSOnly, then go to *Cluster/Remote Access*  ->> *Configure Cluster*.
- select *Enable DNS clustering*
- On *Backend Type* dropdown, you will see *cPanel* only. Then click on *(Show All)* link next to it and the page will reload and you will see two more options: *Softlayer* and *VPS.NET*. Select *Softlayer* and click on *Configure button.
[![cluster-setup](http://linuxsysadminblog.com/images/2012/cluster-setup.png)](http://linuxsysadminblog.com/images/2012/cluster-setup.png)
- On *SoftLayer DNS Remote Configuration* page, enter your Softlayer API user and key. On *DNS role* choose *Synchronize changes* from dropdown list and click on *Submit*.
[![softlyer-dns-config](http://linuxsysadminblog.com/images/2012/softlyer-dns-config.png)](http://linuxsysadminblog.com/images/2012/softlyer-dns-config.png)

2.) Synchronize DNS Records across clusters. DNS Cluster is now your Cpanel server and Softlayer servers.

- From Cpanel WHM or DNSOnly admin, go to * DNS Functions* ->> *Synchronize DNS Records*
- Select *Synchronize all zones to all servers* and check the box that says *Synchronize zones that are not configured on this server*. Then hit *Synchronize* button.
[![sync-dns](http://linuxsysadminblog.com/images/2012/sync-dns.png)](http://linuxsysadminblog.com/images/2012/sync-dns.png)
- The dns sync process will run and it will take some time depending on the number of zones and records that you have. Wait until it's finish and you're done.
- Once this starts you can login to your Softlayer portal and go to *Public Network* ->> *Domain Name System* and you will start seeing zones and see the progress on how many are imported.

*That is all. You can shutdown or remove your Cpanel DNSOnly/WHM server when if not needed.*

###  Notes:

- Cpanel have DNS cluster functionality with SoftLayer and VPS.NET so you might be able to use this guide to bulk import zones to VPS.NET.
- At this time of writing, we encountered a problem with Cpanel DNS cluster integration with Softlayer and we cannot modify the dns records that were imported initially.  When we update them it reverts to the original records from initial import. We disabled the DNS cluster setup from Cpanel and we update our DNS zones/records right from Softlayer portal.
- Above info refers to BIND server as the default DNS server on Cpanel.




