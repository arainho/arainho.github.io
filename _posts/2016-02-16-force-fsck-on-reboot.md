---
layout: post
comments: true
title:  "Linux Force fsck on the Next Reboot"
date:   2016-02-16 16:50:09
categories: linux fsck reboot
---

I want to force a fsck after an Instance reboot,
you can check more details on [cyberciti.biz] website.

Check if you have this line.

    ~# cat /etc/init/mountall.conf | grep "/forcefsck"
    
        [ -f /forcefsck ] && force_fsck="--force-fsck"

Create this file

    ~# touch /forcefsck

And reboot

    ~# reboot


---
[cyberciti.biz]: <http://www.cyberciti.biz/faq/linux-force-fsck-on-the-next-reboot-or-boot-sequence/> 
