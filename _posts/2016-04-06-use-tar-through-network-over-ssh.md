---
layout: post
title:  "Use tar through network over SSH"
date:   2016-04-06 10:37
categories: tar ssh network
---

The tar archiving utility can be use through network over ssh session
Following command backups /mydata directory to server.example.com (IP 192.168.1.201) host over ssh session.

The default first SCSI tape drive under Linux is /dev/st0. You can read more about tape drives naming convention used under Linux here.

```sh
~# tar zcvf - /mydata | ssh root@server.example.com "cat > /backup/mydata.tar.gz"
```
