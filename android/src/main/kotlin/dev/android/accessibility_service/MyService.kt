package dev.android.accessibility_service

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Context
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.CALLBACK_DISPATCHER_HANDLE_KEY
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.EVENT_TYPE
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.FEEDBACK_TYPE
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.FLAGS
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.PACKAGE_NAMES
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.SHARED_PREFERENCE_KEY
import dev.android.accessibility_service.AccessibilityServicePlugin.Companion.TRUE_CALLBACK_KEY
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.view.FlutterCallbackInformation
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.FlutterMain.findAppBundlePath

class BackgroundAccessibilityService : AccessibilityService(),MethodChannel.MethodCallHandler {
    companion object{
        @JvmStatic
        private var sBackgroundFlutterEngine: FlutterEngine? = null
        @JvmStatic
        var messenger : BinaryMessenger? = null

    }
    private lateinit var mBackgroundChannel: MethodChannel
    private lateinit var facadeBackgroundChannel: MethodChannel
    private val TAG="Accessibility service"
    override fun onCreate() {
        super.onCreate()
        facadeBackgroundChannel = MethodChannel(messenger,"plugin.flutter.io/accessibility_background")
        facadeBackgroundChannel.setMethodCallHandler(this)
        startAccessibilityService(this)
    }
    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo()
        val ref = getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE)
        info.flags = ref.getInt(FLAGS,AccessibilityServiceInfo.DEFAULT)
        info.eventTypes = ref.getInt(EVENT_TYPE,AccessibilityEvent.TYPES_ALL_MASK)
        info.feedbackType = ref.getInt(FEEDBACK_TYPE,AccessibilityServiceInfo.FEEDBACK_GENERIC)
        info.packageNames = ref.getString(PACKAGE_NAMES,null)?.split('|')?.toTypedArray()
        serviceInfo = info
    }
    private fun eventToMap(event :AccessibilityEvent): Map<String, Any?> {
        val eventMap = mapOf<String,Any?>("eventType" to event.eventType,"eventTime" to event.eventTime
        ,"packageName" to event.packageName,"action" to event.action,"contentChangeType" to event.contentChangeTypes,
        "movementGranularity" to event.movementGranularity);
        return eventMap;
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        Log.d(TAG,"on event")
        val callbackHandle = getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE).getLong(TRUE_CALLBACK_KEY,0)
        if(callbackHandle==0L){
            Log.d(TAG,"no callback to process")
            return
        }

        val args = arrayListOf<Any?>(callbackHandle,eventToMap(event!!))
        Log.d(TAG,args[1].toString())
        if(mBackgroundChannel ==null){
            Log.d(TAG,"background channel not registered on this side, will skip this event");
            return;
        }
        mBackgroundChannel.invokeMethod("",args)
        Log.d(TAG,"push message successfully")
    }
    private fun startAccessibilityService(context: Context){
        if(sBackgroundFlutterEngine ==null){
            val ref = getSharedPreferences(SHARED_PREFERENCE_KEY,Context.MODE_PRIVATE)
            val callbackHandle = ref.getLong(CALLBACK_DISPATCHER_HANDLE_KEY,0)
            if(callbackHandle== 0L ){
                Log.e(TAG, "Fatal: no callback registered")
                return
            }
            val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
            if(callbackInfo==null){
                Log.e(TAG,"Fatal : failed to find callback")
                return
            }
            sBackgroundFlutterEngine = FlutterEngine(context)
            val args = DartExecutor.DartCallback(context.assets, findAppBundlePath(),callbackInfo)
            sBackgroundFlutterEngine!!.dartExecutor.executeDartCallback(args)
        }
        mBackgroundChannel = MethodChannel(
            sBackgroundFlutterEngine!!.dartExecutor.binaryMessenger,
            "plugin.flutter.io/accessibility_background")
        Log.d(TAG,"start service successfully")
    }
    override fun onInterrupt() {
        TODO("Not yet implemented")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "stopService"-> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                Log.d(TAG,"stop service called")
                disableSelf()
                stopSelf()
                result.success(1)
            };
        }
    }
}