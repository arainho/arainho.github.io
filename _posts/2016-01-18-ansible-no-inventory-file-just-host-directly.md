---
layout: post
comments: true
title:  "Run Ansible without inventory file"
date:   2016-01-18 10:36
categories: ansible inventory-file hosts
---

I want to run Ansible without specifying the inventory file through (ANSIBLE_HOST)
The trick is to append a , after the hostname.

#### Option 1:  Works with Host or an IP address

  ~$ ansible all -i example.com,

#### Option 2:  Requires 'hosts: all' in your playbook

  ~$ ansible-playbook -i example.com, playbook.yml 
