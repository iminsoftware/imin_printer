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

## Print form (width value method)
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
import 'package:imin_printer/column_maker.dart'; ///Need to import
import 'package:imin_printer/enums.dart'; ///Need to import


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

## Print form (width weight ratio)
  - printColumnsString()
      - parameter:
        - List<ColumnMaker> cols -> Column array

ColumnMaker  Related API:

  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | text | Column content | String  | None |
  | width | Column width | int | None |
  | align | Column alignment | IminPrintAlign | None |
  | fontSize | Font size | int | None |

Example:
```dart
import 'package:imin_printer/column_maker.dart'; ///Need to import
import 'package:imin_printer/enums.dart'; ///Need to import


   iminPrinter.printColumnsString(cols: [
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

## Print text picture
   - printTextBitmap()
     - parameter:
       - String text -> Print text picture content
       - IminTextPictureStyle style -> Print text image related Settings (optional)

IminTextPictureStyle Related API:

   | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | Whether print text will join `\n` ,`true` or not set automatic `\n`, for `false` without `\n` | bool  | None |
  | fontSize | Print text size | int | None |
  | typeface | Print text font | IminTypeface  | None |
  | letterSpacing | The value of the spacing between printed characters ranges from 1 to 60 |  double | None |
  | underline | Print text underline | bool | None |
  | throughline | Print text stripper lines | bool | None |
  | lineHeight | The value ranges from 1 to 255 | double | None |
  | reverseWhite | Whether the printed text is reversed white | bool | None |
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

parameter:
```dart
import 'package:imin_printer/imin_style.dart';  /// Need to import
import 'package:imin_printer/enums.dart';  ///Need to import

/// Simple use
iminPrinter.printTextBitmap("Hello World");

/// Set the Settings related to printing text and pictures
iminPrinter.printTextBitmap("Hello World", IminTextPictureStyle(
  fontSize: 20,
  letterSpacing: 1,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

```


## A line of paper
  - printAndLineFeed()
    - Not parameter

Example:
```dart
  iminPrinter.printAndLineFeed();
```

## Walk several lines of paper, customize the height
  - printAndFeedPaper()
    - parameter:
      - int lineHeight The value ranges from 1 to 1016

Example:
```dart
  iminPrinter.printAndFeedPaper(100); 
```

## cutter（Cut paper part）
This method is only applicable to iMin devices with 'cutter function'.
 - partialCut() 
   - Not parameter

Example:
```dart
  iminPrinter.partialCut();
```

## cutter（Cut the paper completely）
This method is only applicable to iMin  devices with 'cutter function'.
 - fullCut() 
      - Not parameter

Example:
```dart
  iminPrinter.fullCut();
```


## Print a single image
 - printSingleBitmap()
   - parameter:
      - dynamic img -> Image path url or image binary stream。
      - IminPictureStyle pictureStyle -> Image style related Settings (optional)。

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
import 'package:imin_printer/imin_style.dart'; ///If passing the image style setting item needs to be imported
import 'package:imin_printer/enums.dart';  ///If passing the image style setting item needs to be imported

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


## Set QR code size
 - setQrCodeSize
    - parameter:
      - int size -> Size of QR code.

Example:
```dart
iminPrinter.setQrCodeSize(5); // Set the QR code size to 5.
```

## Set the left margin of the QR code and barcode
  - setLeftMargin
    - parameter:
      - int  margin -> Left margin.

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
  | errorCorrectionLevel | Error correction level | enum IminQrcodeCorrectionLevel { levelL(48), levelM(49), levelQ(50), levelH(51)} | None|

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
import 'package:imin_printer/enums.dart';  /// Need to import

  iminPrinter.printQrCode('https://www.baidu.com', 
  IminQrCodeStyle(
    qrSize: 4,  
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
    leftMargin: 2,
     align: IminPrintAlign.left 
  ));
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
        - int  height -> The bar code height ranges from 1 to 255。

Example:
```dart
iminPrinter.setBarCodeHeight(2);
```

## The printing position of the HRI character when printing the bar
   - setBarCodeContentPrintPos()
      - parameter:
         - IminBarcodeTextPos position -> Bar code content print location.

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
iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove);
```




## Set paper specifications
  - setPageFormat()
    - parameter:
      - int style -> Paper size 0-80mm 1-58mm;

Example:
```dart
  iminPrinter.setPageFormat(1);
```


## Print the barcode
  - printBarCode()
    - parameter:
       - IminBarcodeType barCodeType -> Barcode type.
       - String barCodeContent -> Bar code content.
       - IminBarCodeStyle style -> Bar code style related Settings (optional)。
  
IminBarCodeStyle Related API:
  | Property | explain | Type | default  |
  | --- | --- | --- | --- |
  | width | Bar code width | int | None |
  | height | Bar code height | int | None |
  | position | Bar code content print location | IminBarcodeTextPos | None |
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

  /// Easy to use
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


## Set the double QR code size
 - setDoubleQRSize
   - parameter:
      - int qrSize -> Qr code size.

Example:
```dart
iminPrinter.setDoubleQRSize(4);
```


## Set double QR code (QR1) error
  - setDoubleQR1Level()
     - parameter:
        - int  level -> Error size range :1-3。

Example:
```dart
iminPrinter.setDoubleQR1Level(2);
```


## Set double QR code (QR2) error
  - setDoubleQR2Level()
     - parameter:
        - int  level -> Error size range :1-3。

Example:
```dart
iminPrinter.setDoubleQR2Level(2);
``` 

## Set the left margin of double QR code (QR1)
  - setDoubleQR1MarginLeft()
     - parameter:
        - int  leftMargin -> Left margin range :0-576

Example:
```dart
iminPrinter.setDoubleQR1MarginLeft(2);
```

## Set the left margin of double QR code (QR2)
  - setDoubleQR2MarginLeft()
     - parameter:
        - int  leftMargin -> Left margin range :0-576.
   
Example:
```dart
iminPrinter.setDoubleQR2MarginLeft(2);
```


## Set double QR code (QR1) version
  - setDoubleQR1Version()
     - parameter:
        - int  version -> Version range :1-40。

Example:
```dart
iminPrinter.setDoubleQR1Version(2);
```

## Set dual QR code (QR2) version
  - setDoubleQR2Version()
     - parameter:
        - int  version -> Version range :1-40。

Example:
```dart
iminPrinter.setDoubleQR2Version(2); 
```


## Print double QR code
 - printDoubleQR()
   - parameter:
      - IminDoubleQRCodeStyle qr1 -> The first QR code setting。
      - IminDoubleQRCodeStyle qr2 -> The second QR code is set.
      - int doubleQRSize -> Double QR code size (optional)

IminDoubleQRCodeStyle  Qr code Settings related API:
  
 | Property | explain | Type | default  |
  | --- | --- | --- | --- |
  | text | Qr code content | String | - |
  | level | Qr code error level (optional) | int | - |
  | leftMargin | Left margin of QR code (optional) | int | - |
  | version | Qr code version (optional) | int | - |

Example:

```dart
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';  ///Need to import

iminPrinter.printDoubleQR( qrCode1: IminDoubleQRCodeStyle(
            text: 'www.imin.sg',
          ),
          qrCode2: IminDoubleQRCodeStyle(
            text: 'www.google.com',
          ),
          doubleQRSize: 5)
```

## Open the money box
  - openCashBox()
     - Not parameter:

Example:
```dart
  iminPrinter.openCashBox();
```

## Unbundling the print service
  - unBindService()
     - Not parameter:

Example:
```dart
  iminPrinter.unBindService();
```

## Reset printer parameters
   - initPrinterParams()
     - Not parameter:

Example:
```dart
  iminPrinter.initPrinterParams();
```

## Get the printer serial number
   - getPrinterSerialNumber()
      - Not parameter:

Example:
```dart
  iminPrinter.getPrinterSerialNumber().then((value){
    // serial number
    print(value);    
  });
```

## Get the printer model
  - getPrinterModelName  
    - Not parameter:

Example:
```dart
  iminPrinter.getPrinterModelName().then((value){
    //printer model
    print(value);    
  });
```

## Get the printer thermal head model
  - getPrinterThermalHead()
     - Not parameter:

Example: 
```dart
  iminPrinter.getPrinterThermalHead().then((value){
    // printer thermal head model
    print(value);    
  });
```

##  Gets the printer firmware version number
  - getPrinterFirmwareVersion()
      - Not parameter:

Example: 
```dart
  iminPrinter.getPrinterFirmwareVersion().then((value){
   // printer firmware version number
    print(value); 
  })
```

## Gets the print service version number
   - getServiceVersion()
         - Not parameter:

Example: 
```dart
  iminPrinter.getServiceVersion().then((value){
    /// print service version number
    print(value); 
  })
```

##  Gets the printer hardware version number
   -  getPrinterHardwareVersion()
      - Not parameter:

Example: 
```dart
  iminPrinter.getPrinterHardwareVersion().then((value){
   // printer hardware version number
    print(value); 
  })
```


## Get the pid vid of the USB connection
   - getUsbPrinterVidPid()
     - Not parameter:

Example: 
```dart
  iminPrinter.getUsbPrinterVidPid().then((value){
   // pid vid for USB connection
    print(value); 
  });
```

## Gets the name of the connected USB device
   - getUsbDevicesName()
      - Not parameter:

Example: 
```dart
  iminPrinter.getUsbDevicesName().then((value){
   // name of the connected USB device
    print(value); 
  });
```

##  Get the printing density
   - getPrinterDensity()
      - Not parameter:

Example: 
```dart
  iminPrinter.getPrinterDensity().then((value){
   // printing density
    print(value); 
  });
```

## Getting the print length
   - getPrinterPaperDistance()
     - Not parameter:

Example:   
```dart
  iminPrinter.getPrinterPaperDistance().then((value){
   // print length
    print(value); 
  });
```

## Gets the current printer speed
     - getPrinterSpeed()
        - Not parameter:

Example:  
```dart
  iminPrinter.getPrinterSpeed().then((value){
   // current printer speed
    print(value); 
  });
```

## Get the paper size set by the current printer
   - getPrinterPaperType()
      - Not parameter:


Example:  
```dart
  iminPrinter.getPrinterPaperType().then((value){
   // Paper specifications set before printer
    print(value); 
  });
```

## Get the number of cuts
   - getPrinterCutTimes()
      - Not parameter:
  

Example:   
```dart
  iminPrinter.getPrinterCutTimes().then((value){
   // Get the number of cuts
    print(value); 
  });
```

## Gets the current printer mode
   - getPrinterMode()
     - Not parameter:
  

Example: 
```dart
  iminPrinter.getPrinterMode().then((value){
   //  current printer mode
    print(value); 
  });
```

## Get the status of the money box
   - getDrawerStatus()
        - Not parameter:

Example: 
```dart
  iminPrinter.getDrawerStatus().then((value){
   // Cash box status
    print(value); 
  });
```

##  Gets the number of times the cash box was opened
   - getOpenDrawerTimes()
       - Not parameter:

Example: 
```dart
  iminPrinter.getOpenDrawerTimes().then((value){
  // The number of times the cash box was opened
    print(value); 
  });
```


## Print the self-test page
  - printerSelfChecking()
     - Not parameter:

Example:   
```dart
  iminPrinter.printerSelfChecking();
```

##  ESC/POS Command printing
  -  sendRAWData()
      - parameter:
          - Uint8List bytes -> To print the data:


Example:  
```dart
  iminPrinter.sendRAWData(bytes);
```

## Sets the print global alignment
  - setCodeAlignment()
     - parameter:
        -  IminPrintAlign alignment -> Print the alignment:

```dart
enum IminPrintAlign { left, center, right }
```

Example:  

```dart
import 'package:imin_printer/enums.dart'; /// Must import

  iminPrinter.setCodeAlignment(IminPrintAlign.left)
```

## Sets the font to print
  - setTextBitmapTypeface()
      - parameter:
          - IminTypeface typeface -> Font type:


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
import 'package:imin_printer/enums.dart'; /// Must import

  iminPrinter.setTextBitmapTypeface(IminTypeface.typefaceDefault)
```

## Set the print font size for text images
   - setTextBitmapSize()
      - parameter:
         - int size -> Font size:

Example:  
```dart
  iminPrinter.setTextBitmapSize(16)
```

## Set the print font style for text images
   - setTextBitmapStyle()
      - parameter:
         - IminFontStyle style -> Text images print font styles:
  
```dart
enum IminFontStyle { normal, bold, italic, boldItalic }
```

Example:  
```dart
import 'package:imin_printer/enums.dart'; /// Must import

  iminPrinter.setTextBitmapStyle(IminFontStyle.italic);
```

## Sets the text font delete line
  - setTextBitmapStrikeThru()
     - parameter:
          - bool strikeThru -> Whether to delete the line

Example: 
```dart

  iminPrinter.setTextBitmapStrikeThru(true);
```

## Sets the text font underline
  - setTextBitmapUnderline()
       - parameter:
            - bool haveUnderline -> Whether to underline or not:
    
Example: 
```dart
  iminPrinter.setTextBitmapUnderline(true);
```

## Sets the line height of the text font
  -  setTextBitmapLineSpacing()
    - parameter:
          -  double lineHeight  -> LineHeight:

Example: 
```dart
  iminPrinter.setTextBitmapLineSpacing(1);
```

## Sets text font spacing
   - setTextBitmapLetterSpacing()
      - parameter
          - double space  -> spacing:

Examples:
```dart
  iminPrinter.setTextBitmapLetterSpacing(1);
```  

## Sets the text font to reverse whitening
   - setTextBitmapAntiWhite()
      - parameter
          - bool antiWhite -> Whether it is anti-white:


Examples:
```dart
  iminPrinter.setTextBitmapAntiWhite(true);
```

## The images are processed in monochrome and printed
   - printSingleBitmapColorChart()
   - parameter
         -  dynamic img -> Image path url or image binary stream.
         -  IminPictureStyle pictureStyle -> Image styles (optional)

IminPictureStyle Related  API:
  
  | Property | explain | Type | default  |
  | ---- | ---- | ---- | ---- |
  | width | Image width | int  | None |
  | height | Image height | int| None |
  | alignment | The alignment of the printed picture | enum IminPrintAlign { left, center, right }  | None |

```dart
  enum IminPrintAlign { left, center, right }
```

Examples:
```dart
import 'package:imin_printer/imin_style.dart'; /// If you pass an image style item, you need to import it
import 'package:imin_printer/enums.dart';  /// If you pass an image style item, you need to import it

/// Easy to use
iminPrinter.printSingleBitmapColorChart(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]));

/// Passing an image uses an image binary stream and styles the image
iminPrinter.printSingleBitmapColorChart(
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0])
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// Pass the url for the image and style the image
iminPrinter.printSingleBitmapColorChart(
    'https://www.example.com/image.jpg',
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```

## Enter transaction mode
   - enterPrinterBuffer()
     - Parameters:
        - bool isClean -> Whether to clear the print buffer

Examples:
 ```dart
 iminPrinter.enterPrinterBuffer(true);
 ```   

##  Commit transaction
   - commitPrinterBuffer()
      - Not parameters

Examples:
 ```dart
 iminPrinter.commitPrinterBuffer();
 ```   

 ## Exiting transaction mode
  - exitPrinterBuffer()
      - Parameters:
        - bool isCommit -> Whether to clear the print buffer


Examples: 
 ```dart
 iminPrinter.exitPrinterBuffer();
 ```   

## Gets the font code page
   - getFontCodepage()
      - Not parameters


Examples:   
 ```dart
 iminPrinter.getFontCodepage((value){
       print(value); /// Gets the font code page
   });
 ```   

## Set the font code page
   - setFontCodepage()
      - parameters:
         - int codepage -> Font code page

Examples:   
 ```dart
  iminPrinter.setFontCodepage(0);
 ```

## Gets the current font codepage
   - getCurCodepage()
     - Not parameters

 Examples:   
 ```dart
  iminPrinter.getCurCodepage((value){
       print(value); /// Current font code page
   });
 ```

 ## Getting a list of encodings
    - getEncodeList()
       - Not parameters


Examples:  
 ```dart
   iminPrinter.getEncodeList((value){
       print(value); // Print a list of encodings
   });
 ```

 ## Set printer code
    - setPrinterEncode()
        - parameters:
            - int encode -> Encoding


Examples: 
 ```dart
   iminPrinter.setPrinterEncode(1);
 ```

 ## Get the current encoding
   - getCurEncode()
        - Not parameters

 Examples: 
 ```dart
   iminPrinter.getCurEncode((value){
       print(value); // Current encoding
   });
 ```

 ## Gets a list of concentrations printed by the printer
   - getPrinterDensityList()
      - Not parameters
      - Return value:
        - List<String> -> Print a list of concentrations

Examples: 
 ```dart
  iminPrinter.getPrinterDensityList((value){
       print(value); // The printer prints a list of concentrations
   });
```

## Gets a list of printer speeds
   - getPrinterSpeedList()
      - Not parameters
      - Return value:
        - List<String> -> Print speed list

Examples:
 ```dart
  iminPrinter.getPrinterSpeedList((value){
       print(value); // A list of printer speeds
   });
```

## Set the printer's printing speed
   - setPrinterSpeed()
      - parameters:
         -  int speed -> Printing speed

Examples:
 ```dart
  iminPrinter.setPrinterSpeed(1);
```

## Get the printer print speed
   - getPrinterSpeed()
     - Not parameters
     - Return value:
        - int -> Printing speed

Examples:
 ```dart
  iminPrinter.getPrinterSpeed((value) {
     print(value); // Printer printing speed
  });
```

## Gets a list of printer paper types
  - getPrinterPaperTypeList()
      - Not parameters
      - Return value:
         - List<String> -> List of paper types

 Examples:
 ```dart
  iminPrinter.getPrinterPaperTypeList((value) {
     print(value); // List of paper types
  });
```