# Migration Guide

This guide helps you migrate from older versions of the iMin Printer SDK to the latest version, and understand the differences between SDK 1.0 and 2.0.

## Table of Contents
- [SDK 1.0 to 2.0 Migration](#sdk-10-to-20-migration)
- [Plugin Version Updates](#plugin-version-updates)
- [Breaking Changes](#breaking-changes)
- [New Features](#new-features)
- [Code Examples](#code-examples)

## SDK 1.0 to 2.0 Migration

### Overview
SDK 2.0 introduces significant enhancements while maintaining backward compatibility for most basic operations. The main improvements include:

- Label printing capabilities
- Text bitmap rendering
- Enhanced buffer management
- Advanced printer configuration
- Improved error handling

### Compatibility Matrix
| Feature | SDK 1.0 | SDK 2.0 | Migration Required |
|---------|---------|---------|-------------------|
| Basic text printing | ✅ | ✅ | No |
| Image printing | ✅ | ✅ | No |
| Barcode printing | ✅ | ✅ | No |
| QR code printing | ✅ | ✅ | No |
| Label printing | ❌ | ✅ | New feature |
| Text bitmap | ❌ | ✅ | New feature |
| Buffer management | ❌ | ✅ | New feature |
| Advanced config | ❌ | ✅ | New feature |

### Migration Steps

#### Step 1: Update Dependencies
```yaml
# pubspec.yaml
dependencies:
  imin_printer: ^0.6.14  # Update to latest version
```

#### Step 2: Update Imports
No changes required for basic imports:
```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
```

#### Step 3: Update Method Calls
Most existing method calls remain the same, but you should add `await` keywords:

**Before (SDK 1.0):**
```dart
iminPrinter.initPrinter();
iminPrinter.printText('Hello World');
iminPrinter.printAndLineFeed();
```

**After (SDK 2.0):**
```dart
await iminPrinter.initPrinter();
await iminPrinter.printText('Hello World');
await iminPrinter.printAndLineFeed();
```

## Plugin Version Updates

### Version 0.6.x Series

#### 0.6.14 (Latest)
- **New**: Android 15 compatibility
- **Improved**: Plugin stability
- **Fixed**: Various bug fixes

#### 0.6.13
- **Updated**: Latest Android SDK compatibility
- **Fixed**: SDK version conflicts

#### 0.6.12
- **Updated**: Android SDK adaptation

#### 0.6.11
- **New**: Transparent background image printing
- **New**: 64-bit SO file adaptation

#### 0.6.10
- **Fixed**: Various bug fixes

#### 0.6.9
- **New**: Label API updates
- **Improved**: Label printing functionality

### Version 0.5.x to 0.6.x Migration

#### Breaking Changes
1. **Method Signatures**: Some methods now require different parameters
2. **Return Types**: Several methods now return `Future<T>` instead of `void`
3. **Error Handling**: Enhanced error reporting

#### Migration Example
**Before (0.5.x):**
```dart
void printReceipt() {
  iminPrinter.initPrinter();
  iminPrinter.printText('Receipt');
  iminPrinter.partialCut();
}
```

**After (0.6.x):**
```dart
Future<void> printReceipt() async {
  try {
    await iminPrinter.initPrinter();
    await iminPrinter.printText('Receipt');
    await iminPrinter.partialCut();
  } catch (e) {
    print('Print error: $e');
  }
}
```

## Breaking Changes

### Method Return Types
Several methods now return `Future` types for better async handling:

| Method | Old Return Type | New Return Type |
|--------|----------------|-----------------|
| `initPrinter()` | `void` | `Future<bool?>` |
| `getPrinterStatus()` | `void` | `Future<Map<String, dynamic>>` |
| `printText()` | `void` | `Future<void>` |
| `printQrCode()` | `void` | `Future<void>` |
| `printBarCode()` | `void` | `Future<void>` |

### Parameter Changes
Some methods have updated parameter structures:

#### Text Style Parameters
**Before:**
```dart
iminPrinter.printText('Hello', IminTextStyle(
  fontSize: 20,
  space: 1.0f,  // Note the 'f' suffix
));
```

**After:**
```dart
await iminPrinter.printText('Hello', 
  style: IminTextStyle(
    fontSize: 20,
    space: 1.0,  // No 'f' suffix needed
  )
);
```

#### Image Printing Parameters
**Before:**
```dart
iminPrinter.printSingleBitmap(imageBytes, IminPictureStyle(...));
```

**After:**
```dart
await iminPrinter.printSingleBitmap(
  imageBytes, 
  pictureStyle: IminPictureStyle(...)
);
```

### Enum Naming Conventions
Some enum values have been updated to follow Dart naming conventions:

**Before:**
```dart
enum Shape {
  RECT_FILL,
  RECT_WHITE,
  // ...
}
```

**After:**
```dart
enum Shape {
  rectFill,    // Recommended
  rectWhite,   // Recommended
  // Old names still work but deprecated
}
```

## New Features

### Label Printing (SDK 2.0 Only)
Complete label printing system with canvas-based approach:

```dart
// Initialize label canvas
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 400,
    height: 300,
  ),
);

// Add elements to label
await iminPrinter.labelAddText('Product Name');
await iminPrinter.labelAddBarCode('1234567890');
await iminPrinter.labelAddQrCode('https://example.com');

// Print the label
await iminPrinter.labelPrintCanvas(1);
```

### Text Bitmap Rendering
Enhanced text rendering as bitmaps:

```dart
// Configure text bitmap settings
await iminPrinter.setTextBitmapTypeface(IminTypeface.typefaceDefaultBold);
await iminPrinter.setTextBitmapSize(32);
await iminPrinter.setTextBitmapUnderline(true);

// Print text as bitmap
await iminPrinter.printTextBitmap('Bitmap Text');
```

### Buffer Management
Improved print job management:

```dart
// Enter buffer mode
await iminPrinter.enterPrinterBuffer(true);

// Add multiple operations
await iminPrinter.printText('Line 1');
await iminPrinter.printText('Line 2');
await iminPrinter.printText('Line 3');

// Execute all at once
await iminPrinter.commitPrinterBuffer();
await iminPrinter.exitPrinterBuffer(true);
```

### Enhanced Configuration
Advanced printer configuration options:

```dart
// Get available options
List<String>? densities = await iminPrinter.getPrinterDensityList();
List<String>? speeds = await iminPrinter.getPrinterSpeedList();

// Configure printer
await iminPrinter.setPrinterSpeed(3);
await iminPrinter.setFontCodepage(0);
```

## Code Examples

### Complete Migration Example

**Before (SDK 1.0 / Plugin 0.5.x):**
```dart
class OldPrinterService {
  final IminPrinter printer = IminPrinter();
  
  void printReceipt() {
    printer.initPrinter();
    printer.setAlignment(IminPrintAlign.center);
    printer.printText('RECEIPT', IminTextStyle(fontSize: 32));
    printer.printAndLineFeed();
    printer.printText('Item 1: \$10.00');
    printer.printText('Total: \$10.00');
    printer.printQrCode('receipt-123', IminQrCodeStyle(qrSize: 4));
    printer.partialCut();
  }
}
```

**After (SDK 2.0 / Plugin 0.6.x):**
```dart
class NewPrinterService {
  final IminPrinter printer = IminPrinter();
  
  Future<bool> printReceipt() async {
    try {
      // Initialize printer
      bool? initialized = await printer.initPrinter();
      if (initialized != true) {
        throw Exception('Failed to initialize printer');
      }
      
      // Check printer status
      Map<String, dynamic> status = await printer.getPrinterStatus();
      if (status['code'] != '0') {
        throw Exception('Printer not ready: ${status['msg']}');
      }
      
      // Print receipt
      await printer.setAlignment(IminPrintAlign.center);
      await printer.printText('RECEIPT', 
        style: IminTextStyle(fontSize: 32)
      );
      await printer.printAndLineFeed();
      await printer.printText('Item 1: \$10.00');
      await printer.printText('Total: \$10.00');
      await printer.printQrCode('receipt-123', 
        qrCodeStyle: IminQrCodeStyle(qrSize: 4)
      );
      await printer.partialCut();
      
      return true;
    } catch (e) {
      print('Print error: $e');
      return false;
    }
  }
}
```

### Error Handling Migration

**Before:**
```dart
void printWithBasicErrorHandling() {
  try {
    printer.printText('Hello');
  } catch (e) {
    print('Error: $e');
  }
}
```

**After:**
```dart
Future<void> printWithAdvancedErrorHandling() async {
  try {
    // Check status first
    Map<String, dynamic> status = await printer.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('Printer error: ${status['msg']}');
    }
    
    await printer.printText('Hello');
  } on PlatformException catch (e) {
    print('Platform error: ${e.message}');
  } catch (e) {
    print('General error: $e');
  }
}
```

## Testing Your Migration

### Basic Functionality Test
```dart
Future<void> testBasicFunctionality() async {
  try {
    // Test initialization
    bool? init = await printer.initPrinter();
    assert(init == true, 'Printer initialization failed');
    
    // Test status check
    Map<String, dynamic> status = await printer.getPrinterStatus();
    assert(status.containsKey('code'), 'Status check failed');
    
    // Test basic printing
    await printer.printText('Migration Test');
    await printer.printAndLineFeed();
    
    print('✅ Basic functionality test passed');
  } catch (e) {
    print('❌ Basic functionality test failed: $e');
  }
}
```

### New Features Test
```dart
Future<void> testNewFeatures() async {
  try {
    // Test label printing (SDK 2.0 feature)
    await printer.labelInitCanvas();
    await printer.labelAddText('Test Label');
    await printer.labelPrintCanvas(1);
    
    // Test text bitmap (SDK 2.0 feature)
    await printer.printTextBitmap('Bitmap Test');
    
    // Test buffer management (SDK 2.0 feature)
    await printer.enterPrinterBuffer(true);
    await printer.printText('Buffered Text');
    await printer.commitPrinterBuffer();
    await printer.exitPrinterBuffer(true);
    
    print('✅ New features test passed');
  } catch (e) {
    print('❌ New features test failed: $e');
  }
}
```

## Common Migration Issues

### Issue 1: Missing await Keywords
**Problem:** Methods not waiting for completion
**Solution:** Add `await` to all printer method calls

### Issue 2: Parameter Name Changes
**Problem:** Named parameters not recognized
**Solution:** Update parameter names (e.g., `style:` instead of direct parameter)

### Issue 3: Return Type Handling
**Problem:** Not handling Future return types
**Solution:** Use `await` and handle potential null returns

### Issue 4: Error Handling
**Problem:** Errors not properly caught
**Solution:** Wrap in try-catch blocks and check printer status

## Best Practices After Migration

1. **Always use async/await** for printer operations
2. **Check printer status** before printing
3. **Handle errors gracefully** with proper exception handling
4. **Test on actual devices** after migration
5. **Use buffer mode** for complex print jobs
6. **Validate return values** from printer methods

## Getting Help

If you encounter issues during migration:

1. Check the [examples documentation](examples.md)
2. Review [device compatibility](device-compatibility.md)
3. Test with simple operations first
4. Check the [GitHub issues](https://github.com/iminsoftware/imin_printer/issues)
5. Refer to the [official documentation](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

---

*Migration guide last updated: January 2026*
*Covers plugin versions up to 0.6.14*