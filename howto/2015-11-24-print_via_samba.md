### CUPS - print via samba

**Issue 1**
If you get this message "Unable to get list of printer drivers"

**solution 1**
Replace ServerName line with localhost:631

    $ cat /etc/cups/client.conf | grep ServerName -B1

        # see 'man client.conf'
        ServerName /run/cups/cups.sock 

    $ sudo sed -i "s/ServerName .*/ServerName localhost:631/g" /etc/cups/client.conf
    $ systemctl restart cups-browsed.service

    $ sudo pacman -R foomatic-db foomatic-db-nonfree
    $ sudo systemctl restart org.cups.cupsd

**Issue 2**
If you get this message '' printer-state-message="Filter failed" ''

**Solution 2**
upgrade cups-filters as suggested in [arch_linux] forums. 

    $ sudo pacman -Sy cups-filters
        
        extra/liblouis                   2.6.5-1        6.66 MiB       1.21 MiB
        extra/cups-filters  1.2.0-1      1.6.0-1        0.12 MiB       0.71 MiB


[arch_linux]: <[https://bbs.archlinux.org/viewtopic.php?id=179572>

