# Update OpenSSH Client to version 7.1p2-1

Do to bugs CVE-2016-0777, CVE-2016-0778 with need to upgrade our OpenSSH Client on all machines to version 7.1p2-1,
or add the line "UseRoaming no" to OpenSSH Client config files. you can check details here [cyberciti.biz] or [digitalocean] 


### 1. On Linux and FreeBSD
Run this command to add the new line to your config:

    ~# echo 'UseRoaming no' | sudo tee -a /etc/ssh/ssh_config

    
### 2. On Mac OSX
Run this command to add the new line to your config:


    ~# echo "UseRoaming no" >> /etc/ssh_config

### 3. Just for current user on Linux / FreeBSD / Mac OS X do this 

    ~$ echo "Host *" 		>> ~/.ssh/config
    ~$ echo "    UseRoaming no" >> ~/.ssh/config

### 4. To upgrade via packages on Arch Linux
With pacman upgrade OpenSSH Client to desired version "7.1p2-1"

    ~# pacman -Sy openssh
          

### 5. To upgrade via packages on Debian / Ubuntu hosts
With apt-get upgrade OpenSSH Client to desired version "7.1p2-1"

    ~# apt-get clean && apt-get update && apt-get install --reinstall -y openssh-client openssh-server

### 5.1 Some Old Debian hosts has this issue

    ~# apt-get install grep openssh-client openssh-server
    
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        
        openssh-client is already the newest version.
        openssh-client set to manually installed.
        You might want to run 'apt-get -f install' to correct these:
        The following packages have unmet dependencies:
        openssh-server : Depends: openssh-client (= 1:6.0p1-4+deb7u2)
        
        E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).

        
### 5.2 Fix debconf first
Fix debconf installation first, in my case debconf version is 1.5.49


    ~# DEBCONF_VERSION=$(dpkg -l | grep " debconf " | awk '{print $3}')
    ~# wget http://ftp.us.debian.org/debian/pool/main/d/debconf/debconf_"${DEBCONF_VERSION}"_all.deb
    ~# dpkg -i debconf_"${DEBCONF_VERSION}"_all.deb
    
    ~# apt-get install grep openssh-client openssh-server
    ~# dpkg -l | grep openssh

        ii  openssh-client                       1:6.0p1-4+deb7u3                  amd64        secure shell (SSH) client, for secure access to remote machines
        
        ii  openssh-server                       1:6.0p1-4+deb7u3                  amd64        secure shell (SSH) server, for secure access from remote machines
    

### 5.3 Or in last case try a manual install 
Try manually installing OpenSSH client with dpkg

    ~# dpkg -i /var/cache/apt/archives/openssh-client*.deb

    
### 6. Upgrade OpenSSH Client via Ansible
Create a playbook named openssh.yml and run ansible-playbook to update Package on all Debian and Ubuntu nodes

    ~# cat openssh.yml

        - hosts: all
        gather_facts: yes
        
        tasks:
            - name: Update OpenSSH (Debian+Ubuntu)
            apt: name={{ item }}
                state=latest
                update_cache=yes
            with_items:
                - openssh-client
                - openssh-server
                - openssh-blacklist
                - openssh-blacklist-extra
                - ncurses-term
                
        post_tasks:
            - name: Check Restart
            command: checkrestart


    ~# ansible-playbook -i ansible_hosts openssh.yml

[cyberciti.biz]: <http://www.cyberciti.biz/faq/howto-openssh-client-security-update-cve-0216-0777-cve-0216-0778/>
[digitalocean]: <https://www.digitalocean.com/community/questions/openssh-client-bug-cve-2016-0777-and-cve-2016-0778>
