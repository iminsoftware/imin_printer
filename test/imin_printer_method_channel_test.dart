import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imin_printer/imin_printer_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIminPrinter platform = MethodChannelIminPrinter();
  const MethodChannel channel = MethodChannel('imin_printer');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('initPrinter', () async {
    expect(await platform.initPrinter(), true);
  });
}
