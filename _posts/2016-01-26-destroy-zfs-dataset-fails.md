---
layout: post
title:  "Destroy zfs dataset fails"
date:   2016-01-25 10:35:00
categories: zfs dataset destroy-dataset unmount-dataset
---

The destroy command fails if the file system is busy. 
To forcibly unmount a file system, you can use the -f option. 

Be cautious when forcibly unmounting a file system if its contents are actively being used. 
Unpredictable application behavior can result,

I found the solution at [oracle docs]

    # zfs destroy DATA_VOL/MY_SERVER/dataset_replication_testdrive

        cannot destroy 'DATA_VOL/MY_SERVER/dataset_replication_testdrive': filesystem has children
        use '-r' to destroy the following datasets:

            DATA_VOL/MY_SERVER/dataset_replication_testdrive@monday
            DATA_VOL/MY_SERVER/dataset_replication_testdrive@sunday


    ~# zfs destroy DATA_VOL/MY_SERVER/dataset_replication_testdrive

        cannot unmount '/mnt/DATA_VOL/MY_SERVER/dataset_replication_testdrive': Device busy


    ~# zfs umount -f /mnt/DATA_VOL/MY_SERVER/dataset_replication_testdrive
    ~# zfs destroy DATA_VOL/MY_SERVER/dataset_replication_testdrive
    ~# zfs list | grep dataset_replication_testdrive



---
[oracle docs]: <http://docs.oracle.com/cd/E19253-01/819-5461/gamnr/index.html>
