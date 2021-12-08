# accessibility_service

Well it's a plugin for interacting with Accessibility Service in Android. This will probably crash if called in iOS device.

## Android  
In your AndroidManifest.xml you should add the following lines:

```
<uses-permission android:name="android.permission.BIND_ACCESSIBILITY_SERVICE"/>
```
You'll need to register for a service as well.
```
<service
    android:name="dev.android.accessibility_service.MyService"
    android:label="custom Label"
    android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
    <intent-filter>
        <action android:name="android.accessibilityservice.AccessibilityService" />
    </intent-filter>
</service>
```

## Getting Started
There are only 5 functions implemented:
- `serviceStatus`: check if the service is online.
- `requestToStartService`: open an intent to Accessibility Settings, that's all
- `stopService`: stop the Accessibility service.
- `setCallbackOnAccessibilityEvent`: set a callback when an `AccessibiltyEvent` is received. Only static or top-level callback is accepted. Please call this before starting the service.
- `setupFilterAccessibilityEvents`: set a filter to choose which kind of events we want to react.

