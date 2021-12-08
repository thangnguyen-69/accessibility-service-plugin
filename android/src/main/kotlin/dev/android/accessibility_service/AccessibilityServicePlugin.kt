package dev.android.accessibility_service

import android.Manifest
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
 
/** AccessibilityServicePlugin */
class AccessibilityServicePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  companion object{
    @JvmStatic
    val SHARED_PREFERENCE_KEY = "accessibility_plugin";
    @JvmStatic
    val CALLBACK_DISPATCHER_HANDLE_KEY = "callback_dispatcher"
    @JvmStatic
    val TRUE_CALLBACK_KEY ="true_callback"
    @JvmStatic
    val PACKAGE_NAMES = "pkgs"
    @JvmStatic
    val EVENT_TYPE = "eventType"
    @JvmStatic
    val FLAGS = "flags"
    @JvmStatic
    val FEEDBACK_TYPE = "feedback_type"
  }
  private var TAG="Plugin";
  private lateinit var channel : MethodChannel
  private var mContext : Context? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    mContext = flutterPluginBinding.applicationContext
    MyService.messenger = flutterPluginBinding.binaryMessenger
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugin.flutter.io/accessibility_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "checkStatus"-> {result.success(checkPermission())}
      "requestPermission"->{var args = call.arguments
      requestToStartService(args,result)}
      "registerCallback"->registerCallback(call.arguments,result)
      "filterAccessibility"->setFilter(call.arguments,result)
    }
  }
  private fun requestToStartService(args:Any, result:Result){
    val callbackHandle = args as Long
    mContext!!.getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE).edit()
      .putLong(CALLBACK_DISPATCHER_HANDLE_KEY,callbackHandle)
      .apply()
    val intentRequest = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
    intentRequest.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//    val intentServiceTest = Intent(mContext,TestService::class.java)
    mContext!!.startActivity(intentRequest)
//    mContext!!.startService(intentServiceTest)
  }
  private fun checkPermission(): Int {
      var enabled = 0
      try {
          enabled = Settings.Secure.getInt(mContext!!.contentResolver, Settings.Secure.ACCESSIBILITY_ENABLED)
      } catch (e: Settings.SettingNotFoundException) {
          return 0
      }
      if (enabled == 1) {
          val name = ComponentName(mContext!!, MyService::class.java)
          val services = Settings.Secure.getString(mContext!!.contentResolver, Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES)
          if(services?.contains(name.flattenToString()) == true){
            return 1
          }
          return 0
      }
      return 0
  }
  private fun registerCallback(args: Any,result: Result){
    val callbackHandle = args as Long
    mContext!!.getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE).edit()
      .putLong(TRUE_CALLBACK_KEY,callbackHandle)
      .apply()
    result.success(1);
  }
  private fun setFilter(args:Any,result:Result){
    val argList = args as Map<String,Any?>
    var packages = argList["packages"] as String
    var flags = argList["flags"] as Int
    var eventType = argList["eventType"] as Number
    var feedbackType= argList["feedbackType"] as Int
    mContext!!.getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE).edit()
      .putString(PACKAGE_NAMES,packages).putInt(FLAGS,flags).putInt(FEEDBACK_TYPE,feedbackType)
      .putInt(EVENT_TYPE,eventType.toInt()).apply()
    result.success(1)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

}
