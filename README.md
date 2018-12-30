# Fybird

用Flutter编写的Cybird。

Fybird下载地址：

<img src="https://github.com/iBotasky/Fybird/blob/master/images/12.png" width="426px"/>



Kotlin编写的Cybird：

<img src="https://github.com/iBotasky/Fybird/blob/master/images/1.png" width="426px"/>

## App展示
### 一个App接口
<img src="https://github.com/iBotasky/Fybird/blob/master/images/2.png" width="426px"/>

### 豆瓣250
<img src="https://github.com/iBotasky/Fybird/blob/master/images/3.png" width="426px"/>

### 豆瓣影院热映
<img src="https://github.com/iBotasky/Fybird/blob/master/images/4.png" width="426px"/>

### 豆瓣即将上映
<img src="https://github.com/iBotasky/Fybird/blob/master/images/5.png" width="426px"/>

### 豆瓣电影详情（只展示了部分数据，豆瓣开放数据不多）
<img src="https://github.com/iBotasky/Fybird/blob/master/images/6.png" width="426px"/>

### 知乎日报接口
<img src="https://github.com/iBotasky/Fybird/blob/master/images/7.png" width="426px"/>

### 知乎日报详情(详情是用flutter_webview_plugin加载的数据，ios展示有问题，Android正常)
<img src="https://github.com/iBotasky/Fybird/blob/master/images/8.png" width="426px"/>

### GankIO的MM
<img src="https://github.com/iBotasky/Fybird/blob/master/images/9.png" width="426px"/>


## Flutter版本
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, v1.1.5-pre.27, on Mac OS X 10.14.2 18C54, locale
    en-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
[!] iOS toolchain - develop for iOS devices (Xcode 10.1)
    ✗ Verify that all connected devices have been paired with this computer in
      Xcode.
      If all devices have been paired, libimobiledevice and ideviceinstaller may
      require updating.
      To update with Brew, run:
        brew update
        brew uninstall --ignore-dependencies libimobiledevice
        brew uninstall --ignore-dependencies usbmuxd
        brew install --HEAD usbmuxd
        brew unlink usbmuxd
        brew link usbmuxd
        brew install --HEAD libimobiledevice
        brew install ideviceinstaller
    ✗ CocoaPods installed but not initialized.
        CocoaPods is used to retrieve the iOS platform side's plugin code that
        responds to your plugin usage on the Dart side.
        Without resolving iOS dependencies with CocoaPods, plugins will not work
        on iOS.
        For more info, see https://flutter.io/platform-plugins
      To initialize CocoaPods, run:
        pod setup
      once to finalize CocoaPods' installation.
[✓] Android Studio (version 3.2)
[✓] Connected device (1 available)
```

## 第三方框架
| 库                          | 功能             |
| -------------------------- | -------------- |
| **dio**                    | **网络框架**       |
| **flutter_webview_plugin** | **全屏的webview，支持加载本地Html** |
| **flutter_swiper** | **轮播框架** |
| **intl** | **日期格式转换** |



## 运行(先配置好Flutter环境)
clone到本地后删除`pubspec.lock`，然后重新运行即可





