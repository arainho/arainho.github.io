---
layout: post
title:  "Jekyll uninitialized constant"
date:   2016-01-25 14:02:00
categories: jekyll psych gem
---


I try to run jekyll and get this warning "Jekyll - uninitialized constant",
i search and found the solution on [github]

I follow these steps:


    ~$ jekyll serve

        /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:4:in `<class:PsychResolver>': uninitialized constant Psych::Nodes (NameError)
        from /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:2:in `<module:SafeYAML>'
        from /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:1:in `<top (required)>'
        ......
        
    ~$ sudo gem update --system

        RubyGems system software updated
    

    ~$ gem uninstall psych
        
        Successfully uninstalled psych-2.0.15


    ~$ gem install psych -v 2.0.5

        Fetching: psych-2.0.5.gem (100%)
        Building native extensions.  This could take a while...
        Successfully installed psych-2.0.5
        1 gem installed


    ~$ jekyll serve

        Server address: http://127.0.0.1:4000/
        Server running... press ctrl-c to stop.


---
[github]: <https://github.com/dtao/safe_yaml/issues/72>

