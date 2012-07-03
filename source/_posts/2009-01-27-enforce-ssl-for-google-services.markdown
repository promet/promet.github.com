---
author: max-veprinsky
published: true
comments: true
date: '2009-01-27 16:30:45'
layout: post
slug: enforce-ssl-for-google-services
status: publish
title: Enforce SSL for Google Services
wordpress_id: '282'
categories:
- Installation
---

Most Google services are now avaible over **encrypted** ssl connections. **Google Apps** now offers the option to enforce ssl for most of it's services. Here is the overview:

`
Email - Yes.
Calendar - Yes.
Docs - Yes.
Sites - Yes.
Chat - Yes. SSL supports Chat in Gmail. The Google Talk Client is always over a secure connection (TLS).
Video - Not available.
Start Page - Not available. This includes start page gadgets for email, chat, calendar, and docs account.
`

To enable SSL enforcement in Google Apps services login as an Administrative user for your Google Apps hosted domain, click on *Domain Settings* tab and check *SSL* checkbox.
