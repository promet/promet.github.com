---
published: true
author: marius-ducea
date: '2009-02-17 06:35:57'
layout: post
slug: cisco-asa-5505-activestandby-failover-configuration
status: publish
title: 'Cisco ASA 5505: Active/Standby Failover Configuration'
wordpress_id: '327'
categories:
- cisco
- CLI
- Security
tags:
- asa
- asa5505
- cisco
- firewall
- Security
---

The **ASA 5505** is the smallest (and cheapest) solution from the current Cisco hardware security appliances. Still, if we have the proper software license (like _Security Plus_ for example) we can use the ASA5505 to setup rather complex solutions. This post will show how we can setup a pair of **ASA5505 in failover configuration**, solution that can be very useful in a small office where we want to achieve a high availability and we can't tolerate a failure of our frontend firewall.


### Prerequisites


Before even starting, let's check that our ASA5505's are running the appropriate software license. For example the sh run command will output something like this:
`sh ver
...
Licensed features for this platform:
Maximum Physical Interfaces  : 8
VLANs                        : 20, DMZ Unrestricted
Inside Hosts                 : Unlimited
**Failover                   : Active/Standby**
VPN-DES                      : Enabled
VPN-3DES-AES                 : Enabled
VPN Peers                    : 25
WebVPN Peers                 : 2
Dual ISPs                    : Enabled
VLAN Trunk Ports             : 8
AnyConnect for Mobile        : Disabled
AnyConnect for Linksys phone : Disabled
Advanced Endpoint Assessment : Disabled
UC Proxy Sessions            : 2
This platform has an ASA 5505 Security Plus license.
.`
You should look at the Failover feature and you should have "**Active/Standby**". If this outputs _disabled_, you will have to order and install a software license upgrade from Cisco in order to be able to use the ASA's in failover.

Cisco (as always) has a very complex [documentation](http://www.cisco.com/en/US/docs/security/asa/asa72/configuration/guide/failover.html#wp1064158) on how you can achieve this. Still, it is hard to digest, as they try to cover all possible devices on the same page (even the obsolete pix500); even more the ASA5505 has some particularities compared with the rest of the ASA 5500 range of products and **this is not very clearly explained**. _Hopefully this post will be more useful and simpler to follow._

First we need to understand some limitations of our devices. The ASA5505 can **only perform Active/Standby** failover and **not Active/Active**. If you need that, you will have to look at a higher range device. Also they can only perform **LAN-Based Failover** (as opposed to old pixes that can use cable based failover) and they **don't support Stateful Failover** (meaning all active connections will be lost after a failover event). Also both units must have the same hardware, software configuration, and proper license and run in same mode (single or multiple, transparent or routed).


### Configuring the Primary Unit


For each of the IPs assigned to the interfaces of the ASA we will need to **allocate a secondary IP** from the same network range; this will be used as the IP of the standby unit, while the main IPs will always be used by the primary (active) unit and will be normally used by the clients (as default gateways for ex). The first step is to **configure the active and standby IP addresses for each data interface**; the cisco documentation is confusing here and it is not clear that on the **ASA5505 **this is done for **each of the used vlans, and not real interfaces**:
`conf t
(config)#interface Vlan1
(config-if)#ip address active_addr netmask standby standby_addr`
for ex:
`(config-if)#ip address 192.168.0.1 255.255.255.0 standby 192.168.0.2`

Once we have defined all standby IPs we can move forward...
You will also need to define **one interface that will be used for failover**. You can either cross-connect this between the 2 ASAs or you can use a switch with a dedicated vlan for this. The later one is preferred as it will more accurately detect if one ASA is down. Again in the documentation this is not clear how to do it on the ASA5505 and it discusses about _real interfaces_, while on the **ASA5505 we have to use vlans**.

**The trick is to create a new vlan and don't assign any ip on the vlan inteface:**
`interface Vlan32
description LAN Failover Interface
no shutdown`
the ip will be assigned by the failover commands;
Finally **enable failover**:
`failover
failover lan unit primary
failover lan interface failover Vlan32
failover interface ip failover 192.168.255.1 255.255.255.0 standby 192.168.255.2`
(where you will use one unused ip range for the failover ips).

Save the running config: **copy running-config startup-config**


### Configuring the Secondary Unit


The configuration of the secondary, standby unit is very simple as it needs **only the failover interface configuration**.  The secondary unit requires these commands to initially communicate with the primary unit, and get its configuration from the active unit.

As with the main ASA we have to define the **vlan that will be used for failover** first:
`interface Vlan32
description LAN Failover Interface
no shutdown`

And next we just have to enable failover and set this unit as secondary:
`failover
failover lan unit secondary
failover lan interface failover Vlan32
failover interface ip failover 192.168.255.1 255.255.255.0 standby 192.168.255.2`

After this, the active unit sends the configuration in running memory to the standby unit. As the configuration synchronizes, the messages "Beginning configuration replication: Sending to mate" and "End Configuration Replication to mate" appear on the active unit console.


### Verifying the Failover Configuration


The command **show failover** can be used to show the status of the failover operation; the output on the active device will look similar to:
`sh failover
Failover On
Failover unit Primary
Failover LAN Interface: failover Vlan32 (up)
Unit Poll frequency 1 seconds, holdtime 15 seconds
Interface Poll frequency 5 seconds, holdtime 25 seconds
Interface Policy 1
Monitored Interfaces 5 of 250 maximum
Version: Ours 8.0(4), Mate 8.0(4)
Last Failover at: 02:28:31 CST Jan 23 2009
This host: Primary - Active
Active time: 2166923 (sec)
slot 0: ASA5505 hw/sw rev (1.0/8.0(4)) status (Up Sys)
Interface inside (10.10.10.1): Normal
Interface outside (192.168.0.1): Normal
slot 1: empty
Other host: Secondary - Standby Ready
Active time: 378 (sec)
slot 0: ASA5505 hw/sw rev (1.0/8.0(4)) status (Up Sys)
Interface inside (10.10.10.2): Normal
Interface outside (192.168.0.2): Normal
slot 1: empty`

Finally, you will probably want to test the failover functionality and maybe tune the triggers of the failover, but maybe we will talk about this in a future post.
_I hope you found this post useful and helped to explain better the steps needed to configure the Active/Standby Failover on the ASA5505._
