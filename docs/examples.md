# Practical Examples

This document provides comprehensive examples for common printing scenarios using the iMin Printer SDK.

## Table of Contents
- [Basic Setup](#basic-setup)
- [Receipt Printing](#receipt-printing)
- [Label Printing](#label-printing)
- [Image Printing](#image-printing)
- [Error Handling](#error-handling)
- [Advanced Features](#advanced-features)

## Basic Setup

### Initialize the Printer
```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

class PrinterService {
  final IminPrinter _printer = IminPrinter();
  
  Future<bool> initializePrinter() async {
    try {
      bool? result = await _printer.initPrinter();
      if (result == true) {
        print('Printer initialized successfully');
        return true;
      } else {
        print('Failed to initialize printer');
        return false;
      }
    } catch (e) {
      print('Error initializing printer: $e');
      return false;
    }
  }
  
  Future<void> checkPrinterStatus() async {
    try {
      Map<String, dynamic> status = await _printer.getPrinterStatus();
      print('Printer Status: ${status['msg']}');
    } catch (e) {
      print('Error checking printer status: $e');
    }
  }
}
```

## Receipt Printing

### Simple Receipt Example
```dart
class ReceiptPrinter {
  final IminPrinter _printer = IminPrinter();
  
  Future<void> printSimpleReceipt() async {
    try {
      // Initialize printer
      await _printer.initPrinter();
      
      // Print header
      await _printer.printText(
        'STORE NAME',
        style: IminTextStyle(
          fontSize: 32,
          fontStyle: IminFontStyle.bold,
          align: IminPrintAlign.center,
        ),
      );
      
      await _printer.printText(
        '123 Main Street, City',
        style: IminTextStyle(
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
      );
      
      await _printer.printText(
        'Tel: (555) 123-4567',
        style: IminTextStyle(
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
      );
      
      // Print separator line
      await _printer.printAndLineFeed();
      await _printer.printText('--------------------------------');
      await _printer.printAndLineFeed();
      
      // Print items
      await _printer.printColumnsText(cols: [
        ColumnMaker(
          text: 'Item',
          width: 2,
          fontSize: 24,
          align: IminPrintAlign.left,
        ),
        ColumnMaker(
          text: 'Qty',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
        ColumnMaker(
          text: 'Price',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.right,
        ),
      ]);
      
      await _printer.printText('--------------------------------');
      
      await _printer.printColumnsText(cols: [
        ColumnMaker(
          text: 'Coffee',
          width: 2,
          fontSize: 24,
          align: IminPrintAlign.left,
        ),
        ColumnMaker(
          text: '2',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
        ColumnMaker(
          text: '\$6.00',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.right,
        ),
      ]);
      
      await _printer.printColumnsText(cols: [
        ColumnMaker(
          text: 'Sandwich',
          width: 2,
          fontSize: 24,
          align: IminPrintAlign.left,
        ),
        ColumnMaker(
          text: '1',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
        ColumnMaker(
          text: '\$8.50',
          width: 1,
          fontSize: 24,
          align: IminPrintAlign.right,
        ),
      ]);
      
      // Print total
      await _printer.printText('--------------------------------');
      await _printer.printColumnsText(cols: [
        ColumnMaker(
          text: 'TOTAL',
          width: 3,
          fontSize: 28,
          align: IminPrintAlign.left,
        ),
        ColumnMaker(
          text: '\$14.50',
          width: 1,
          fontSize: 28,
          align: IminPrintAlign.right,
        ),
      ]);
      
      // Print QR code for receipt
      await _printer.printAndLineFeed();
      await _printer.printQrCode(
        'https://store.com/receipt/12345',
        qrCodeStyle: IminQrCodeStyle(
          qrSize: 6,
          align: IminPrintAlign.center,
          errorCorrectionLevel: IminQrcodeCorrectionLevel.levelM,
        ),
      );
      
      // Print footer
      await _printer.printAndLineFeed();
      await _printer.printText(
        'Thank you for your business!',
        style: IminTextStyle(
          fontSize: 24,
          align: IminPrintAlign.center,
        ),
      );
      
      // Cut paper (if supported)
      await _printer.partialCut();
      
    } catch (e) {
      print('Error printing receipt: $e');
    }
  }
}
```

### Advanced Receipt with Barcode
```dart
Future<void> printReceiptWithBarcode() async {
  try {
    await _printer.initPrinter();
    
    // Print store logo (if you have image bytes)
    // await _printer.printSingleBitmap(logoBytes);
    
    // Print receipt number as barcode
    await _printer.printBarCode(
      IminBarcodeType.code128,
      'RCP001234567890',
      style: IminBarCodeStyle(
        width: 300,
        height: 80,
        align: IminPrintAlign.center,
        position: IminBarcodeTextPos.textBelow,
      ),
    );
    
    await _printer.printAndLineFeed();
    
    // Continue with receipt content...
    await _printer.printText(
      'Receipt #: RCP001234567890',
      style: IminTextStyle(
        fontSize: 20,
        align: IminPrintAlign.center,
      ),
    );
    
    // Add timestamp
    await _printer.printText(
      'Date: ${DateTime.now().toString().substring(0, 19)}',
      style: IminTextStyle(
        fontSize: 20,
        align: IminPrintAlign.center,
      ),
    );
    
  } catch (e) {
    print('Error printing receipt with barcode: $e');
  }
}
```

## Label Printing

### Product Label Example
```dart
class LabelPrinter {
  final IminPrinter _printer = IminPrinter();
  
  Future<void> printProductLabel({
    required String productName,
    required String productCode,
    required String price,
    required String qrData,
  }) async {
    try {
      // Initialize label canvas
      await _printer.labelInitCanvas(
        labelCanvasStyle: LabelCanvasStyle(
          width: 400,
          height: 300,
          posX: 0,
          posY: 0,
        ),
      );
      
      // Add product name
      await _printer.labelAddText(
        productName,
        labelTextStyle: LabelTextStyle(
          posX: 20,
          posY: 20,
          textSize: 28,
          enableBold: true,
          align: AlignLabel.left,
        ),
      );
      
      // Add product code as barcode
      await _printer.labelAddBarCode(
        productCode,
        barCodeStyle: LabelBarCodeStyle(
          posX: 20,
          posY: 60,
          symbology: Symbology.code128,
          barHeight: 60,
          readable: HumanReadable.pos_two,
        ),
      );
      
      // Add price
      await _printer.labelAddText(
        'Price: $price',
        labelTextStyle: LabelTextStyle(
          posX: 20,
          posY: 140,
          textSize: 24,
          enableBold: true,
          align: AlignLabel.left,
        ),
      );
      
      // Add QR code
      await _printer.labelAddQrCode(
        qrData,
        qrCodeStyle: LabelQrCodeStyle(
          posX: 280,
          posY: 60,
          size: 4,
          errorLevel: ErrorLevel.m,
        ),
      );
      
      // Add border
      await _printer.labelAddArea(
        areaStyle: LabelAreaStyle(
          style: Shape.box,
          posX: 10,
          posY: 10,
          width: 380,
          height: 280,
          thick: 2,
        ),
      );
      
      // Print the label
      await _printer.labelPrintCanvas(1);
      
    } catch (e) {
      print('Error printing product label: $e');
    }
  }
}
```

### Shipping Label Example
```dart
Future<void> printShippingLabel({
  required String fromAddress,
  required String toAddress,
  required String trackingNumber,
}) async {
  try {
    await _printer.labelInitCanvas(
      labelCanvasStyle: LabelCanvasStyle(
        width: 600,
        height: 400,
      ),
    );
    
    // From address
    await _printer.labelAddText(
      'FROM:',
      labelTextStyle: LabelTextStyle(
        posX: 20,
        posY: 20,
        textSize: 20,
        enableBold: true,
      ),
    );
    
    await _printer.labelAddText(
      fromAddress,
      labelTextStyle: LabelTextStyle(
        posX: 20,
        posY: 50,
        textSize: 18,
      ),
    );
    
    // To address
    await _printer.labelAddText(
      'TO:',
      labelTextStyle: LabelTextStyle(
        posX: 20,
        posY: 120,
        textSize: 20,
        enableBold: true,
      ),
    );
    
    await _printer.labelAddText(
      toAddress,
      labelTextStyle: LabelTextStyle(
        posX: 20,
        posY: 150,
        textSize: 18,
      ),
    );
    
    // Tracking number as barcode
    await _printer.labelAddBarCode(
      trackingNumber,
      barCodeStyle: LabelBarCodeStyle(
        posX: 20,
        posY: 250,
        symbology: Symbology.code128,
        barHeight: 80,
        readable: HumanReadable.pos_two,
      ),
    );
    
    // Print label
    await _printer.labelPrintCanvas(1);
    
  } catch (e) {
    print('Error printing shipping label: $e');
  }
}
```

## Image Printing

### Print Logo or Image
```dart
class ImagePrinter {
  final IminPrinter _printer = IminPrinter();
  
  Future<void> printImageFromUrl(String imageUrl) async {
    try {
      await _printer.initPrinter();
      
      await _printer.printSingleBitmap(
        imageUrl,
        pictureStyle: IminPictureStyle(
          alignment: IminPrintAlign.center,
          width: 300,
          height: 200,
        ),
      );
      
      await _printer.printAndLineFeed();
      
    } catch (e) {
      print('Error printing image from URL: $e');
    }
  }
  
  Future<void> printImageFromBytes(Uint8List imageBytes) async {
    try {
      await _printer.initPrinter();
      
      await _printer.printSingleBitmap(
        imageBytes,
        pictureStyle: IminPictureStyle(
          alignment: IminPrintAlign.center,
          width: 250,
        ),
      );
      
      await _printer.printAndLineFeed();
      
    } catch (e) {
      print('Error printing image from bytes: $e');
    }
  }
  
  Future<void> printMultipleImages(List<String> imageUrls) async {
    try {
      await _printer.initPrinter();
      
      await _printer.printMultiBitmap(
        imageUrls,
        pictureStyle: IminPictureStyle(
          alignment: IminPrintAlign.center,
          width: 200,
          height: 150,
        ),
      );
      
      await _printer.printAndLineFeed();
      
    } catch (e) {
      print('Error printing multiple images: $e');
    }
  }
}
```

## Error Handling

### Comprehensive Error Handling
```dart
class PrinterErrorHandler {
  final IminPrinter _printer = IminPrinter();
  
  Future<bool> safePrint(Function printFunction) async {
    try {
      // Check printer status first
      Map<String, dynamic> status = await _printer.getPrinterStatus();
      String statusCode = status['code'] ?? '-1';
      
      switch (statusCode) {
        case '0':
          print('Printer is ready');
          break;
        case '1':
          throw Exception('Printer is not connected or powered on');
        case '3':
          throw Exception('Print head is open');
        case '5':
          throw Exception('Printer is overheated');
        case '8':
          throw Exception('Paper is running out');
        default:
          print('Printer status: ${status['msg']}');
      }
      
      // Execute the print function
      await printFunction();
      return true;
      
    } catch (e) {
      print('Print error: $e');
      await _handlePrintError(e);
      return false;
    }
  }
  
  Future<void> _handlePrintError(dynamic error) async {
    String errorMessage = error.toString();
    
    if (errorMessage.contains('not connected')) {
      print('Please check printer connection');
    } else if (errorMessage.contains('paper')) {
      print('Please check paper supply');
    } else if (errorMessage.contains('overheated')) {
      print('Please wait for printer to cool down');
    } else {
      print('Unknown printer error: $errorMessage');
    }
    
    // Optionally reset the printer
    try {
      await _printer.resetDevice();
    } catch (resetError) {
      print('Failed to reset printer: $resetError');
    }
  }
}
```

### Usage with Error Handling
```dart
Future<void> printWithErrorHandling() async {
  final errorHandler = PrinterErrorHandler();
  
  bool success = await errorHandler.safePrint(() async {
    await _printer.printText('Test Print');
    await _printer.printAndLineFeed();
  });
  
  if (success) {
    print('Print completed successfully');
  } else {
    print('Print failed');
  }
}
```

## Advanced Features

### Using Printer Buffer
```dart
Future<void> printWithBuffer() async {
  try {
    await _printer.initPrinter();
    
    // Enter buffer mode
    await _printer.enterPrinterBuffer(true);
    
    // Add multiple print commands to buffer
    await _printer.printText('Buffered Print 1');
    await _printer.printAndLineFeed();
    await _printer.printText('Buffered Print 2');
    await _printer.printAndLineFeed();
    await _printer.printText('Buffered Print 3');
    
    // Commit all commands at once
    await _printer.commitPrinterBuffer();
    
    // Exit buffer mode
    await _printer.exitPrinterBuffer(true);
    
  } catch (e) {
    print('Error with buffered printing: $e');
    // Exit buffer without committing on error
    await _printer.exitPrinterBuffer(false);
  }
}
```

### Custom Text Bitmap Printing
```dart
Future<void> printCustomTextBitmap() async {
  try {
    await _printer.initPrinter();
    
    // Configure text bitmap settings
    await _printer.setTextBitmapTypeface(IminTypeface.typefaceDefaultBold);
    await _printer.setTextBitmapSize(36);
    await _printer.setTextBitmapStyle(IminFontStyle.bold);
    await _printer.setTextBitmapUnderline(true);
    await _printer.setTextBitmapAntiWhite(false);
    
    // Print text as bitmap
    await _printer.printTextBitmap(
      'Custom Bitmap Text',
      style: IminTextPictureStyle(
        fontSize: 32,
        fontStyle: IminFontStyle.bold,
        underline: true,
        reverseWhite: false,
        align: IminPrintAlign.center,
      ),
    );
    
    await _printer.printAndLineFeed();
    
  } catch (e) {
    print('Error printing custom text bitmap: $e');
  }
}
```

### Printer Configuration
```dart
Future<void> configurePrinter() async {
  try {
    // Get available configurations
    List<String>? densityList = await _printer.getPrinterDensityList();
    List<String>? speedList = await _printer.getPrinterSpeedList();
    List<String>? paperTypes = await _printer.getPrinterPaperTypeList();
    
    print('Available densities: $densityList');
    print('Available speeds: $speedList');
    print('Available paper types: $paperTypes');
    
    // Set printer configuration
    await _printer.setPrinterSpeed(3);
    await _printer.setFontCodepage(0);
    await _printer.setPrinterEncode(0);
    
    // Get current settings
    int? currentSpeed = await _printer.getPrinterSpeed();
    String? currentCodepage = await _printer.getCurCodepage();
    String? currentEncode = await _printer.getCurEncode();
    
    print('Current speed: $currentSpeed');
    print('Current codepage: $currentCodepage');
    print('Current encode: $currentEncode');
    
  } catch (e) {
    print('Error configuring printer: $e');
  }
}
```

## Complete Example Application

```dart
import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

class PrinterExampleApp extends StatefulWidget {
  @override
  _PrinterExampleAppState createState() => _PrinterExampleAppState();
}

class _PrinterExampleAppState extends State<PrinterExampleApp> {
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iMin Printer Examples'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Printer Status: $_status'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _printTestReceipt,
              child: Text('Print Test Receipt'),
            ),
            ElevatedButton(
              onPressed: _printQRCode,
              child: Text('Print QR Code'),
            ),
            ElevatedButton(
              onPressed: _printBarcode,
              child: Text('Print Barcode'),
            ),
            ElevatedButton(
              onPressed: _checkStatus,
              child: Text('Check Printer Status'),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _printTestReceipt() async {
    try {
      await _printer.printText(
        'TEST RECEIPT',
        style: IminTextStyle(
          fontSize: 32,
          fontStyle: IminFontStyle.bold,
          align: IminPrintAlign.center,
        ),
      );
      await _printer.printAndLineFeed();
      await _printer.printText('Item 1: \$10.00');
      await _printer.printText('Item 2: \$15.00');
      await _printer.printText('Total: \$25.00');
      await _printer.printAndLineFeed();
      await _printer.partialCut();
    } catch (e) {
      print('Error printing receipt: $e');
    }
  }
  
  Future<void> _printQRCode() async {
    try {
      await _printer.printQrCode(
        'https://www.imin.sg',
        qrCodeStyle: IminQrCodeStyle(
          qrSize: 6,
          align: IminPrintAlign.center,
        ),
      );
      await _printer.printAndLineFeed();
    } catch (e) {
      print('Error printing QR code: $e');
    }
  }
  
  Future<void> _printBarcode() async {
    try {
      await _printer.printBarCode(
        IminBarcodeType.code128,
        '1234567890',
        style: IminBarCodeStyle(
          align: IminPrintAlign.center,
          position: IminBarcodeTextPos.textBelow,
        ),
      );
      await _printer.printAndLineFeed();
    } catch (e) {
      print('Error printing barcode: $e');
    }
  }
  
  Future<void> _checkStatus() async {
    try {
      Map<String, dynamic> status = await _printer.getPrinterStatus();
      setState(() {
        _status = status['msg'] ?? 'Unknown';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }
}
```

This comprehensive examples document covers the most common use cases and provides practical, working code that developers can use as a starting point for their own applications.