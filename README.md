# root-ios-slc-tester
The goal of this app is to be a minimal implementation of iOS significant location changes (SLCs).

The primary implementation is in `AppDelegate`. It initializes a `CLLocationManager`, handles permissions, and then starts monitoring SLCs. On an SLC, the latitude, longitude, and timestamp are written to a file that is saved on the device's hard drive using `CachedLog.log()`. This allows for the device to not be attached to a debugger and for the app to suspend and go out of memory freely as the debugger prevents that.

Xcode can be used to pull the files off of the device. Sample output where permissions have already been granted will look like this:
```
CachedLog: 17:55:03--App started 
CachedLog: 17:55:04--Permissions authorized 
CachedLog: 17:55:04--SLC, lat: 39.956107, long: -83.000855, timestamp: 2017-09-26 21:55:01 +0000 
CachedLog: 18:20:21--SLC, lat: 39.949368, long: -82.995448, timestamp: 2017-09-26 22:20:21 +0000 
CachedLog: 18:25:21--SLC, lat: 39.969431, long: -83.002073, timestamp: 2017-09-26 22:25:21 +0000 
CachedLog: 18:30:22--SLC, lat: 39.976902, long: -83.003522, timestamp: 2017-09-26 22:30:22 +0000 
CachedLog: 20:44:45--SLC, lat: 39.953200, long: -82.996041, timestamp: 2017-09-27 00:44:44 +0000 
CachedLog: 07:27:48--SLC, lat: 39.963680, long: -83.001948, timestamp: 2017-09-27 11:27:46 +0000 
```

Note that there will be a pre- and postamble that provide no value and are a side-effect of the archiver. It is not included in the above sample.

A new file will be generated every time the app comes in to memory (when `application didFinishLaunchingWithOptions` is called)
