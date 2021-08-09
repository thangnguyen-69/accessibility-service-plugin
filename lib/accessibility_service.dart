// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:accessibility_service/accessibility_event.dart';
import 'package:accessibility_service/callback_dispatcher.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class AccessibilityServiceManager {
  static const MethodChannel _channel =
      const MethodChannel('plugin.flutter.io/accessibility_plugin');
  static const MethodChannel _backgroundChannel =
      const OptionalMethodChannel("plugin.flutter.io/accessibility_background");
  static Future<int> get serviceStatus async {
    return await _channel.invokeMethod('checkStatus');
  }

  static Future<void> requestToStartService() async {
    final CallbackHandle? dispatcherHandle =
        PluginUtilities.getCallbackHandle(callbackDispatcher);
    assert(dispatcherHandle != null);
    int rawHandle = dispatcherHandle!.toRawHandle();
    await _channel.invokeMethod('requestPermission', rawHandle);
  }

  // multiple call to setCallbackonAccessibilityEvent only replace the callback.
  static Future<void> setCallbackOnAccessibilityEvent(
      void Function(AccessibilityEvent event) callback) async {
    CallbackHandle? userCallbackHandle =
        PluginUtilities.getCallbackHandle(callback);
    stderr.writeln(callback);
    if (userCallbackHandle == null) {
      throw AssertionError(
          "cannot set callback that is not static or top-level");
    }
    await _channel.invokeMethod(
        'registerCallback', userCallbackHandle.toRawHandle());
  }

  static Future<void> setupFilterAccessibilityEvents(
      String packageNames, int flags, int eventType, int feedBackType) async {
    await _channel.invokeMethod('filterAccessibility', <String, dynamic>{
      'packages': packageNames,
      'flags': flags,
      'eventType': eventType,
      'feedbackType': feedBackType
    });
  }

  static Future<void> stopService() async {
    developer.log("pressed the button!");
    await _backgroundChannel.invokeMethod("stopService");
  }
}
