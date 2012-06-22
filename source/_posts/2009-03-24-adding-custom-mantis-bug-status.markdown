---
author: gerold-mercadero
date: '2009-03-24 03:15:52'
layout: post
slug: adding-custom-mantis-bug-status
status: publish
title: Adding Custom Mantis Bug Status
wordpress_id: '458'
categories:
- Installation
tags:
- mantis
---

This post will guide you in adding new or custom ticket status on your Mantis bug tracker installation.  In our case we will refer the new status as GTG (GoodToGo).  Ticket will have this status if it is ready to push to production.
To do this we need to edit two files, _config_inc.php_ and _custom_strings_inc.php_ (create this file if not existing).

**Changes to config_inc.php:**

Find this line (bottom):
`$g_status_enum_string = '10:new,20:feedback,30:acknowledged,40:confirmed,50:assigned,
80:resolved,90:closed';`



and insert your new bug status together with its number.  You can assign the number depending on the level of status that you want.  Example my GTG status is higher than "resolved" but less than "closed" so i can assign 81 to 89.
`$g_status_enum_string = '10:new,20:feedback,30:acknowledged,40:confirmed,50:assigned,
80:resolved,85:GTG,90:closed';`

Assign a color for your bug status, example:
`$g_status_colors['GTG'] = '#cceedd';`

**Changes to custom_strings_inc.php:**

Create definition for your new status:
`$g_status_enum_string = '10:new,20:feedback,30:acknowledged,40:confirmed,50:assigned,
80:resolved,85:GTG,90:closed';
$s_GTG_bug_button = "GTG Issue";
$s_GTG_bug_title = "Set Issue to GTG";
$s_email_notification_title_for_status_bug_GTG = "The following issue is GTG.";`

That's all and you should see your new status.


