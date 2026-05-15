# iMin Printer Flutter Plugin

> 🌐 Language / 语言: **English** | [中文](README-zh.md)

Flutter plugin for iMin built-in thermal printers. Supports text, image, barcode, QR code, and label printing.

## Device Quick Reference

| Paper Width | Printable Pixels | Cutter |
|-------------|-----------------|--------|
| 80mm | 576px | �?Some models |
| 58mm | 384px | �?|

| SDK Version | Android Version | Notes |
|-------------|----------------|-------|
| SDK 2.0 | Android 13+ | Full feature set, recommended |
| SDK 1.0 | Android 11 and below | Basic printing features |

## Installation

```yaml
dependencies:
  imin_printer: ^0.7.5
```

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';

final iminPrinter = IminPrinter();

// 1. Initialize
await iminPrinter.initPrinter();

// 2. Check status
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] != '0') {
  print('Printer error: ${status['msg']}');
  return;
}

// 3. Print
await iminPrinter.printText('Hello World',
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// 4. Feed paper
await iminPrinter.printAndLineFeed();
```

## Receipt Example

```dart
Future<void> printReceipt() async {
  final printer = IminPrinter();
  await printer.initPrinter();

  await printer.printText('COFFEE SHOP',
    style: IminTextStyle(fontSize: 32, fontStyle: IminFontStyle.bold, align: IminPrintAlign.center),
  );
  await printer.printText('123 Main Street',
    style: IminTextStyle(fontSize: 24, align: IminPrintAlign.center),
  );
  await printer.printAndLineFeed();
  await printer.printText('--------------------------------');
  await printer.printAndLineFeed();

  // width is pixel width, 80mm paper = 576px total
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'Coffee', width: 200, fontSize: 24, align: IminPrintAlign.left),
    ColumnMaker(text: 'x2',     width: 100, fontSize: 24, align: IminPrintAlign.center),
    ColumnMaker(text: '\$7.00', width: 150, fontSize: 24, align: IminPrintAlign.right),
  ]);
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'Muffin', width: 200, fontSize: 24, align: IminPrintAlign.left),
    ColumnMaker(text: 'x1',     width: 100, fontSize: 24, align: IminPrintAlign.center),
    ColumnMaker(text: '\$2.50', width: 150, fontSize: 24, align: IminPrintAlign.right),
  ]);

  await printer.printText('--------------------------------');
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'TOTAL',  width: 300, fontSize: 28, align: IminPrintAlign.left),
    ColumnMaker(text: '\$9.50', width: 150, fontSize: 28, align: IminPrintAlign.right),
  ]);
  await printer.printAndLineFeed();

  await printer.printQrCode('receipt-12345',
    qrCodeStyle: IminQrCodeStyle(qrSize: 5, align: IminPrintAlign.center),
  );
  await printer.printAndLineFeed();
  await printer.printText('Thank you!',
    style: IminTextStyle(fontSize: 24, align: IminPrintAlign.center),
  );
  await printer.partialCut();
}
```

## Error Handling

```dart
Future<void> safePrint() async {
  try {
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('Printer error: ${status['msg']}');
    }
    await iminPrinter.printText('Hello World');
  } on PlatformException catch (e) {
    print('Platform error: ${e.message}');
  } catch (e) {
    print('Print error: $e');
  }
}
```

## API Reference

Complete method documentation �?[api.md](api.md)

## Resources

- [Pub Package](https://pub.dev/packages/imin_printer)
- [GitHub Repository](https://github.com/iminsoftware/imin_printer)
- [Official iMin Printer SDK Doc](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
