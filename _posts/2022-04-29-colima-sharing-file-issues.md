### Introduction
After Docker Desktop changed its new licensing schema, some people went after alternatives such as a Linux VM with docker daemon inside, minikube, Rancher Desktop, and Colima.     
I tried them all and end up in Colima after issues with sharing folders/files between host and containers and also port forwarding.   

"Now let me show you what happens when I share a file from `/tmp/file` to a docker container with Colima ..."

It’s 28th April and I'm using the following software versions:
```bash
docker client version: 20.10.12
colima version: 0.3.4
macOS: 11.6.5
```

### The colima sharing file issue
The steps to reproduce the issue are the following:

Download and ensure file is present.
```bash
curl -o /tmp/config.yaml https://example.com/config.yaml
test -f /tmp/config.yaml && echo "it's a file"
```

Removing any config file from colima Linux VM.
```bash
colima ssh exec sudo rmdir /tmp/config*
```

Try to share a file whitin a container.
```bash
docker run -it --rm -v /tmp/config.yaml:/opt/config.yaml alpine /bin/sh -c "test -d /opt/config.yaml && echo it\'s a directory"
```

colima ends up creating a directory !
```bash
colima ssh exec ls /tmp/config.yaml && echo $?
```

Remove the file from your macOS host 
```bash
rm /tmp/config.yaml
test -f /tmp/config.yaml || echo "config.yaml not found"
```

And the directory remains in colima Linux VM  !
```bash
colima ssh exec ls /tmp/config.yaml && echo $?
```

Now use other container to share /tmp from host and you have "trash" from colima's /tmp
```bash
docker run -it --rm -v /tmp:/opt ubuntu /bin/sh -c "test -d /opt/config.yaml && ls -ld /opt/config.yaml"
```

Stop and start colima Linux VM, and /tmp/config.yaml dir remains there !
```bash
colima stop
colima start
colima ssh exec ls /tmp/config.yaml && echo $?
```

### Solution
It’s 29th April and I open a [issue#267](https://github.com/abiosoft/colima/issues/267) in the Colima GitHub repository and receive a response.

Only two host directories are available to the Linux VM and Docker containers: $HOME and `/tmp/colima`. 
I need to use `/tmp/colima/file` instead of `/tmp/file` and after that, I'm able to share a file from host to container.
```bash
docker run -it --rm -v /tmp/config.yaml:/opt/config.yaml alpine /bin/sh -c "test -d /opt/config.yaml && echo it\'s a directory"
```


