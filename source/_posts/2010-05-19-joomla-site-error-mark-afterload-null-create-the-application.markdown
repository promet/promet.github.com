---
date: '2010-05-19 11:39:40'
layout: post
author: gerold-mercadero
published: true
slug: joomla-site-error-mark-afterload-null-create-the-application
status: publish
title: 'Joomla site error: "mark( ''afterLoad'' ) : null; /** * CREATE THE APPLICATION..."'
wordpress_id: '1093'
categories:
- Installation
---

I happened to setup a Joomla site from other hosting (zipped Joomla files and mysqldump), and after the setup on our server I got the error (below) - not exactly an error but a contents of "index.php" file.  I found few Joomla related discussion regarding this issue but there's no solution.
`
mark( 'afterLoad' ) : null; /** * CREATE THE APPLICATION * * NOTE : */ $mainframe =& JFactory::getApplication('site'); /** * INITIALISE THE APPLICATION * * NOTE : */ // set the `
`......`
`JDEBUG ? $_PROFILER->mark('afterRender') : null; $mainframe->triggerEvent('onAfterRender'); /** * RETURN THE RESPONSE */ echo JResponse::toString($mainframe->getCfg('gzip'));
`

I found the problem on ".htaccess" file as it contain a line "AddType x-mapp-php5 .php".  I commented out the line because I think it is related to parsing PHP files and this solved my problem.  I searched for this code and it is related to servers with PHP 4 and 5 installed - details below from [1and1 hosting](http://faq.1and1.com/scripting_languages_supported/php/9.html).





> By default Apache uses PHP 4 for .php extension. If you don't want to rename all your
scripts to .php5 you can do the following:
Create a .htaccess file and place the following line AddType x-mapp-php5 .php in it.

This will tell Apache to use PHP 5 instead of PHP 4 for the extension .php in the
directory the .htaccess is placed and all sub-directories under it.

You can use AddHandler x-mapp-php5 .php as an alternative for or instead of
AddType x-mapp-php5 .php





