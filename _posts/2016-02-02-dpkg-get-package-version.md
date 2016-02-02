---
layout: post
title:  "Get package version on Debian/Ubuntu Systems"
date:   2016-02-02 11:35:12
categories: dpkg package version debian ubuntu linux
---

To check a version of a package with dpkg do this,
i found the tip on [askubuntu]

    ~$ MY_PACKAGE="curl"
    ~$ dpkg-query --showformat='${Version}' --show "${MY_PACKAGE}"


---
[askubuntu]: <http://askubuntu.com/questions/15452/how-can-i-find-the-version-number-of-an-installed-package-via-dpkg>
