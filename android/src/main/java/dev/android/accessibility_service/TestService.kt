package dev.android.accessibility_service

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TestService : Service(),MethodChannel.MethodCallHandler {
    private lateinit var backgroundChannel : MethodChannel
    companion object{
        @JvmStatic
        var backgroundEngine: FlutterEngine? = null
        var TAG="test"
    }
    override fun onCreate() {
        super.onCreate()
        Log.d(TAG,"onCreate called")
        backgroundEngine = FlutterEngine(this.applicationContext)
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG,"onStartCommand called")
        backgroundChannel = MethodChannel(backgroundEngine!!.dartExecutor.binaryMessenger,"plugin.flutter.io/accessibility_background")
        backgroundChannel.setMethodCallHandler(this)
        backgroundChannel.invokeMethod("",0)
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.d("haha","this is called on native side")
//        TODO("Not yet implemented")
    }
}