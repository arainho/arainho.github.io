---
layout: post
comments: true
title:  "Rancher Apps Catalog - 503 - service unavailable"
date:   2016-02-11 8:48:00
categories: rancher apps catalog docker dns service-unavailable
---

On Rancher web interface i cannot access apps catalog.
I enter on rancher/server container and found some git clone pending, inside my Company only comany dns are allowed by Enterprise Firewall !


1. Go to Docker HOST Machine

<pre>
~$ ssh user@docker-host
~$ sudo docker exec -it <rancher/server-id> /bin/bash
</pre>

2. Inside rancher/server container check dns

<pre>
~> ps aux | grep git
~> dig google.com

~> cat /etc/resolv.conf
        nameserver 8.8.8.8
        nameserver 8.8.4.4
</pre>

3. Change dns servers inside rancher-server container !

<pre>
~# sed -i "s/nameserver 8.8.8.8/nameserver dns.company.com/g" /etc/resolv.conf
~# sed -i "s/nameserver 8.8.4.4/nameserver dns2.company.com/g" /etc/resolv.conf

~# echo "dns.company.com" > /etc/resolvconf/resolvconf.d/base
~# echo "dns2.company.com" >> /etc/resolvconf/resolvconf.d/base
~# /etc/init.d/resolvconf restart
</pre>

4. Back to the Docker HOST Machine, change the google dns to company dns.
Replace _dns.company.com_ by the ip address of your company dns server.

<pre>
~# vi /etc/default/docker
    #DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"
    DOCKER_OPTS="--dns dns.company.com --dns dns2.company.com

~# service docker restart
</pre>

