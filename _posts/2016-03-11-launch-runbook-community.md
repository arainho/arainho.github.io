---
layout: post
title:  "Launch RunBook Community"
date:   2016-03-11 10:56
categories: runbook containers linux
---

### Intro
I installed a RunBook container on Rancher farm, setup some monitoring alerts and start to setup some action reactions.
The container goes down and I lost a few settings ...  

### Option 1.
So let´s launch the container with a volume attached :-)

To mount a host directory as a data volume,
create a directory on the host and use _-v_ option when launch the container.

	~# /# mkdir /volumes/runbook

	~# sudo docker run -d --name runbook -v /volumes/runbook:/ -p 8000:8000 --link runbook_rethinkdb:runbook_rethinkdb --link runbook_redis:runbook_redis runbook/runbook

### Option 2.

Deploy Runbook in a highly available and distributed fashion, 
we can use an Docker Compose as described on [runbook docs].

On github we have the [docker-compose] file.

	~# wget https://raw.githubusercontent.com/Runbook/runbook/master/docker-compose.yml 
	~# docker-compose up 

For more details on Runbook go to the [runbook] quick start.


---
[runbook]: <http://runbook.readthedocs.org/en/latest/quick-start/>
[runbook docs]: <http://runbook.readthedocs.org/en/latest/install_docker_compose/>
[docker-compose]: <https://raw.githubusercontent.com/Runbook/runbook/master/docker-compose.yml>
