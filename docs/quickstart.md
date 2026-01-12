# Quick Start

This guide will help you get started with the iMin Printer SDK quickly and efficiently.

## Prerequisites

- Flutter SDK 3.3.0 or higher
- Dart SDK 3.0.6 or higher
- Android device with iMin printer
- USB connection between device and printer

## Installation

### Step 1: Add Dependency

Add the iMin printer plugin to your `pubspec.yaml`:

```yaml
dependencies:
  imin_printer: ^0.6.14
```

Or install via command line:
```bash
flutter pub add imin_printer
```

### Step 2: Import Required Packages

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';
```

## Basic Setup

### Create a Flutter Project
```bash
flutter create my_printer_app
cd my_printer_app
```

### Update pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  imin_printer: ^0.6.14
```

### Run pub get
```bash
flutter pub get
```

## Your First Print

### Simple Example

Create a basic printing example in `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMin Printer Demo',
      home: PrinterDemo(),
    );
  }
}

class PrinterDemo extends StatefulWidget {
  @override
  _PrinterDemoState createState() => _PrinterDemoState();
}

class _PrinterDemoState extends State<PrinterDemo> {
  final IminPrinter _printer = IminPrinter();
  String _status = 'Not initialized';
  
  @override
  void initState() {
    super.initState();
    _initializePrinter();
  }
  
  Future<void> _initializePrinter() async {
    try {
      bool? result = await _printer.initPrinter();
      setState(() {
        _status = result == true ? 'Ready' : 'Failed to initialize';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }
  
  Future<void> _printHelloWorld() async {
    try {
      await _printer.printText(
        'Hello World!',
        style: IminTextStyle(
          fontSize: 28,
          fontStyle: IminFontStyle.bold,
          align: IminPrintAlign.center,
        ),
      );
      await _printer.printAndLineFeed();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Print successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Print failed: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iMin Printer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Printer Status: $_status'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _printHelloWorld,
              child: Text('Print Hello World'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Essential Operations

### 1. Initialize Printer

Always initialize the printer before use:

```dart
final IminPrinter printer = IminPrinter();

Future<bool> initializePrinter() async {
  try {
    bool? result = await printer.initPrinter();
    return result == true;
  } catch (e) {
    print('Initialization failed: $e');
    return false;
  }
}
```

### 2. Check Printer Status

Check if the printer is ready before printing:

```dart
Future<bool> isPrinterReady() async {
  try {
    Map<String, dynamic> status = await printer.getPrinterStatus();
    return status['code'] == '0';
  } catch (e) {
    print('Status check failed: $e');
    return false;
  }
}
```

### 3. Print Text

Print text with various styling options:

```dart
Future<void> printStyledText() async {
  // Simple text
  await printer.printText('Simple text');
  
  // Styled text
  await printer.printText(
    'Styled Text',
    style: IminTextStyle(
      fontSize: 32,
      fontStyle: IminFontStyle.bold,
      align: IminPrintAlign.center,
      typeface: IminTypeface.typefaceDefaultBold,
    ),
  );
  
  // Line feed
  await printer.printAndLineFeed();
}
```

### 4. Print QR Code

```dart
Future<void> printQRCode() async {
  await printer.printQrCode(
    'https://www.imin.sg',
    qrCodeStyle: IminQrCodeStyle(
      qrSize: 6,
      align: IminPrintAlign.center,
      errorCorrectionLevel: IminQrcodeCorrectionLevel.levelM,
    ),
  );
}
```

### 5. Print Barcode

```dart
Future<void> printBarcode() async {
  await printer.printBarCode(
    IminBarcodeType.code128,
    '1234567890',
    style: IminBarCodeStyle(
      width: 300,
      height: 80,
      align: IminPrintAlign.center,
      position: IminBarcodeTextPos.textBelow,
    ),
  );
}
```

## Complete Example: Receipt Printing

Here's a complete example that prints a receipt:

```dart
Future<void> printReceipt() async {
  try {
    // Initialize printer
    bool initialized = await initializePrinter();
    if (!initialized) {
      throw Exception('Failed to initialize printer');
    }
    
    // Check printer status
    bool ready = await isPrinterReady();
    if (!ready) {
      throw Exception('Printer not ready');
    }
    
    // Print receipt header
    await printer.printText(
      'COFFEE SHOP',
      style: IminTextStyle(
        fontSize: 32,
        fontStyle: IminFontStyle.bold,
        align: IminPrintAlign.center,
      ),
    );
    
    await printer.printText(
      '123 Main Street',
      style: IminTextStyle(
        fontSize: 24,
        align: IminPrintAlign.center,
      ),
    );
    
    await printer.printAndLineFeed();
    await printer.printText('--------------------------------');
    await printer.printAndLineFeed();
    
    // Print items using columns
    await printer.printColumnsText(cols: [
      ColumnMaker(
        text: 'Item',
        width: 2,
        fontSize: 24,
        align: IminPrintAlign.left,
      ),
      ColumnMaker(
        text: 'Price',
        width: 1,
        fontSize: 24,
        align: IminPrintAlign.right,
      ),
    ]);
    
    await printer.printColumnsText(cols: [
      ColumnMaker(
        text: 'Coffee',
        width: 2,
        fontSize: 24,
        align: IminPrintAlign.left,
      ),
      ColumnMaker(
        text: '\$3.50',
        width: 1,
        fontSize: 24,
        align: IminPrintAlign.right,
      ),
    ]);
    
    await printer.printColumnsText(cols: [
      ColumnMaker(
        text: 'Muffin',
        width: 2,
        fontSize: 24,
        align: IminPrintAlign.left,
      ),
      ColumnMaker(
        text: '\$2.50',
        width: 1,
        fontSize: 24,
        align: IminPrintAlign.right,
      ),
    ]);
    
    await printer.printText('--------------------------------');
    
    // Print total
    await printer.printColumnsText(cols: [
      ColumnMaker(
        text: 'TOTAL',
        width: 2,
        fontSize: 28,
        align: IminPrintAlign.left,
      ),
      ColumnMaker(
        text: '\$6.00',
        width: 1,
        fontSize: 28,
        align: IminPrintAlign.right,
      ),
    ]);
    
    await printer.printAndLineFeed();
    
    // Print QR code for receipt
    await printer.printQrCode(
      'receipt-12345',
      qrCodeStyle: IminQrCodeStyle(
        qrSize: 5,
        align: IminPrintAlign.center,
      ),
    );
    
    await printer.printAndLineFeed();
    await printer.printText(
      'Thank you!',
      style: IminTextStyle(
        fontSize: 24,
        align: IminPrintAlign.center,
      ),
    );
    
    // Cut paper (if supported)
    await printer.partialCut();
    
  } catch (e) {
    print('Receipt printing failed: $e');
    rethrow;
  }
}
```

## Error Handling

Always implement proper error handling:

```dart
Future<void> safePrintOperation() async {
  try {
    // Your print operations here
    await printer.printText('Test');
    
  } on PlatformException catch (e) {
    // Handle platform-specific errors
    print('Platform error: ${e.message}');
  } catch (e) {
    // Handle general errors
    print('Print error: $e');
  }
}
```

## Testing Your Setup

### Basic Test Function

```dart
Future<void> testPrinterSetup() async {
  print('🔧 Testing printer setup...');
  
  try {
    // Test 1: Initialization
    print('1. Testing initialization...');
    bool? init = await printer.initPrinter();
    if (init != true) {
      throw Exception('Initialization failed');
    }
    print('✅ Initialization successful');
    
    // Test 2: Status check
    print('2. Testing status check...');
    Map<String, dynamic> status = await printer.getPrinterStatus();
    print('Status: ${status['code']} - ${status['msg']}');
    if (status['code'] != '0') {
      throw Exception('Printer not ready: ${status['msg']}');
    }
    print('✅ Status check successful');
    
    // Test 3: Simple print
    print('3. Testing simple print...');
    await printer.printText('Setup Test Successful!');
    await printer.printAndLineFeed();
    print('✅ Print test successful');
    
    print('🎉 All tests passed! Your printer is ready to use.');
    
  } catch (e) {
    print('❌ Test failed: $e');
    print('Please check your printer connection and try again.');
  }
}
```

## Next Steps

Now that you have the basic setup working, explore more features:

1. **Advanced Examples**: Check out [Practical Examples](examples.md) for real-world scenarios
2. **API Reference**: Browse the complete [API Documentation](api.md)
3. **Device Support**: Review [Device Compatibility](device-compatibility.md) for your specific device
4. **Error Handling**: Learn about [Error Codes & Troubleshooting](error-codes.md)

## Common Issues

### "Printer not connected"
- Ensure USB cable is properly connected
- Check that the printer is powered on
- Try restarting the app

### "Failed to initialize"
- Make sure no other app is using the printer
- Try unplugging and reconnecting the USB cable
- Restart the printer device

### "Permission denied"
- Grant USB permissions when prompted
- Check Android manifest permissions

For more troubleshooting help, see [Error Codes & Troubleshooting](error-codes.md).

## Support

- 📚 [Complete Documentation](https://iminsoftware.github.io/imin_printer/)
- 🐛 [Report Issues](https://github.com/iminsoftware/imin_printer/issues)
- 📖 [Official iMin Docs](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)