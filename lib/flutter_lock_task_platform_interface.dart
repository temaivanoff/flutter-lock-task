import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_lock_task_method_channel.dart';

abstract class FlutterLockTaskPlatform extends PlatformInterface {
  /// Constructs a FlutterLockTaskPlatform.
  FlutterLockTaskPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLockTaskPlatform _instance = MethodChannelFlutterLockTask();

  /// The default instance of [FlutterLockTaskPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLockTask].
  static FlutterLockTaskPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLockTaskPlatform] when
  /// they register themselves.
  static set instance(FlutterLockTaskPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> startLockTask() {
    throw UnimplementedError('startLockTask() has not been implemented.');
  }

  Future<bool> stopLockTask() {
    throw UnimplementedError('stopLockTask() has not been implemented.');
  }

  Future<bool> isInLockTaskMode() {
    throw UnimplementedError('isInLockTaskMode() has not been implemented.');
  }

  Future<bool> setDeviceOwnerApp() {
    throw UnimplementedError('setDeviceOwnerApp() has not been implemented.');
  }

  Future<bool> clearDeviceOwnerApp() {
    throw UnimplementedError('clearDeviceOwnerApp() has not been implemented.');
  }

  Future<bool> openHomeSettings() {
    throw UnimplementedError('openHomeSettings() has not been implemented.');
  }

  Future<String?> getPackageName() {
    throw UnimplementedError('getPackageName() has not been implemented.');
  }
}
