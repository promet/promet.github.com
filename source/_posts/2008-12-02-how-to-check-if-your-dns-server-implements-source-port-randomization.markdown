---
published: true
comments: true
author: marius-ducea
date: '2008-12-02 06:11:40'
layout: post
slug: how-to-check-if-your-dns-server-implements-source-port-randomization
status: publish
title: How to check if your DNS server implements source port randomization
wordpress_id: '144'
categories:
- Centos
- Security
- sysadmin
tags:
- dns
- Security
---

The **Domain Name System** (DNS) is responsible for translating host names to IP addresses (and vice versa) and is critical for the normal operation of internet-connected systems. **DNS cache poisoning** (sometimes referred to as cache pollution) is an attack technique that allows an attacker to introduce forged DNS information into the cache of a caching nameserver. DNS cache poisoning is not a new concept; in fact, there are published articles that describe a number of inherent deficiencies in the DNS protocol and defects in common DNS implementations that facilitate DNS cache poisoning.

**Fixed source port for generating queries** – in most dns implementations the source port for outgoing queries is fixed at the traditional assigned DNS server port number, **53/udp**.
We can easily find out if our own dns server is using a fixed source port for queries by looking into **named.conf** and if we see a line like:
`query-source port 53;`
_this means that the port 53 udp will be used for **all **dns outgoing queries_.

This can be tested externally (you can check on your ISP resolvers for ex.) with the dig command:
`dig +short @<IP_DNS_SERVER> porttest.dns-oarc.net txt`

Here is a sample output for a server not using source port randomization:
`dig +short @192.168.0.1 porttest.dns-oarc.net txt
porttest.y.x.w.v.u.t.s.r.q.p.o.n.m.l.k.j.i.h.g.f.e.d.c.b.a.pt.dns-oarc.net.
"192.168.0.1 is **POOR**: 26 queries in 2.0 seconds from 1 ports with std dev 0"`

and also one for a server that does this:
`dig +short @192.168.0.2 porttest.dns-oarc.net txt
porttest.y.x.w.v.u.t.s.r.q.p.o.n.m.l.k.j.i.h.g.f.e.d.c.b.a.pt.dns-oarc.net.
"192.168.0.2 is **GREAT**: 26 queries in 1.2 seconds from 26 ports with std dev 5243"`
as this shows it is using **random ports** for each query.

Now if you want to be safe from this [vulnerability](http://www.kb.cert.org/vuls/id/800113) you should **upgrade to the latest bind version** available (**yum install bind** if using rhel/centos/etc. or **apt-get install bind9** if you use debian/ubuntu) and also remove from your **named.conf** such lines:
`query-source port 53;
query-source-v6 port 53;`
and reload named afterwards:
`rndc reload`

Once you are done check it again with dig and this should show now '**GREAT**' as expected.
