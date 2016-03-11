---
layout: post
title:  "DNS Slave with bind and Ansible"
date:   2016-03-11 14:23
categories: dns slave bind ansible linux
---


### Setup your DNS Slave with Ansible

Clone the Ansible repository

    ~$ git clone https://github.com/resmo/ansible-role-bind.git
    ~$ cd ansible-role-bind


Create your own playbook, i use a template i found on github named [ansible-role-bind].
Replace _example.com_ with your domain and _192.168.0.201_ with the ipv4 of your DNS Master.

<pre>
~$ vi dns-slave.yml 

---
- hosts: dns_slave

  vars:
    my_hostname: "dns2"
    my_domain: "example.com"
    my_nameserver1: "127.0.0.1"
    my_nameserver2: "192.168.0.200"
    my_nameserver3: "8.8.8.8"       

    bind_config_slave_zones:
      - name: example.com
        masters: [ '192.168.0.201' ]
        zones:
          - example.com
          - vm.example.com
          - dyn.example.com

  tasks:

  - name: "Change machine hostname"
    hostname: name={{my_hostname}} 

  - name: "Set resolvconf nameserver"
    blockinfile:
        dest=/etc/resolvconf/resolv.conf.d/base
        block= |
            search {{ my_domain }}
            nameserver {{ my_nameserver1 }}
            nameserver {{ my_nameserver2 }}
            nameserver {{ my_nameserver3 }}

  - name: "Restart resolvconf service"
    service: 
      name=resolvconf
      enabled=yes
      state=restarted

  - name: "Restart DNS Service"
    service:
        name=bind9
        enabled=yes
        state=restarted

  roles:
    - ansible-role-bind
</pre>

<pre>
    ~$ vi ansible_hosts 

        [dns_slave]
        dns2.example.com      ansible_connection=ssh  ansible_ssh_user=root
</pre>


    ~$ ansible-playbook -i ansible_hosts dns-slave.yml

    
### Go to your _named.conf_ or your zone files and add _ipv4_ of the Slave DNS to the line _allow-transfer_

<pre>
    ~# ssh dns@example.com
</pre>

<pre>
~# vi /etc/named.conf

    allow-query       { localhost; 192.168.0.0/24; };
    allow-transfer    { localhost; 192.168.0.201; };  # Slave DNS ipv4.
    recursion no;
</pre>

### Go to your DNS Master, and edit your zone file

<pre>
~# vi /etc/bind/example.com.zone

$TTL 86400
@       IN SOA  dns.example.com.     root.example.com. (
                                  2014090401    ; serial
                                        3600    ; refresh
                                        1800    ; retry
                                      604800    ; expire
                                       86400 )  ; minimum

; Name server's

       IN      NS      dns.example.com.
       IN      NS      dns2.example.com.        
</pre>


### Check your conf and zone files

    ~# named-checkconf /etc/bind/named.conf
    ~# named-checkconf /etc/bind/named.conf.options

    ~# named-checkzone example.com /etc/bind/example.com.zone
    ~# named-checkzone vm.example.com /etc/bind/vm.example.com.zone


### Restart bind

    ~# service bind9 restart

### Go to Slave DNS

Test if you can tranfer the zone(s), replace  _dns.example.com_ by you DNS Master ip
in our case is _192.168.0.200_

    ~$ dig axfr example.com @dns.example.com

### Open firewall on the Slave DNS Machine

On OpenStack / AWS you need a security group, and add a security rule for port 53
both UDP and TCP.

In case you have iptables do

    ~# iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
    ~# iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
    ~# iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
    ~# iptables -A OUTPUT -p tcp -m tcp --dport 53 -j ACCEPT


## Login on your Laptop 

    ~$ dig foo.example.com @dns2.example.com


---
[ansible-role-bind]: <https://github.com/resmo/ansible-role-bind>
