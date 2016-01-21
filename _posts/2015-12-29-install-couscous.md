---
layout: post
title:  "Put your documentation online with couscous"
date:   2015-12-29 17:00:00
categories: composer homebrew osx couscous
---

Couscous turn Markdown documentation into beautiful websites,
see more here. [couscous] 

### Install composer on a OS X, details at [composer] website.

	~$ brew install homebrew/php/composer


### Global installation of PHP tools with Composer [more]

	~$ composer global require phpunit/phpunit
	~$ composer global require phpunit/dbunit
	~$ composer global require phing/phing
	~$ composer global require phpdocumentor/phpdocumentor
	~$ composer global require sebastian/phpcpd
	~$ composer global require phploc/phploc
	~$ composer global require phpmd/phpmd
	~$ composer global require squizlabs/php_codesniffer


### After set up a global install of Composer just run:

	~$ composer global require couscous/couscous
	~$ export PATH=~/.composer/vendor/bin:$PATH

### Preview let´s just run:

	~$ couscous preview
	   .... php 5.4 or above is required to run the internal webserver

### Let´s install PHP version 5.4 or above

	~$ brew install php54

---
[couscous]: <http://couscous.io>
[composer]: <https://getcomposer.org>
[more]: <https://akrabat.com/global-installation-of-php-tools-with-composer/>
