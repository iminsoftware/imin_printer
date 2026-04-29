# imin_printer

Flutter plugin for iMin built-in thermal printers. Supports text, image, barcode, QR code, and label printing on Android.

iMin built-in thermal printer Flutter plugin.

### Resources

- [Complete Documentation (English / Chinese)](https://iminsoftware.github.io/imin_printer/)
- [Pub Package](https://pub.dev/packages/imin_printer)
- [GitHub Repository](https://github.com/iminsoftware/imin_printer)
- [Official iMin Printer SDK Doc](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

#### Platform Support

| Android |
| :-----: |
|   Yes   |

## SDK Version Compatibility

| SDK Version | Android Version | Features |
|-------------|----------------|----------|
| **SDK 2.0** | Android 13+ | Full feature set including label printing, ESC/POS font control, advanced 2D codes, transaction printing |
| **SDK 1.0** | Android 11 and below | Basic printing, images, barcodes, QR codes |

## Installation

```yaml
dependencies:
  imin_printer: ^0.7.3
```

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

final iminPrinter = IminPrinter();

// Initialize
await iminPrinter.initPrinter();

// Check status
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('Printer status: ${status['msg']}');

// Print text
await iminPrinter.printText('Hello World',
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// Print QR code
await iminPrinter.printQrCode('https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
  ),
);

// Cut paper (devices with cutter only)
await iminPrinter.partialCut();
```

## Key Features

- Text printing with custom fonts, styles, alignment
- Image printing (URL and byte array)
- Barcode printing (UPC, EAN, Code128, etc.)
- QR code and double QR code printing
- Advanced 2D codes: PDF417, DataMatrix, Aztec, MaxiCode `[2.0]`
- ESC/POS font control (bold, italic, underline, multiple size) `[2.0]`
- Label printing with canvas-based layout `[2.0]`
- Transaction printing (buffer management) `[2.0]`
- Cash drawer control
- Paper cutting (on devices with cutter hardware)

## Error Handling

```dart
try {
  Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
  if (status['code'] != '0') {
    throw Exception('Printer error: ${status['msg']}');
  }
  await iminPrinter.printText('Hello World');
} catch (e) {
  print('Print error: $e');
}
```

## Documentation

For complete API reference, examples, and device compatibility details:

**[https://iminsoftware.github.io/imin_printer/](https://iminsoftware.github.io/imin_printer/)**

## License

This project is licensed under the terms specified in the LICENSE file.
