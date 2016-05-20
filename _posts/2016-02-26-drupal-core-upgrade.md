---
layout: post
comments: true
title:  "Drupal core upgrade"
date:   2016-02-26 15:42
categories: drupal upgrade
---

These are the steps to upgrade drupal core.

    ~# cd /var/www/website

        sed -i "s/\$update_free_access = .*/\$update_free_access = TRUE;/g" ./sites/default/settings.php

    ~# drush en update

        update is already enabled.                          [ok]
        There were no extensions that could be enabled.     [ok]

    ~# drush up

        Update information last refreshed: Fri, 26/02/2016 - 08:21
        No code updates available.                          [ok]

    ~# drush up drupal

        Update information last refreshed: Fri, 26/02/2016 - 08:21
        No code updates available.                          [ok]

Let's refresh the available releases 

    ~# drush rf 


Check for new core releases of Drupal

    ~# drush pm-releases

         Project  Release  Date         Status   
         drupal   6.38     2016-Feb-24  Security 

Try to upgrade

    ~# drush pm-update drupal

        Update information last refreshed: Fri, 26/02/2016 - 08:21
        No code updates available.                          [ok]

Let's Force upgrade
Warning !!! backup your database, webroot and files .htaccess and robots.txt.  

    ~# drush pm-update drupal-6.38

         Name    Installed Version  Proposed version  Message                     
         Drupal  6.37               6.38              Specified version available 


        Do you really want to continue? (y/n): y
        Project drupal was updated successfully. Installed version is now 6.38.
        
        Do you wish to run all pending updates? (y/n): y

        Executing system_update_6056                                            [success]
        ALTER TABLE {sessions} CHANGE `session` `session` LONGBLOB DEFAULT NULL [success]
        'all' cache was cleared.                                                [success]

        Finished performing updates



Change Permissions

        ~# chown -Rv www-data:www-data -- /var/www/website/


Go online, clear cache and check your website

        ~# drush vset --exact maintenance_mode 0
        ~# drush cache-clear all

