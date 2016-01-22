---
layout: post
title:  "Linux filesystem is full"
date:   2016-01-22 10.21
categories: linux filesystem nfs syslog debian
---

I have a NFS Server on a Debian and this morning when i try to copy a key
i realize that filesystem is full !!! 


    ~# ssh-copy-id  user@nfs-server
    cat: write error: No space left on device


    ~# df -h | grep rootfs -B1

        Filesystem      Size  Used Avail Use% Mounted on
        rootfs          7.4G  7.4G     0 100% /

###  Let's check the log files

    ~# du -sh /var/log/* | grep G

        5G    /var/log/kern.log
        1.5G    /var/log/messages
        1.5G    /var/log/syslog 


### Checking log messages

    ~# tail -n 10 /var/log/syslog

    Jan 22 10:15:49 nfs-server kernel: [762787.964058] svc: server ffff880208f50000, pool 0, transport ffff8801b0b53000, inuse=2
    Jan 22 10:15:49 nfs-server kernel: [762787.959073] svc: TCP complete record (108 bytes)
    Jan 22 10:15:49 nfs-server kernel: [762787.959118] svc: got len=108
    Jan 22 10:15:49 nfs-server kernel: [762787.959158] svc: svc_authenticate (1)
    Jan 22 10:15:49 nfs-server kernel: [762787.959202] svc: calling dispatcher
    Jan 22 10:15:49 nfs-server kernel: [762787.959260] svc: socket ffff8801b0b53000 sendto([ffff8801b43a3000 116... ], 116) = 116 (addr 10.100.1.40, port=807)
    Jan 22 10:15:49 nfs-server kernel: [762787.959353] svc: server ffff880208f50000 waiting for data (to = 900000)
    Jan 22 10:15:49 nfs-server kernel: [762787.963885] svc: socket ffff8801fcca3100 TCP data ready (svsk ffff8801b0b53000)
    Jan 22 10:15:49 nfs-server kernel: [762787.963967] svc: transport ffff8801b0b53000 served by daemon ffff880208f50000
    Jan 22 10:15:49 nfs-server kernel: [762787.964058] svc: server ffff880208f50000, pool 0, transport ffff8801b0b53000, inuse=2
    
### Disable debugging
The 'rpcdebug' is very helpful in analysing the NFS or RPC communication, check here[novell]
But be careful with rpcdebug, it can fill you filesystem !!!

    Disable the respective debugging options again by using the option -c in front of the trailing all:

    ~# rpcdebug -m nfsd -c all
    ~# rpcdebug -m nfs -c all
    ~# rpcdebug -m rpc -c all
    ~# rpcdebug -m nlm -c all

    Advanced logging on kernel level should be disable via sysctl:

    ~# sysctl -w sunrpc.nfsd_debug=0
    ~# sysctl -w sunrpc.nfs_debug=0
    ~# sysctl -w sunrpc.rpc_debug=0

### Compress log files

Execute Logrotate Command Manually, [rackspace] has a entry about troubleshooting logrotate

    ~# logrotate -vf /etc/logrotate.conf

            The flags ‘-vf’ passed to the command are as follows:

            -v verbose shows more information. useful to try detect any errors there may be with logrotate
            -f force the rotation to occur even if it is not necessarily needed

### Check available space
And finally problem is solved :-)

    ~# df -h | grep rootfs
    
        rootfs      7.4G  5.9G  1.1G  85% /




---
[novell]: <http://www.novell.com/support/kb/doc.php?id=7011571>
[rackspace]: <https://www.rackspace.com/knowledge_center/article/sample-logrotate-configuration-and-troubleshooting>

