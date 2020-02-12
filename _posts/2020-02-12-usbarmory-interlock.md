# usbarmory-interlock

The purpose is to install [interlock](https://github.com/f-secure-foundry/interlock) in usbarmory Mk I in [usbarmory-debian-base_image](https://github.com/f-secure-foundry/usbarmory-debian-base_image).

You can check my [previous post](https://github.com/arainho/arainho.github.io/blob/master/_posts/2019-04-19-usbarmory-setup.md) to check how to prepare burn usbarmory-debian-base_image, connect to usbarmory via ssh / serial.

The INTERLOCK app is a file encryption front-end, that consists of a web-based file manager for an encrypted partition running on the device hosting the JSON application server.

The main features of INTERLOCK are:
- a file manager that allows uploading/downloading of files to/from the encrypted partition, 
- symmetric/asymmetric cryptographic operations on the individual files
- secure messaging and file sharing supported with an optional built-in Signal client.


The script to install and setup interlock is <script src="https://gist.github.com/arainho/5d9e31a8d5d8e432838e405ddb43ae8b.js"></script>

### notes
If you prefer Pre-compiled binary releases for ARM targets they are available at [interlock repository](https://github.com/f-secure-foundry/interlock/releases).


