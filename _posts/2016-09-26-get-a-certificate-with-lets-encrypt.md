---
layout: post
title:  "Enable HTTPS on your website with Let’s Encrypt"
date:   2016-09-26 15:57
categories: $tag1 $tag2
---
# Let's Encrypt
Let's Encrypt is a new Certificate Authority:
It's free, automated, and open

# Enable HTTPS Automatically
Automatically enable HTTPS on your website with EFF's Certbot, 
deploying Let's Encrypt certificates.


### To install just do
```sh
mkdir /usr/local/bin/ || exit
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
```


### If you would like to generate specific certificates, use the certonly command. 
```sh
certbot-auto --agree-tos --email admin@example.com --apache certonly -n -d example.com -d example.org
```

### Add your new certificate to Apache
In Apache if you need to specify the chain file, otherwise clients will complain about certificate hierarchy in some browsers and Operating Systems.

vi /etc/apache2/sites-enabled/000-defaul-ssl

        SSLCertificateFile      /etc/letsencrypt/archive/example.com/cert1.pem
        SSLCertificateKeyFile   /etc/letsencrypt/archive/example.com/privkey1.pem
        SSLCertificateChainFile /etc/letsencrypt/archive/example.com/chain1.pem

### Or add the new certificate to nginx

vi /etc/nginx/nginx.conf

        ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;


### Automating renewal
Let's Encrypt certificates last for 90 days, 
so it's highly advisable to renew them automatically! 

We can use _pre-hook_ and _post-hook_ to stop services before renewing the certificates and after,
in this case i use _apache2_ but can be _nginx_.
Let's test automatic renewal for our certificates by running this command:

```sh
certbot-auto renew \
    --dry-run \
    --force-renew \
    --standalone \
    --noninteractive \
    --pre-hook "service apache2 stop" \
    --post-hook "service apache2 start"
```

And finally add a line to cron, _auto-renew-certs.sh_ it's the previous command in a script.

```sh
# Let's Encrypt 
0 3 1 * * root /usr/local/bin/auto-renew-certs.sh | mail -e -s "[Let's Encrypt] monthly renew certs" admin@example.com
```

#### Some usefull links

https://certbot.eff.org/
https://certbot.eff.org/#ubuntuother-apache
https://certbot.eff.org/docs/using.html#renewal
https://certbot.eff.org/docs/using.html#renewing-certificates
