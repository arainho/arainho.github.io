---
layout: post
title:  "Enable port 587 in postfix"
date:   2016-01-25 14:02:00
categories: jekyll psych gem
---


"Jekyll - uninitialized    constant Psych::Nodes (NameError)"

    ~$ jekyll serve

        /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:4:in `<class:PsychResolver>': uninitialized constant Psych::Nodes (NameError)
        from /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:2:in `<module:SafeYAML>'
        from /home/my-user/.gem/ruby/2.2.0/gems/safe_yaml-1.0.4/lib/safe_yaml/psych_resolver.rb:1:in `<top (required)>'
        ......
        
    ~$ sudo gem update --system

        RubyGems system software updated
    

    ~$ gem uninstall psych
        
        Successfully uninstalled psych-2.0.15


    ~$ jekyll serve

        Server address: http://127.0.0.1:4000/
        Server running... press ctrl-c to stop.
