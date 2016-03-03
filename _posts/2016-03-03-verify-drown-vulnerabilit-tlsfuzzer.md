---
layout: post
title:  "Verify DROWN vulnerability - tlsfuzzer"
date:   2016-03-03 11:55
categories: sslv2 drown verify tlsfuzzer openssl
---

OpenSSL Security Advisory shows us a script to verify a server is not vulnerable to DROWN as described on [openssl.org] website.

Reproducer requires Python 2.6 or 3.2 or later, you will also need git 
to download the sources


Download reproducer:

    ~$ git clone https://github.com/tomato42/tlsfuzzer
    ~$ cd tlsfuzzer
    ~$ git checkout ssl2


Download reproducer dependencies

    ~$ git clone https://github.com/tomato42/tlslite-ng .tlslite-ng
    ~$ ln -s .tlslite-ng/tlslite tlslite
    ~$ pushd .tlslite-ng


Go to branch _sslv2_

    ~$ git checkout sslv2
    ~$ popd
    ~$ git clone https://github.com/warner/python-ecdsa .python-ecdsa
    ~$ ln -s .python-ecdsa/ecdsa ecdsa


Verify that server _example.com_ don't support SSLv2 at all:
First let's do a tunnel to our Web Server with SSH, and do a curl do ensure that you receive output ;-)

    ~$ ssh -f example.com -L 4443:localhost:443 -N
    ~$ curl http://localhost:4443

    ~$ PYTHONPATH=. python scripts/test-sslv2-force-export-cipher.py \
-h localhost -p 4443


And verify that server don't support export grade SSLv2 ciphers, 
use the following command:

    ~$ PYTHONPATH=. python scripts/test-sslv2-force-cipher.py -h localhost -p 4443



---
[openssl.org]: <https://mta.openssl.org/pipermail/openssl-dev/2016-March/005602.html>
