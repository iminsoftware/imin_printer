# imin_printer

It is used to print text, pictures, two-dimensional code, bar code and other functions sdk in imin printer using Android system

### Resources:

- [Pub Package](https://pub.dev/packages/imin_printer)
- [GitHub Repository](https://github.com/iminsoftware/imin_printer)
- [Complete Documentation](https://iminsoftware.github.io/imin_printer/)

#### Platform Support

| Android |
| :-----: | 
|   ✅   |

[Official Imin Inner Printer Doc](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

## Documentation

- 📚 [API Documentation](docs/api.md) - Complete API reference
- 🚀 [Quick Start Guide](docs/quickstart.md) - Get started quickly
- 💡 [Practical Examples](docs/examples.md) - Real-world usage examples
- 🔧 [Device Compatibility](docs/device-compatibility.md) - Supported devices and features
- 📋 [Migration Guide](docs/migration-guide.md) - Upgrade from older versions

## Getting Started

### Installation  

```bash
flutter pub add imin_printer
```

### Basic Usage

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

// Initialize printer
final iminPrinter = IminPrinter();
await iminPrinter.initPrinter();

// Check printer status
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('Printer status: ${status['msg']}');

// Print text
await iminPrinter.printText(
  'Hello World', 
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  )
);

// Print QR code
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
  )
);

// Cut paper (if supported)
await iminPrinter.partialCut();
```




## Tested Devices

| Device Model | Series | Paper Width | Cutter | Status |
|--------------|--------|-------------|---------|---------|
| M2-202 | Handheld Finance | 58mm | ❌ | ✅ Fully Tested |
| M2-203 | Handheld Finance | 58mm | ❌ | ✅ Fully Tested |
| M2 Pro | Handheld Finance | 58mm | ❌ | ✅ Fully Tested |
| Swift 1 | Handheld Finance | 58mm | ❌ | ⚠️ Compatible |
| Swift 2 | Handheld Finance | 58mm | ❌ | ⚠️ Compatible |
| M2 Max | Flat Panel Terminal | 58mm | ❌ | ⚠️ Compatible |
| D1 | Flat Panel Terminal | 58mm | ❌ | ⚠️ Compatible |
| Falcon 1 | Flat Panel Terminal | 80mm | ✅ | ⚠️ Compatible |
| D4 | Desktop Cash Register | 80mm | ✅ | ⚠️ Compatible |

**Legend:** ✅ Fully tested | ⚠️ Compatible but not extensively tested

For complete device compatibility information, see [Device Compatibility Guide](docs/device-compatibility.md).

## Key Features

### Basic Printing
- ✅ Text printing with custom styles
- ✅ Image printing (URL and byte array)
- ✅ Table/column printing
- ✅ Anti-white text printing

### Barcode & QR Code
- ✅ Multiple barcode formats (UPC, EAN, Code128, etc.)
- ✅ QR code with error correction levels
- ✅ Double QR code printing
- ✅ Custom positioning and sizing

### Label Printing (SDK 2.0)
- ✅ Canvas-based label design
- ✅ Text, barcode, QR code on labels
- ✅ Image and shape elements
- ✅ Flexible positioning

### Advanced Features
- ✅ Text bitmap rendering
- ✅ Print buffer management
- ✅ Printer configuration
- ✅ Cash drawer control
- ✅ Paper cutting (on supported devices)

## Quick Examples

### Print Receipt
```dart
Future<void> printReceipt() async {
  await iminPrinter.initPrinter();
  
  // Header
  await iminPrinter.printText(
    'STORE RECEIPT',
    style: IminTextStyle(
      fontSize: 32,
      fontStyle: IminFontStyle.bold,
      align: IminPrintAlign.center,
    ),
  );
  
  // Items
  await iminPrinter.printColumnsText(cols: [
    ColumnMaker(text: 'Coffee', width: 2, align: IminPrintAlign.left),
    ColumnMaker(text: '\$3.50', width: 1, align: IminPrintAlign.right),
  ]);
  
  // QR Code
  await iminPrinter.printQrCode('receipt-12345');
  
  await iminPrinter.partialCut();
}
```

### Print Label
```dart
Future<void> printProductLabel() async {
  // Initialize label canvas
  await iminPrinter.labelInitCanvas(
    labelCanvasStyle: LabelCanvasStyle(width: 400, height: 300),
  );
  
  // Add product name
  await iminPrinter.labelAddText('Product Name');
  
  // Add barcode
  await iminPrinter.labelAddBarCode('1234567890');
  
  // Print label
  await iminPrinter.labelPrintCanvas(1);
}
```

For more examples, see [Practical Examples](docs/examples.md).

## API Reference

### Basic Operations
```dart
// Initialize printer
await iminPrinter.initPrinter();

// Check status
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();

// Print text with styling
await iminPrinter.printText(
  'Styled Text',
  style: IminTextStyle(
    fontSize: 24,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

### Supported Enums

#### Text Alignment
```dart
enum IminPrintAlign { 
  left, 
  center, 
  right 
}
```

#### QR Code Error Correction
```dart
enum IminQrcodeCorrectionLevel {
  levelL(48),  // ~7% correction
  levelM(49),  // ~15% correction
  levelQ(50),  // ~25% correction
  levelH(51);  // ~30% correction
}
```

#### Text Styles
```dart
enum IminFontStyle { 
  normal, 
  bold, 
  italic, 
  boldItalic 
}

enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
```

### Text Style Configuration
```dart
class IminTextStyle {
  bool? wordWrap;        // Auto line wrap
  int? fontSize;         // Font size
  double? space;         // Line spacing
  IminTypeface? typeface; // Font family
  IminFontStyle? fontStyle; // Bold, italic, etc.
  IminPrintAlign? align;  // Text alignment
}
```

For complete API documentation, see [API Documentation](docs/api.md).

## Error Handling

Always wrap printer operations in try-catch blocks:

```dart
Future<void> safePrint() async {
  try {
    // Check printer status first
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('Printer not ready: ${status['msg']}');
    }
    
    await iminPrinter.printText('Hello World');
  } catch (e) {
    print('Print error: $e');
    // Handle error appropriately
  }
}
```

## Migration from Older Versions

If you're upgrading from an older version:

1. **Add await keywords** to all printer method calls
2. **Update parameter names** (e.g., `style:` parameter)
3. **Handle Future return types** properly
4. **Check the migration guide** for detailed instructions

See [Migration Guide](docs/migration-guide.md) for complete upgrade instructions.

## Support

- 📖 [Documentation](https://iminsoftware.github.io/imin_printer/)
- 🐛 [GitHub Issues](https://github.com/iminsoftware/imin_printer/issues)
- 📧 [Official iMin Documentation](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to help improve this plugin.

## License

This project is licensed under the terms specified in the LICENSE file.