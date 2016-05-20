---
layout: post
comments: true
title:  "Use top to monitor I/O on FreeBSD"
date:   2016-02-10  16:53:00
categories: freebsd top io
---

To monitor processes by I/O instead of CPU, on Linux we have "iotop". 
_iotop_ does not exist on FreeBSD. We can use iostat or top like this.

	
    ~# top -m io -o total

    ~# iostat -w 1

