import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello11/hello11.dart';

void main() {
  const MethodChannel channel = MethodChannel('hello11');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Hello11.platformVersion, '42');
  });
}
