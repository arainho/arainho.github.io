---
layout: post
title:  "Setup GitLab-CE runner"
date:   2016-02-22 14:00:02
categories: gitlab gitlab-ce runner
---

To setup gitlab-ci-multi-runner follow the Installation using GitLab's repository for Debian/Ubuntu/CentOS/RedHat (preferred)
as described on [gitlab] website.


Install curl

    ~$ apt-get update; apt-get install curl;


To use Docker runner, install it before using the multi runner:

    ~$ curl -sSL https://get.docker.com/ | sh


Add GitLab's official repository via apt-get or yum:

    # For Debian/Ubuntu
    ~$ curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash


Install gitlab-ci-multi-runner:

    # For Debian/Ubuntu
    ~$ sudo apt-get install gitlab-ci-multi-runner



Find your project page

    https://gitlab.com/dashboard/projects


Enter the project page and choose _Settings_ at the lower left corner,
scroll down to _Advanced settings_ and copy _CI token_

    https://gitlab.com/mygroup/my-project/edit


Register the runner.


    ~$ sudo gitlab-ci-multi-runner register

            Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci )
            https://gitlab.com/ci
            Please enter the gitlab-ci token for this runner
            xxx
            Please enter the gitlab-ci description for this runner
            my-runner
            INFO[0034] fcf5c619 Registering runner... succeeded
            Please enter the executor: shell, docker, docker-ssh, ssh?
            docker
            Please enter the Docker image (eg. ruby:2.1):
            ruby:*
            INFO[0037] Runner registered successfully. Feel free to start it, but if it's
            running already the config should be automatically reloaded!


    ~# cat /etc/gitlab-runner/config.toml 

    concurrent = 5
    
    [[runners]]
      name = "docker-runner"
      url = "https://gitlab.com/ci"
      token = "xx"
      tls-ca-file = ""
      executor = "docker"
      [runners.docker]
        image = "debian:jessie"
        privileged = false
        volumes = ["/cache"]
        allowed_images = ["ruby:*", "python:*", "java:*", "gcc:*"]

    
    ~# gitlab-runner status
    
        gitlab-runner: Service is running!



Finaly go to GitLab dashboard and check the new runner :-)

    https://gitlab.com/admin/runners


---
[gitlab]: <https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-repository.md>
