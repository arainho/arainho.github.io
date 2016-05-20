---
layout: post
comments: true
title:  "Can't start mysql - mysql respawning too fast, stopped"
date:   2016-01-19 16:07:00
categories: mysql linux ubuntu
---

I can't start mysql, so i dig in some blog's and forums like [blogs oracle], [ask ubuntu], [launchpad bugs] and finally i found out that the issue was configuration lines inside my.cnf config file on VM.


### Start wathing dmesg and syslog:

    ~# dmesg -l warn -T

    [Tue Jan 19 15:03:35 2016] init: mysql post-start process (1569) terminated with status 1
    [Tue Jan 19 15:03:36 2016] init: mysql main process (1626) terminated with status 2
    [Tue Jan 19 15:03:36 2016] init: mysql respawning too fast, stopped

    ~# tail /var/log/syslog

    Jan 19 15:03:35 io kernel: [2512905.106158] type=1400 audit(1453215815.892:27): apparmor="STATUS" operation="profile_replace" name="/usr/sbin/mysqld" pid=1614 comm="apparmor_parser"
    Jan 19 15:03:37 io kernel: [2512906.533900] init: mysql main process (1626) terminated with status 2
    Jan 19 15:03:37 io kernel: [2512906.533929] init: mysql respawning too fast, stopped


### Check AppArmor

    ~# /etc/init.d/apparmor status

        apparmor module is loaded.
        6 profiles are loaded.
        6 profiles are in enforce mode.
           /sbin/dhclient
           /usr/lib/NetworkManager/nm-dhcp-client.action
           /usr/lib/connman/scripts/dhclient-script
           /usr/sbin/mysqld
           /usr/sbin/ntpd
           /usr/sbin/tcpdump
        0 profiles are in complain mode.
        2 processes have profiles defined.
        2 processes are in enforce mode.
           /sbin/dhclient (567) 
           /usr/sbin/ntpd (18274) 
        0 processes are in complain mode.
        0 processes are unconfined but have a profile defined.


        ~# apt-get install apparmor-utils
        
        ~# cat /sys/kernel/security/apparmor/profiles

                /usr/sbin/mysqld (enforce)
                /usr/sbin/tcpdump (enforce)
                /usr/sbin/ntpd (enforce)
                /usr/lib/connman/scripts/dhclient-script (enforce)
                /usr/lib/NetworkManager/nm-dhcp-client.action (enforce)
                /sbin/dhclient (enforce)

### To disable a profile called mysql i.e. disable apparmore protection for mysql server, enter:
 
        ~# ln -s /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/
        ~# apparmor_parser -R /etc/apparmor.d/usr.sbin.mysqld
 
### Check your config file
We have innodb_buffer_pool_size and key_buffer_size without the equal sign,

        ~# egrep "(key_buffer_size|innodb_buffer_pool_size)"  /etc/mysql/my.cnf

            key_buffer_size 64M
            innodb_buffer_pool_size 256M

After changing that mysqld starts working.

            
        ~# egrep -v "(\#|^$)"  /etc/mysql/my.cnf  | grep "_buffer_"

            key_buffer_size = 64M
            innodb_buffer_pool_size = 256M

### Finally MySQL daemon starts

        ~# service mysql restart

            stop: Unknown instance: 
            mysql start/running, process 9000


### Enable AppArmor for MySQL 
I turn on (enable) apparmor protection for mysql again?
Type the following commands:

 
        ~# rm /etc/apparmor.d/disable/usr.sbin.mysqld
        ~# apparmor_parser -r /etc/apparmor.d/usr.sbin.mysqld
        ~# aa-status

### Restart MySQL daemon
Stop and Start MySQL daemon again

        ~# service mysql stop

            mysql stop/waiting

        ~# service mysql start
            
            mysql start/running, process 9330


---

[blogs oracle]: <https://blogs.oracle.com/jsmyth/entry/apparmor_and_mysql>
[ask ubuntu]: <http://askubuntu.com/questions/127264/cant-start-mysql-mysql-respawning-too-fast-stopped>
[launchpad bugs]: <https://bugs.launchpad.net/ubuntu/+source/mysql-5.5/+bug/970366>

