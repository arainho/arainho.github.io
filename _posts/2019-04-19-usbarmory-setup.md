# usbarmory-setup

I order my usbarmory device from [crowdsupply](https://www.crowdsupply.com/inverse-path/usb-armory) to Europe, and after more than one month and paying customs duties the armory finally arrived :-)

### 1. Preparing your own microSD card
- 1. check [microSD-compatibility](https://github.com/inversepath/usbarmory/wiki/microSD-compatibility)
- 2. choose one of the [available images](https://github.com/inversepath/usbarmory/wiki/Available-images) for usbarmory.
- 3. [burn](https://github.com/inversepath/usbarmory-debian-base_image#Installing) the image into microSD card 

I choose a Samsung microSD and a pre-compiled release of Debian stretch image available [here](https://github.com/inversepath/usbarmory-debian-base_image/releases).

### 2. Connect to usbarmory
We have to options to connect with the usbarmory device, via serial or ssh .

#### Option 1 - serial interface
We can connect to usbarmory serial port through a USB to TTL cable, the breakout header can be accessed as, the breakout header can be accessed as described in [gpio page](https://github.com/inversepath/usbarmory/wiki/GPIOs).

I solder a header in usbarmory and use pins 1,5,6 to connect 'usb to ttl' adapter with silicon CP210x chipset and specific [drivers](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers).
To connect in macOS use the next command:
```
screen /dev/tty.SLAB_USBtoUART 115200
```

#### Option 2 - ssh connection
In this image `usbarmory-debian-base_image` usbarmory cames with predefined ipv4 address `10.0.0.1`, so set the laptop or workstation ip address to `10.0.0.2` and connect to your usbarmory. 

Now we can log in with
```
ssh 10.0.0.1 -l usbarmory
```

### 3. Additional setup
Create a ssh key pair, and sent it to usbarmory
```
ssh-keygen -t rsa -b 4096 -C "usbarmory key"
ssh-copy-id -i $HOME/.ssh/id_rsa_usbarmory usbarmory@10.0.0.1
```

### Notes
#### macOS Monterey
We need the `CDC Composite Gadget` interface in the macOS Network Preferences.

Also if we want to share our internet access with the usbarmory device
- in macOS Monterey set ip address of `CDC Composite Gadget` interface to `10.0.0.2`
- finally set `Enable Internet Sharing` to ON in System Preferences

#### on other macOS versions
In some case we may need to
- have `RNDIS/Ethernet Gadget` interface in the Network Preferences
- Set usbmory ip to `192.168.2.X/24` and gateway `192.168.2.1`
- Set ip address of `RNDIS/Ethernet Gadget` interface to `192.168.2.1`
- finally set `Enable Internet Sharing` to ON in System Preferences
