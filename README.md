# Fuji RAF Quick Look Extensions

This application includes / registers finder extensions to preview (thumbnails/gallery) Fuji RAF images in finder on MacOS.

## Build / Registration

To build/register:

 -  clone repository
 -  open with xcode
 -  build
 -  run once
 -  exit the application

The application only needs to be run once to preform the actual registration.
Run from `~/Library/Developer/Xcode/DerivedData/RAFQuickLook-.../Build/Products/Debug`.
Replace '...' with what ever xcode generates for your build.

Finder appears to cache thumbnails so the thumbnail extension may appear not to run on an existing folder.
Browse a new folder of RAF files to verify. It will eventually catch up.

If I make code changes I typically run the following commands:
 - qlmanage -r
 - qlmanage -r cache
 - killall QuickLookUIService
 - killall Finder

## System Settings

Control with 'System Settings/General/Login Items & Extensions/RAFQuickLook'

## Useful Terminal Commands:

### Show file content type
```
mdls -name kMDItemContentType ./Desktop/Raw/DSCF0000.RAF
```
Should return `com.fuji.raw-image`
### Manage/ test  quick look entensions
```
qlmanage -r
qlmanage -r cache
qlmanage -p ./Desktop/Raw/DSCF0000.RAF
qlmanage -t ./Desktop/Raw/DSCF0000.RAF
```
### Remove / add extensions
```
pluginkit -r ~/Library/Developer/Xcode/DerivedData/RAFQuickLook-.../Build/Products/Debug/RAFQuickLook.app/Contents/PlugIns/QLPreviewProvider.appex
pluginkit -a ~/Library/Developer/Xcode/DerivedData/RAFQuickLook-.../Build/Products/Debug/RAFQuickLook.app/Contents/PlugIns/QLPreviewProvider.appex
pluginkit -r ~/Library/Developer/Xcode/DerivedData/RAFQuickLook-.../Build/Products/Debug/RAFQuickLook.app/Contents/PlugIns/QLThumbnailProvider.appex
pluginkit -a ~/Library/Developer/Xcode/DerivedData/RAFQuickLook-.../Build/Products/Debug/RAFQuickLook.app/Contents/PlugIns/QLThumbnailProvider.appex
```
### Restart quick look service / finder
```
killall QuickLookUIService
killall Finder
```
