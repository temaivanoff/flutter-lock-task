import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_lock_task_platform_interface.dart';

/// An implementation of [FlutterLockTaskPlatform] that uses method channels.
class MethodChannelFlutterLockTask extends FlutterLockTaskPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_lock_task');

  @override
  Future<bool> startLockTask() async {
    final value = await methodChannel.invokeMethod<bool>('startLockTask') ?? false;
    return value;
  }

  @override
  Future<bool> stopLockTask() async {
    final value = await methodChannel.invokeMethod<bool>('stopLockTask') ?? false;
    return value;
  }

  @override
  Future<bool?> isInLockTaskMode() async {
    final value = await methodChannel.invokeMethod<bool>('isInLockTaskMode') ?? false;
    return value;
  }

  @override
  Future<bool?> setDeviceOwnerApp() async {
    final value = await methodChannel.invokeMethod<bool>('setDeviceOwnerApp') ?? false;
    return value;
  }

  @override
  Future<bool?> clearDeviceOwnerApp() async {
    final value = await methodChannel.invokeMethod<bool>('clearDeviceOwnerApp') ?? false;
    return value;
  }
  
  @override
  Future<String?> getPackageName() async {
    final version = await methodChannel.invokeMethod<String>('getPackageName');
    return version;
  }
}
