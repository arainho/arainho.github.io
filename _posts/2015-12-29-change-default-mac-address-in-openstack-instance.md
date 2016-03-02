---
layout: post
title:  "Change default mac address in OpenStack instance"
date:   2015-12-29 15:22:03
categories: openstack mac-address linux instance cadence
---



I have an instance with Cadence on my Openstack and i need a custom mac address, in order to get Cadence and other license software to work properly.

1. Change mac address on MySQL on database: neutron and table: ports
2. power off Instance
3. backup libvirt.xml inside instance folder on Compute node
4. remove libvirt.xml
5. restart neutron-server on Controller
6. restart neutron services on Network Node
7. restart openvswitch-switch, neutron-plugin-openvswitch-agent
8. power on Instance
