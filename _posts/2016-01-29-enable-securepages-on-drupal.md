---
layout: post
comments: true
title:  "Enable securepages on Drupal"
date:   2016-01-29 10:32
categories: drupal drush securepages_enabled
---

If you need to enable or disable [securepages] in Drupal you can follow these steps, i found some info at [stackoverflow].

    Go to your vhost folder
    ~$ cd /var/www/example.com
    
    To disable do
    ~$ drush -l example.com vset securepages_enable 0

    To enable do this
    ~$ drush -l example.com vset securepages_enable 1


---
[stackoverflow]: <http://stackoverflow.com/questions/4539608/how-to-disable-secure-pages-on-a-local-server>
[securepages]: <https://www.drupal.org/project/securepages>


