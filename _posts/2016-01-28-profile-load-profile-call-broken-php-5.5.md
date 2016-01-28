---
layout: post
title:  "profile_load_profile call broken in php 5.5"
date:   2016-01-28 20:13:00
categories: drupal php5.5 profile_load_profile
---

I have a custom module in Drupal, after upgrading php to version from 5.3.2 to 5.5.9 php raises an error when using references in function calls.

I found the solution on [stackoverflow], removing the reference in &$account solves the issue.

     ~# cat /var/www/website/sites/all/modules/custom/my_custom.module

         // In the insert and login operation we make sure that the profile fields are initia

        -      profile_load_profile(&$account);
        +      profile_load_profile($account);
         
    
---
[stackoverflow]: <http://stackoverflow.com/questions/8971261/php-5-4-call-time-pass-by-reference-easy-fix-available>
