---
layout: post
title:  "Postfix Settings - The DROWN Attack"
date:   2016-03-03 15:45
categories: drown drown-attack postfix
---

Ensure that your Postfix configuration disables SSLv2, and weak or obsolete ciphers, you should also deploy the appropriate OpenSSL upgrade.

The below recommended TLS settings for Postfix are sufficient to avoid exposure to DROWN. 
Many of these are defaults in sufficiently recent releases, I follow this [postfix] config.


Change your config to this:

    ~# vi /etc/postfix/main.cf

        # Disable deprecated SSL protocol versions.  See:
        # http://www.postfix.org/postconf.5.html#smtp_tls_protocols
        # http://www.postfix.org/postconf.5.html#smtpd_tls_protocols
        #
        # Default in all supported stable Postfix releases since July 2015.
        # Defaults for the mandatory variants never allowed SSLv2.
        #
        smtpd_tls_mandatory_protocols = !SSLv2, !SSLv3
        smtpd_tls_protocols = !SSLv2, !SSLv3
        smtp_tls_mandatory_protocols = !SSLv2, !SSLv3
        smtp_tls_protocols = !SSLv2, !SSLv3
        lmtp_tls_mandatory_protocols = !SSLv2, !SSLv3
        lmtp_tls_protocols = !SSLv2, !SSLv3
        tlsproxy_tls_mandatory_protocols = ${smtpd_tls_mandatory_protocols}
        tlsproxy_tls_protocols = ${smtpd_tls_protocols}
        
        # Disable export and low-grade ciphers.  See:
        # http://www.postfix.org/postconf.5.html#smtpd_tls_ciphers
        # http://www.postfix.org/postconf.5.html#smtp_tls_ciphers
        #
        # Default in all supported stable Postfix releases since July 2015.
        #
        smtpd_tls_ciphers = medium
        smtp_tls_ciphers = medium
        
        # Enable forward-secrecy with a 2048-bit prime and the P-256 EC curve. See
        # http://www.postfix.org/FORWARD_SECRECY_README.html#server_fs
        # http://www.postfix.org/postconf.5.html#smtpd_tls_dh1024_param_file
        # http://www.postfix.org/postconf.5.html#smtpd_tls_eecdh_grade
        #
        # The default DH parameters use a 2048-bit strong prime as of Postfix 3.1.0.
        #
        smtpd_tls_dh1024_param_file=${config_directory}/dh2048.pem
        smtpd_tls_eecdh_grade = strong
        
        # Trimmed cipherlist improves interoperability with old Exchange servers
        # and reduces exposure to obsolete and rarely used crypto.  See:
        # http://www.postfix.org/postconf.5.html#smtp_tls_exclude_ciphers
        # http://www.postfix.org/postconf.5.html#smtpd_tls_exclude_ciphers
        #
        smtp_tls_exclude_ciphers =
            EXPORT, LOW, MD5,
            aDSS, kECDHe, kECDHr, kDHd, kDHr,
            SEED, IDEA, RC2
        smtpd_tls_exclude_ciphers =
            EXPORT, LOW, MD5, SEED, IDEA, RC2

Generate the Diffie-Hellman file _dh2048.pem_

    ~# openssl gendh -out /etc/postfix/dh2048.pem -2 2048


Test your configuration:

    ~# service postfix check
    ~# service postfix stop
    ~# service saslauthd stop


Check if it's real stopped:

    ~# ps aux | grep postfix


Start _saslauthd_ and _postfix_

    ~# service saslauthd start
    ~# service postfix start


Test your config with _openssl_

    ~# openssl s_client -connect example.com:25 -ssl3
    ~# openssl s_client -connect example.com:25 -ssl2
    

Go to [drownattack] website and see if you are vulnerable.


---
[postfix]: <https://drownattack.com/postfix.html>
[drownattack]: <https://test.drownattack.com>
