---
layout: post
title:  "# Run Ansible without inventory file"
date:   2016-01-18 10:36
categories: ansible inventory-file hosts
---

I want to run Ansible without specifying the inventory file through (ANSIBLE_HOST)
The trick is to append a , after the hostname.

#### Host and IP address
ansible all -i example.com,

### OR

#### Requires 'hosts: all' in your playbook
ansible-playbook -i example.com, playbook.yml 
