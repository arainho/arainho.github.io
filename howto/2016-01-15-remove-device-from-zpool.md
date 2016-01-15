# Detach device from zpool

## Scenario
I create a mirrored zpool equivalent to a RAID1 array [zfsbuild website], but i create the pool with one device connected via usb hdd docking stattion.

Later on i connect the device directly on my bus sata on my workstation, so i have to remove the device from pool.
To do this i detach the old device name from pool and attach the new one. [oracle attach and detach]

### 1. Take offline the device 
Take the device offline starting with "usb-WDC_WD15_EARS", since it does not exit anymore !

    ~# zpool offline tank usb-WDC_WD15_EARS-00MVWB0_DCAA46930898-0:0-part4
    

### 2. Try to remove device from pool
If you try to remove the device from pool it will fail !

    ~# zpool remove tank usb-WDC_WD15_EARS-00MVWB0_DCAA46930898-0:0-part4
cannot remove usb-WDC_WD15_EARS-00MVWB0_DCAA46930898-0:0-part4: only inactive hot spares, cache, top-level, or log devices can be removed

    ~# zpool status
  pool: tank
 state: DEGRADED
status: One or more devices has been taken offline by the administrator.
        Sufficient replicas exist for the pool to continue functioning in a
        degraded state.
action: Online the device using 'zpool online' or replace the device with
        'zpool replace'.
  scan: none requested
config:

        NAME                                                  STATE     READ WRITE CKSUM
        tank                                             DEGRADED     0     0     0
          mirror-0                                            DEGRADED     0     0     0
            ata-WDC_WD30EFRX-68AX9N0_WD-WMC1T0093794-part4    ONLINE       0     0     0
            usb-WDC_WD15_EARS-00MVWB0_DCAA46930898-0:0-part4  OFFLINE      0     0     0


    
### 3. Detach the device from pool
You can use the zpool detach command to detach a device from a mirrored storage pool.
            
    ~# zpool detach tank usb-WDC_WD15_EARS-00MVWB0_DCAA46930898-0:0-part4
    
    ~# zpool status
    
            pool: tank
            state: ONLINE
            scan: none requested
            config:

                    NAME                                              STATE     READ WRITE CKSUM
                    tank                                         ONLINE       0     0     0
                    ata-WDC_WD30EFRX-68AX9N0_WD-WMC1T0093794-part4  ONLINE       0     0     0

### 4. Find the id of the new device
Find the id of the new device to add to the pool, in our case start's with "ata-WDC_WD15EARS"
                    
    ~# ls -la /dev/disk/by-id/ | grep sdc4

            lrwxrwxrwx 1 root root  10 Jan 15 11:39 ata-WDC_WD15EARS-00MVWB0_WD-WCAZA4693089-part4 -> ../../sdc4


### 5. Attach the new device to pool
Attach the new device to pool and after that you have a two-way mirrored storage pool ;-)

    ~# zpool attach tank ata-WDC_WD30EFRX-68AX9N0_WD-WMC1T0093794-part4 ata-WDC_WD15EARS-00MVWB0_WD-WCAZA4693089-part4

    ~# root@terrance /h/r/S/g/a/howto# zpool status
  
            pool: tank
            state: ONLINE
            status: One or more devices is currently being resilvered.  The pool will
                    continue to function, possibly in a degraded state.
            action: Wait for the resilver to complete.
            scan: resilver in progress since Fri Jan 15 14:24:43 2016
                254M scanned out of 196G at 31.7M/s, 1h45m to go
                253M resilvered, 0.13% done
            config:

                    NAME                                                STATE     READ WRITE CKSUM
                    tank                                           ONLINE       0     0     0
                    mirror-0                                          ONLINE       0     0     0
                        ata-WDC_WD30EFRX-68AX9N0_WD-WMC1T0093794-part4  ONLINE       0     0     0
                        ata-WDC_WD15EARS-00MVWB0_WD-WCAZA4693089-part4  ONLINE       0     0     0  (resilvering)



---

[zfsbuild website]: <http://www.zfsbuild.com/2010/06/03/howto-create-mirrored-vdev-zpool/>
[oracle attach and detach]: <http://docs.oracle.com/cd/E19253-01/819-5461/gcfhe/index.html>

