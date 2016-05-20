---
layout: post
comments: true
title:  "Problem with NFS server lockd timed out on Debian linux "
date:   2016-01-19 09:32:23
categories: nfs linux debian
---

### The issue

    ~# dmesg -T
    
        [Tue Jan 19 13:58:49 2016] statd: server rpc.statd not responding, timed out
        [Tue Jan 19 13:58:49 2016] lockd: cannot monitor koios


### Possible solution 
I found the answer to this on [serverfault], in Debian/Ubuntu the commands would be:

    ~# service nfs-kernel-server stop
    ~# service rpcbind stop
    ~# service nfs-common stop
    ~# service rpcbind start
    ~# service nfs-common start
    ~# service nfs-kernel-server start


### Debugging
I use rpcdebug to dedug rpc, i found a lot of information on [archlinux wiki]

    ~$ rpcdebug -vh

        usage: rpcdebug [-v] [-h] [-m module] [-s flags...|-c flags...]
               set or cancel debug flags.
        
        Module     Valid flags
        rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc cache all
        nfs        vfs dircache lookupcache pagecache proc xdr file root callback client mount all
        nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
        nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcache xdr all

    Examples:

        $ rpcdebug -m nfsd -s proc
        nfsd proc


---

[archlinux wiki]: <https://wiki.archlinux.org/index.php/NFS/Troubleshooting>
[serverfault]: <http://serverfault.com/questions/188918/problem-with-nfs-server-lockd-timing-out-on-debian-linux>

