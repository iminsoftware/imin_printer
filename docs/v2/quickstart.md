# Quick Start - SDK 2.0

> **For Android 13 and above**  
> **SDK Version**: 2.0.0

This guide will help you get started with iMin Printer SDK 2.0 quickly.

---

## Prerequisites

- Flutter SDK 3.3.0 or higher
- Dart SDK 3.0.6 or higher
- iMin device (Android 13+)
- Built-in thermal printer

---

## Installation

### Method 1: Using Command Line

```bash
flutter pub add imin_printer
```

### Method 2: Manual Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  imin_printer: ^0.6.14
```

Then run:

```bash
flutter pub get
```

---

## Basic Usage

### 1. Import Packages

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';
```

### 2. Create Printer Instance

```dart
final iminPrinter = IminPrinter();
```

### 3. Initialize Printer

```dart
await iminPrinter.initPrinter();
```

### 4. Check Printer Status

```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] == '0') {
  print('Printer ready');
} else {
  print('Printer error: ${status['msg']}');
}
```

### 5. Print Text

```dart
await iminPrinter.printText('Hello World');
```

---

## Complete Example

Create a simple printing app:

```dart
import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMin Printer Demo',
      home: const PrinterDemo(),
    );
  }
}

class PrinterDemo extends StatefulWidget {
  const PrinterDemo({super.key});

  @override
  State<PrinterDemo> createState() => _PrinterDemoState();
}

class _PrinterDemoState extends State<PrinterDemo> {
  final iminPrinter = IminPrinter();
  String _status = 'Not initialized';

  @override
  void initState() {
    super.initState();
    _initPrinter();
  }

  // Initialize printer
  Future<void> _initPrinter() async {
    try {
      await iminPrinter.initPrinter();
      
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      setState(() {
        _status = status['code'] == '0' ? 'Ready' : 'Error: ${status['msg']}';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  // Print test content
  Future<void> _printTest() async {
    try {
      // Check status
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      if (status['code'] != '0') {
        _showMessage('Printer not ready: ${status['msg']}');
        return;
      }

      // Print title
      await iminPrinter.printText(
        'Test Print',
        style: IminTextStyle(
          fontSize: 32,
          fontStyle: IminFontStyle.bold,
          align: IminPrintAlign.center,
        ),
      );

      // Print content
      await iminPrinter.printText('This is a test message');
      await iminPrinter.printText('Time: ${DateTime.now()}');

      // Print QR code
      await iminPrinter.printQrCode(
        'https://www.imin.sg',
        qrCodeStyle: IminQrCodeStyle(
          qrSize: 6,
          align: IminPrintAlign.center,
        ),
      );

      // Feed paper and cut
      await iminPrinter.printAndFeedPaper(100);
      await iminPrinter.partialCut();

      _showMessage('Print successful!');
    } catch (e) {
      _showMessage('Print failed: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iMin Printer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Printer Status: $_status',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _printTest,
              child: const Text('Test Print'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Common Functions

### Print Text

```dart
// Simple text
await iminPrinter.printText('Hello World');

// Styled text
await iminPrinter.printText(
  'Welcome',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

### Print Image

```dart
// Print network image
await iminPrinter.printSingleBitmap(
  'https://example.com/logo.png',
  pictureStyle: IminPictureStyle(
    width: 250,
    height: 80,
    alignment: IminPrintAlign.center,
  ),
);
```

### Print QR Code

```dart
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
  ),
);
```

### Print Barcode

```dart
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '1234567890',
  style: IminBarCodeStyle(
    width: 300,
    height: 80,
    align: IminPrintAlign.center,
    position: IminBarcodeTextPos.textBelow,
  ),
);
```

### Print Table

```dart
import 'package:imin_printer/column_maker.dart';

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(
    text: 'Item',
    width: 150,
    fontSize: 24,
    align: IminPrintAlign.left,
  ),
  ColumnMaker(
    text: 'Price',
    width: 100,
    fontSize: 24,
    align: IminPrintAlign.right,
  ),
]);
```

---

## Error Handling

Always wrap print operations with try-catch:

```dart
try {
  // Check status
  Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
  if (status['code'] != '0') {
    throw Exception('Printer not ready: ${status['msg']}');
  }

  // Execute print
  await iminPrinter.printText('Test');
  
} catch (e) {
  print('Print error: $e');
  // Handle error
}
```

---

## Next Steps

- 📖 View [Complete API Documentation](api.md)
- 💡 Learn [Label Printing](api.md#label-printing)
- 🔧 Understand [Transaction Printing](api.md#transaction-printing)
- 📋 Check [Complete Examples](api.md#complete-examples)

---

## FAQ

### How to determine which SDK version?

```dart
String? version = await iminPrinter.getSdkVersion();
print('SDK Version: $version'); // "2.0.0" or "1.0.0"
```

### Printer not responding?

1. Check printer status
2. Try reinitializing
3. Check device connection

```dart
await iminPrinter.resetDevice();
await iminPrinter.initPrinter();
```

### How to improve printing efficiency?

Use transaction printing for batch submission:

```dart
await iminPrinter.enterPrinterBuffer(true);
// Add multiple print commands
await iminPrinter.printText('Line 1');
await iminPrinter.printText('Line 2');
await iminPrinter.commitPrinterBuffer();
await iminPrinter.exitPrinterBuffer(true);
```

---

## Support

- 📚 [Full Documentation](https://iminsoftware.github.io/imin_printer/)
- 🐛 [Report Issues](https://github.com/iminsoftware/imin_printer/issues)
- 📧 [Official iMin Docs](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
