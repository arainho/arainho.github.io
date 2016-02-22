---
layout: post
title:  "OpenStack cannot delete volume"
date:   2016-02-22 14:23
categories: openstack cinder mysql delete volume snapshots issue
---

I tried to delete a volume on OpenStack and receive this output "Volume still has 1 dependent snapshots".
There is a post on [ask openstack] that suggested to edit directly on MySQL, but i do not want to mess up things.


Let's Find your volume id

    ~# cinder list  --all-tenants=1 | grep <volume-name>


When i try to delete the volume

    ~# cinder delete <volume-id>

    Delete for volume <volume-id> failed: Invalid volume: 
    Volume still has 1 dependent snapshots (HTTP 400) (Request-ID: req-51a8c127-5f26-4266-a774-e2375860be20)
    
    ERROR: Unable to delete any of the specified volumes.

List snapshots available

    ~# cinder snapshot-list --all-tenants=1


Remove the dependent snapshot

    ~# cinder snapshot-delete <volume-id>


Now we can delete the volume :-)

    ~# cinder delete <volume-id>


---
[ask openstack]: <https://ask.openstack.org/en/question/26430/volume-still-has-1-dependent-snapshots/?answer=88756#post-id-88756>

