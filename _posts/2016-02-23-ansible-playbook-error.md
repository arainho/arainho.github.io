---
layout: post
comments: true
title:  "Ansible playbook error - the field 'hosts' is required"
date:   2016-02-23 10:48
categories: ansible yml playbook error
---

I created a new Ansible playbook and got this output, 
i check the ansible hosts file and it's ok.

    ~$ cat ansible_hosts

        [myserver]
        myserver   ansible_connection=ssh  ansible_ssh_user=root    ansible_sudo=true


Check the playbook file

    ~$ cat install_tools.yml

        - hosts: rancher_hosts
        
        - tasks:
          - name: "ensure packages are installed"
            apt: name={{item}}
            with_items:
              - vim
              - htop 
              - iotop
              - wget
              - curl


Try to run it and fails !!!

    ~$ ansible-playbook -i ansible_hosts install_tools.yml -vvvvv

    ERROR! the field 'hosts' is required but was not set


Removing the _dash_ before _tasks_ line and correcting the identation solves the issue,
i found some similar issue on [reddit].

	~$ cat install_tools.yml

	- hosts: rancher_hosts
	
	  tasks:
	    - name: "ensure packages are installed"
	      apt: name={{item}}
	      with_items:
	        - vim
	        - htop 
	        - iotop
	        - wget
	        - curl


---
[reddit]: <https://www.reddit.com/r/ansible/comments/43qhdo/running_playbook_against_single_host/>

