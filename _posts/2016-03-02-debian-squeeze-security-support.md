---
layout: post
comments: true
title:  "Debian Squeeze - Add Security Support"
date:   2016-03-02 17:06
categories: debian squeeze security lts
---

So we have a legacy server with Debian 6.0 !, the solution is to add LTS repository for Debian.
I follow these instructions on [turnkeylinux] website.

First enable LTS updates on your Debian 6.0:

    ~# apt-get install -y debian-keyring debian-archive-keyring

    ~# cat>>/etc/apt/sources.list.d/security.sources.list<<'EOF'
    deb http://http.debian.net/debian/ squeeze-lts main contrib non-free
    deb-src http://http.debian.net/debian/ squeeze-lts main contrib non-free
    EOF

Update repositories and upgrade packages:

    ~# apt-get update
    ~# apt-get upgrade


Find which packages are not supported: 
 
    ~# apt-get install -y debian-security-support
    ~# check-support-status


Now setup the unattended-upgrades like i described in [my blog],
for more info go to [debian wiki].


---
[my-blog]: <http://blog.arainho.me/ubuntu/security/upgrade/unattended-upgrades/ansible/2016/02/19/ubuntu-automatic-security-updates.html>
[debian wiki]: <https://wiki.debian.org/UnattendedUpgrades>
[turnkeylinux]: <https://www.turnkeylinux.org/blog/extending-squeeze-security-support>
