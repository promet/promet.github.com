---
date: '2008-10-06 22:42:04'
layout: post
slug: calculating-videos-on-site-to-bandwidth-or-aggregate-transfer-to-cost-of-video-played
status: publish
title: Calculating Videos on site to Bandwidth or Aggregate Transfer to cost of video
  played
wordpress_id: '25'
categories:
- hosting
tags:
- bandwidth
- data transfer
- video
---

A client had asked us a very innocent question about bandwidth usage "What will my average cost of video download be?".  This question lead me down a path of assumptions and translations of different bandwidth terminologies which would make sense to someone without having to learn how to convert binary and calculate video compressions.  This article is first of an outline of how to get from a technical measurement to a non technical answer.

**Bitrate**

The assumptions for calculating the bandwidth of the video are the following:



	
  * Size of average video, which depends on:

	
    * pixel hight

	
    * pixel width

	
    * frames speed

	
    * compression or movement

	
    * length of video (time)





We'll assume video bitstream is understood, there are lots of resources on the web which cover this topic, most widely [adobe itself](http://livedocs.adobe.com/flash/9.0/flvencoder/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_NoParts&file=FLV_01.html), as well as some [old school ](http://sorenson-usa.com/vbe/index.html)sources.

_Let's assume that our video bitrate is 440kbs and audio 128kbs, making the whole a 568kbs. _

For explanation of [KiloBytes vs. kilobits vs. Kibibyte](http://www.lyberty.com/encyc/articles/kb_kilobytes.html)s vs. Monkeybytes see Lyberty blog or one of these [nifty](http://www.valkaryn.net/bwcalc/) [calculators ](http://www.ibeast.com/content/tools/band-calc.asp)on the web.

**Site bandwidth usage**

Once we have our "average" video size, lets consider the usage of the site, as the videos are embedded in a webiste, whose pages also incorporate images, javascript, css, etc, adding to the bandiwdth requirements.  So what we need to determine next is some baseline by which we can determine the download of videos considering pageviews, visitors, etc.

If our baseline is visitors to the site, then we need to assume the number of pages viewed and videos watched per visit.   If its going to be determined by pageviews, then we need to understand number of videos watched per page.  This is a huge assumption as we assume each video preloads.

Our assumptions here would therefor be:



	
  * Number of videos watched per visitor

	
    * average page size outside of video

	
    * average page views per visitor

	
    * average videos viewed per page





The easiest number to assume here as it requires no assumptions but rather a guess, is:

	
  * Number of visitors


_In our case, for simplicty of calculation, lets assume our video lenght is 3600 seconds and we'll just add a overhead percentage penalty on pages encapsulating the video of about 45%._

**Bandwidth Cost**

We then must turn the calculation into something useful which can be applied to a cost formula for bandwidth.  There are generally two ways in which bandwidth is sold, either by measured transfer, typically per month, or by average badnwidth usage, generally at 95% capacity, meaning the lowest and the highest 2.5% of usage do not count.  Either transfer or metered bandwidth costs are typically tiered, basically the more you use the less it costs per unit.

One of the better bandwidth explanations I found on the web is from Rackforce:

[Understanding Bandwidth ](http://www.rackforce.com/blog/2006/11/03/understanding-bandwidth/)by Doug Alder

I am not taking into consideration the "unmetered" offers which are in fact throttled or in worse case oversaturated which does not provide a good user experience.

To assume:



	
  * Cost of Bandwidth

	
    * based on tiered cost which is based on usage

	
    * based on total data transfer

	
    * based on connection





Once we have our assumptions, the rest is relatively easy.  To calculate total monthly bandwidth use the following formula:

[video encoding rate] x [average video length] x [daily uniques] x [assumed views per unique] x [30] x [overhead bandwidth addon]

Then backout your cost of bandwidth, either fixed or connection based:

[total monthly bandwidth] x [usage cost]

This last calculation is simplified, we shall devote another article for continuation.
