---
layout: post
title:  "Install rancher-compose on Arch Linux"
date:   2016-02-10 19:16:00
categories: rancher rancher-compose linux arch-linux
---


Add ~/bin to your path

    ~$ cd ~/bin
    ~$ PATH=$PATH:$HOME/bin 

    on a fish shell
    ~$ fish
    ~> set PATH $PATH $HOME/bin

Go to [rancher github] and download the release for your OS

    ~$ wget https://github.com/rancher/rancher-compose/releases/download/v0.7.2-rc1/rancher-compose-linux-amd64-<version>.tar.gz
    ~$ tar zxvf rancher-compose-linux-amd64-<version>.tar.gz
    ~$ mv rancher-compose-linux-amd64-<version>/rancher-compose .


Test it

    ~> rancher-compose -v

        _rancher-compose version v0.7.2-rc1_


---
[rancher github]: <https://github.com/rancher/rancher-compose/releases>
