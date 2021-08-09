import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility_service/accessibility_service.dart';

void main() {
  const MethodChannel channel = MethodChannel('accessibility_service');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
