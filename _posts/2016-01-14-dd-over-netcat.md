---
layout: post
title:  "Using dd over Netcat"
date:   2016-01-14  15:19:00
categories: netcat dd clone copy
---

I want to clone a VM from OpenStack to a physical CompatFlash attached on my workstation in my private network.

In case of some public networks or internet use "ssh + dd" as described here in [NDCHost Wiki],
i use netcat because is faster ;-)

### A warning !!
Be extremly careful with dd, and triple check your devices names /dev/sdx  !!

### 1. On workstation
Go to your workstation and run this, sdf is the destination disk

    workstation ~# nc -l 9000 | dd of=/dev/sdf

### 2. On the instance 
On the instance do the following, the source disk is /dev/sda

    ~# ssh user@instance-01.local
    instance-01 ~# dd if=/dev/sda | nc workstation.example.net 9000

#### notes
Usualy i would use screen or tmux on each machine like this, and after detach screen with Ctrl+D.

    ~# screen -S clone-sda


---
[NDCHost Wiki]: <https://www.ndchost.com/wiki/server-administration/netcat-over-ssh>


