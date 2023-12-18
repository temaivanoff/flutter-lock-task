import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lock_task/flutter_lock_task.dart';
import 'package:flutter_lock_task/flutter_lock_task_platform_interface.dart';
import 'package:flutter_lock_task/flutter_lock_task_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLockTaskPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLockTaskPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLockTaskPlatform initialPlatform = FlutterLockTaskPlatform.instance;

  test('$MethodChannelFlutterLockTask is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLockTask>());
  });

  test('getPlatformVersion', () async {
    FlutterLockTask flutterLockTaskPlugin = FlutterLockTask();
    MockFlutterLockTaskPlatform fakePlatform = MockFlutterLockTaskPlatform();
    FlutterLockTaskPlatform.instance = fakePlatform;

    expect(await flutterLockTaskPlugin.getPlatformVersion(), '42');
  });
}
