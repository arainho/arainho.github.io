---
layout: post
title:  "Amavisd - define myhostname variable"
date:   2016-03-04 14:23
categories: debian amavisd myhostname
---



    Starting amavisd:   The value of variable $myhostname is "myserver", but should have been
      a fully qualified domain name; perhaps uname(3) did not provide such.
      You must explicitly assign a FQDN of this host to variable $myhostname
      in /etc/amavis/conf.d/05-node_id, or fix what uname(3) provides as a host's 
      network name!



    ~ # vi /etc/amavis/conf.d/05-node_id
        
            $myhostname = "mail.company.com";


    ~ # service  amavis restart

        Stopping amavisd: (not running).
        Starting amavisd: amavisd-new.
