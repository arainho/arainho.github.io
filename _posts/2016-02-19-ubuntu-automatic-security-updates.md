---
layout: post
title:  "Ubuntu - Provision Automatic Security Updates with Ansible"
date:   2016-02-19 10:37:05
categories: ubuntu security upgrade unattended-upgrades ansible
---

I setup the Automatic Security Updates on Ubuntu OS with unattended-upgrades packages using a Ansible playbook.
For more info about unattended-upgrades go to [debian wiki] or [ubuntu help].

    ~$ sudo ansible-galaxy install jnv.unattended-upgrades

    ~$ vi unattended-upgrades.yml

        - hosts: unattended_hosts
        
          vars: 
            admin_mail: "user@company.com"
        
          roles:
          - role: jnv.unattended-upgrades
            unattended_origins_patterns:
            - 'origin=Ubuntu,archive=${distro_codename}-security'
            - 'o=Ubuntu,a=${distro_codename}-updates'
            unattended_package_blacklist: [cowsay, vim]
            unattended_mail: {{ admin_mail }}
   
    ~$ vi ansible_hosts

        [unattended_hosts]
        remote-host.company.com    ansible_connection=ssh  ansible_ssh_user=root
 
    ~$ ansible-playbook -i ansible_hosts unattended-upgrades.yml

    ~$ ssh user@remote-host
    ~$ sudo unattended-upgrade --debug --dry-run

            Initial blacklisted packages: cowsay vim
            Starting unattended upgrades script
            Allowed origins are: ['origin=Ubuntu,archive=trusty-security', 'o=Ubuntu,a=trusty-updates']
            pkgs that look like they should be upgraded: 
            Fetched 0 B in 0s (0 B/s)                                                                                                
            fetch.run() result: 0
            blacklist: ['cowsay', 'vim']
            No packages found that can be upgraded unattended and no pending auto-removals


I have this issue after apply this playbook, and found the solution on [ubuntu forums].

    ~# apt-get update

        Hit http://security.ubuntu.com trusty-security InRelease                       
        Hit http://security.ubuntu.com trusty-security/main amd64 Packages
        Hit http://security.ubuntu.com trusty-security/main Translation-en  
        Fetched 14 B in 17s (0 B/s)                                                    
        Reading package lists... Done
        N: Ignoring file '20auto-upgrades.ucf-dist' in directory '/etc/apt/apt.conf.d/' as it has an invalid filename extension

    ~# diff /etc/apt/apt.conf.d/20auto-upgrades.ucf-dist /etc/apt/apt.conf.d/20auto-upgrades

        1,2c1,4
        < APT::Periodic::Update-Package-Lists "0";
        < APT::Periodic::Unattended-Upgrade "0";
        ---
        > APT::Periodic::Update-Package-Lists "1";
        > APT::Periodic::Download-Upgradeable-Packages "1";
        > APT::Periodic::AutocleanInterval "7";
        > APT::Periodic::Unattended-Upgrade "1";

    ~# rm /etc/apt/apt.conf.d/20auto-upgrades.ucf-dist


---
[ubuntu help]: <https://help.ubuntu.com/community/AutomaticSecurityUpdates>
[ubuntu forums]: <http://ubuntuforums.org/showthread.php?t=1897475>
[debian wiki]: <https://wiki.debian.org/UnattendedUpgrades>

