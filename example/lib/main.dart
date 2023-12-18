import 'package:flutter/material.dart';

import 'package:flutter_lock_task/flutter_lock_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
              child: const Text('startLockTask'),
              onPressed: () { 
                FlutterLockTask().startLockTask().then((value) {
                  print("startLockTask: " + value.toString());
                });
              }
            ),
            ElevatedButton(
              child: const Text('stopLockTask'),
              onPressed: () { 
                FlutterLockTask().stopLockTask().then((value) {
                  print("stopLockTask: " + value.toString());
                });
              }
            ),
            ElevatedButton(
              child: const Text('isInLockTaskMode'),
              onPressed: () { 
                FlutterLockTask().isInLockTaskMode().then((value) {
                  print("isInLockTaskMode: " + value.toString());
                });
              }
            ),
            ElevatedButton(
              child: const Text('setDeviceOwnerApp (only root device)'),
              onPressed: () { 
                FlutterLockTask().setDeviceOwnerApp().then((value) {
                  print("setDeviceOwnerApp: " + value.toString());
                });
              }
            ),
            ElevatedButton(
              child: const Text('clearDeviceOwnerApp'),
              onPressed: () { 
                FlutterLockTask().clearDeviceOwnerApp().then((value) {
                  print("clearDeviceOwnerApp: " + value.toString());
                });
              }
            ),
            ElevatedButton(
              child: const Text('openHomeSettings'),
              onPressed: () { 
                FlutterLockTask().openHomeSettings().then((value) {
                  print(value);
                });
              }
            ),
            ElevatedButton(
              child: const Text('getPackageName'),
              onPressed: () { 
                FlutterLockTask().getPackageName().then((value) {
                  print(value);
                });
              }
            )
          ]),
        ),
      ),
    );
  }
}

