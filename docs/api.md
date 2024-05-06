# Related methods provided by flutter, iMin's internal printer

## Initializes the iMin internal printer
 - initPrinter()
    - Not parameter

Example: 
```dart
  iminPrinter.initPrinter();
```

## Get printer status
 - getPrinterStatus()
    - Not parameter

Example: 
```dart
  iminPrinter.getPrinterStatus().then((value){
    // printer status
    print(state['msg']);    
  });   
```

## A line of paper
  - printAndLineFeed()
    -  Not parameter

Example:
```dart
  iminPrinter.printAndLineFeed();
```


## Walk several lines of paper, customize the height
  - printAndFeedPaper()
    - parameter:
      - int lineHeight , Value range: 1-1016

Example:
```dart
  iminPrinter.printAndFeedPaper(100); 
```

## Set paper size
  - setPageFormat()
    - parameter:
      - int style -> Paper size  0-80mm 1-58mm;

Example:
```dart
  iminPrinter.setPageFormat(1);
```

## cutter
This method is only applicable to iMin  devices with 'cutter function'.
 - partialCut()
   - Not parameter

Example:
```dart
  iminPrinter.partialCut();
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
  iminPrinter.setAlignment(IminPrintAlign.center);
```

## Set text size
  - setTextSize()
    - parameter:
      - int size -> Font size

Example:
```dart
  iminPrinter.setTextSize(25);
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

 iminPrinter.setTextTypeface(IminTypeface.typefaceMonospace);
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
  
  
  iminPrinter.setTextStyle(IminFontStyle.bold);
```

## Set text line spacing
    - setTextLineSpacing()
       - parameter:
         - double space -> Line spacing

Example:
```dart
  iminPrinter.setTextLineSpacing(1.0f);
```

## Set the print text width
  - setTextWidth()
    - parameter:
      - int width -> Width

Example:
```dart
  iminPrinter.setTextWidth(200);
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
iminPrinter.printText("Hello World");

/// Set the Settings related to the printed text
iminPrinter.printText("Hello World", IminTextStyle(
  fontSize: 20,
  space: 1.0f,
  width: 100,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

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
iminPrinter.printAntiWhiteText("Hello World");

/// Set the Settings related to the printed text
iminPrinter.printAntiWhiteText("Hello World", IminTextStyle(
  fontSize: 20,
  space: 1.0f,
  width: 100,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

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


   iminPrinter.printColumnsText(cols: [
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
    ])

```


## Print a single image
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
iminPrinter.printSingleBitmap(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]));

/// Use the image binary stream and set the image style
iminPrinter.printSingleBitmap(
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0])
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// Pass the image using the url address and set the image style
iminPrinter.printSingleBitmap(
    'https://www.example.com/image.jpg',
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```


## Print multiple pictures
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

iminPrinter.printMultiBitmap([Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00]]);

/// Use the image binary stream and set the image style
iminPrinter.printMultiBitmap(
   [Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00])],
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// Pass the image using the url address and set the image style
iminPrinter.printSingleBitmap(
    ['https://www.example.com/image.jpg', 'https://www.example.com/image.jpg'],
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```


## Print a single anti-white image
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
iminPrinter.printSingleBitmapBlackWhite(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]))

/// Pass the image using the url address and set the image style
iminPrinter.printSingleBitmapBlackWhite('https://www.example.com/image.jpg',
     pictureStyle: IminBaseStyle(
        width: 250,
        height: 50,
      ));

```

## Set QR code size
 - setQrCodeSize
    - parameter:
      - int size -> Qr code size。

Example:
```dart
iminPrinter.setQrCodeSize(5); // Set the QR code size to 5.
```

## Set the left margin of the QR code and barcode
  - setLeftMargin
    - parameter:
      - int  margin -> left margin

Example:
```dart
iminPrinter.setLeftMargin(5); // Set the left margin to 5.
```

## Set the error correction level of the QR code
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


iminPrinter.IminQrcodeCorrectionLevel(IminQrcodeCorrectionLevel.levelL); 

```

## Print QR code
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

  iminPrinter.printQrCode('https://www.baidu.com', 
  IminQrCodeStyle(
    qrSize: 4,  
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
    leftMargin: 2,
     align: IminPrintAlign.left 
  ));
```

## Set double QR code size
 - setDoubleQRSize
   - parameter:
      - int qrSize -> Size of QR code.

Example:
```dart
iminPrinter.setDoubleQRSize(4);
```

## Set double QR code (QR1) error
  - setDoubleQR1Level()
     - parameter:
        - int  level -> Error Size Value range :1 to 3。

Example:
```dart
iminPrinter.setDoubleQR1Level(2);
```

## Set double QR code (QR2) error
  - setDoubleQR2Level()
     - parameter:
        - int  level -> Error Size Value range:1 to 3。

Example:
```dart
iminPrinter.setDoubleQR2Level(2);
``` 

## Set double QR code (QR1) left margin
  - setDoubleQR1MarginLeft()
     - parameter:
        - int  leftMargin -> The left distance ranges from 0 to 576.

Example:
```dart
iminPrinter.setDoubleQR1MarginLeft(2);
```

## Set double QR code (QR2) left margin
  - setDoubleQR2MarginLeft()
     - parameter:
        - int  leftMargin -> The left distance ranges from 0 to 576.
   
Example:
```dart
iminPrinter.setDoubleQR2MarginLeft(2);
```

## Set up the dual QR Code (QR1) version
  - setDoubleQR1Version()
     - parameter:
        - int  version -> Version Value range :1 to 40。

Example:
```dart
iminPrinter.setDoubleQR1Version(2);
```

## Set the dual QR Code (QR2) version
  - setDoubleQR2Version()
     - parameter:
        - int  version -> Version Value range :1 to 40。

Example:
```dart
iminPrinter.setDoubleQR2Version(2); 
```

## Print double QR code
 - printDoubleQR()
   - parameter:
      - IminDoubleQRCodeStyle qr1 -> The first QR code setting.
      - IminDoubleQRCodeStyle qr2 -> Second QR code Settings.
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

iminPrinter.printDoubleQR( qrCode1: IminDoubleQRCodeStyle(
            text: 'www.imin.sg',
          ),
          qrCode2: IminDoubleQRCodeStyle(
            text: 'www.google.com',
          ),
          doubleQRSize: 5)
```


## Set bar code width
  - setBarCodeWidth()
     - parameter:
        - int  width -> Bar code width Value range :2-6.
      
Example:
```dart
iminPrinter.setBarCodeWidth(2);
```

## Set bar code height
  - setBarCodeHeight()
     - parameter:
        - int  height -> The bar code height ranges from 1 to 255.

Example:
```dart
iminPrinter.setBarCodeHeight(2);
```

## The print position of the HRI character when printing the bar
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

  iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove);
```

## Print bar code
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
   iminPrinter.printBarCode(IminBarcodeType.jan13, "0123456789012",);

 /// Set the bar code style
     iminPrinter.printBarCode(
          IminBarcodeType.jan13, "0123456789012",
          style: IminBarCodeStyle(
               width: 150,
               height: 50,
              align: IminPrintAlign.center,
              position: IminBarcodeTextPos.textAbove));
```


## Print barcode setup format
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

 iminPrinter.printBarCodeToBitmapFormat( "0123456789012", 100, 50, IminBarCodeToBitmapFormat.code39);

```


## Open the money box
  - openCashBox()
     - Not parameter:

Example:
```dart
  iminPrinter.openCashBox();
```

## Reset printer
  - resetDevice()
    - Not parameter:

Example:
```dart
  iminPrinter.resetDevice();
```

## Set the initialization printer
  - setInitIminPrinter
      - parameter:
         - bool isDefault -> Whether it is set by default.

```dart
  iminPrinter.setInitIminPrinter(true);
```


## Open Logs
  - openLogs
     - parameter:
         - int 0 or 1 -> is open

```dart
   iminPrinter.openLogs(1);
```

## Send RAW Data Hex Str
  - sendRAWDataHexStr
   - parameter: 
   - String bytes -> byte String。


```dart
   iminPrinter.sendRAWDataHexStr('0A');
```