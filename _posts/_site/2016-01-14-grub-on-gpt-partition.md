# GRUB on GPT Partitions

GPT partition tables do not have the limit of 4 primary partitions (unlike MBR) but requires an additional (small) partition to be able to boot from GNU GRUB. 
Use mktable gpt to initialize a disk with a GPT partition table:

<pre>
(parted) mktable gpt
</pre>

3 partitions are at least required to use GPT: 
1 small partition (1MB) with no filesystem at the first 2GB of the disk with toggle bios_grub used for booting, 
and 2 more for the rootfs and swap, i.e:

If you don't have this 1MB partition you get this
<pre>
~# grub-install /dev/sdb

Installing for i386-pc platform.
grub-install: warning: this GPT partition label contains no BIOS Boot Partition; embedding won't be p
ossible.
grub-install: warning: Embedding is not possible.  GRUB can only be installed in this setup by using 
blocklists.  However, blocklists are UNRELIABLE and their use is discouraged..
grub-install: error: will not proceed with blocklists.
</pre>

Create partitions
<pre>
parted> mkpart primary ext2 1 2
parted> set 1 bios_grub on
parted> mkpart primary linux-swap 2 32G
parted> mkpart primary ext4 32G 100%
parted> quit
</pre>

List partitions
<pre>
(parted) p
Model: HP LOGICAL VOLUME (scsi)
Disk /dev/sdb: 1000GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt

Number  Start   End     Size    File system  Name     Flags
 1      262kB   2097kB  1835kB               primary  bios_grub
 2      2097kB  32.0GB  32.0GB               primary
 3      32.0GB  1000GB  968GB                primary
</pre>

After this you can install GRUB with success
<pre>
~# grub-install /dev/sdb

Installing for i386-pc platform.
Installation finished. No error reported

https://github.com/voidlinux/documentation/wiki/Installer-Partitioning
https://wiki.archlinux.org/index.php/GRUB#GUID_Partition_Table_.28GPT.29_specific_instructions
