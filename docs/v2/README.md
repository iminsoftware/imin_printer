# iMin Printer SDK 2.0

> **For iMin devices running Android 13 and above**

Welcome to the iMin Printer Flutter SDK 2.0! This SDK provides a complete Flutter interface for iMin devices' built-in thermal printers.

---

## ✨ Key Features

### 🎯 Core Functions
- ✅ Text printing (multiple fonts, styles, alignment)
- ✅ Image printing (URL, byte array, transparent background)
- ✅ QR code printing (single, double QR codes)
- ✅ Barcode printing (9 standard formats)
- ✅ Table printing (fixed width, weight ratio)

### 🏷️ Label Printing (New in SDK 2.0)
- ✅ Canvas mode
- ✅ Free layout for text, barcodes, QR codes
- ✅ Shape drawing (rectangles, circles, lines)
- ✅ Image element support

### 🚀 Advanced Features
- ✅ Text bitmap rendering
- ✅ Transaction printing management
- ✅ Printer configuration (density, speed, encoding)
- ✅ Cash drawer control
- ✅ Paper cutting (selected devices)

---

## 📦 Installation

```bash
flutter pub add imin_printer
```

Or add to `pubspec.yaml`:

```yaml
dependencies:
  imin_printer: ^0.6.14
```

---

## 🚀 Quick Start

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

final iminPrinter = IminPrinter();

// Initialize
await iminPrinter.initPrinter();

// Check status
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('Status: ${status['msg']}');

// Print text
await iminPrinter.printText(
  'Welcome',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// Print QR code
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
  ),
);

// Cut paper
await iminPrinter.partialCut();
```

---

## 📚 Documentation

### Getting Started
- [Quick Start](quickstart.md) - 5-minute guide
- [API Reference](api.md) - Complete API documentation

### Feature Modules
- [Text Printing](api.md#text-printing) - Text, styles, alignment
- [Image Printing](api.md#image-printing) - Single, multiple, transparent
- [QR Code Printing](api.md#qr-code-printing) - Single, double QR codes
- [Barcode Printing](api.md#barcode-printing) - 9 standard formats
- [Table Printing](api.md#table-printing) - Fixed width, weight ratio
- [Label Printing](api.md#label-printing) - Canvas mode
- [Transaction Printing](api.md#transaction-printing) - Batch printing
- [Printer Configuration](api.md#printer-configuration) - Density, speed, encoding
- [Cash Drawer Control](api.md#cash-drawer-control) - Open cash drawer

---

## 💡 Examples

### Print Receipt

```dart
// Title
await iminPrinter.printText(
  'Store Name',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// Items
await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: 'Item', width: 150, fontSize: 24),
  ColumnMaker(text: 'Price', width: 100, fontSize: 24, align: IminPrintAlign.right),
]);

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: 'Apple', width: 150, fontSize: 24),
  ColumnMaker(text: '\$10.00', width: 100, fontSize: 24, align: IminPrintAlign.right),
]);

// QR code
await iminPrinter.printQrCode('ORDER-12345');

// Cut paper
await iminPrinter.partialCut();
```

### Print Label

```dart
// Initialize canvas
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 400,
    height: 300,
  ),
);

// Add text
await iminPrinter.labelAddText(
  'Product Name',
  labelTextStyle: LabelTextStyle(
    posX: 20,
    posY: 20,
    textSize: 28,
    enableBold: true,
  ),
);

// Add barcode
await iminPrinter.labelAddBarCode(
  '1234567890',
  barCodeStyle: LabelBarCodeStyle(
    posX: 20,
    posY: 60,
    symbology: Symbology.CODE128,
  ),
);

// Print label
await iminPrinter.labelPrintCanvas(1);
```

---

## 🔧 SDK Version Comparison

| Feature | SDK 1.0 | SDK 2.0 |
|---------|---------|---------|
| Android Version | 11 and below | 13 and above |
| Basic Printing | ✅ | ✅ |
| Image Printing | ✅ | ✅ |
| QR/Barcode | ✅ | ✅ |
| Label Printing | ❌ | ✅ |
| Text Bitmap | ❌ | ✅ |
| Transaction Printing | ❌ | ✅ |
| Advanced Config | Partial | Complete |

---

## 📱 Device Compatibility

### Supported Device Types
- **Handheld Finance Series** - 58mm paper width
- **Flat Panel Terminal Series** - 58mm or 80mm paper width
- **Desktop Cash Register** - 80mm paper width

### Cutter Function
- ✅ 80mm printers usually have cutter
- ❌ 58mm printers usually don't have cutter

---

## ⚠️ Important Notes

1. **SDK Version Detection**
   ```dart
   String? version = await iminPrinter.getSdkVersion();
   // "2.0.0" means SDK 2.0
   // "1.0.0" means SDK 1.0
   ```

2. **Status Check**
   Always check printer status before printing:
   ```dart
   Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
   if (status['code'] != '0') {
     print('Printer error: ${status['msg']}');
   }
   ```

3. **Error Handling**
   Wrap all print operations with try-catch:
   ```dart
   try {
     await iminPrinter.printText('Test');
   } catch (e) {
     print('Print failed: $e');
   }
   ```

---

## 🆘 Get Help

- 📖 [Full Documentation](https://iminsoftware.github.io/imin_printer/)
- 🐛 [Report Issues](https://github.com/iminsoftware/imin_printer/issues)
- 📦 [Pub.dev](https://pub.dev/packages/imin_printer)
- 📧 [Official iMin Docs](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

---

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

---

**Get Started**: [Quick Start Guide](quickstart.md) | [API Documentation](api.md)
