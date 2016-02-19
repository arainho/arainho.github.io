---
layout: post
title:  "Speedup raid rebuilds"
date:   2016-02-18 16:35
categories: rebuild raid speedup linux
---

In order to recover Linux software raid, and increase speed of RAID rebuilds, I found a nice howto at [cyberciti.biz].

Warning !!! ... these options are good for tweaking rebuilt process and may increase overall system load, high cpu and memory usage.

To increase speed, enter:
<pre>
echo value > /proc/sys/dev/raid/speed_limit_min
 
OR

sysctl -w dev.raid.speed_limit_min=value

</pre> 
In this example, set it to 50000 K/Sec, enter:
<pre>
# echo 120000 > /proc/sys/dev/raid/speed_limit_min
</pre>


---
[cyberciti.biz]: <http://www.cyberciti.biz/tips/linux-raid-increase-resync-rebuild-speed.html>
