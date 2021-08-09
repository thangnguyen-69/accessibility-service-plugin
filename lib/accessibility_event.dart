import 'dart:core';

class AccessibilityEvent {
  late int action;
  late int contentChangeType;
  late int eventTime;
  late int eventType;
  late String packageName;
  late int movementGranularity;

  // https://stackoverflow.com/questions/57845333/dart-how-internallinkedhashmapstring-dynamic-convert-to-mapstring-dynamic
  // reason why i have to set Map<dynamic,dynamic> but not Map<string, dynamic>
  AccessibilityEvent(Map<dynamic, dynamic> map) {
    action = map['action'] as int;
    contentChangeType = map['contentChangeType'] as int;
    eventTime = map['eventTime'] as int;
    eventType = map['eventType'] as int;
    packageName = map['packageName'] as String;
    movementGranularity = map['movementGranularity'] as int;
  }
}
