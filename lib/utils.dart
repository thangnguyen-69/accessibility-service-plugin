class EventType {
  static const int typeAllMask =
      0xffffffff; //Receives AccessibilityEvent.type(\w*)= i.e. all events.
  static const int typeAnnouncement =
      0x4000; //Receives AccessibilityEvent.TYPE_ANNOUNCEMENT events.
  static const int typeAssistReadingContext =
      1000000; //Receives AccessibilityEvent.TYPE_ASSIST_READING_CONTEXT events.
  static const int typeContextClicked =
      800000; //	Receives AccessibilityEvent.TYPE_VIEW_CONTEXT_CLICKED events.
  static const int typeGestureDetectionEnd =
      80000; //Receives AccessibilityEvent.TYPE_GESTURE_DETECTION_END events.
  static const int typeGestureDetectionStart =
      40000; //Receives AccessibilityEvent.TYPE_GESTURE_DETECTION_START events.
  static const int typeNotificationStateChanged =
      40; //Receives AccessibilityEvent.TYPE_NOTIFICATION_STATE_CHANGED events.
  static const int typeTouchExplorationGestureEnd =
      400; //Receives AccessibilityEvent.TYPE_TOUCH_EXPLORATION_GESTURE_END events.
  static const int typeTouchExplorationGestureStart =
      200; //Receives AccessibilityEvent.TYPE_TOUCH_EXPLORATION_GESTURE_START events.
  static const int typeTouchInteractionEnd =
      200000; //Receives AccessibilityEvent.TYPE_TOUCH_INTERACTION_END events.
  static const int typeTouchInteractionStart =
      100000; //	Receives AccessibilityEvent.TYPE_TOUCH_INTERACTION_START events.
  static const int typeViewAccessibilityFocusCleared =
      10000; //	Receives AccessibilityEvent.TYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED events.
  static const int typeViewAccessibilityFocused =
      8000; //	Receives AccessibilityEvent.TYPE_VIEW_ACCESSIBILITY_FOCUSED events.
  static const int typeViewClicked =
      1; //Receives AccessibilityEvent.TYPE_VIEW_CLICKED events.
  static const int typeViewFocused =
      8; //Receives AccessibilityEvent.TYPE_VIEW_FOCUSED events.
  static const int typeViewHoverEnter =
      80; //Receives AccessibilityEvent.TYPE_VIEW_HOVER_ENTER events.
  static const int typeViewHoverExit =
      100; //Receives AccessibilityEvent.TYPE_VIEW_HOVER_EXIT events.
  static const int typeViewLongClicked =
      2; //	Receives AccessibilityEvent.TYPE_VIEW_LONG_CLICKED events.
  static const int typeViewScrolled =
      1000; //	Receives AccessibilityEvent.TYPE_VIEW_SCROLLED events.
  static const int typeViewSelected =
      4; //Receives AccessibilityEvent.TYPE_VIEW_SELECTED events.
  static const int typeViewTextChanged =
      10; //	Receives AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED events.
  static const int typeViewTextSelectionChanged =
      2000; //Receives AccessibilityEvent.TYPE_VIEW_TEXT_SELECTION_CHANGED events.
  static const int typeViewTextTraversedAtMovementGranularity =
      20000; //Receives AccessibilityEvent.TYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY events.
  static const int typeWindowContentChanged =
      800; //Receives AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED events.
  static const int typeWindowStateChanged =
      20; //Receives AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED events.
  static const int typeWindowsChanged =
      400000; //Receives AccessibilityEvent.TYPE_WINDOWS_CHANGED events.
}

class FeedbackType {
  static const int feedbackAllMask =
      0xffffffff; //Provides AccessibilityServiceInfo.FEEDBACK_ALL_MASK feedback.
  static const int feedbackAudible =
      4; //Provides AccessibilityServiceInfo.FEEDBACK_AUDIBLE feedback.
  static const int feedbackGeneric =
      10; //Provides AccessibilityServiceInfo.FEEDBACK_GENERIC feedback.
  static const int feedbackHaptic =
      2; //Provides AccessibilityServiceInfo.FEEDBACK_HAPTIC feedback.
  static const int feedbackSpoken =
      1; //Provides AccessibilityServiceInfo.FEEDBACK_SPOKEN feedback.
  static const int feedbackVisual =
      8; //Provides AccessibilityServiceInfo.FEEDBACK_VISUAL feedback.
}

class Flag {
  static const int flagDefault = 1; //Has flag AccessibilityServiceInfo.DEFAULT.
  static const int flagEnableAccessibilityVolume =
      80; //Has flag AccessibilityServiceInfo.FLAG_ENABLE_ACCESSIBILITY_VOLUME.
  static const int flagIncludeNotImportantViews =
      2; //Has flag AccessibilityServiceInfo.FLAG_INCLUDE_NOT_IMPORTANT_VIEWS.
  static const int flagReportViewIds =
      10; //Has flag AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS.
  static const int flagRequestAccessibilityButton =
      100; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_ACCESSIBILITY_BUTTON.
  static const int flagRequestEnhancedWebAccessibility =
      8; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_ENHANCED_WEB_ACCESSIBILITY. Not used by the framework.
  static const int flagRequestFilterKeyEvents =
      20; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_FILTER_KEY_EVENTS.
  static const int flagRequestFingerprintGestures =
      200; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_FINGERPRINT_GESTURES.
  static const int flagRequestMultiFingerGestures =
      1000; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_MULTI_FINGER_GESTURES.
  static const int flagRequestShortcutWarningDialogSpokenFeedback =
      400; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_SHORTCUT_WARNING_DIALOG_SPOKEN_FEEDBACK.
  static const int flagRequestTouchExplorationMode =
      4; //Has flag AccessibilityServiceInfo.FLAG_REQUEST_TOUCH_EXPLORATION_MODE.
  static const int flagRetrieveInteractiveWindows =
      40; //Has flag AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS.
  static const int flagSendMotionEvents = 4000;
  static const int flagServiceHandlesDoubleTap =
      800; //Has flag AccessibilityServiceInfo.FLAG_SERVICE_HANDLES_DOUBLE_TAP.
}
