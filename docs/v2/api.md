# iMin Printer SDK 2.0 API Reference

> **Compatible with**: Android 13 and above  
> **SDK Version**: 2.0.0  
> **Flutter Plugin Version**: 0.6.14+

## 📋 Table of Contents

- [Basic Operations](#basic-operations)
- [Printer Status & Information](#printer-status--information)
- [Text Printing](#text-printing)
- [Image Printing](#image-printing)
- [QR Code Printing](#qr-code-printing)
- [Barcode Printing](#barcode-printing)
- [Table Printing](#table-printing)
- [Label Printing](#label-printing)
- [Transaction Printing](#transaction-printing)
- [Printer Configuration](#printer-configuration)
- [Cash Drawer Control](#cash-drawer-control)
- [Advanced Features](#advanced-features)

---

## Basic Operations

### Initialize Printer

Initialize the printer before use.

**Method:** `initPrinter()`

**Parameters:** None

**Returns:** `Future<bool?>`

**Example:**
```dart
final iminPrinter = IminPrinter();
await iminPrinter.initPrinter();
```

---

### Get SDK Version

Get the current SDK version number.

**Method:** `getSdkVersion()`

**Parameters:** None

**Returns:** `Future<String?>` - Returns "1.0.0" or "2.0.0"

**Example:**
```dart
String? version = await iminPrinter.getSdkVersion();
print('SDK Version: $version');
```

---

### Initialize Printer Parameters

Initialize the printer's default parameter settings.

**Method:** `initPrinterParams()`

**Parameters:** None

**Returns:** `Future<void>`

**Example:**
```dart
await iminPrinter.initPrinterParams();
```

---

### Paper Feed

#### Feed One Line

**Method:** `printAndLineFeed()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.printAndLineFeed();
```

#### Feed Specified Height

**Method:** `printAndFeedPaper(int height)`

**Parameters:**
- `height` - Feed height in pixels, range: 1-1016

**Example:**
```dart
await iminPrinter.printAndFeedPaper(100);
```

---

### Paper Cutting

> **Note**: Only applicable to iMin devices with cutter function (typically 80mm printers)

#### Partial Cut

**Method:** `partialCut()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.partialCut();
```

#### Full Cut

**Method:** `fullCut()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.fullCut();
```

---

## Printer Status & Information

### Get Printer Status

Check the current printer status to determine if it's ready.

**Method:** `getPrinterStatus()`

**Parameters:** None

**Returns:** `Future<Map<String, dynamic>>`

**Return Structure:**
```dart
{
  "code": "0",        // Status code
  "msg": "Normal"     // Status description
}
```

**Status Codes:**
| Code | Description |
|------|-------------|
| 0 | Printer normal |
| 1 | Printer not connected or powered off |
| 2 | Printer and library mismatch |
| 3 | Print head open |
| 4 | Cutter not reset |
| 5 | Overheated |
| 6 | Black mark error |
| 7 | No paper feed |
| 8 | Paper running out |
| 99 | Other errors |

**Example:**
```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('Status code: ${status['code']}');
print('Status message: ${status['msg']}');

if (status['code'] == '0') {
  print('Printer ready');
} else {
  print('Printer error: ${status['msg']}');
}
```


### Get Printer Information

#### Get Printer Serial Number

**Method:** `getPrinterSerialNumber()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? serialNumber = await iminPrinter.getPrinterSerialNumber();
print('Serial Number: $serialNumber');
```

#### Get Printer Model Name

**Method:** `getPrinterModelName()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? modelName = await iminPrinter.getPrinterModelName();
print('Model: $modelName');
```

#### Get Thermal Head Model

**Method:** `getPrinterThermalHead()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? thermalHead = await iminPrinter.getPrinterThermalHead();
print('Thermal Head: $thermalHead');
```

#### Get Firmware Version

**Method:** `getPrinterFirmwareVersion()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? firmwareVersion = await iminPrinter.getPrinterFirmwareVersion();
print('Firmware Version: $firmwareVersion');
```

#### Get Service Version

**Method:** `getServiceVersion()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? serviceVersion = await iminPrinter.getServiceVersion();
print('Service Version: $serviceVersion');
```

#### Get Hardware Version

**Method:** `getPrinterHardwareVersion()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? hardwareVersion = await iminPrinter.getPrinterHardwareVersion();
print('Hardware Version: $hardwareVersion');
```

#### Get Printer Density

**Method:** `getPrinterDensity()`

**Returns:** `Future<int?>`

**Example:**
```dart
int? density = await iminPrinter.getPrinterDensity();
print('Printer Density: $density');
```

#### Get Paper Type

**Method:** `getPrinterPaperType()`

**Returns:** `Future<int?>` - 0: 80mm, 1: 58mm

**Example:**
```dart
int? paperType = await iminPrinter.getPrinterPaperType();
print('Paper Type: ${paperType == 0 ? "80mm" : "58mm"}');
```

#### Get Printer Mode

**Method:** `getPrinterMode()`

**Returns:** `Future<int?>` - 0: Normal mode, 1: Label mode

**Example:**
```dart
int? mode = await iminPrinter.getPrinterMode();
print('Printer Mode: ${mode == 0 ? "Normal" : "Label"}');
```

---

## Text Printing

### Print Text

Print text content with customizable styles.

**Method:** `printText(String text, {IminTextStyle? style})`

**Parameters:**
- `text` - Text content to print
- `style` - Text style (optional)

**IminTextStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| wordWrap | bool | Auto line wrap | true |
| fontSize | int | Font size | 26 |
| space | double | Line spacing | - |
| width | int | Text width | - |
| typeface | IminTypeface | Font typeface | typefaceDefault |
| fontStyle | IminFontStyle | Font style | normal |
| align | IminPrintAlign | Alignment | left |

**Enum Types:**

```dart
// Font Typeface
enum IminTypeface {
  typefaceDefault,      // Default font
  typefaceMonospace,    // Monospace font
  typefaceDefaultBold,  // Default bold
  typefaceSansSerif,    // Sans-serif font
  typefaceSerif         // Serif font
}

// Font Style
enum IminFontStyle {
  normal,      // Normal
  bold,        // Bold
  italic,      // Italic
  boldItalic   // Bold Italic
}

// Alignment
enum IminPrintAlign {
  left,    // Left align
  center,  // Center align
  right    // Right align
}
```

**Examples:**

```dart
// Simple print
await iminPrinter.printText('Hello World');

// Print centered title
await iminPrinter.printText(
  'Welcome',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// Print receipt content
await iminPrinter.printText(
  'Item: Apple',
  style: IminTextStyle(
    fontSize: 24,
    align: IminPrintAlign.left,
  ),
);
```

---

### Print Anti-White Text

Print text with inverted colors (white text on black background).

**Method:** `printAntiWhiteText(String text, {IminTextStyle? style})`

**Parameters:** Same as `printText`

**Example:**
```dart
await iminPrinter.printAntiWhiteText(
  'Important Notice',
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

---

### Text Bitmap Printing

Convert text to bitmap before printing, supporting more style effects.

**Method:** `printTextBitmap(String text, {IminTextPictureStyle? style})`

**Parameters:**
- `text` - Text to print
- `style` - Text picture style (optional)

**IminTextPictureStyle Properties:**

| Property | Type | Description |
|----------|------|-------------|
| fontSize | int | Font size |
| typeface | IminTypeface | Font typeface |
| fontStyle | IminFontStyle | Font style |
| align | IminPrintAlign | Alignment |
| letterSpacing | double | Letter spacing |
| underline | bool | Enable underline |
| throughline | bool | Enable strikethrough |
| lineHeight | double | Line height |
| reverseWhite | bool | Reverse white |

**Example:**
```dart
await iminPrinter.printTextBitmap(
  'Special Effect Text',
  style: IminTextPictureStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    underline: true,
    align: IminPrintAlign.center,
  ),
);
```

---

## Image Printing

### Print Single Image

Print URL images or Uint8List byte array images.

**Method:** `printSingleBitmap(dynamic img, {IminPictureStyle? pictureStyle})`

**Parameters:**
- `img` - Image data, can be:
  - `String` - Image URL
  - `Uint8List` - Image byte array
- `pictureStyle` - Picture style (optional)

**IminPictureStyle Properties:**

| Property | Type | Description |
|----------|------|-------------|
| width | int | Image width (pixels) |
| height | int | Image height (pixels) |
| alignment | IminPrintAlign | Alignment |

**Examples:**

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

// Print local image (byte array)
Uint8List imageBytes = await readFileBytes('assets/images/logo.png');
await iminPrinter.printSingleBitmap(
  imageBytes,
  pictureStyle: IminPictureStyle(
    width: 200,
    height: 100,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### Print Image with Transparent Background

Print images with transparent backgrounds, automatically converting transparent areas to white.

**Method:** `printSingleBitmapWithTranslation(dynamic img, {IminPictureStyle? pictureStyle})`

**Parameters:** Same as `printSingleBitmap`

**Example:**
```dart
await iminPrinter.printSingleBitmapWithTranslation(
  imageBytes,
  pictureStyle: IminPictureStyle(
    width: 300,
    height: 200,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### Print Multiple Images

Print multiple images at once.

**Method:** `printMultiBitmap(List<dynamic> imgs, {IminPictureStyle? pictureStyle})`

**Parameters:**
- `imgs` - Image array, can be URL array or Uint8List array
- `pictureStyle` - Picture style (optional)

**Example:**
```dart
// Print multiple network images
await iminPrinter.printMultiBitmap(
  [
    'https://example.com/image1.png',
    'https://example.com/image2.png',
  ],
  pictureStyle: IminPictureStyle(
    width: 250,
    height: 100,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### Print Color Chart

Print color charts or color images (color printer only).

**Method:** `printSingleBitmapColorChart(dynamic img, {IminPictureStyle? pictureStyle})`

**Parameters:** Same as `printSingleBitmap`

**Example:**
```dart
await iminPrinter.printSingleBitmapColorChart(
  'https://example.com/chart.png',
  pictureStyle: IminPictureStyle(
    width: 400,
    height: 300,
    alignment: IminPrintAlign.center,
  ),
);
```

---

## QR Code Printing

### Print QR Code

Print standard QR codes.

**Method:** `printQrCode(String data, {IminQrCodeStyle? qrCodeStyle})`

**Parameters:**
- `data` - QR code content
- `qrCodeStyle` - QR code style (optional)

**IminQrCodeStyle Properties:**

| Property | Type | Description |
|----------|------|-------------|
| qrSize | int | QR code size (1-10) |
| align | IminPrintAlign | Alignment |
| leftMargin | int | Left margin |
| errorCorrectionLevel | IminQrcodeCorrectionLevel | Error correction level |

**Error Correction Levels:**
```dart
enum IminQrcodeCorrectionLevel {
  levelL(48),  // ~7% error correction
  levelM(49),  // ~15% error correction
  levelQ(50),  // ~25% error correction
  levelH(51);  // ~30% error correction
}
```

**Examples:**
```dart
// Simple print
await iminPrinter.printQrCode('https://www.imin.sg');

// Custom style
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
  ),
);
```


### Print Double QR Code

Print two QR codes in one line.

**Method:** `printDoubleQR({required IminDoubleQRCodeStyle qrCode1, required IminDoubleQRCodeStyle qrCode2, int? doubleQRSize})`

**Parameters:**
- `qrCode1` - First QR code configuration
- `qrCode2` - Second QR code configuration
- `doubleQRSize` - Double QR code size (optional)

**IminDoubleQRCodeStyle Properties:**

| Property | Type | Description |
|----------|------|-------------|
| text | String | QR code content |
| level | int | Error correction level (1-3) |
| leftMargin | int | Left margin |
| version | int | QR code version (1-40) |

**Example:**
```dart
await iminPrinter.printDoubleQR(
  qrCode1: IminDoubleQRCodeStyle(
    text: 'https://www.imin.sg',
  ),
  qrCode2: IminDoubleQRCodeStyle(
    text: 'https://www.google.com',
  ),
  doubleQRSize: 5,
);
```

---

## Barcode Printing

### Print Barcode

Print one-dimensional barcodes.

**Method:** `printBarCode(IminBarcodeType barCodeType, String barCodeContent, {IminBarCodeStyle? style})`

**Parameters:**
- `barCodeType` - Barcode type
- `barCodeContent` - Barcode content
- `style` - Barcode style (optional)

**IminBarcodeType:**
```dart
enum IminBarcodeType {
  upcA(0),      // UPC-A
  upcE(1),      // UPC-E
  jan13(2),     // JAN13 (EAN13)
  jan8(3),      // JAN8 (EAN8)
  code39(4),    // Code 39
  itf(5),       // ITF
  codabar(6),   // Codabar
  code93(7),    // Code 93
  code128(8);   // Code 128
}
```

**IminBarCodeStyle Properties:**

| Property | Type | Description |
|----------|------|-------------|
| width | int | Barcode width |
| height | int | Barcode height |
| position | IminBarcodeTextPos | Text position |
| align | IminPrintAlign | Alignment |

**Text Position:**
```dart
enum IminBarcodeTextPos {
  noText(0),     // No text
  textAbove(1),  // Text above
  textBelow(2),  // Text below
  both(3);       // Text above and below
}
```

**Examples:**
```dart
// Simple print
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '1234567890',
);

// Custom style
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

---

### Print Barcode as Bitmap

Convert barcode to bitmap format for printing.

**Method:** `printBarCodeToBitmapFormat(String barCodeContent, int width, int height, IminBarCodeToBitmapFormat codeFormat)`

**Parameters:**
- `barCodeContent` - Barcode content
- `width` - Width
- `height` - Height
- `codeFormat` - Barcode format

**IminBarCodeToBitmapFormat:**
```dart
enum IminBarCodeToBitmapFormat {
  aztec,
  codabar,
  code39,
  code93,
  code128,
  dataMatrix,
  ean13,
  itf,
  maxicode,
  pdf417,
  qrCode,
  rss14,
  rssExpanded,
  upcA,
  upcE,
  upcEanExteNsion;
}
```

**Example:**
```dart
await iminPrinter.printBarCodeToBitmapFormat(
  '1234567890',
  300,
  100,
  IminBarCodeToBitmapFormat.code128,
);
```

---

## Table Printing

### Print Table (Fixed Width)

Print tables using fixed pixel widths.

**Method:** `printColumnsText({required List<ColumnMaker> cols})`

**Parameters:**
- `cols` - Column array

**ColumnMaker Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| text | String | Column content | '' |
| width | int | Column width (pixels) | 2 |
| fontSize | int | Font size | 26 |
| align | IminPrintAlign | Alignment | left |

**Example:**
```dart
import 'package:imin_printer/column_maker.dart';

// Print grade table
await iminPrinter.printColumnsText(cols: [
  ColumnMaker(
    text: 'Subject',
    width: 100,
    fontSize: 26,
    align: IminPrintAlign.left,
  ),
  ColumnMaker(
    text: 'Score',
    width: 70,
    fontSize: 26,
    align: IminPrintAlign.center,
  ),
  ColumnMaker(
    text: 'Grade',
    width: 50,
    fontSize: 26,
    align: IminPrintAlign.right,
  ),
]);

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: 'Math', width: 100, fontSize: 26),
  ColumnMaker(text: '88', width: 70, fontSize: 26),
  ColumnMaker(text: 'A-', width: 50, fontSize: 26),
]);
```

---

### Print Table (Weight Ratio)

Print tables using weight ratios for automatic column width distribution.

**Method:** `printColumnsString({required List<ColumnMaker> cols})`

**Parameters:**
- `cols` - Column array, `width` represents weight ratio

**Example:**
```dart
// Print product list (1:1:1:1 ratio)
await iminPrinter.printColumnsString(cols: [
  ColumnMaker(
    text: 'Item',
    width: 1,
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
  ColumnMaker(
    text: 'Total',
    width: 1,
    fontSize: 24,
    align: IminPrintAlign.right,
  ),
]);
```

---

## Label Printing

> **Note**: Label printing is only available in SDK 2.0

Label printing uses Canvas mode, allowing free layout of text, barcodes, QR codes, images, and shapes on labels.

### Initialize Label Canvas

Create a label printing canvas.

**Method:** `labelInitCanvas({LabelCanvasStyle? labelCanvasStyle})`

**Parameters:**
- `labelCanvasStyle` - Canvas style configuration

**LabelCanvasStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| width | int | Canvas width (pixels) | 50 |
| height | int | Canvas height (pixels) | 50 |
| posX | int | X coordinate | 0 |
| posY | int | Y coordinate | 0 |

**Example:**
```dart
import 'package:imin_printer/imin_style.dart';

// Create 50mm x 30mm label canvas
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 50 * 8,   // 50mm
    height: 30 * 8,  // 30mm
    posX: 48,
  ),
);
```

---

### Add Text to Label

Add text elements to the label.

**Method:** `labelAddText(String text, {LabelTextStyle? labelTextStyle})`

**Parameters:**
- `text` - Text content
- `labelTextStyle` - Text style

**LabelTextStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| posX | int | X coordinate | 0 |
| posY | int | Y coordinate | 0 |
| textSize | int | Text size | 24 |
| textWidthRatio | int | Text width ratio | 1 |
| textHeightRatio | int | Text height ratio | 1 |
| width | int | Width | -1 |
| height | int | Height | -1 |
| align | AlignLabel | Alignment | DEFAULT |
| rotate | Rotate | Rotation angle | ROTATE_0 |
| textSpace | int | Text spacing | 0 |
| enableBold | bool | Enable bold | false |
| enableUnderline | bool | Enable underline | false |
| enableStrikethrough | bool | Enable strikethrough | false |
| enableItalics | bool | Enable italics | false |
| enAntiColor | bool | Enable anti-color | false |

**Example:**
```dart
// Add title
await iminPrinter.labelAddText(
  'PACKED ON',
  labelTextStyle: LabelTextStyle(
    posX: 30,
    posY: 30,
    textSize: 18,
    enableBold: true,
  ),
);

// Add product name
await iminPrinter.labelAddText(
  'Fuji Apple',
  labelTextStyle: LabelTextStyle(
    posX: 220,
    posY: 45,
    textSize: 30,
  ),
);
```

---

### Add Barcode to Label

Add barcode elements to the label.

**Method:** `labelAddBarCode(String barCode, {LabelBarCodeStyle? barCodeStyle})`

**Parameters:**
- `barCode` - Barcode content
- `barCodeStyle` - Barcode style

**LabelBarCodeStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| posX | int | X coordinate | 0 |
| posY | int | Y coordinate | 0 |
| dotWidth | int | Dot width | 2 |
| barHeight | int | Barcode height | 162 |
| readable | HumanReadable | Text display position | HIDE |
| symbology | Symbology | Barcode type | CODE39 |
| align | AlignLabel | Alignment | DEFAULT |
| rotate | Rotate | Rotation angle | ROTATE_0 |
| width | int | Width | -1 |
| height | int | Height | -1 |

**Enum Types:**
```dart
enum Symbology {
  UPCA,
  UPCE,
  EAN13,
  EAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128;
}

enum HumanReadable {
  HIDE,      // Hide text
  POS_ONE,   // Position 1
  POS_TWO,   // Position 2
  POS_THREE; // Position 3
}
```

**Example:**
```dart
await iminPrinter.labelAddBarCode(
  '{B123456',
  barCodeStyle: LabelBarCodeStyle(
    posX: 160,
    posY: 125,
    symbology: Symbology.CODE128,
    dotWidth: 2,
    barHeight: 50,
    readable: HumanReadable.POS_TWO,
  ),
);
```

---

### Add QR Code to Label

Add QR code elements to the label.

**Method:** `labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle})`

**Parameters:**
- `qrCode` - QR code content
- `qrCodeStyle` - QR code style

**LabelQrCodeStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| posX | int | X coordinate | 0 |
| posY | int | Y coordinate | 0 |
| size | int | QR code size | 4 |
| errorLevel | ErrorLevel | Error correction level | L |
| rotate | Rotate | Rotation angle | ROTATE_0 |
| width | int | Width | -1 |
| height | int | Height | -1 |

**ErrorLevel:**
```dart
enum ErrorLevel {
  L,  // ~7% error correction
  M,  // ~15% error correction
  Q,  // ~25% error correction
  H;  // ~30% error correction
}
```

**Example:**
```dart
await iminPrinter.labelAddQrCode(
  'https://www.imin.sg',
  qrCodeStyle: LabelQrCodeStyle(
    posX: 280,
    posY: 60,
    size: 4,
    errorLevel: ErrorLevel.M,
  ),
);
```

---

### Add Shape to Label

Add shape elements (rectangles, circles, lines, etc.) to the label.

**Method:** `labelAddArea({LabelAreaStyle? areaStyle})`

**Parameters:**
- `areaStyle` - Shape style

**LabelAreaStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| style | Shape | Shape type | RECT_FILL |
| width | int | Width | 50 |
| height | int | Height | 50 |
| posX | int | Start X coordinate | 0 |
| posY | int | Start Y coordinate | 0 |
| endX | int | End X coordinate | 50 |
| endY | int | End Y coordinate | 50 |
| thick | int | Line thickness | 1 |

**Shape Types:**
```dart
enum Shape {
  RECT_FILL,     // Filled rectangle
  RECT_WHITE,    // White rectangle
  RECT_REVERSE,  // Reverse rectangle
  BOX,           // Hollow rectangle
  CIRCLE,        // Circle
  OVAL,          // Oval
  PATH;          // Path/Line
}
```

**Examples:**
```dart
// Add border
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.BOX,
    posX: 10,
    posY: 10,
    width: 380,
    height: 280,
    thick: 2,
  ),
);

// Add separator line
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.PATH,
    posX: 24,
    posY: 80,
    endX: 50 * 8 - 4,
    endY: 80,
    thick: 2,
  ),
);
```

---

### Add Image to Label

Add image elements to the label.

**Method:** `labelAddBitmap(dynamic img, {LabelBitmapStyle? addBitmapStyle})`

**Parameters:**
- `img` - Image data (URL or Uint8List)
- `addBitmapStyle` - Image style

**LabelBitmapStyle Properties:**

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| posX | int | X coordinate | 0 |
| posY | int | Y coordinate | 0 |
| algorithm | ImageAlgorithm | Image algorithm | BINARIZATION |
| value | int | Algorithm parameter | 200 |
| width | int | Width | -1 |
| height | int | Height | -1 |

**ImageAlgorithm:**
```dart
enum ImageAlgorithm {
  BINARIZATION,  // Binarization
  DITHERING;     // Dithering
}
```

**Example:**
```dart
await iminPrinter.labelAddBitmap(
  'https://example.com/logo.png',
  addBitmapStyle: LabelBitmapStyle(
    posX: 50,
    posY: 50,
    width: 100,
    height: 100,
    algorithm: ImageAlgorithm.BINARIZATION,
  ),
);
```

---

### Print Label

Print the label after completing the design.

**Method:** `labelPrintCanvas(int printCount)`

**Parameters:**
- `printCount` - Number of copies to print

**Example:**
```dart
// Print 1 copy
await iminPrinter.labelPrintCanvas(1);
```

---

### Label Learning

Execute label learning function for calibrating label paper.

**Method:** `labelLearning()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.labelLearning();
```

---

### Complete Label Printing Example

```dart
// 1. Initialize canvas
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 50 * 8,
    height: 30 * 8,
    posX: 48,
  ),
);

// 2. Add title
await iminPrinter.labelAddText(
  'PACKED ON',
  labelTextStyle: LabelTextStyle(
    posX: 30,
    posY: 30,
    textSize: 18,
  ),
);

// 3. Add product name
await iminPrinter.labelAddText(
  'Fuji Apple',
  labelTextStyle: LabelTextStyle(
    posX: 220,
    posY: 45,
    textSize: 30,
  ),
);

// 4. Add price
await iminPrinter.labelAddText(
  '\$16.98',
  labelTextStyle: LabelTextStyle(
    posX: 10,
    posY: 190,
    textSize: 45,
    enableBold: true,
  ),
);

// 5. Add barcode
await iminPrinter.labelAddBarCode(
  '{B123456',
  barCodeStyle: LabelBarCodeStyle(
    posX: 160,
    posY: 125,
    symbology: Symbology.CODE128,
    dotWidth: 2,
    barHeight: 50,
    readable: HumanReadable.POS_TWO,
  ),
);

// 6. Add border
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.BOX,
    posX: 10,
    posY: 10,
    width: 380,
    height: 280,
    thick: 2,
  ),
);

// 7. Print label
await iminPrinter.labelPrintCanvas(1);
```


---

## Transaction Printing

Transaction printing allows caching multiple print commands and submitting them at once, improving printing efficiency and consistency.

### Enter Print Buffer

Enable buffer mode, subsequent print commands will be cached.

**Method:** `enterPrinterBuffer(bool isClean)`

**Parameters:**
- `isClean` - Whether to clean buffer before entering

**Example:**
```dart
// Enter buffer and clean
await iminPrinter.enterPrinterBuffer(true);
```

---

### Commit Print Buffer

Submit all print commands in the buffer for execution at once.

**Method:** `commitPrinterBuffer()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.commitPrinterBuffer();
```

---

### Exit Print Buffer

Exit buffer mode.

**Method:** `exitPrinterBuffer(bool isCommit)`

**Parameters:**
- `isCommit` - Whether to commit buffer content before exiting

**Example:**
```dart
// Exit and commit
await iminPrinter.exitPrinterBuffer(true);

// Exit without committing (discard buffer content)
await iminPrinter.exitPrinterBuffer(false);
```

---

### Transaction Printing Usage Example

**Use Case**: Transaction printing (buffer management) is ideal for batch printing multiple tickets, such as delivery orders, batch invoices, etc. By using buffer mode, you can cache multiple print tasks and submit them at once, improving printing efficiency and consistency.

#### Complete Call Flow

```dart
final iminPrinter = IminPrinter();

try {
  // 1. Enter print buffer (clean previous buffer)
  iminPrinter.enterPrinterBuffer(true);
  
  // 2. Send RAW data to buffer
  await iminPrinter.sendRAWData(Uint8List.fromList(ticketData));
  
  // 3. Commit buffer and execute printing
  await iminPrinter.commitPrinterBuffer();
  
  // 4. Exit buffer mode (commit remaining content)
  iminPrinter.exitPrinterBuffer(true);
  
} catch (e) {
  // Exit without committing on error (discard buffer)
  iminPrinter.exitPrinterBuffer(false);
  print('Print failed: $e');
}
```

> **Notes**:
> - `enterPrinterBuffer(true)` - Enter buffer and clean previous content
> - `sendRAWData()` - Send ESC/POS raw data to buffer
> - `commitPrinterBuffer()` - Commit buffer content and execute printing
> - `exitPrinterBuffer(true)` - Exit buffer mode and commit remaining content
> - `exitPrinterBuffer(false)` - Exit buffer mode and discard content (for error handling)

#### Basic Example: Print Single Ticket

```dart
try {
  // 1. Start transaction printing
  await iminPrinter.enterPrinterBuffer(true);
  
  // 2. Add multiple print commands to buffer
  await iminPrinter.printText('Order #12345');
  await iminPrinter.printText('Item 1: \$10.00');
  await iminPrinter.printText('Item 2: \$20.00');
  await iminPrinter.printText('Total: \$30.00');
  await iminPrinter.printQrCode('ORDER-12345');
  
  // 3. Commit all commands, print at once
  await iminPrinter.commitPrinterBuffer();
  
  // 4. Exit transaction printing mode
  await iminPrinter.exitPrinterBuffer(true);
  
} catch (e) {
  // Exit without committing on error (discard buffer)
  await iminPrinter.exitPrinterBuffer(false);
  print('Print failed: $e');
}
```

**Batch Print Multiple Tickets Example:**

```dart
Future<void> printMultipleTickets() async {
  final iminPrinter = IminPrinter();
  
  // Prepare multiple ticket data
  List<Uint8List> ticketDataList = [
    await getTicket1Data(),
    await getTicket2Data(),
    await getTicket3Data(),
  ];
  
  try {
    // 1. Start transaction printing mode
    await iminPrinter.enterPrinterBuffer(true);
    
    // 2. Add all ticket data to buffer
    for (var ticketData in ticketDataList) {
      await iminPrinter.sendRAWData(ticketData);
    }
    
    // 3. Commit and print all tickets at once
    await iminPrinter.commitPrinterBuffer();
    
    // 4. Exit transaction printing mode
    await iminPrinter.exitPrinterBuffer(true);
    
    print('Batch print successful! Printed ${ticketDataList.length} tickets');
    
  } catch (e) {
    // Cancel printing on error
    await iminPrinter.exitPrinterBuffer(false);
    print('Batch print failed: $e');
  }
}

// Helper function to generate ticket data
Future<Uint8List> getTicket1Data() async {
  // Generate ticket data using ESC/POS commands
  List<int> bytes = [
    0x1b, 0x40,  // Initialize
    // ... more ESC/POS commands
  ];
  return Uint8List.fromList(bytes);
}
```

**Real-World Scenario - Delivery Order Batch Printing:**

```dart
class OrderPrinter {
  final iminPrinter = IminPrinter();
  
  // Batch print delivery orders
  Future<void> printDeliveryOrders(List<Order> orders) async {
    try {
      // Start transaction printing
      await iminPrinter.enterPrinterBuffer(true);
      
      // Generate print content for each order
      for (var order in orders) {
        await _printSingleOrder(order);
      }
      
      // Commit and print at once
      await iminPrinter.commitPrinterBuffer();
      await iminPrinter.exitPrinterBuffer(true);
      
      print('Successfully printed ${orders.length} orders');
      
    } catch (e) {
      await iminPrinter.exitPrinterBuffer(false);
      print('Batch print failed: $e');
    }
  }
  
  // Print single order
  Future<void> _printSingleOrder(Order order) async {
    await iminPrinter.printText(
      'Order #${order.id}',
      style: IminTextStyle(
        fontSize: 28,
        fontStyle: IminFontStyle.bold,
        align: IminPrintAlign.center,
      ),
    );
    
    await iminPrinter.printText('Customer: ${order.customerName}');
    await iminPrinter.printText('Address: ${order.address}');
    await iminPrinter.printText('Phone: ${order.phone}');
    await iminPrinter.printText('--------------------------------');
    
    // Print items
    for (var item in order.items) {
      await iminPrinter.printColumnsText(cols: [
        ColumnMaker(text: item.name, width: 150, fontSize: 24),
        ColumnMaker(text: 'x${item.quantity}', width: 50, fontSize: 24),
        ColumnMaker(text: '\$${item.price}', width: 100, fontSize: 24, align: IminPrintAlign.right),
      ]);
    }
    
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printText('Total: \$${order.total}');
    await iminPrinter.printAndFeedPaper(100);
    await iminPrinter.partialCut();
  }
}

// Order data model
class Order {
  final String id;
  final String customerName;
  final String address;
  final String phone;
  final List<OrderItem> items;
  final double total;
  
  Order({
    required this.id,
    required this.customerName,
    required this.address,
    required this.phone,
    required this.items,
    required this.total,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;
  
  OrderItem({required this.name, required this.quantity, required this.price});
}
```

**事务打印的优势：**

1. **提高效率** - 多个打印任务一次性提交，减少通信开销
2. **保证一致性** - 要么全部打印成功，要么全部失败
3. **减少错误** - 避免打印过程中的中断导致部分打印
4. **适合批量** - 特别适合外卖、快递等需要批量打印的场景

---

## Printer Configuration

### Set Print Mode

Set the printer working mode.

**Method:** `setPrintModel(int printModel)`

**Parameters:**
- `printModel` - Print mode
  - `0` - Normal mode (thermal printing)
  - `1` - Label mode

**Example:**
```dart
// Set to normal mode
await iminPrinter.setPrintModel(0);

// Set to label mode
await iminPrinter.setPrintModel(1);
```

---

### Font Encoding Management

#### Get Font Codepage List

**Method:** `getFontCodepage()`

**Returns:** `Future<List<String>?>`

**Example:**
```dart
List<String>? codepages = await iminPrinter.getFontCodepage();
print('Supported codepages: $codepages');
```

#### Set Font Codepage

**Method:** `setFontCodepage(int codepage)`

**Parameters:**
- `codepage` - Codepage number

**Example:**
```dart
await iminPrinter.setFontCodepage(0);
```

#### Get Current Codepage

**Method:** `getCurCodepage()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? currentCodepage = await iminPrinter.getCurCodepage();
print('Current codepage: $currentCodepage');
```

---

### Encoding Management

#### Get Encode List

**Method:** `getEncodeList()`

**Returns:** `Future<List<String>?>`

**Example:**
```dart
List<String>? encodeList = await iminPrinter.getEncodeList();
print('Supported encodings: $encodeList');
```

#### Set Printer Encode

**Method:** `setPrinterEncode(int encode)`

**Parameters:**
- `encode` - Encode number

**Example:**
```dart
await iminPrinter.setPrinterEncode(0);
```

#### Get Current Encode

**Method:** `getCurEncode()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? currentEncode = await iminPrinter.getCurEncode();
print('Current encoding: $currentEncode');
```

---

### Print Density and Speed

#### Get Printer Density List

**Method:** `getPrinterDensityList()`

**Returns:** `Future<List<String>?>`

**Example:**
```dart
List<String>? densityList = await iminPrinter.getPrinterDensityList();
print('Supported densities: $densityList');
```

#### Get Printer Speed List

**Method:** `getPrinterSpeedList()`

**Returns:** `Future<List<String>?>`

**Example:**
```dart
List<String>? speedList = await iminPrinter.getPrinterSpeedList();
print('Supported speeds: $speedList');
```

#### Set Printer Speed

**Method:** `setPrinterSpeed(int speed)`

**Parameters:**
- `speed` - Speed value

**Example:**
```dart
await iminPrinter.setPrinterSpeed(3);
```

#### Get Printer Speed

**Method:** `getPrinterSpeed()`

**Returns:** `Future<int?>`

**Example:**
```dart
int? speed = await iminPrinter.getPrinterSpeed();
print('Current speed: $speed');
```

---

### Paper Type Management

#### Get Printer Paper Type List

**Method:** `getPrinterPaperTypeList()`

**Returns:** `Future<List<String>?>`

**Example:**
```dart
List<String>? paperTypes = await iminPrinter.getPrinterPaperTypeList();
print('Supported paper types: $paperTypes');
```

#### Get Paper Distance

**Method:** `getPrinterPaperDistance()`

**Returns:** `Future<String?>` - Returns paper distance in cm

**Example:**
```dart
String? paperDistance = await iminPrinter.getPrinterPaperDistance();
print('Paper distance: ${paperDistance}cm');
```

---

### Other Configuration

#### Get USB Printer VID/PID

**Method:** `getUsbPrinterVidPid()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? vidPid = await iminPrinter.getUsbPrinterVidPid();
print('USB VID/PID: $vidPid');
```

#### Get USB Device Name

**Method:** `getUsbDevicesName()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? deviceName = await iminPrinter.getUsbDevicesName();
print('USB device name: $deviceName');
```

#### Get Cutter Times

**Method:** `getPrinterCutTimes()`

**Returns:** `Future<String?>`

**Example:**
```dart
String? cutTimes = await iminPrinter.getPrinterCutTimes();
print('Cutter times: $cutTimes');
```

---

## Cash Drawer Control

### Open Cash Drawer

Control the connected cash drawer to open.

**Method:** `openCashBox()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.openCashBox();
```

---

### Get Drawer Status

**Method:** `getDrawerStatus()`

**Returns:** `Future<bool?>` - true: open, false: closed

**Example:**
```dart
bool? isOpen = await iminPrinter.getDrawerStatus();
print('Drawer status: ${isOpen ? "Open" : "Closed"}');
```

---

### Get Open Drawer Times

**Method:** `getOpenDrawerTimes()`

**Returns:** `Future<int?>`

**Example:**
```dart
int? openTimes = await iminPrinter.getOpenDrawerTimes();
print('Drawer opened times: $openTimes');
```

---

## Advanced Features

### Printer Self-Checking

Execute printer self-checking program.

**Method:** `printerSelfChecking()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.printerSelfChecking();
```

---

### Reset Printer

Reset the printer to initial state.

**Method:** `resetDevice()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.resetDevice();
```

---

### Send RAW Data

Send raw ESC/POS commands to the printer.

**Method:** `sendRAWData(Uint8List bytes)`

**Parameters:**
- `bytes` - Raw byte data

**Example:**
```dart
// Send ESC/POS command
Uint8List escPosCommand = Uint8List.fromList([0x1B, 0x40]); // Initialize command
await iminPrinter.sendRAWData(escPosCommand);
```

---

### Send Hex String

Send raw data in hexadecimal format.

**Method:** `sendRAWDataHexStr(String hex)`

**Parameters:**
- `hex` - Hexadecimal string

**Example:**
```dart
// Send line feed command
await iminPrinter.sendRAWDataHexStr('0A');
```

---

### Open Logs

Enable or disable printer debug logs.

**Method:** `openLogs(int open)`

**Parameters:**
- `open` - 0: disable, 1: enable

**Example:**
```dart
// Enable logs
await iminPrinter.openLogs(1);

// Disable logs
await iminPrinter.openLogs(0);
```

---

### Unbind Service

Unbind from the print service.

**Method:** `unBindService()`

**Parameters:** None

**Example:**
```dart
await iminPrinter.unBindService();
```

---

### Set Code Alignment

Set alignment for barcodes and QR codes.

**Method:** `setCodeAlignment(IminPrintAlign alignment)`

**Parameters:**
- `alignment` - Alignment

**Example:**
```dart
await iminPrinter.setCodeAlignment(IminPrintAlign.center);
```

---

## Complete Examples

### Print Receipt Example

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';

Future<void> printReceipt() async {
  final iminPrinter = IminPrinter();
  
  try {
    // 1. Initialize printer
    await iminPrinter.initPrinter();
    
    // 2. Check printer status
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('Printer not ready: ${status['msg']}');
    }
    
    // 3. Print store name
    await iminPrinter.printText(
      'Welcome',
      style: IminTextStyle(
        fontSize: 32,
        fontStyle: IminFontStyle.bold,
        align: IminPrintAlign.center,
      ),
    );
    
    await iminPrinter.printText(
      'Store Name',
      style: IminTextStyle(
        fontSize: 28,
        align: IminPrintAlign.center,
      ),
    );
    
    // 4. Print separator
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printAndLineFeed();
    
    // 5. Print order info
    await iminPrinter.printText('Order No: 20240116001');
    await iminPrinter.printText('Date: 2024-01-16 14:30');
    await iminPrinter.printText('--------------------------------');
    
    // 6. Print items table
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: 'Item', width: 150, fontSize: 24),
      ColumnMaker(text: 'Qty', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: 'Price', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: 'Total', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: 'Apple', width: 150, fontSize: 24),
      ColumnMaker(text: '2', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: '5.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: '10.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: 'Banana', width: 150, fontSize: 24),
      ColumnMaker(text: '3', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: '3.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: '9.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    // 7. Print total
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: 'TOTAL', width: 270, fontSize: 28, align: IminPrintAlign.right),
      ColumnMaker(text: '\$19.00', width: 70, fontSize: 28, align: IminPrintAlign.right),
    ]);
    
    // 8. Print QR code
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printQrCode(
      'ORDER-20240116001',
      qrCodeStyle: IminQrCodeStyle(
        qrSize: 6,
        align: IminPrintAlign.center,
      ),
    );
    
    // 9. Print footer
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printText(
      'Thank you for your business!',
      style: IminTextStyle(
        fontSize: 24,
        align: IminPrintAlign.center,
      ),
    );
    
    // 10. Feed paper and cut
    await iminPrinter.printAndFeedPaper(100);
    await iminPrinter.partialCut();
    
    print('Print successful!');
    
  } catch (e) {
    print('Print failed: $e');
  }
}
```

---

## FAQ

### 1. How to determine which SDK version the device uses?

```dart
String? version = await iminPrinter.getSdkVersion();
if (version == '2.0.0') {
  print('Using SDK 2.0');
} else {
  print('Using SDK 1.0');
}
```

### 2. How to check printer status before printing?

```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] == '0') {
  // Printer is ready, can print
  await iminPrinter.printText('Hello');
} else {
  // Printer has error
  print('Error: ${status['msg']}');
}
```

### 3. How to handle print errors?

```dart
try {
  await iminPrinter.printText('Test print');
} catch (e) {
  print('Print failed: $e');
  // Can try resetting the printer
  await iminPrinter.resetDevice();
}
```

### 4. What's the difference between label printing and normal printing?

- **Normal Printing**: For receipts, tickets on continuous paper
- **Label Printing**: For fixed-size label paper, requires `labelInitCanvas` and other label APIs

### 5. How to improve printing efficiency?

Use buffer management to batch submit print commands:

```dart
await iminPrinter.enterPrinterBuffer(true);
// Add multiple print commands
await iminPrinter.commitPrinterBuffer();
await iminPrinter.exitPrinterBuffer(true);
```

---

## Related Resources

- [GitHub Repository](https://github.com/iminsoftware/imin_printer)
- [Pub.dev Package](https://pub.dev/packages/imin_printer)
- [Official iMin Documentation](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
- [Complete Documentation Site](https://iminsoftware.github.io/imin_printer/)

---

**Document Version**: v2.0  
**Last Updated**: 2024-01-16  
**Compatible Plugin Version**: imin_printer ^0.6.14
