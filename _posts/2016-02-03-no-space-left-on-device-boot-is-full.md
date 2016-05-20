---
layout: post
comments: true
title:  "No space left on device, /boot is full"
date:   2016-02-03 15:51:03
categories: linux kernel boot no-space
---

When try to install a new kernel i get this message "No space left on device",
i check the /boot partition and it's 100% in use.
 
Later I found some clues on [askubuntu] forums. :-)


    ~# apt-get install linux-image-3.13.0-77-generic

    ...

    Unpacking linux-image-3.13.0-77-generic (3.13.0-77.121) ...
    dpkg: error processing archive /var/cache/apt/archives/linux-image-3.13.0-77-generic_3.13.0-77.121_amd64.deb (--unpack):
     cannot copy extracted data for './boot/vmlinuz-3.13.0-77-generic' to '/boot/vmlinuz-3.13.0-77-generic.dpkg-new': failed to write (No space left on device)
    No apport report written because the error message indicates a disk full error


    /# df -h | grep boot

        /dev/sda1                                    236M  233M     0 100% /boot


    ~# cd /boot
    ~# rm $(ls initrd.img-3.13.0-* vmlinuz-3.13.0-* | grep -v 3.13.0-24  |grep -v initrd.img-3.13.0-59 | grep -v initrd.img-3.13.0-58)

    ~# apt-get autoremove

        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        The following packages will be REMOVED
          linux-headers-3.13.0-53 linux-headers-3.13.0-53-generic
          linux-headers-3.13.0-55 linux-headers-3.13.0-55-generic
          linux-headers-3.13.0-57 linux-headers-3.13.0-57-generic
          linux-headers-3.13.0-58 linux-headers-3.13.0-58-generic
          linux-image-3.13.0-53-generic linux-image-3.13.0-55-generic
          linux-image-3.13.0-57-generic linux-image-3.13.0-58-generic
          linux-image-3.13.0-61-generic linux-image-extra-3.13.0-53-generic
          linux-image-extra-3.13.0-55-generic linux-image-extra-3.13.0-57-generic
          linux-image-extra-3.13.0-58-generic linux-image-extra-3.13.0-61-generic
        0 to upgrade, 0 to newly install, 18 to remove and 184 not to upgrade.
        3 not fully installed or removed.
        After this operation, 1,279 MB disk space will be freed.
        Do you want to continue? [Y/n]    


    ~# apt-get -f install
    ~# apt-get install --reinstall linux-image-3.13.0-77-generic



---
[askubuntu]: <http://askubuntu.com/questions/263363/how-can-i-remove-old-kernels-install-new-ones-when-boot-is-full>
