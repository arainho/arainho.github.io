---
layout: post
comments: true
title:  "Install ipython on Mac OS X"
date:   2016-01-29 12:04:19
categories: osx python ipython pip
---

First we need to install python via Homebrew, there is a nice post at [stackoverflow] or check out [python-guide].

	~$ brew install python
	~$ brew linkapps python
	~$ sudo pip install --upgrade pip setuptools
	~$ sudo pip install ipython

And finally ipython is working !

	~> ipython

	IPython 4.0.3 -- An enhanced Interactive Python.
	
	  ?         -> Introduction and overview of IPython's features.
	  %quickref -> Quick reference.
	  help      -> Python's own help system.
	  object?   -> Details about 'object', use 'object??' for extra details.

	  In [1]:


---
[python-guide]: <http://docs.python-guide.org/en/latest/starting/install/osx/>
[stackoverflow]: <http://docs.python-guide.org/en/latest/starting/install/osx/>


