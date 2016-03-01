---
layout: post
title:  "Upgrade Standalone Chef Server"
date:   2016-03-01 11:36
categories: chef chef-server upgrade
---

I upgrade the Chef Server to version 12.4.1, just follow the instructions from [chef docs]

Verify that the make command is available on the Chef server server. 
If it is not available, install the make command.

    ~# make

        _The program 'make' is currently not installed. You can install it by typing:_
        _apt-get install make_
    
    ~# apt-get install make


Run the following on all servers to make sure all services are in a sane state:

    ~# chef-server-ctl reconfigure
        
        Starting Chef Client, version 12.0.3
        resolving cookbooks for run list: ["private-chef::default"]

        ........................
        .....................
        .............

        Running handlers:
        Running handlers complete
        Chef Client finished, 32/390 resources updated in 51.240191762 seconds
        opscode Reconfigured!


Download the new version of Chef Server, get the link here [chef downloads]

    ~# wget https://packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core-<version>.deb/download -O chef-server-core-<version>.deb


Stop the server:
    
    ~# chef-server-ctl stop

        ok: down: bookshelf: 0s, normally up
        ok: down: ec_sync_client: 0s, normally up
        ok: down: ec_sync_server: 0s, normally up
        ok: down: nginx: 1s, normally up
        ok: down: oc_bifrost: 0s, normally up
        ok: down: oc_id: 1s, normally up
        ok: down: opscode-chef-mover: 2212s, normally up
        ok: down: opscode-erchef: 1s, normally up
        ok: down: opscode-expander: 0s, normally up
        ok: down: opscode-expander-reindexer: 0s, normally up
        ok: down: opscode-pushy-server: 1s, normally up
        ok: down: opscode-reporting: 0s, normally up
        ok: down: opscode-solr4: 1s, normally up
        ok: down: postgresql: 0s, normally up
        ok: down: rabbitmq: 1s, normally up
        ok: down: redis_lb: 0s, normally up


Run dpkg, the -D enables debugging and 10 creates output for each file processed in the upgrade

    ~# dpkg -D10 -i /path/to/chef-server-core-<version>.deb


Upgrade the server with this:

    ~# chef-server-ctl upgrade


Start Chef server 12:

    ~# chef-server-ctl start


After the upgrade is complete and everything verified to be working properly, 
clean up the server by removing all of the old data:

    $ chef-server-ctl cleanup



---
[chef docs]: <https://docs.chef.io/upgrade_server.html>
[chef downloads]: <https://downloads.chef.io/chef-server/ubuntu/>
