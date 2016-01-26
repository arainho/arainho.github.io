---
layout: post
title:  "Install Drush via composer"
date:   2016-01-26  10:46:00
categories: drush composer drupal
---

To install Drush via Composer, i follow the instructions of [drush website]

#### 1. Install Composer globally.


    ~# curl -sS https://getcomposer.org/installer | php

        All settings correct for using Composer
        Downloading...

        Composer successfully installed to: /root/composer.phar
        Use it: php composer.phar


    ~# mv composer.phar /usr/local/bin/composer
    ~# bash -l
    ~# composer


#### 2. Add composer's bin directory to the system path by placing composer path on bash_profile (Mac OS users) or into your ~/.bashrc (Linux users).

        ~# echo "export PATH="$HOME/.composer/vendor/bin:$PATH"" >>  ~/.bash_profile

        OR        

        ~# echo "export PATH="$HOME/.composer/vendor/bin:$PATH"" >> ~/.bashrc

#### 3. Install latest stable Drush: 

        ~# composer global require drush/drush.
    
            Changed current directory to /root/.composer
            Using version ^7.1 for drush/drush
            ./composer.json has been created
            Loading composer repositories with package information
            Updating dependencies (including require-dev)
              - Installing pear/console_table (v1.2.1)
                Downloading: 100%         
            
              - Installing symfony/polyfill-mbstring (v1.1.0)
                Downloading: 100%         
            
              - Installing symfony/var-dumper (v2.8.2)
                Downloading: Connecting...
            

#### 4. Verify that Drush works: 
    
        ~# drush status


[drush website]: <http://docs.drush.org/en/master/install-alternative/>
