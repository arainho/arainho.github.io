---
layout: post
comments: true
title:  "GitLab - smtp settings"
date:   2016-02-19 11:56:00
categories: gitlab smtp settings
---

SMTP settings

If you would rather send application email via an SMTP server instead of via Sendmail, add the following configuration information to _/etc/gitlab/gitlab.rb_ and run _gitlab-ctl reconfigure._ Check out more info at [gitlab] website.

    ~# cat /etc/gitlab/gitlab.rb | grep smtp | grep -v "#"

        gitlab_rails['smtp_enable'] = true
        gitlab_rails['smtp_address'] = "smtp.server"
        gitlab_rails['smtp_port'] = 465
        gitlab_rails['smtp_user_name'] = "smtp user"
        gitlab_rails['smtp_password'] = "smtp password"
        gitlab_rails['smtp_domain'] = "example.com"
        gitlab_rails['smtp_authentication'] = "login"
        gitlab_rails['smtp_enable_starttls_auto'] = false
        gitlab_rails['smtp_tls'] = true

If your SMTP server does not like the default 'From: gitlab@localhost' you

        gitlab_rails['gitlab_email_from'] = 'gitlab@example.com'
        gitlab_rails['gitlab_email_reply_to'] = 'noreply@example.com'


Run reconfigure 

    ~# gitlab-ctl reconfigure

Check logs if you need with _tail_ or in the interface.

    ~# tail -f /var/log/gitlab/gitlab-rails/sidekiq.log

---
[gitlab]: <https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/settings/smtp.md>
