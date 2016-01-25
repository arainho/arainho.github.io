---
layout: post
title:  "Enable port 587 in postfix"
date:   2016-01-25 13:35:00
categories: postfix ubuntu starttls 587
---

Since some ISP have port 25 disabled in their routers to prevent spam.

A client want to use port 587 port with STARTTLS, i need to enable the submission port (587) in postfix 
to be able to send emails from your local email client to your own mailserver.

To enable port 587, edit the file /etc/postfix/master.cf
and remove the # in front of the line:

    ~# vi /etc/postfix/master.cf

          submission inet n - n - - smtpd


After that restart postfix:
    
    ~# service postfix restart


Check if postfix is listen on that port

    ~# netstat -antpl | grep 587

        tcp        0      0 0.0.0.0:587             0.0.0.0:*               LISTEN      29796/master
        tcp6       0      0 :::587                  :::*                    LISTEN      29796/master 


Test if mail server has STARTTLS enable

    ~# telnet localhost 587

        Trying 127.0.0.1...
        Connected to example.
        Escape character is '^]'.
        220 example.com ESMTP Postfix (Ubuntu)
        EHLO example.com           
        250-example.com
        250-PIPELINING
        250-SIZE 10240000
        250-ETRN
        250-STARTTLS
        250-AUTH LOGIN PLAIN
        250-AUTH=LOGIN PLAIN
        250-ENHANCEDSTATUSCODES
        250-8BITMIME
        250 DSN
        



---
[faqforge]: <http://www.faqforge.com/linux/how-to-enable-port-587-submission-in-postfix/>

