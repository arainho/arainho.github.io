---
layout: post
title:  "Download GPG Keys Behind Firewall"
date:   2016-04-05 13:25:13
categories: gpg firewall linux rvm 
---



In case you need to download GPG keys, and you have some Firewall ou Proxy behind you.
In the proxy case you can do the following.

### Set Proxy

Check if proxy.mycompany.com and proxy1.mycompany.com are available.
<pre>
$ ping proxy.mycompany.com -c 3
$ ping proxy1.mycompany.com -c 3
</pre>

Define _http_proxy_ and _ftp_proxy_ environment vars
<pre>
$ export http_proxy="http://proxy1.mycompany.com:3128"
$ export ftp_proxy="http://proxy1.mycompany.com:3128"
</pre>

### Download Keys

In this case the keyserver is subkeys.pgp.net, keyserver.ubuntu.com and keyhash - 6A423791
<pre> 
$ gpg --keyserver subkeys.pgp.net --recv-key 6A423791
$ gpg --fingerprint 6A423791
$ gpg --armor --export 6A423791| apt-key add -
</pre>

<pre>
$ sudo apt-get update
</pre>

If you are behind a restricted Firewall:

Use TCP port 80 instead of 11371
<pre>
$ apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 fingerprint
</pre>

OR

<pre>
$ wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
$ sudo apt-get update
</pre>

OR

<pre>
Firefox -> Edit -> Preferences -> Advanced -> Network -> Settings -> manual proxy configuration

HTTP Proxy: proxy.mycompany.com port: 3128
select Use this proxy for all server protocols

Download the key
http://deb.opera.com/archive.key

Go to System -> Administration -> Software Sources -> Authentication -> Import Key File -> select archive.key
System -> Administration -> Synaptic -> Reload
</pre>

### Practical Example

I need to install RVM (Ruby Version Manager), and I did it this way.
<pre>
$ gpg --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ curl -sSL https://get.rvm.io | bash -s stable
<pre>
