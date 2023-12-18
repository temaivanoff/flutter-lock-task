
import 'flutter_lock_task_platform_interface.dart';

class FlutterLockTask {
  Future<bool?> startLockTask() {
    return FlutterLockTaskPlatform.instance.startLockTask();
  }
  Future<bool?> stopLockTask() {
    return FlutterLockTaskPlatform.instance.stopLockTask();
  }
  Future<bool?> isInLockTaskMode() {
    return FlutterLockTaskPlatform.instance.isInLockTaskMode();
  }
  Future<bool?> setDeviceOwnerApp() {
    return FlutterLockTaskPlatform.instance.setDeviceOwnerApp();
  }
  Future<bool?> clearDeviceOwnerApp() {
    return FlutterLockTaskPlatform.instance.clearDeviceOwnerApp();
  }
  Future<String?> getPackageName() {
    return FlutterLockTaskPlatform.instance.getPackageName();
  }
}
