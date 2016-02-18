---
layout: post
title:  "GitLab Community Edition - first steps"
date:   2016-02-16 18:22:02
categories: gitlab credentials openldap ldap
---

First I install GitLab-CE with a docker-composer stack, 
that i found at [stackfiles.io] as described in [my blog post].

Go to your OpenLDAP Server and create a user to use _bind_dn_ _named _gitlab-search_,
and check if you can search with this user


    ~# ldapsearch -LLL -H ldaps://ldap.mycompany.com -D uid=gitlab-search,ou=people,ou=mycompany,dc=com -b ou=people,ou=mycompany,dc=com -W

        Enter LDAP Password:


To _enable LDAP_ edit gitlab.rb, as decribed in [gitlab] setting-up-ldap-sign-in.

    ~# vi /etc/gitlab/gitlab.rb
    
        gitlab_rails['ldap_enabled'] = true
        gitlab_rails['ldap_servers'] = YAML.load <<-'EOS' # remember to close this block with 'EOS' below
          main: # 'main' is the GitLab 'provider ID' of this LDAP server
            label: 'LDAP'
            host: 'ldap.mycompany.com'
            port: 389
            uid: 'uid'
            method: 'tls' # "tls" or "ssl" or "plain"
            bind_dn: 'cn=gitlab-search,ou=people,ou=mycompany,dc=com'
            password: 'the_password_of_the_bind_user'
            active_directory: false
            allow_username_or_email_login: false
            block_auto_created_users: false
            base: 'ou=people,ou=mycompany,dc=com'
            user_filter: 'uid'
            attributes:
              username: ['uid', 'userid', 'sAMAccountName']
              email:    ['mail', 'email', 'userPrincipalName']
              name:       'cn'
              first_name: 'givenName'
              last_name:  'sn'
            ## EE only
            group_base: ''
            admin_group: ''
            sync_ssh_keys: false

If your OpenLDAP support _anonymous search_ edit your gitlab.rb,
and put a _empty fields_ on _bind_dn_ and _password_.

    ~# vi /etc/gitlab/gitlab.rb

            gitlab_rails['ldap_enabled'] = true
            gitlab_rails['ldap_servers'] = YAML.load <<-'EOS' # remember to close this block with 'EOS' below
              main: # 'main' is the GitLab 'provider ID' of this LDAP server
                label: 'LDAP'
                host: 'ldap.mycompany.com'
                port: 389
                uid: 'uid'
                method: 'tls' # "tls" or "ssl" or "plain"
                bind_dn: ''
                password: ''
                active_directory: false
                allow_username_or_email_login: false
                block_auto_created_users: false
                base: 'ou=people,ou=mycompany,dc=com'
                user_filter: ''
                attributes:
                  username: ['uid', 'userid', 'sAMAccountName']
                  email:    ['mail', 'email', 'userPrincipalName']
                  name:       'cn'
                  first_name: 'givenName'
                  last_name:  'sn'
                ## EE only
                group_base: ''
                admin_group: ''
                sync_ssh_keys: false
            

Install Your Company CA Certificate

    ~# cd /usr/share/ca-certificates/
    ~# wget http://mycompany.com/ca/MyCompany_Class_3_Root.crt
    ~# apt-get install --reinstall ca-certificates
    ~# dpkg-reconfigure ca-certificates

Check date and timezone on gitlab and ldap servers, it must be the same

    gitlab:~# date
    
        Wed Feb 17 11:32:23 UTC 2016

    ldap:~# date

        Wed Feb 17 11:32:33 WET 2016

    gitlab:~# cat /etc/timezone 
    
        Etc/UTC

    ldap :~# cat /etc/timezone
        
        Europe/Lisbon    

Go to you GitLab and check if you can search your LDAP Server

    ~# ldapsearch -H ldaps://ldap.mycompany.com  -x -b "ou=people,ou=mycompany,dc=com"


Reconfigure gitlab stuff

    ~# gitlab-ctl reconfigure

Check out the logs

    ~# gitlab-ctl tail

If you have a issue about invalid credentials, you can check more about it as described in [serverfault].

    ~# gitlab-rake gitlab:ldap:check RAILS_ENV=production


---
[my blog post]: <http://arainho.github.io/rancher/stack/docker-compose/gitlab/2016/02/12/rancher-first-stack.html>
[stackfiles.io]: <https://stackfiles.io/registry/5617e9eb31f4d50100cc9d2f>
[serverfault]: <http://serverfault.com/questions/658632/gitlab-openldap-invalid-credentials>
[gitlab]: <https://gitlab.com/gitlab-org/omnibus-gitlab/blob/629def0a7a26e7c2326566f0758d4a27857b52a3/README.md#setting-up-ldap-sign-in>
