---
layout: post
comments: true
title:  "Move running process to new screen shell"
date:   2016-07-01 09:34
categories: running process screen shell
---

In order to move a running process on your current shell to a new screen session.

Imagine that your connected via ssh to a remote server and your current job is taking to long to complete ...
or you forgot to open a tmux or a screen session and launch a long task ...

I found the solution at [serverfault], and an nice post at [monkeypatch] blog.

```
$ htop                 # Launch new process
$ ctrl+z               # Suspend the current process
$ screen               # Launch screen
$ reptyr $(pgrep htop) # Get back the process
```

[screen]: https://www.gnu.org/software/screen/
[tmux]: https://tmux.github.io/
[reptyr]: https://github.com/nelhage/reptyr
[serverfault]: http://serverfault.com/questions/55880/moving-an-already-running-process-to-screen
[monkeypatch]: http://monkeypatch.me/blog/move-a-running-process-to-a-new-screen-shell.html
