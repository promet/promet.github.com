---
date: '2009-06-16 14:53:10'
layout: post
slug: tracing-memory-leaks-with-pidstat
status: publish
title: Tracing memory leaks with pidstat
wordpress_id: '734'
categories:
- Performance
- sysadmin
tags:
- pidstat
- script
---

Finding application memory leaks is important part of keeping systems stable and often very hard to track down. Monitoring application memory consumption can be performed in a few different ways, the easiest is a simple capture of ps and append to log file triggered via cron at desired interval. In this example we will track sshd memory usage via shell script.

`
    
    
    #!/bin/bash
    
    PID=`cat /var/run/sshd.pid`
    ps -p $PID -o pid -o rss -o %mem -o cmd >> logname
    exit
    

`

The output of log file will looks like this:
`
    
    
    PID RSS %MEM CMD
    2607  1036  0.0 /usr/sbin/sshd

`

Note the RSS column, it the values keep increasing with usage of application that would indicate a memory leak.

Another way to do the same thing is with [pidstat](http://pagesperso-orange.fr/sebastien.godard/man_pidstat.html) which is a part of the [sysstat](http://pagesperso-orange.fr/sebastien.godard/) package. The package can be installed via yum or aptitude but may not come with pidstat, if so download and install or build the latest version from [here](http://pagesperso-orange.fr/sebastien.godard/download.html).

Pidstat is better way to track resources of an application because it has built in polling as well as combining process's children statistics into the total. See pidstat man page options. In the script below we will use pidstat to  track memory usage for sshd by polling 12 times every 5 minutes and e-mailing a report and writing to a log file. This script can also be run via cron.

`
    
    #!/bin/bash
    # track memory usage of sshd using pidstat and send report
    # http://www.linuxsysadminblog.com - MaxV
    
    export PID=/var/run/sshduse.pid
    export TIMESTAMP=`date +%Y%m%d_%H%M%S`
    export LOGDIR=/var/log/
    export SSHD_LOG="${LOGDIR}sshd_memUsage_${TIMESTAMP}"
    export SSHD_PID=`cat /var/run/sshd.pid`
    export MAILTO=user@domain.com
    
    if [ ! -e ${PID} ]; then
    
    #create pid file
    echo $$ > ${PID}
    
    #log begin of script to /var/log/messages
    /usr/bin/logger "Starting SSHD Memory Usage Tracker"
    
    # pidstat portion, poll 12 times with 5 minutes apart
    /usr/bin/pidstat -r -p ${SSHD_PID} 300 12 >> ${SSHD_LOG}
    
    #e-mail report
    mail -s "SSHD memory usage ${TIMESTAMP}" ${MAILTO} < ${SSHD_LOG}
    
    #clean up pid file
    if [ -f ${PID} ]; then
    rm -rf ${PID}
    
    #log end of script to /var/log/messages
    /usr/bin/logger "Ending SSHD Memory Usage Tracker"
    fi
    exit 0
    else
    
    exit 0
    fi

`

The output of this script:
`
    
    
    Linux 2.6.18-6-686 (hostname)       06/16/09        _i686_  (2 CPU)
    
    14:21:26          PID  minflt/s  majflt/s     VSZ    RSS   %MEM  Command
    14:21:56         2564      0.00      0.00    4932   1108   0.05  sshd
    14:22:26         2564      0.00      0.00    4932   1108   0.05  sshd
    14:22:56         2564      0.00      0.00    4932   1108   0.05  sshd
    14:23:26         2564      0.00      0.00    4932   1108   0.05  sshd
    14:23:56         2564      0.00      0.00    4932   1108   0.05  sshd
    14:24:26         2564      0.00      0.00    4932   1108   0.05  sshd
    14:24:56         2564      0.00      0.00    4932   1108   0.05  sshd
    14:25:26         2564      0.00      0.00    4932   1108   0.05  sshd
    14:25:56         2564      0.00      0.00    4932   1108   0.05  sshd
    14:26:26         2564      0.00      0.00    4932   1108   0.05  sshd
    14:26:56         2564      0.47      0.00    4932   1108   0.05  sshd
    14:27:26         2564      0.00      0.00    4932   1108   0.05  sshd
    Average:         2564      0.04      0.00    4932   1108   0.05  sshd

`

From the output we can see that "RSS" values are not increasing as time progresses which means that it's a solid piece of coding.

