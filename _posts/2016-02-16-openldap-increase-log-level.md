---
layout: post
title:  "Increase OpenLDAP log level"
date:   2016-02-16 09:58
categories: openldap logs loglevel
---

Change loglevel of slapd to _-1_, check out other values at [openldap.org]. 

    ~# sed -i "s/loglevel .*/loglevel      -1/g" /etc/ldap/slapd.conf


Check the logs

    ~# tail -f /var/log/syslog | grep slapd


[openldap.org]: <http://www.openldap.org/doc/admin24/runningslapd.html>
