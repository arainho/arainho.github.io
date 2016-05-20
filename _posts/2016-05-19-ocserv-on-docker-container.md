---
layout: post
comments: true
title:  "OpenConnect VPN Server on Docker container"
date:   2016-05-19 16:12
categories: vpn openconnect docker ocserv
---

## OpenConnect VPN Server -- 'ocserv'

OpenConnect server (ocserv) is an SSL VPN server. Its purpose is to be a secure, small, fast and configurable VPN server. It implements the OpenConnect SSL VPN protocol, and has also (currently experimental) compatibility with clients using the AnyConnect SSL VPN protocol. The OpenConnect protocol provides a dual TCP/UDP VPN channel, and uses the standard IETF security protocols to secure it. The server is implemented primarily for the GNU/Linux platform but its code is designed to be portable to other UNIX variants as well. 

http://www.infradead.org/ocserv/manual.html

## Setup Server
The setup was  adopted from a github project named [wppurking/ocserv-docker].
Assuming that the server hostname is _server.example.com_

```sh
ssh you@server.example.com
./launch_ocserv.sh
```

My script to launch ocserv container is this:

```sh
cat ./launch_ocserv.sh
```

```sh
#!/bin/bash

OCSERV_GIT_DIR="ocserv-docker"
GITHUB_URL="https://github.com/wppurking/ocserv-docker.git"

echo "GET git clone"
if [ -d ocserv-docker ]
then
        echo "${OCSERV_GIT_DIR} exits"
else
        cd ~
        git clone ${GITHUB_URL}
fi

echo "LAUNCH ocserv container"
docker run -dt --privileged --name ocserv -v ~/ocserv-docker/ocserv:/etc/ocserv -p 443:443/tcp ocserv-docker

echo "CHECK container"
docker ps -aq | xargs docker logs
```

## Clean default users
Remove the default users of the docker container

```sh
FILE="/etc/ocserv/ocpasswd"
SED_COMMAND=(sed -i '1,2d' ${FILE})
docker exec -it "$(docker ps -a | grep vpn_run | awk '{print $ 1}')" "${SED_COMMAND[@]}"
```

## Add a new user

```sh
OCSERV_DOCKER_ID=$(docker ps -a | grep vpn_run | awk '{print $1}')
docker exec -it ${CSERV_DOCKER_ID} ocpasswd my_username
```
  

## On Client

### check openconnect version
You should have OpenConnect version v7.06 or higher :-)

```sh
openconnect --version
```

### manually

```sh
sudo openconnect --no-cert-check --no-dtls server.example.com
```

### automatically with a script

```sh
MY_USER="my_username"
MY_PASSWORD="my_password"
echo -n ${MY_PASSWORD} | sudo openconnect --no-cert-check --no-dtls --background -u ${MY_USER} --passwd-on-stdin server.example.com
```

---
[wppurking/ocserv-docker]: https://github.com/wppurking/ocserv-docker.git
