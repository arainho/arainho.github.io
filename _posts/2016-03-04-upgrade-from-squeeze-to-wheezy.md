---
layout: post
title:  "Upgrading from Squeeze LTS to Wheezy LTS"
date:   2016-03-04 14:32
categories: upgrade debian squeeze wheezy
---

Security support for Debian 6 "Squeeze" reached end-of-life on 2016-02-29 !
Next LTS version is Debian 7 "Wheezy" :-)

To receive security updates, change your /etc/apt/sources.list 

    deb http://httpredir.debian.org/debian/ wheezy main contrib non-free
    deb-src http://httpredir.debian.org/debian/ wheezy main contrib non-free

    deb http://security.debian.org/ wheezy/updates main contrib non-free
    deb-src http://security.debian.org/ wheezy/updates main contrib non-free

    deb http://httpredir.debian.org/debian wheezy-updates main contrib non-free
    deb-src http://httpredir.debian.org/debian wheezy-updates main contrib non-free


Update your system repositories:

    ~# apt-get update

    ..............
    ...........
    ........
    Fetched 12.5 MB in 44s (279 kB/s)

    Reading package lists... Done
    W: There is no public key available for the following key IDs:
    9D6D8F6BC857C906
    W: There is no public key available for the following key IDs:
    7638D0442B90D010
    W: There is no public key available for the following key IDs:
    7638D0442B90D010


Found the solution on [stackexchange] forum.

    ~# apt-get install debian-keyring debian-archive-keyring


Install apt from Wheezy before upgrading your system:

    ~# apt-get install apt -t wheezy


Upgrade your system, and carefully check all debconf prompts and update configuration files as needed. 

    ~# apt-get upgrade


Open a new terminal and use vimdiff to check differences between old file and new conf file.
In my case I neeed to change your sudoers file, and change users line

    ~# vimdiff /etc/sudoers /etc/sudoers.dpkg-new

    ~# vi /etc/sudoers
    
        myuser  ALL=(ALL:ALL) ALL


Upgrade your system and remove obsolete packages

    ~# apt-get dist-upgrade

        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        Calculating upgrade... Failed
        The following packages have unmet dependencies:
         initscripts : Breaks: nfs-common (< 1:1.2.5-3) but 1:1.2.2-4squeeze3 is to be installed
        E: Error, pkgProblemResolver::Resolve generated breaks, this may be caused by held packages.

    ~# apt-get remove nfs-common
    ~# apt-get install nfs-common

    ~# apt-get autoremove



---
[debian wiki]: <https://wiki.debian.org/LTS/Using>
[stackexchange]: <http://unix.stackexchange.com/questions/75807/no-public-key-available-on-apt-get-update>
