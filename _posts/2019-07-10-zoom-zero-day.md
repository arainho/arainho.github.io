After the latest news about a zero-day vulnerability in the Zoom client for Mac that allows a malicious website to hijack a user’s web camera without their permission.

Reading [this article](https://medium.com/bugbountywriteup/zoom-zero-day-4-million-webcams-maybe-an-rce-just-get-them-to-visit-your-website-ac75c83f4ef5) at Medium from a Security Researcher named [Jonathan Leitschuh](https://medium.com/@jonathan.leitschuh)

So I decided to do 3 things
1. uninstall `zoom.us` application from macOS
2. disable the ability for Zoom to turn on your webcam when joining a meeting
3. shut down and prevent this server from being restored after updates

I created a public gist called [zoom_uninstall_macos-sh](https://gist.github.com/arainho/c4989631946073f75ee9f8726dcdc9dc#file-zoom_uninstall_macos-sh) to mitigate these 3 items,  using a public script from Zoom at [Google Drive](https://drive.google.com/drive/folders/1MP0cNLyJjzPLNrvNDCZv9hRuif091f0c) and instructions from [Jonathan Leitschuh](https://medium.com/@jonathan.leitschuh) referenced in the medium article and also [this post](https://apple.stackexchange.com/questions/358651/unable-to-completely-uninstall-zoom-meeting-app) at apple stackexchange.

You can use this find all the zoom files and folders in your machine, and complete the public gist.

find all files
```
find . -type f |&grep -iE "us.zoom|zoom|zoom.us"
```

find all folders
```
find . -type d |&grep -iE "us.zoom|zoom|zoom.us"
```
