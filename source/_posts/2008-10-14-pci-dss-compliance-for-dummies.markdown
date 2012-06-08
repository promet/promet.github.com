---
date: '2008-10-14 13:37:16'
layout: post
slug: pci-dss-compliance-for-dummies
status: publish
title: PCI DSS compliance for dummies
wordpress_id: '72'
categories:
- PCI Compliance
tags:
- Compliance
- DSS
- PCI
- Security
- Standards
---

One of our longer running projects for while now has been to become PCI DSS compliant. For those of you that have never heard of it, PCI stands for Payment Card Industry and DSS stands for Data Security Standards. Basically what it comes down to is that the credit card companies have gotten together and created a standard for data security for anyone dealing with credit card information ([PCI Security Standards Council](https://www.pcisecuritystandards.org)). They then followed it up with a compliance program with audits and certifications and such. We think this is great. Credit card information should be treated with the utmost care and a lot of effort should be put into keeping that data secure. There are however some issues with the standards. Not that they're bad as such but there are some inherent problems with standards that will be applied to both small web shops and large corporations. For the small shops the standard brings a lot of overhead and worse, requires things that are outside of the control of the company. For the large institutions the implementation of something that is seemingly trivial can take ages and lots of manpower.

So, how are we as a growing company dealing with this? Well, after some initial investigation we found that the implementation allows some leeway. First of all there are compensating controls. These magic words are found throughout the specifications  and indicate that even if you are not fully compliant with a certain requirement you can still be overall compliant if you have some extra measures in place. For example, if you use FTP instead of the more secure SFTP and cannot switch over for some reason it is considered a compensating control if you only allow very strong passwords. There is, however, no exact definition of what is considered an acceptable compensating control and that brings us to the next point. The company auditing you for PCI compliance will be assigned by a credit card company or a bank who requests the compliance. The auditor and the sponsor together they will be the judges of where compensating controls are allowed and what compensating controls are acceptable. What works in one audit may therefore not necessarily be accepted in another.

As a result of all of this achieving PCI DSS compliancy may not be quite as daunting a task as it seems to be when you first read through the requirements. Don't get me wrong though, this is not a simple task and it depends a lot on how organized and security-aware your company is now, but for us it is more a path than one goal. Actually, the that's another thing where some leeway is allowed. If there is a requirement with which you are not compliant and you don't have compensating controls in place it may suffice to show a roadmap on how to implement this over time. You can even be overall compliant in that case. However, since the audits are at regular intervals expect the auditors to demand some progress and insight into that roadmap.
