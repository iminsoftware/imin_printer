# Related methods provided by flutter, iMin's internal printer

## Basic Printer Operations

### Initializes the iMin internal printer
 - initPrinter()
    - No parameters
    - Returns: `Future<bool?>`

Example: 
```dart
  await iminPrinter.initPrinter();
```

### Get SDK Version
 - getSdkVersion()
    - No parameters
    - Returns: `Future<String?>`

Example:
```dart
  String? version = await iminPrinter.getSdkVersion();
  print('SDK Version: $version');
```

### Get Printer Information
 - getPrinterSerialNumber()
    - Returns: `Future<String?>`
 - getPrinterModelName()
    - Returns: `Future<String?>`
 - getPrinterThermalHead()
    - Returns: `Future<String?>`
 - getPrinterFirmwareVersion()
    - Returns: `Future<String?>`
 - getPrinterHardwareVersion()
    - Returns: `Future<String?>`

Example:
```dart
  String? serialNumber = await iminPrinter.getPrinterSerialNumber();
  String? modelName = await iminPrinter.getPrinterModelName();
  String? firmwareVersion = await iminPrinter.getPrinterFirmwareVersion();
```

## Get printer status
 - getPrinterStatus()
    - No parameters
    - Returns: `Future<Map<String, dynamic>>`

Example: 
```dart
  Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
  print('Printer status: ${status['msg']}');    
```

## Printer Buffer Management

### Enter Printer Buffer
 - enterPrinterBuffer(bool isClean)
    - parameter:
      - bool isClean -> Whether to clean the buffer before entering

Example:
```dart
  await iminPrinter.enterPrinterBuffer(true);
```

### Commit Printer Buffer
 - commitPrinterBuffer()
    - No parameters

Example:
```dart
  await iminPrinter.commitPrinterBuffer();
```

### Exit Printer Buffer
 - exitPrinterBuffer(bool isCommit)
    - parameter:
      - bool isCommit -> Whether to commit before exiting

Example:
```dart
  await iminPrinter.exitPrinterBuffer(true);
```

## Paper Control

### A line of paper
  - printAndLineFeed()
    -  No parameters

Example:
```dart
  await iminPrinter.printAndLineFeed();
```

### Walk several lines of paper, customize the height
  - printAndFeedPaper()
    - parameter:
      - int lineHeight , Value range: 1-1016

Example:
```dart
  await iminPrinter.printAndFeedPaper(100); 
```

### Set paper size
  - setPageFormat()
    - parameter:
      - int style -> Paper size  0-80mm 1-58mm;

Example:
```dart
  await iminPrinter.setPageFormat(1);
```

### Cutter (Only for devices with cutter function)
This method is only applicable to iMin devices with cutter hardware.
 - partialCut()
   - No parameters

Example:
```dart
  await iminPrinter.partialCut();
```

### Full Cut
This method is only applicable to iMin devices with cutter hardware.
 - fullCut()
   - No parameters

Example:
```dart
  await iminPrinter.fullCut();
```

## Set alignment
  - setAlignment
    - parameter:
      - IminPrintAlign alignment -> Alignment mode

```dart
  enum IminPrintAlign { left, center, right }
```

Example:
```dart
import 'package:imin_printer/enums.dart';  ///need import
  await iminPrinter.setAlignment(IminPrintAlign.center);
```

## Set text size
  - setTextSize()
    - parameter:
      - int size -> Font size

Example:
```dart
  await iminPrinter.setTextSize(25);
```

## Set text Typeface
   - setTextTypeface()
      - parameter:
          - IminTypeface typeface -> Typeface

```dart
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
```   

Example:
```dart
import 'package:imin_printer/enums.dart';  ///need import

 await iminPrinter.setTextTypeface(IminTypeface.typefaceMonospace);
```

## Set text style
  - setTextStyle()
      - parameter:
          - IminFontStyle style -> Text style

```dart
  enum IminFontStyle { normal, bold, italic, boldItalic }
```

Example:
```dart
import 'package:imin_printer/enums.dart';   ///need import
  
  await iminPrinter.setTextStyle(IminFontStyle.bold);
```

## Set text line spacing
    - setTextLineSpacing()
       - parameter:
         - double space -> Line spacing

Example:
```dart
  await iminPrinter.setTextLineSpacing(1.0);
```

## Set the print text width
  - setTextWidth()
    - parameter:
      - int width -> Width

Example:
```dart
  await iminPrinter.setTextWidth(200);
```

## Print text
   - printText()
     - parameter:
       - String text -> Print text content
       - IminTextStyle style -> Print text related Settings (optional)

IminTextStyle Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | Whether print text will join `\n` ,`true` or not set automatic `\n`, for `false` without `\n` | bool  | None |
  | fontSize | Print text size | int | None |
  | space | Print text line spacing | double | None |
  | width | Print text width | int | None |
  | typeface | Print text font | IminTypeface | None |
  | fontStyle | Print text style  | IminFontStyle | None |
  | align | Print text alignment | IminPrintAlign | None |

```dart
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
enum IminFontStyle { normal, bold, italic, boldItalic }

enum IminPrintAlign { left, center, right }
```

Example:
```dart
import 'package:imin_printer/imin_style.dart';  ///Need to import
import 'package:imin_printer/enums.dart';  ///Need to import

///Simple use
await iminPrinter.printText("Hello World");

/// Set the Settings related to the printed text
await iminPrinter.printText("Hello World", 
  style: IminTextStyle(
    fontSize: 20,
    space: 1.0,
    width: 100,
    typeface: IminTypeface.typefaceDefaultBold,
    fontStyle: IminFontStyle.boldItalic,
    align: IminPrintAlign.center
  )
);
```

## Text Bitmap Printing

### Set Text Bitmap Properties
 - setTextBitmapTypeface(IminTypeface typeface)
 - setTextBitmapSize(int size)
 - setTextBitmapStyle(IminFontStyle style)
 - setTextBitmapStrikeThru(bool strikeThru)
 - setTextBitmapUnderline(bool haveUnderline)
 - setTextBitmapLineSpacing(double lineHeight)
 - setTextBitmapLetterSpacing(double space)
 - setTextBitmapAntiWhite(bool antiWhite)

Example:
```dart
await iminPrinter.setTextBitmapTypeface(IminTypeface.typefaceDefaultBold);
await iminPrinter.setTextBitmapSize(32);
await iminPrinter.setTextBitmapStyle(IminFontStyle.bold);
await iminPrinter.setTextBitmapUnderline(true);
await iminPrinter.setTextBitmapAntiWhite(false);
```

### Print Text as Bitmap
 - printTextBitmap(String text, {IminTextPictureStyle? style})
   - parameter:
     - String text -> Text content
     - IminTextPictureStyle style -> Text picture style settings (optional)

IminTextPictureStyle Properties:
  | Property | Explain | Type | Default |
  | ---- | ---- | ---- | ---- |
  | fontSize | Font size | int | None |
  | typeface | Font typeface | IminTypeface | None |
  | fontStyle | Font style | IminFontStyle | None |
  | align | Text alignment | IminPrintAlign | None |
  | letterSpacing | Letter spacing | double | None |
  | underline | Enable underline | bool | None |
  | throughline | Enable strikethrough | bool | None |
  | lineHeight | Line height | double | None |
  | reverseWhite | Reverse white | bool | None |

Example:
```dart
await iminPrinter.printTextBitmap(
  "Bitmap Text",
  style: IminTextPictureStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    underline: true,
    reverseWhite: false,
  )
);
```

## Print anti-white text
  - printAntiWhiteText()
    - parameter:
       - String text -> Print text content
       - IminTextStyle style -> Print text related Settings (optional)

IminTextStyle Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | Whether print text will join `\n` ,`true` or not set automatic `\n`, for `false` without `\n` | bool  | None |
  | fontSize | Print text size | int | None |
  | space | Print text line spacing | double | None |
  | width | Print text width | int | None |
  | typeface | Print text font | IminTypeface | None |
  | fontStyle | Print text style  | IminFontStyle | None |
  | align | Print text alignment | IminPrintAlign | None |

```dart
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
enum IminFontStyle { normal, bold, italic, boldItalic }

enum IminPrintAlign { left, center, right }
```

Example:
```dart
import 'package:imin_printer/imin_style.dart';  /// Need to import
import 'package:imin_printer/enums.dart';  ///Need to import

/// Simple use
await iminPrinter.printAntiWhiteText("Hello World");

/// Set the Settings related to the printed text
await iminPrinter.printAntiWhiteText("Hello World", 
  style: IminTextStyle(
    fontSize: 20,
    space: 1.0,
    width: 100,
    typeface: IminTypeface.typefaceDefaultBold,
    fontStyle: IminFontStyle.boldItalic,
    align: IminPrintAlign.center
  )
);
```


## Print Table
  - printColumnsText()
      - parameter:
        - List<ColumnMaker> cols -> Column array

ColumnMaker Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | text | Column content | String  | None |
  | width | Column width | int | None |
  | align | Column alignment | IminPrintAlign | None |
  | fontSize | Font size | int | None |

Example:
```dart
import 'package:imin_printer/column_maker.dart'; /// Need to import
import 'package:imin_printer/enums.dart'; /// Need to import

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(
      text: '1',
      width: 1,
      fontSize: 26,
      align: IminPrintAlign.center),
  ColumnMaker(
      text: 'iMin',
      width: 2,
      fontSize: 26,
      align: IminPrintAlign.left),
  ColumnMaker(
      text: 'iMin',
      width: 1,
      fontSize: 26,
      align: IminPrintAlign.right)
]);
```

## Print Columns String
  - printColumnsString()
      - parameter:
        - List<ColumnMaker> cols -> Column array

Example:
```dart
await iminPrinter.printColumnsString(cols: [
  ColumnMaker(
      text: 'Item',
      width: 2,
      fontSize: 24,
      align: IminPrintAlign.left),
  ColumnMaker(
      text: 'Price',
      width: 1,
      fontSize: 24,
      align: IminPrintAlign.right)
]);
```


## Image Printing

### Print a single image
 - printSingleBitmap()
   - parameter:
      - dynamic img -> Image path url or image binary stream。
      - IminPictureStyle pictureStyle -> Image style Settings (optional)。

IminPictureStyle Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | width | Picture width | int  | None |
  | height | Picture height | int| None |
  | alignment | Print picture alignment | enum IminPrintAlign { left, center, right }  | None |

```dart
  enum IminPrintAlign { left, center, right }
```

Example:
```dart
import 'package:imin_printer/imin_style.dart'; ///If passing an image style setting item needs to be imported
import 'package:imin_printer/enums.dart';  ///If passing an image style setting item needs to be imported

/// Simple use
await iminPrinter.printSingleBitmap(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]));

/// Use the image binary stream and set the image style
await iminPrinter.printSingleBitmap(
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]),
    pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
    )
);

/// Pass the image using the url address and set the image style
await iminPrinter.printSingleBitmap(
    'https://www.example.com/image.jpg',
    pictureStyle: IminPictureStyle(
      alignment: IminPrintAlign.center,
      width: 250,
      height: 50,
    )
);
```

### Print Single Bitmap with Translation
 - printSingleBitmapWithTranslation()
   - parameter:
      - dynamic img -> Image path url or image binary stream
      - IminPictureStyle pictureStyle -> Image style Settings (optional)

Example:
```dart
await iminPrinter.printSingleBitmapWithTranslation(
    imageBytes,
    pictureStyle: IminPictureStyle(
      alignment: IminPrintAlign.center,
      width: 300,
      height: 200,
    )
);
```

### Print multiple pictures
 - printMultiBitmap()
   - parameter:
      - List<dynamic> img -> Image path url array or image binary stream array。
      - IminPictureStyle pictureStyle -> Image style Settings (optional)。

IminPictureStyle Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | width | Picture width | int  | None |
  | height | Picture height | int| None |
  | alignment | Print picture alignment | enum IminPrintAlign { left, center, right }  | None |

```dart
  enum IminPrintAlign { left, center, right }
```

Example:
```dart
import 'package:imin_printer/imin_style.dart'; /// If passing an image style setting item needs to be imported
import 'package:imin_printer/enums.dart';  /// If passing an image style setting item needs to be imported

/// Simple use
await iminPrinter.printMultiBitmap([
  Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), 
  Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00])
]);

/// Use the image binary stream and set the image style
await iminPrinter.printMultiBitmap(
   [Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), 
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00])],
    pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
    )
);

/// Pass the image using the url address and set the image style
await iminPrinter.printMultiBitmap(
    ['https://www.example.com/image1.jpg', 'https://www.example.com/image2.jpg'],
    pictureStyle: IminPictureStyle(
      alignment: IminPrintAlign.center,
      width: 250,
      height: 50,
    )
);
```

### Print a single anti-white image
 - printSingleBitmapBlackWhite
    - parameter:
      - dynamic img -> Image path url or image binary stream。
      - IminBaseStyle baseStyle -> Image style Settings (optional)。

IminBaseStyle Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | width | Picture width | int  | None |
  | height | Picture height | int| None |

Example:
```dart
/// Pass a picture using a picture binary stream
await iminPrinter.printSingleBitmapBlackWhite(
  Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0])
);

/// Pass the image using the url address and set the image style
await iminPrinter.printSingleBitmapBlackWhite(
  'https://www.example.com/image.jpg',
  baseStyle: IminBaseStyle(
    width: 250,
    height: 50,
  )
);
```

### Print Single Bitmap Color Chart
 - printSingleBitmapColorChart()
   - parameter:
      - dynamic img -> Image data
      - IminPictureStyle pictureStyle -> Picture style settings (optional)

Example:
```dart
await iminPrinter.printSingleBitmapColorChart(
  imageBytes,
  pictureStyle: IminPictureStyle(
    alignment: IminPrintAlign.center,
    width: 400,
    height: 300,
  )
);
```

## QR Code Printing

### Set QR code size
 - setQrCodeSize
    - parameter:
      - int size -> Qr code size。

Example:
```dart
await iminPrinter.setQrCodeSize(5); // Set the QR code size to 5.
```

### Set the left margin of the QR code and barcode
  - setLeftMargin
    - parameter:
      - int  margin -> left margin

Example:
```dart
await iminPrinter.setLeftMargin(5); // Set the left margin to 5.
```

### Set Code Alignment
 - setCodeAlignment
   - parameter:
     - IminPrintAlign alignment -> Code alignment

Example:
```dart
await iminPrinter.setCodeAlignment(IminPrintAlign.center);
```

### Set the error correction level of the QR code
 - setQrCodeErrorCorrectionLev
    - parameter:
      -  IminQrcodeCorrectionLevel level -> Error correction level.

```dart
  enum IminQrcodeCorrectionLevel {
    levelL(48),
    levelM(49),
    levelQ(50),
    levelH(51);
  }
```

Example:
```dart
import 'package:imin_printer/enums.dart';  ///Need to import

await iminPrinter.setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel.levelL); 
```

### Print QR code
 - printQrCode
    - parameter:
      - String content -> Qr code content.
      - IminQrCodeStyle qrCodeStyle -> Qr code style correlation (optional)

IminQrCodeStyle Qr code style related API:

  | Property | explain | Type | default  |
  | --- | --- | --- | --- |
  | qrSize | Qr code size | int | None |
  | align  | Qr code alignment | enum IminPrintAlign { left, center, right } | None |
  | leftMargin | Left margin of QR code | int | None |
  | errorCorrectionLevel | Error correction level | enum IminQrcodeCorrectionLevel { levelL(48), levelM(49), levelQ(50), levelH(51)} | None |

```dart
enum IminPrintAlign { left, center, right }

enum IminQrcodeCorrectionLevel {
  levelL(48),
  levelM(49),
  levelQ(50),
  levelH(51);
}
```

Example:
```dart
import 'package:imin_printer/enums.dart';  ///Need to import

await iminPrinter.printQrCode('https://www.baidu.com', 
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 4,  
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
    leftMargin: 2,
    align: IminPrintAlign.left 
  )
);
```

### Double QR Code Operations

#### Set double QR code size
 - setDoubleQRSize
   - parameter:
      - int qrSize -> Size of QR code.

Example:
```dart
await iminPrinter.setDoubleQRSize(4);
```

#### Set double QR code (QR1) error level
  - setDoubleQR1Level()
     - parameter:
        - int  level -> Error Size Value range :1 to 3。

Example:
```dart
await iminPrinter.setDoubleQR1Level(2);
```

#### Set double QR code (QR2) error level
  - setDoubleQR2Level()
     - parameter:
        - int  level -> Error Size Value range:1 to 3。

Example:
```dart
await iminPrinter.setDoubleQR2Level(2);
``` 

#### Set double QR code (QR1) left margin
  - setDoubleQR1MarginLeft()
     - parameter:
        - int  leftMargin -> The left distance ranges from 0 to 576.

Example:
```dart
await iminPrinter.setDoubleQR1MarginLeft(2);
```

#### Set double QR code (QR2) left margin
  - setDoubleQR2MarginLeft()
     - parameter:
        - int  leftMargin -> The left distance ranges from 0 to 576.
   
Example:
```dart
await iminPrinter.setDoubleQR2MarginLeft(2);
```

#### Set up the dual QR Code (QR1) version
  - setDoubleQR1Version()
     - parameter:
        - int  version -> Version Value range :1 to 40。

Example:
```dart
await iminPrinter.setDoubleQR1Version(2);
```

#### Set the dual QR Code (QR2) version
  - setDoubleQR2Version()
     - parameter:
        - int  version -> Version Value range :1 to 40。

Example:
```dart
await iminPrinter.setDoubleQR2Version(2); 
```

#### Print double QR code
 - printDoubleQR()
   - parameter:
      - IminDoubleQRCodeStyle qrCode1 -> The first QR code setting.
      - IminDoubleQRCodeStyle qrCode2 -> Second QR code Settings.
      - int doubleQRSize -> Double QR code size (optional)

IminDoubleQRCodeStyle Qr code Settings related API
  
  | Property | explain | Type | default  |
  | --- | --- | --- | --- |
  | text | qrcode content | String | - |
  | level | Error level of QR code (optional) | int | - |
  | leftMargin | Left margin of QR code (optional) | int | - |
  | version | Qr code version (optional) | int | - |

Example:
```dart
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';  /// Need to import

await iminPrinter.printDoubleQR(
  qrCode1: IminDoubleQRCodeStyle(
    text: 'www.imin.sg',
  ),
  qrCode2: IminDoubleQRCodeStyle(
    text: 'www.google.com',
  ),
  doubleQRSize: 5
);
```


## Barcode Printing

### Set bar code width
  - setBarCodeWidth()
     - parameter:
        - int  width -> Bar code width Value range :2-6.
      
Example:
```dart
await iminPrinter.setBarCodeWidth(2);
```

### Set bar code height
  - setBarCodeHeight()
     - parameter:
        - int  height -> The bar code height ranges from 1 to 255.

Example:
```dart
await iminPrinter.setBarCodeHeight(2);
```

### The print position of the HRI character when printing the bar
   - setBarCodeContentPrintPos()
      - parameter:
         - IminBarcodeTextPos position -> Barcode content print location.

```dart
enum IminBarcodeTextPos {
  noText(0),
  textAbove(1),
  textBelow(2),
  both(3);
}
```

Example:
```dart
import 'package:imin_printer/enums.dart';

await iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove);
```

### Print bar code
  - printBarCode()
    - parameter:
       - IminBarcodeType barCodeType -> Bar code type.
       - String barCodeContent -> Bar code content.
       - IminBarCodeStyle style -> Bar code style related Settings (optional).
  
IminBarCodeStyle  Related API:
  | Property | explain | Type | default  |
  | --- | --- | --- | --- |
  | width | Bar code width | int | None |
  | height | Bar code height | int | None |
  | position | Barcode content print location | IminBarcodeTextPos | None |
  | align | Barcode alignment | IminPrintAlign | None |

```dart
enum IminBarcodeTextPos {
  noText(0),
  textAbove(1),
  textBelow(2),
  both(3);
}

enum IminPrintAlign { left, center, right }

enum IminBarcodeType {
  upcA(0),
  upcE(1),
  jan13(2),
  jan8(3),
  code39(4),
  itf(5),
  codabar(6),
  code93(7),
  code128(8);
}
```

Example:
```dart
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/enums.dart';

/// Simple to use
await iminPrinter.printBarCode(IminBarcodeType.jan13, "0123456789012");

/// Set the bar code style
await iminPrinter.printBarCode(
    IminBarcodeType.jan13, 
    "0123456789012",
    style: IminBarCodeStyle(
        width: 150,
        height: 50,
        align: IminPrintAlign.center,
        position: IminBarcodeTextPos.textAbove
    )
);
```

### Print barcode setup format
   - printBarCodeToBitmapFormat()
       - parameter:
          - String barCodeContent -> Bar code content.
          - int width -> Bar code width.
          - int height -> Bar code height.
          - IminBarCodeToBitmapFormat codeFormat -> Bar code format

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

Example:
```dart
import 'package:imin_printer/enums.dart';

await iminPrinter.printBarCodeToBitmapFormat(
  "0123456789012", 
  100, 
  50, 
  IminBarCodeToBitmapFormat.code39
);
```


## Open the money box
  - openCashBox()
     - No parameters

Example:
```dart
  await iminPrinter.openCashBox();
```

## Reset printer
  - resetDevice()
    - No parameters

Example:
```dart
  await iminPrinter.resetDevice();
```

## Printer Configuration

### Set Print Model
 - setPrintModel(int printModel)
   - parameter:
     - int printModel -> Print model (0: thermal, 1: label)

Example:
```dart
  await iminPrinter.setPrintModel(0); // Set to thermal printing
```

### Font and Encoding Management

#### Get Font Codepage List
 - getFontCodepage()
   - Returns: `Future<List<String>?>`

Example:
```dart
  List<String>? codepages = await iminPrinter.getFontCodepage();
```

#### Set Font Codepage
 - setFontCodepage(int codepage)
   - parameter:
     - int codepage -> Codepage number

Example:
```dart
  await iminPrinter.setFontCodepage(0);
```

#### Get Current Codepage
 - getCurCodepage()
   - Returns: `Future<String?>`

Example:
```dart
  String? currentCodepage = await iminPrinter.getCurCodepage();
```

#### Get Encode List
 - getEncodeList()
   - Returns: `Future<List<String>?>`

Example:
```dart
  List<String>? encodeList = await iminPrinter.getEncodeList();
```

#### Set Printer Encode
 - setPrinterEncode(int encode)
   - parameter:
     - int encode -> Encode number

Example:
```dart
  await iminPrinter.setPrinterEncode(0);
```

#### Get Current Encode
 - getCurEncode()
   - Returns: `Future<String?>`

Example:
```dart
  String? currentEncode = await iminPrinter.getCurEncode();
```

### Printer Density and Speed

#### Get Printer Density List
 - getPrinterDensityList()
   - Returns: `Future<List<String>?>`

Example:
```dart
  List<String>? densityList = await iminPrinter.getPrinterDensityList();
```

#### Get Printer Density
 - getPrinterDensity()
   - Returns: `Future<int?>`

Example:
```dart
  int? density = await iminPrinter.getPrinterDensity();
```

#### Get Printer Speed List
 - getPrinterSpeedList()
   - Returns: `Future<List<String>?>`

Example:
```dart
  List<String>? speedList = await iminPrinter.getPrinterSpeedList();
```

#### Set Printer Speed
 - setPrinterSpeed(int speed)
   - parameter:
     - int speed -> Speed value

Example:
```dart
  await iminPrinter.setPrinterSpeed(3);
```

#### Get Printer Speed
 - getPrinterSpeed()
   - Returns: `Future<int?>`

Example:
```dart
  int? speed = await iminPrinter.getPrinterSpeed();
```

### Paper Type Management

#### Get Printer Paper Type List
 - getPrinterPaperTypeList()
   - Returns: `Future<List<String>?>`

Example:
```dart
  List<String>? paperTypes = await iminPrinter.getPrinterPaperTypeList();
```

#### Get Printer Paper Type
 - getPrinterPaperType()
   - Returns: `Future<int?>`

Example:
```dart
  int? paperType = await iminPrinter.getPrinterPaperType();
```

#### Get Printer Paper Distance
 - getPrinterPaperDistance()
   - Returns: `Future<String?>`

Example:
```dart
  String? paperDistance = await iminPrinter.getPrinterPaperDistance();
```

### Hardware Information

#### Get USB Printer VID PID
 - getUsbPrinterVidPid()
   - Returns: `Future<String?>`

Example:
```dart
  String? vidPid = await iminPrinter.getUsbPrinterVidPid();
```

#### Get USB Devices Name
 - getUsbDevicesName()
   - Returns: `Future<String?>`

Example:
```dart
  String? deviceName = await iminPrinter.getUsbDevicesName();
```

#### Get Service Version
 - getServiceVersion()
   - Returns: `Future<String?>`

Example:
```dart
  String? serviceVersion = await iminPrinter.getServiceVersion();
```

### Cash Drawer

#### Get Drawer Status
 - getDrawerStatus()
   - Returns: `Future<bool?>`

Example:
```dart
  bool? isOpen = await iminPrinter.getDrawerStatus();
```

#### Get Open Drawer Times
 - getOpenDrawerTimes()
   - Returns: `Future<int?>`

Example:
```dart
  int? openTimes = await iminPrinter.getOpenDrawerTimes();
```

#### Get Printer Cut Times
 - getPrinterCutTimes()
   - Returns: `Future<String?>`

Example:
```dart
  String? cutTimes = await iminPrinter.getPrinterCutTimes();
```

#### Get Printer Mode
 - getPrinterMode()
   - Returns: `Future<int?>`

Example:
```dart
  int? mode = await iminPrinter.getPrinterMode();
```

### Printer Self-Checking
 - printerSelfChecking()
   - No parameters

Example:
```dart
  await iminPrinter.printerSelfChecking();
```

### RAW Data Operations

#### Send RAW Data
 - sendRAWData(Uint8List bytes)
   - parameter:
     - Uint8List bytes -> Raw data bytes

Example:
```dart
  await iminPrinter.sendRAWData(Uint8List.fromList([0x1B, 0x40]));
```

### Service Management

#### Unbind Service
 - unBindService()
   - No parameters

Example:
```dart
  await iminPrinter.unBindService();
```

#### Initialize Printer Parameters
 - initPrinterParams()
   - No parameters

Example:
```dart
  await iminPrinter.initPrinterParams();
```

## Set the initialization printer
  - setInitIminPrinter
      - parameter:
         - bool isDefault -> Whether it is set by default.

```dart
  await iminPrinter.setInitIminPrinter(true);
```

## Open Logs
  - openLogs
     - parameter:
         - int 0 or 1 -> is open

```dart
   await iminPrinter.openLogs(1);
```

## Send RAW Data Hex Str
  - sendRAWDataHexStr
   - parameter: 
   - String bytes -> byte String。


```dart
   await iminPrinter.sendRAWDataHexStr('0A');
```

## Label Printing API

### Initialize Label Canvas
 - labelInitCanvas({LabelCanvasStyle? labelCanvasStyle})
   - parameter:
     - LabelCanvasStyle labelCanvasStyle -> Canvas style settings (optional)

LabelCanvasStyle Properties:
  | Property | Explain | Type | Default |
  | ---- | ---- | ---- | ---- |
  | width | Canvas width | int | 50 |
  | height | Canvas height | int | 50 |
  | posX | X position | int | 0 |
  | posY | Y position | int | 0 |

Example:
```dart
import 'package:imin_printer/imin_style.dart';

await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 400,
    height: 300,
    posX: 0,
    posY: 0,
  )
);
```

### Add Text to Label
 - labelAddText(String text, {LabelTextStyle? labelTextStyle})
   - parameter:
     - String text -> Text content
     - LabelTextStyle labelTextStyle -> Text style settings (optional)

LabelTextStyle Properties:
  | Property | Explain | Type | Default |
  | ---- | ---- | ---- | ---- |
  | posX | X position | int | 0 |
  | posY | Y position | int | 0 |
  | textSize | Text size | int | 24 |
  | align | Text alignment | AlignLabel | DEFAULT |
  | rotate | Text rotation | Rotate | ROTATE_0 |
  | enableBold | Enable bold | bool | false |
  | enableUnderline | Enable underline | bool | false |

Example:
```dart
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/enums.dart';

await iminPrinter.labelAddText(
  'Hello Label',
  labelTextStyle: LabelTextStyle(
    posX: 10,
    posY: 10,
    textSize: 32,
    enableBold: true,
    align: AlignLabel.center,
  )
);
```

### Add Barcode to Label
 - labelAddBarCode(String barCode, {LabelBarCodeStyle? barCodeStyle})
   - parameter:
     - String barCode -> Barcode content
     - LabelBarCodeStyle barCodeStyle -> Barcode style settings (optional)

Example:
```dart
await iminPrinter.labelAddBarCode(
  '1234567890',
  barCodeStyle: LabelBarCodeStyle(
    posX: 50,
    posY: 100,
    symbology: Symbology.code128,
    readable: HumanReadable.pos_two,
  )
);
```

### Add QR Code to Label
 - labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle})
   - parameter:
     - String qrCode -> QR code content
     - LabelQrCodeStyle qrCodeStyle -> QR code style settings (optional)

Example:
```dart
await iminPrinter.labelAddQrCode(
  'https://www.imin.sg',
  qrCodeStyle: LabelQrCodeStyle(
    posX: 200,
    posY: 50,
    size: 6,
    errorLevel: ErrorLevel.h,
  )
);
```

### Add Area/Shape to Label
 - labelAddArea({LabelAreaStyle? areaStyle})
   - parameter:
     - LabelAreaStyle areaStyle -> Area style settings (optional)

Example:
```dart
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.rect_fill,
    posX: 10,
    posY: 10,
    width: 100,
    height: 50,
  )
);
```

### Add Bitmap to Label
 - labelAddBitmap(dynamic img, {LabelBitmapStyle? addBitmapStyle})
   - parameter:
     - dynamic img -> Image data (Uint8List or URL)
     - LabelBitmapStyle addBitmapStyle -> Bitmap style settings (optional)

Example:
```dart
await iminPrinter.labelAddBitmap(
  imageBytes,
  addBitmapStyle: LabelBitmapStyle(
    posX: 50,
    posY: 50,
    algorithm: ImageAlgorithm.binarization,
  )
);
```

### Print Label Canvas
 - labelPrintCanvas(int printCount)
   - parameter:
     - int printCount -> Number of copies to print

Example:
```dart
await iminPrinter.labelPrintCanvas(1);
```

### Print Label Bitmap
 - printLabelBitmap(dynamic img, {LabelPrintBitmapStyle? printBitmapStyle})
   - parameter:
     - dynamic img -> Image data
     - LabelPrintBitmapStyle printBitmapStyle -> Print style settings (optional)

Example:
```dart
await iminPrinter.printLabelBitmap(
  imageBytes,
  printBitmapStyle: LabelPrintBitmapStyle(
    width: 400,
    height: 300,
  )
);
```

### Label Learning
 - labelLearning()
   - No parameters

Example:
```dart
await iminPrinter.labelLearning();
```