After the latest news about a zero-day vulnerability in the Zoom client for Mac that allows a malicious website to hijack a user’s web camera without their permission.

Reading [this article](https://medium.com/bugbountywriteup/zoom-zero-day-4-million-webcams-maybe-an-rce-just-get-them-to-visit-your-website-ac75c83f4ef5) at Medium from a Security Researcher named [Jonathan Leitschuh](https://medium.com/@jonathan.leitschuh)

So I decided to do 3 things
1. uninstall `zoom.us` application from macOS
2. disable the ability for Zoom to turn on your webcam when joining a meeting
3. shut down and prevent this server from being restored after updates

You can use this find all the zoom files and folders in your machine, and complete the public gist.

find all files
```
find . -type f |&grep -iE "us.zoom|zoom|zoom.us"
```

find all folders
```
find . -type d |&grep -iE "us.zoom|zoom|zoom.us"
```

I created a public gist called [zoom_uninstall_macos-sh](https://gist.github.com/arainho/c4989631946073f75ee9f8726dcdc9dc#file-zoom_uninstall_macos-sh) to mitigate these 3 items,  
using a public script from [Zoom Google Drive](https://drive.google.com/drive/folders/1MP0cNLyJjzPLNrvNDCZv9hRuif091f0c), instructions from [Jonathan Leitschuh](https://medium.com/@jonathan.leitschuh) referenced in the medium article and also [this post](https://apple.stackexchange.com/questions/358651/unable-to-completely-uninstall-zoom-meeting-app) at apple stackexchange.

```
#!/usr/bin/env bash

echo Stopping Zoom...
pkill "zoom.us"

echo Cleaning Zoom...
echo Cleaning Application Cached Files...
{
  rm -fr -- ~/Library/Application\ Support/zoom.us
  rm -fr -- ~/Library/Application\ Support/ZoomPresence
  rm -fr -- ~/Library/Caches/us.zoom.xos
  rm -fr -- ~/Library/Logs/zoom.us/
  rm -fr -- ~/Library/Logs/zoomRooms/
  rm -fr -- ~/Library/Logs/zoominstall.log
  rm -fr -- ~/Library/Preferences/ZoomChat.plist
  rm -fr -- ~/Library/Preferences/us.zoom.xos.plist
  rm -fr -- ~/Library/Saved\ Application\ State/us.zoom.xos.savedState
}

echo "Cleaning Application..."
{
  rm -fr -- ~/Applications/zoom.us.app
  rm -fr -- ~/.zoomus/ZoomOpener.app
  rm -fr -- ~/.zoomus
}
echo "Removed Application..."

echo "Preventing the vulnerable server from running on your machine..."
# (You may need to run these lines for each user on your machine.)
pkill "ZoomOpener"; rm -rf ~/.zoomus; touch ~/.zoomus && chmod 000 ~/.zoomus;
pkill "RingCentralOpener";  rm -rf ~/.ringcentralopener; touch ~/.ringcentralopener && chmod 000 ~/.ringcentralopener;

echo "Disabling the ability of Zoom to turn on your webcam when joining a meeting..."
defaults write ~/Library/Preferences/us.zoom.config.plist ZDisableVideo 1           # For just your local account

echo "Removing Launch Daemons/Agents and Internet Plug-Ins..."
{
  rm -fr -- ~/Library/LaunchDaemons/us.zoom.rooms.daemon.plist
  rm -fr -- ~/Library/LaunchAgents/us.zoom*
  rm -fr -- ~/Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin/
}

echo "Switching to a user with sudo privileges to remove more zoom things..."
{
  sudo rm -fr -- /Applications/zoom.us.app
  sudo kextunload -b zoom.us.ZoomAudioDevice
  sudo rm -fr -- /System/Library/Extensions/ZoomAudioDevice.kext
  sudo defaults write /Library/Preferences/us.zoom.config.plist ZDisableVideo 1       # For all users on the machine
  sudo rm -fr -- /Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin/
  sudo rm -fr -- /Library/LaunchDaemons/us.zoom.rooms.daemon.plist
  sudo rm -fr -- /Library/LaunchAgents/us.zoom*
}

