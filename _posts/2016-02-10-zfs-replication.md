---
layout: post
title:  "ZFS replication"
date:   2016-02-10  17:24:00
categories: freebsd linux zfs replication
---

It's possible to send data of a pool over a network to another system. Snapshots are the basis for this replication (see the section on ZFS snapshots). The commands used for replicating data are zfs send and zfs receive
I found a lot of information on [freebsd handbook] and [oracle website] 


#### First, do the required config

    1. passwordless SSH access between sending and receiving host using SSH keys
    ~# ssh-copy-id someuser@backuphost 

    2. ZFS Delegation system can be used to allow a non-root user on each system to perform the respective send and receive operations.

    On the sending system:

        ~# zfs allow -u someuser send,snapshot mypool

    
    3. To mount the pool, the unprivileged user must own the directory, and regular users must be allowed to mount file systems. 


    On the receiving system:

        ~# sysctl vfs.usermount=1
        vfs.usermount: 0 -> 1

        ~# echo vfs.usermount=1 >> /etc/sysctl.conf
        ~# zfs create recvpool/backup
        ~# zfs allow -u someuser create,mount,receive recvpool/backup
        ~# chown someuser /recvpool/backup

#### Finally
The unprivileged user now has the ability to receive and mount datasets, and the home dataset can be replicated to the remote system:

    
    ~$ zfs snapshot -r mypool/home@monday
    ~$ zfs send -R mypool/home@monday | ssh someuser@backuphost zfs recv -dvu recvpool/backup


---
[freebsd handbook]: <https://www.freebsd.org/doc/handbook/zfs-zfs.html>
[oracle website]:   <http://docs.oracle.com/cd/E18752_01/html/819-5461/gbchx.html#gbinw>
