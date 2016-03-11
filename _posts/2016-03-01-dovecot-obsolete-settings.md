---
layout: post
title:  "Dovecot Obsolete settings"
date:   2016-03-10 13:30
categories: dovecot upgrade obsolete-settings
---

I upgrade Dovecot to version, and after that i have to change some parameters.


	mail-server ~ # dovecot --version
	
			2.1.7


	mail-server ~ # service dovecot restart

		doveconf: Warning: NOTE: You can get a new clean config file with: doveconf -n > dovecot-new.conf
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:25: 'imaps' protocol is no longer necessary, remove it
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:50: listen=..:port has been replaced by service { inet_listener { port } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:50: protocol { listen } has been replaced by service { inet_listener { address } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:51: ssl_listen=..:port has been replaced by service { inet_listener { port } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:51: protocol { ssl_listen } has been replaced by service { inet_listener { address } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:112: ssl_cert_file has been replaced by ssl_cert = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:113: ssl_key_file has been replaced by ssl_key = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:125: ssl_ca_file has been replaced by ssl_ca = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:380: fsync_disable has been renamed to mail_fsync
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:741: protocol managesieve {} has been replaced by protocol sieve { }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:914: add auth_ prefix to all settings inside auth {} and remove the auth {} section completely
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:952: passdb pam {} has been replaced by passdb { driver=pam }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:1066: userdb passwd {} has been replaced by userdb { driver=passwd }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:1128: auth_user has been replaced by service auth { user }
		[....] Restarting IMAP/POP3 mail server: dovecotdoveconf: Warning: NOTE: You can get a new clean config file with: doveconf -n > dovecot-new.conf
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:25: 'imaps' protocol is no longer necessary, remove it
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:50: listen=..:port has been replaced by service { inet_listener { port } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:50: protocol { listen } has been replaced by service { inet_listener { address } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:51: ssl_listen=..:port has been replaced by service { inet_listener { port } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:51: protocol { ssl_listen } has been replaced by service { inet_listener { address } }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:112: ssl_cert_file has been replaced by ssl_cert = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:113: ssl_key_file has been replaced by ssl_key = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:125: ssl_ca_file has been replaced by ssl_ca = <file
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:380: fsync_disable has been renamed to mail_fsync
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:741: protocol managesieve {} has been replaced by protocol sieve { }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:914: add auth_ prefix to all settings inside auth {} and remove the auth {} section completely
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:952: passdb pam {} has been replaced by passdb { driver=pam }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:1066: userdb passwd {} has been replaced by userdb { driver=passwd }
		doveconf: Warning: Obsolete setting in /etc/dovecot/dovecot.conf:1128: auth_user has been replaced by service auth { user }
		. ok 


Or we change things by hand:

	~# sed -i "s/ssl_cert_file/ssl_cert/g" /etc/dovecot/dovecot.conf
	~# sed -i "s/ssl_key_file/ssl_key/g" /etc/dovecot/dovecot.conf
	~# sed -i "s/fsync_disable/mail_fsync/g" /etc/dovecot/dovecot.conf
	~# sed -i "s/ssl_ca_file/ssl_ca/g" /etc/dovecot/dovecot.conf
	
	...............
	...........
	.....

	
Or you can get a new clean config file with: 

	~# cd /etc/dovecot/
	~# doveconf -n > dovecot-new.conf
	~# service dovecot restart

Test your IMAP server with this 

	~# openssl s_client -connect localhost:993


---
