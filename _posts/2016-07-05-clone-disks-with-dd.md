---
layout: post
title:  "Clone disks with dd"
date:   2016-07-05 11:51
categories: clone disks dd dd_rescue
---

#### 0. !!! WARNING !!!  'dd' may damage your system ...

Please use disks with no data or non critical data, and use _dd_ with extreme caution.
Test things first, Disks, Flash Drivers and operating systems differ so be carefull.

#### 1. Before clonning let's check the state our original disk _sdc_, see the _rw_ flag bellow RO.

```sh
# blockdev -v --getro /dev/sdc
get read-only: 0

# blockdev -v --getro /dev/sdc1
get read-only: 0

# blockdev --report  /dev/sdc
RO    RA   SSZ   BSZ   StartSec            Size   Device
rw   256   512  4096          0   1000204886016   /dev/sdc

# blockdev --report  /dev/sdc1
RO    RA   SSZ   BSZ   StartSec            Size   Device
rw   256   512  4096       2048   1000203091968   /dev/sdc1

# hdparm -r1 /dev/sdc

```


#### 2. Lock property of device _sdc_, this will set the device and partition to read-only mode

```sh
blockdev --setro /dev/sdc
blockdev --setro /dev/sdc1
```


```sh
# blockdev -v --getro /dev/sdc
get read-only: 1

# blockdev -v --getro /dev/sdc1
get read-only: 1
```

##### We also can use the hdparm instead of blockdev

```sh
hdparm -r1 /dev/sdc

/dev/sdc:
 setting readonly to 1 (on)
 readonly      =  1 (on)

# hdparm -r /dev/sde

/dev/sde:
 readonly      =  1 (on)
```

#### 3. Insert the clean device

```sh
dmesg -T 

[Tue Jul  5 13:13:41 2016]  sdg: sdg1
[Tue Jul  5 13:13:41 2016] sd 5:0:0:0: [sdg] Attached SCSI disk
```


#### 4. Clone the devices with dd

Used _device ids_ instead of sda, sdX, etc it's safer. :-)
```sh
ls -lh /dev/disk/by-id/* | grep -i kingston | awk '{ print $9}'
/dev/disk/by-id/usb-Kingston_DT_HyperX_000000-0:0 -> ../../sde
```

option 1 ( safer )
```sh
sudo dd status=progress if=/dev/disk/by-id/usb-Kingston_DT_HyperX_0011100-0:0 /dev/disk/by-id/ata-Hitachi_HDT000_XXX
```

option 2 ( risky )
```sh
sudo dd status=progress if=/dev/sdc /dev/sdg
```

In my Arch Linux i have progress with _dd_ version 8.25,

```sh
# dd --version
dd (coreutils) 8.25
```

On some of Debian/Ubuntu or other Linux Distro the option is to use [dd_rescue], 
that has progress and other nice features for data recovery.

```sh
dd_rescue /dev/sdc /dev/sdg
```

After using [deftlinux] for some data recovery, i found that is possible to set devices in read only mode. You can check details in the here [deft-quickguide].


[dd_rescue]: http://www.garloff.de/kurt/linux/ddrescue/
[deftlinux]: http://www.deftlinux.net/
[deft-quickguide]: http://www.deftlinux.net/doc/DEFT%20Zero%20-%20Quick%20Guide%20v0.11%20[ENG].pdf

