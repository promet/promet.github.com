---
date: '2009-07-20 17:45:55'
layout: post
slug: waiting-for-ssh-login-prompt
status: publish
title: 'Waiting for SSH login prompt '
wordpress_id: '799'
categories:
- Centos
- HowTo
- Security
- sysadmin
tags:
- delay
- kerberos
- lag
- login
- ssh
---

Are you often waiting over 1 minute to get a ssh prompt? This can be caused by several things however more often then not is a missing PTR record for server address and enabled GSSAPIAuthentication in ssh_config. GSSAPIAuthentiction is Kerberos 5 centralized authentication/authorization mechanism that relies on resolving a hostname for proper operation, when it cannot do so it tries 3 times before falling back on the next authentication mechanism.

First you need to see where the login process gets hung up:
`ssh -vvv server_address
debug1: Authentications that can continue: publickey,gssapi-with-mic,password
debug3: start over, passed a different list publickey,gssapi-with-mic,password
debug3: preferred gssapi-with-mic,publickey,keyboard-interactive,password
debug3: authmethod_lookup gssapi-with-mic
debug3: remaining preferred: publickey,keyboard-interactive,password
debug3: authmethod_is_enabled gssapi-with-mic
debug1: Next authentication method: gssapi-with-mic
debug3: Trying to reverse map address server_address.
debug1: Unspecified GSS failure.  Minor code may provide more information
No credentials cache found
debug1: Unspecified GSS failure.  Minor code may provide more information
No credentials cache found
debug1: Unspecified GSS failure.  Minor code may provide more information
debug2: we did not send a packet, disable method`

and check if a PTR record exists:
`[max@linux ~]$ dig -x server_address
; <<>> DiG 9.5.1-P2-RedHat-9.5.1-2.P2.fc10 <<>> -x server_address
;; global options:  printcmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: SERVFAIL, id: 20960
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 0`

`;; QUESTION SECTION:
;sserdda_revres.in-addr.arpa.	IN	PTR`

`;; Query time: 87 msec`

Here we see that in fact we are being hung on the gssapi-with-mic method  and there is no PTR record for the host. The quickest and simples way to resolve this is to disable gssapi-with-mic authmethod globally on the client. 
In RedHat/Fedora Linux edit /etc/ssh/ssh_config and make sure you have an uncommented "GSSAPIAuthentication no" line for Host *

`# Host *
#   ForwardAgent no
#   ForwardX11 no
#   RhostsRSAAuthentication no
#   RSAAuthentication yes
#   PasswordAuthentication yes
#   HostbasedAuthentication no
     GSSAPIAuthentication no
#   GSSAPIDelegateCredentials no`

If you are using host-based configuration be sure to put this at the top of the file so it takes priority over the defaults below it.
`Host server_name
HostName server_address
Port 22
User max
GSSAPIAuthentication no`
