import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'accessibility_event.dart';

void callbackDispatcher() {
  const backgroundChannel =
      MethodChannel("plugin.flutter.io/accessibility_background");
  WidgetsFlutterBinding.ensureInitialized();
  backgroundChannel.setMethodCallHandler((MethodCall call) async {
    List<dynamic> args = call.arguments;
    CallbackHandle callbackHandle = CallbackHandle.fromRawHandle(args[0]);
    Function? callback = PluginUtilities.getCallbackFromHandle(callbackHandle);
    var ev = AccessibilityEvent(args[1]);
    // why tf do we have to do this?
    // https://stackoverflow.com/questions/57845333/dart-how-internallinkedhashmapstring-dynamic-convert-to-mapstring-dynamic
    if (callback == null) {
      stderr.writeln("cant find true callback in callback dispatcher");
      return;
    }
    callback(ev);
  });
}
