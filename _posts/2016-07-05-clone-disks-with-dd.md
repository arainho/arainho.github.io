---
layout: post
title:  "Clone disks with dd"
date:   2016-07-05 11:51
categories: clone disks dd dd_rescue
---

#### 1. Before clonning let's check the state our original disk _sda_, see the _rw_ flag bellow RO.

```sh
# blockdev -v --getro /dev/sda
get read-only: 0

# blockdev -v --getro /dev/sda1
get read-only: 0

# blockdev --report  /dev/sda
RO    RA   SSZ   BSZ   StartSec            Size   Device
rw   256   512  4096          0   1000204886016   /dev/sda

# blockdev --report  /dev/sda1
RO    RA   SSZ   BSZ   StartSec            Size   Device
rw   256   512  4096       2048   1000203091968   /dev/sda1
```


#### 2. Lock property of device _sda_, this will set the device and partition to read-only mode

```sh
blockdev --setro /dev/sda
blockdev --setro /dev/sda1
```

```sh
# blockdev -v --getro /dev/sda
get read-only: 1

# blockdev -v --getro /dev/sda1
get read-only: 1
```


#### 3. Insert the clean device

```sh
dmesg -T 

[Tue Jul  5 13:13:41 2016]  sdd: sdd1
[Tue Jul  5 13:13:41 2016] sd 5:0:0:0: [sdd] Attached SCSI disk
```


#### 4. Clone the devices with dd

```sh
sudo dd status=progress if=/dev/sda /dev/sdc
```

In my Arch Linux i have progress with _dd_ version 8.25,

```sh
# dd --version
dd (coreutils) 8.25
```

On some of Debian/Ubuntu or other Linux Distro the option is to use [dd_rescue], 
that has progress and other nice features for data recovery.

```sh
dd_rescue /dev/sda /dev/sdc
```

After using [deftlinux] for some data recovery, i found that is possible to set devices in read only mode. You can check details in the here [deft-quickguide].


[dd_rescue]: http://www.garloff.de/kurt/linux/ddrescue/
[deftlinux]: http://www.deftlinux.net/
[deft-quickguide]: http://www.deftlinux.net/doc/DEFT%20Zero%20-%20Quick%20Guide%20v0.11%20[ENG].pdf

