---
layout: post
comments: true
title:  "OpenStack Compute node error"
date:   2015-09-24 15:42:13
categories: openstack compute linux ubuntu
---

### OpenStack Compute node error

2015-09-24 15:42:13.630 21919 ERROR nova.virt.images [req-f497ed0e-84f2-4a71-94f2-656a7c4708f5 276624420e464f8cbecb72a286de3d70 0e5f16e243e74a0889339881d3c207f7] /var/lib/nova/instances/_base/5e9e4a48e508b635cdb1f70a697390afb6f89ae7 virtual size 85899345920 larger than flavor root disk size 84825604096
2015-09-24 15:42:13.647 21919 ERROR nova.compute.manager [req-f497ed0e-84f2-4a71-94f2-656a7c4708f5 276624420e464f8cbecb72a286de3d70 0e5f16e243e74a0889339881d3c207f7] [instance: 11d30771-412f-43f7-9995-6042879150e7] Instance failed to spawn
2015-09-24 15:42:13.647 21919 TRACE nova.compute.manager [instance: 11d30771-412f-43f7-9995-6042879150e7] Traceback (most recent call last):

### SOLUTIONS

    $ ssh admin@controller
    $ sudo -s
    # cd /var/lib/glance/images
    # source admin_creds.sh
    # glance image-list --all-tenants | your-image-name

    # qemu-img info your-image-id

        image: 1d7d2f6e-2843-43e3-9337-cb9778fb6ac5
        file format: qcow2
        virtual size: 80G (85899345920 bytes)
        disk size: 2.4G
        cluster_size: 65536
        Format specific information:
            compat: 1.1
            lazy refcounts: false

### Finally change your flavor disk space to "virtual size", 
in this case is 80G.

        # nova flavor-list --all | grep your-flavor-name
        # nova flavor-show your-flavor-id
        
        Go to dashboard and edit flavor ( disk size = 80 )

