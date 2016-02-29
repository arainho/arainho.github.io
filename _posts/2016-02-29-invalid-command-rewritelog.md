---
layout: post
title:  "Apache - Invalid command RewriteLog"
date:   2016-02-29 17:00
categories: apache mod_rewrite upgrade
---

The issue appear after upgrading and old Apache2.2 to Apache2.4.

    ~# service apache2 restart

         * Restarting web server apache2                [fail] 
         * The apache2 configtest failed.

        Output of config test was:
        AH00526: Syntax error on line 11 of /etc/apache2/sites-enabled/www-mycompany:
        Invalid command 'RewriteLog', perhaps misspelled or defined by a module 
        not included in the server configuration

        Action 'configtest' failed.
        The Apache error log may have more information.



Earlier versions of mod_rewrite use RewriteLog and RewriteLogLevel directives.
This functionality has been completely replaced by new per-module logging configuration like mentioned on [apache docs]

    ~# cat /etc/apache2/sites-enabled/www-mycompany | grep LogLevel
 
       LogLevel alert rewrite:trace3


To get just the mod_rewrite-specific log messages, pipe the log file through grep:

    ~# tail -f error_log|fgrep '[rewrite:'



---
[apache docs]: <https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html>

