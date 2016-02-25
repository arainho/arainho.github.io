---
layout: post
title:  "Runnning your own ELK stack on Rancher"
date:   2016-02-25 07:18:39
categories: ELK Rancher
---

I want to run a ELK stack on Rancher, i found a detailed step-by-step guide at [rancher] website

0. Prepare the environment

Go to http://company.com:8080/api and find your "Endpoint for 'Default' Environment"
this Endpoint will be your RHANCER_URL.

Click on "Add API Key" and you will see the a Username(RANCHER_ACCESS_KEY) and a Password(RANCHER_SECRET_KEY), please register these values in a file. 

	~$ mkdir my-elk
	~$ cd my-elk
	~$ vi creds
	
		export RANCHER_URL="http://company.com:8080/v1/projects/1a5"
		export RANCHER_ACCESS_KEY="your_access_key"
		export RANCHER_SECRET_KEY="your_secret_key"

In a bash shell do

	~$ source creds

Download rancher-compose from this URL

https://github.com/rancher/rancher-compose/releases/latest/

    ~$ wget https://github.com/rancher/rancher-compose/releases/download/v0.7.2/rancher-compose-linux-amd64-<version-number>.tar.gz
    ~$ tar zxvf rancher-compose-linux-amd64-<version-number>.tar.gz
    ~$ sudo mv -v rancher-compose-v0.7.2/rancher-compose /usr/local/bin/

    ~$ rancher-compose -v

        rancher-compose version v0.7.2


1. Clone our _compose-templates_ repository:
	
	~$ git clone https://github.com/rancher/compose-templates.git


First lets bring up the Elasticsearch cluster.

        ~$ cd compose-templates/elasticsearch


First try will fail, cannot find the docker-compose.yml file.
	
	~$ rancher-compose -p es up 
       
		ERRO[0000] Failed to find docker-compose.yml            
		FATA[0000] Failed to read project: open docker-compose.yml: no such file or directory  

	~$ find . -name docker-compose.yml

		./0.1.0/docker-compose.yml
		./0.2.0/docker-compose.yml
		./0.2.1/docker-compose.yml
		./0.3.0/docker-compose.yml
		./0.3.1/docker-compose.yml

	~$ cd 0.3.1/

Next instruction will bring up four services: 
(Other services assume _es_ as the elasticsearch stack name)

- elasticsearch-masters
- elasticsearch-datanodes
- elasticsearch-clients
- kopf

<pre>
	~$ rancher-compose -p es up

	INFO[0001] Creating stack es                            
	INFO[0001] Creating service elasticsearch-masters       
	INFO[0006] Creating service elasticsearch-datanodes     
	INFO[0006] Creating service elasticsearch-clients       
	INFO[0011] Creating service kopf                        
	INFO[0015] Project [es]: Starting project               
	INFO[0015] [0/10] [elasticsearch-masters]: Starting     
	INFO[0216] [1/10] [elasticsearch-masters]: Started      
	INFO[0216] [1/10] [elasticsearch-clients]: Starting     
	INFO[0216] [1/10] [elasticsearch-datavolume-masters]: Starting  
	INFO[0216] [2/10] [elasticsearch-datavolume-masters]: Started  
	INFO[0216] [2/10] [elasticsearch-base-master]: Starting  
	INFO[0216] [2/10] [elasticsearch-datanodes]: Starting   
	INFO[0216] [3/10] [elasticsearch-base-master]: Started 
</pre>
        
Once Kopf is up, click on the container in the Rancher UI, and get the IP of the node it is running on.
Open a new tab in your browser and go to the IP, You should see one datanode on the page.

	http://node.company.com/#!/cluster


Now lets bring up our Logstash tier, this will bring up the following services:

- Redis
- logstash-collector
- logstash-indexer

<pre>
	~$ cd ../logstash
	~$ rancher-compose -p logstash up
</pre>

At this point, you can point your applications at logtstash://host:5000.
(Optional) Install logspout on your nodes

    ~$ cd ../logspout
    ~$ rancher-compose -p logspout up


This will bring up a logspout container on every node in your Rancher environment.
Logs will start moving through the pipeline into Elasticsearch.


Finally lets bring up Kibana 4, this will bring up the following services
- kibana-vip
- nginx-proxy
- kibana4


        ~$ cd ../kibana
        ~$ rancher-compose -p kibana up


Click the container in the kibana-vip service in the Rancher UI. 
Visit the host ip in a separate tab, you will be directed to the Kibana 4 landing page to select your index.

Now that you have a fully functioning ELK stack on Rancher, you can start sending your logs through the Logstash collector.
By default the collector is listening for Logstash inputs on UDP port 5000. 

If you are running applications outside of Rancher, you can simply point them to your Logstash endpoint. 
If your application runs on Rancher you can use the optional Logspout-logstash service above. 

If your services run outside of Rancher, you can configure your Logstash to use Gelf, and use the Docker log driver.
Alternatively, you could setup a Syslog listener, or any number of supported Logstash input plugins.


---
[rancher]: <http://rancher.com/running-our-own-elk-stack-with-docker-and-rancher/>


