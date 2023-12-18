# flutter-lock-task

## Getting started

`$ flutter pub add flutter-lock-task`

### Settings

**`yourProject/android/app/src/main/AndroidManifest.xml`**

```diff
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
+   <uses-permission android:name="android.permission.MANAGE_DEVICE_ADMINS" />
    <application
        android:label="flutter_lock_task_example"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
+       <receiver android:exported="true" android:name="flutter.lock.task.flutter_lock_task.DeviceAdmin" android:permission="android.permission.BIND_DEVICE_ADMIN">
+           <meta-data android:name="android.app.device_admin" android:resource="@xml/policies" />
+           <intent-filter android:exported="true">
+               <action android:name="android.app.action.DEVICE_ADMIN_ENABLED" />
+               <action android:name="android.app.action.ACTION_DEVICE_ADMIN_DISABLE_REQUESTED" />
+               <action android:name="android.app.action.ACTION_DEVICE_ADMIN_DISABLED" />
+               <action android:name="android.intent.action.PROFILE_PROVISIONING_COMPLETE"/>
+               <action android:name="android.intent.action.BOOT_COMPLETED"/>
+           </intent-filter>
+       </receiver>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

**`yourProject/android/app/src/main/res/xml/policies.xml`**

```diff
+ <?xml version="1.0" encoding="utf-8"?>
+ <device-admin>
+ <uses-policies>
+     <limit-password />
+     <watch-login />
+     <reset-password />
+     <force-lock />
+     <wipe-data />
+     <expire-password />
+     <encrypted-storage />
+     <disable-camera />
+ </uses-policies>
+ </device-admin>

```
## Set owner device adb
* Settings --> Accounts --> Delete All
* `./adb shell dpm set-device-owner YOU_PACKAGE_NAME/flutter.lock.task.flutter_lock_task.DeviceAdmin`

YOU_PACKAGE_NAME - `FlutterLockTask().getPackageName()`
  
## Usage
```dart
import 'package:flutter_lock_task/flutter_lock_task.dart';

FlutterLockTask().startLockTask().then((value) {
  print("startLockTask: " + value.toString());
});

FlutterLockTask().stopLockTask().then((value) {
  print("stopLockTask: " + value.toString());
});

FlutterLockTask().isInLockTaskMode().then((value) {
  print("isInLockTaskMode: " + value.toString());
});

FlutterLockTask().setDeviceOwnerApp().then((value) { // only root device, if device not root see step (Set owner device adb)
  print("setDeviceOwnerApp: " + value.toString());
});

FlutterLockTask().clearDeviceOwnerApp().then((value) {
  print("clearDeviceOwnerApp: " + value.toString());
});

FlutterLockTask().getPackageName().then((value) {
  print(value);
});
```
