---
layout: post
title:  "Install GitLab-CE on Ubuntu 14.04 LTS"
date:   2016-02-14 11:37
categories: gitlab gitlab-ce installation ubuntu
---

These are the instalation steps for GitLab Community Edition, the recommended way to install GitLab is with the Omnibus packages. I follow these steps as described at [gitlab] website.


1. Install and configure the necessary dependencies

<pre>
    ~$ sudo apt-get update
    ~$ apt-get install curl openssh-server ca-certificates postfix
</pre>

2. Add the GitLab package server and install the package
    
<pre>
    ~$ curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
    ~$ sudo apt-get install gitlab-ce
</pre>

3. Configure and start GitLab

    ~$ sudo gitlab-ctl reconfigure


4. Browse to the hostname and login

    Username: root
    Password: 5iveL!fe


#### After installation, you can do some maintenance commands as described here [gitlab maintenance]

Get service status

<pre>
    ~$ sudo gitlab-ctl status; 

        the output should look like this:

        run: nginx: (pid 972) 7s; run: log: (pid 971) 7s
        run: postgresql: (pid 962) 7s; run: log: (pid 959) 7s
        run: redis: (pid 964) 7s; run: log: (pid 963) 7s
        run: sidekiq: (pid 967) 7s; run: log: (pid 966) 7s
        run: unicorn: (pid 961) 7s; run: log: (pid 960) 7s
</pre>

#### Tail process logs as described here in [gitlab logs]

Tail all logs; press Ctrl-C to exit
    
    ~$ sudo gitlab-ctl tail

Drill down to a sub-directory of /var/log/gitlab

    ~$ sudo gitlab-ctl tail gitlab-rails

Drill down to an individual file

    ~$ sudo gitlab-ctl tail nginx/gitlab_error.log


#### Starting and stopping

Start all GitLab components
    
    ~$ sudo gitlab-ctl start

Stop all GitLab components

    ~$ sudo gitlab-ctl stop

Restart all GitLab components

    ~$ sudo gitlab-ctl restart


[gitlab]: <https://about.gitlab.com/downloads/#ubuntu1404>
[gitlab maintenance]: <https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/maintenance/README.md>
[gitlab logs]: <https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/settings/logs.md>

