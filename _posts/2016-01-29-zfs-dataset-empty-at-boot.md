---
layout: post
title:  "ZFS Dataset not available at bootup"
date:   2016-01-29 15:57:22
categories: zfs boot arch-linux dataset
---

I have my /home with a ZFS pool in Arch Linux, i reboot the PC and my directory 'Code' is empty !!!
Code directory is a ZFS Dataset, let's check it out ;-)


    ~$ cd /home/user/Code
    ~$ ls -la
        
        Jan 29 15:57 ./
        Jan 29 15:57 ../
    
First unmount the dataset and mount it again

    ~$ sudo zfs unmount -f tank/home/Code
    ~$ sudo zfs mount tank/home/Code


After finally we have content :-D

    ~$ ls -la

        user1.github.io/
        cloud-init/        


