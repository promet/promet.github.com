---
date: '2011-04-22 15:59:01'
layout: post
slug: amazon-aws-worse-failure
status: publish
title: Amazon AWS worse failure
wordpress_id: '1333'
categories:
- cloud computing
tags:
- Amazon
- aws
---

I'm sure almost everyone is aware at this point on the **failure** that caused Amazon cloud computing solution AWS to be down yesterday (and still is at some smaller extend happening at this time as we can see on their [status](http://status.aws.amazon.com/) page) for most of the day. This has affected a few big (Reddit, Foursquare, Quora, Heroku, Engine Yard, for ex.) and many small sites hosted in the **us-east-1** AWS region. This happened regardless on the availability zone you were in the region US-EAST (this is the oldest one and still the default for many client tools) and questioned the [independence and isolation](http://aws.amazon.com/ec2/faqs/#How_isolated_are_Availability_Zones_from_one_another) of the availability zones in the AWS infrastructure design.

The failure was specifically related to the **EBS** drives that made customer instances non responding, but also prevented them to start or stop new instances with the same EBS volumes (that probably 99% have tried immediately as they got paged). There are some sites that had failover mechanisms, but if they were in the same availability zone it was useless (something that looked like a good solution and fast and cost effective). Others, many startups, found out that they had no such mechanism at all, and that they depended way too much on the Amazon reliability. Until this issue, Amazon had a great uptime record; there were many issues but with individual instances, but not such a global issue. You would expect people running their application in the cloud to expect failures and be prepared and I'm sure most of them are compared with applications deployed in the regular datacenter, but apparently there is still much work to be done.

Overall I believe this showed (if we needed a reminder), that failures can happen and anyone can suffer from such a problem (Google had problems, Facebook the same, and Twitter is most of the time down, and now was just Amazon's turn). We need to be prepared and build and architect our applications with this in mind and be ready to failover. A great example of this is the twilio application design: [http://www.twilio.com/engineering/2011/04/22/why-twilio-wasnt-affected-by-todays-aws-issues/](http://www.twilio.com/engineering/2011/04/22/why-twilio-wasnt-affected-by-todays-aws-issues/)

Also I think Amazon will learn many things from this event, and hopefully one of them will be to _better communicate with their clients_. They can definitely improve on this, and not leave people to go to twitter or ec2 forums for the best updates on such problems instead from the source.

I've also seen different providers (I will not give names but they are everywhere on twitter) come out and offer their services to people hit by this. I don't believe this is the best approach to sell your very performant cloud solution or barebone datacenter servers or whatever, and probably it does worse for their reputation making them look like coyotes on a fallen prey. I'm sure like me, most people felt disgusted on their offers at this time, and it will definitely not make me look at their offering again.

Now its time to get back to work on failover and redundancy design for our clients that need help with this. If you've been affected by this and want to share your story and what are your takeaways feel free to comment bellow on the post. If you need specialized help to design or implement a fully fault tolerant infrastructure feel free to [contact us](http://www.prometsource.com/contact) anytime. We are here to help.
