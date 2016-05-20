---
layout: post
comments: true
title:  "Linux mdadm replace disk"
date:   2016-02-16 10:02:03
categories: linux mdadm replace disk
---

h1. Mdadm add new disk

*Remove fail drive*
<pre>
mdadm --manage /dev/md0 --fail /dev/sda1
mdadm --manage /dev/md0 --remove /dev/sda1
</pre>

*Rescan new disks attached*
for i in {0..3}; do echo "- - -" > /sys/class/scsi_host/host${i}/scan; done

*Add new drive*
<pre>
parted /dev/sdc mklabel msdos
parted /dev/sdc mkpart primary 2048s 100%
parted /dev/sdc set 1 raid on
parted /dev/sdc unit s p
mdadm --manage /dev/md0 --add /dev/sdc1
</pre>

*To avoid this run mkdevicemap*
"/usr/sbin/grub-probe: warning: Couldn't find physical volume `(null)'. Some modules may be missing from core image..."
<pre>
grub-mkdevicemap -n
</pre>

*Install grub*
<pre>
grub-install --recheck /dev/sda
update-grub
</pre>

*Debug with*
<pre>
mdadm -D /dev/md0
cat /proc/mdstat
</pre>
