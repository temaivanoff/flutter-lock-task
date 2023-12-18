package flutter.lock.task.flutter_lock_task;

import java.util.ArrayList;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.admin.DevicePolicyManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;
import android.os.Build;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/** FlutterLockTaskPlugin */
public class FlutterLockTaskPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler, PluginRegistry.ActivityResultListener {

  private MethodChannel channel;
  private Context appContext;
  private Activity mActivity;
  DevicePolicyManager dpm;
  ComponentName cn;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    appContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_lock_task");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    cn = new ComponentName(appContext, DeviceAdmin.class);
    dpm = (DevicePolicyManager) appContext.getSystemService(Context.DEVICE_POLICY_SERVICE);

    if (call.method.equals("startLockTask")) {
      try {
        if (mActivity != null) {
          if (dpm.isDeviceOwnerApp(mActivity.getPackageName())) {
            ArrayList<String> packages = new ArrayList<>();
            packages.add(mActivity.getPackageName());
        
            dpm.setLockTaskPackages(cn, packages.toArray(new String[0]));
            mActivity.startLockTask();
            result.success(true);
          } else {
            mActivity.startLockTask();
            result.success(true);
          }
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("stopLockTask")) {
      try {
        if (mActivity != null) {
          mActivity.stopLockTask();
          result.success(true);
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("isInLockTaskMode")) {
      try {
        if (mActivity != null) {
          ActivityManager activityManager = (ActivityManager) mActivity.getSystemService(Context.ACTIVITY_SERVICE);

          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int lockTaskMode = activityManager.getLockTaskModeState();
            result.success(lockTaskMode != ActivityManager.LOCK_TASK_MODE_NONE);
          } else {
            result.success(activityManager.isInLockTaskMode());
          }
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("setDeviceOwnerApp")) {
      try {
        if (mActivity != null) {
          Runtime.getRuntime().exec(new String[]{"su","-c", "dpm set-device-owner " + mActivity.getPackageName() + "/flutter.lock.task.flutter_lock_task.DeviceAdmin"});
          result.success(true);
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("clearDeviceOwnerApp")) {
      try {
        if (mActivity != null) {
          dpm.clearDeviceOwnerApp(mActivity.getPackageName());
          result.success(true);
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("openHomeSettings")) {
      try {
        if (mActivity != null) {
          final Intent intent = new Intent(Settings.ACTION_HOME_SETTINGS);
          mActivity.startActivity(intent);
          result.success(true);
        } else {
          result.success(false);
        }
      } catch (Exception e) {
        result.success(false);
      }
    } else if (call.method.equals("getPackageName")) {
      result.success(mActivity.getPackageName());
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
      channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    this.mActivity = activityPluginBinding.getActivity();
    activityPluginBinding.addActivityResultListener(this);
}

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.mActivity = null;
  }

  @Override
  public void onDetachedFromActivity() {
    this.mActivity = null;
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    return false;
  }
}
