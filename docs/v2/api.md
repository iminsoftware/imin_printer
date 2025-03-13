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

## label printing
## Canvas settings
- labelInitCanvas
- parameters：
- LabelCanvasStyle labelCanvasStyle ->Specify the location and size of the label canvas
- LabelCanvasStyle Related APIs:
- |property | describe | Parameter description | default value |
  | --- | --- | --- | --- |
  | width | Pre-rendered canvas width | The size can be set not exceeding the width of the printing paper | 50 |
  | height |Pre-rendered canvas height | The size can be set not exceeding the height of the printing paper | 30 |
  | posX | The starting horizontal coordinate of the canvas relative to the label | Unit pixel | 0 |
  | posY | The starting vertical coordinate of the canvas relative to the label | Unit pixel | 0 |

```dart
LabelCanvasStyle labelCanvasStyle = LabelCanvasStyle(width: 40 * 8,
height: 30 * 8,);

await iminPrinter.labelInitCanvas(labelCanvasStyle: labelCanvasStyle);
```
## Draw text content
- labelAddText
- parameters：
- String text ->Specifies the print content of the area to be drawn
- LabelTextStyle labelTextStyle -> Draw the attributes of the content of the content instruction
- LabelTextStyle Related APIs:
-    |Available methods|	Method description	| Parameter description                                                                |	default value|
     | --- | --- |--------------------------------------------------------------------------------------| --- |
     |posX	|Set the text content to the starting horizontal coordinate position of the canvas	| Unit pixel                                                                           |	0|
     |posY	|Set the text content at the starting ordinate position of the canvas| 	Unit pixel	                                                                         |0|
     |textSize	|Specify text character size	| Effective range: 6~96 pixels	                                                        |24|
     |textWidthRatio	|Specify double width size	| Valid range 0-9                                                                      |	0|
     |textHeightRatio	|Specify double height size	| Valid range 0-9	                                                                     |0|
     |width	|Set text limit width| If you set a width limit, the line will wrap automatically if the width is exceeded. |	no limit（-1）|
     |height	|Set text limit height| 	If you set a height limit, the part exceeding it will not be displayed	             |no limit（-1）|
     |align	|Set the position of the text content relative to the starting coordinates| 	See Align                                                                           |Align.DEFAUL|
     |rotate	|Set the direction of text content	| See Rotate	                       |horizontal direction|
     |textSpace	|Set text spacing	| 0~100 pixels	                                                           |0|
     |enableBold	|Set text bold	| Turn on bold text	                                                    |Not open|
     |enableUnderline	|Set text underline| 	Enable text underline	                                        |Not open|
     |enableStrikethrough	|Set text strikethrough	| Enable text strikethrough	                              |Not open|
     |enableItalics	|Set text italics| 	Turn on italic text	                                                     |Not open|
     |enAntiColor	|Set text highlight	| Enable text highlighting                              |Not open|



```dart
LabelTextStyle labelTextStyle = LabelTextStyle(
                    posX: 0,
                    posY: 60,
                    align: AlignLabel.CENTER,
                    enableBold: true,
                    textSize: 30,
                  );
                  
                  await iminPrinter.labelAddText("iMin Label Printer",labelTextStyle: labelTextStyle);
```
## Draw barcode content
- labelAddBarCode
- parameters：
- String barCode -> Barcode content
- LabelBarCodeStyle barCodeStyle -> Specified attributes related to barcode content
- LabelBarCodeStyle Related APIs
- | Available methods       |	Method description| 	Parameter description	 |default value|
  |------------| --- |-------------------------| --- |
  | posX       |	Set the barcode content to the starting horizontal coordinate position of the canvas	| Unit pixel              |	0|
  | posY       |	Set the barcode content to the starting ordinate position of the canvas| 	Unit pixel             |	0|
  | dotWidth   |	Set code block width| 	1~16 pixels            | Will affect the total width of the final barcode   |	2|
  | barHeight	 |Set barcode height	| 1~255 pixels            | Will affect the total height of the final barcode   |	162|
  | readable	  |Set HRI location	| See HumanReadable       |	Do not display|
  | symbology	 |Set barcode type	| See Symbology           |	code128|
  | align	     |Set the relative starting coordinate position of the barcode| 	See Align              |	Align.DEFAUL|
  | rotate     |	Set the barcode rotation direction	| See Rotate	                |horizontal direction|
  | width	     |Specify barcode scaling width	| When the zoom width is set, the code content size will be forced to change	     |No scaling|
  | height     |	Specify barcode scaling height	| When the zoom width is set, the code content size will be forced to change	     |No scaling|

```dart

                  LabelBarCodeStyle barCodeStyle = LabelBarCodeStyle(
                    posX: 30,
                    posY: 370,
                    align: AlignLabel.CENTER,
                    symbology: Symbology.CODABAR,
                    dotWidth: 2,
                    barHeight: 60,
                    readable: HumanReadable.POS_TWO,
                  );
                  
                  await iminPrinter.labelAddBarCode("123456",barCodeStyle: barCodeStyle);
```
## Draw the QR code content
- labelAddQrCode
- parameters：
- String qrCode -> Printed QR code content
- LabelQrCodeStyle qrCodeStyle -> QR code configuration related properties
- LabelQrCodeStyle Related APIs description

  | Available methods	       |Method description	| Parameter description	 | default value |
  |-------------| --- |------------------------|-----|
  | posX	       |Set the starting horizontal coordinate position of the QR code content on the canvas	| Unit pixel	            |0|
  | posY	       |Set the starting vertical coordinate position of the QR code content on the canvas	| Unit pixel             |	0|
  | size	       |Set the QR code block size	| 1~16 pixels            |This will ultimately affect the size of the QR code |	4|
  | errorLevel	 | Set the QR code error correction level	| See ErrorLevel         |	ErrorLevel.L|
  | rotate	     |Set the QR code rotation direction	| See Rotate             |	horizontal direction|
  | width	      |Specify the width of the QR code	| When the zoom width is set, the code content size will be forced to change     |	No scaling|
  | height	     |Specify the QR code scaling height| 	When the zoom width is set, the code content size will be forced to change	   |No scaling|

```dart
LabelQrCodeStyle qrCodeStyle = LabelQrCodeStyle(
                    posX: 290,
                    posY: 145,
                    size: 3,
                    errorLevel: ErrorLevel.H,
                  );
                  
                  await iminPrinter.labelAddQrCode("12345658哈哈",qrCodeStyle: qrCodeStyle);
```
## Draw special graphics
- labelAddArea
- parameters：
- LabelAreaStyle areaStyle -> Graphics related configuration properties
- | Available methods    |	Method description|	Parameter description|	default value|
  |---------| --- |-------|-----|
  | style   |	Set drawing shape|See Shape	|Shape.RECT_FILL|
  | width	  |Set the width of the graphic| Invalid if the shape is a line segment. Indicates the diameter of the circle if the shape is a circle.	|Unit pixel	|50|
  | height	 |Set the height of the graphic| Invalid when the shape is a line segment |	Unit pixel|	50|
  | posX	   |Set starting x coordinate	|Unit pixel|	0|
  | posY	   |Set the starting y coordinate|	Unit pixel|	0|
  | endX	   |Set the x coordinate of the end point of the line segment	|Unit pixel|	50|
  | endY	   |Set the y coordinate of the end point of the line segment|	Unit pixel|	50|
  | thick	  |Set stroke|	stroke width|	1|

```dart
LabelAreaStyle printBitmapStyle = LabelAreaStyle(
                    style: Shape.PATH,
                    posX: 1,
                    posY: 40,
                    endX: 50 * 8 - 1,
                    endY: 60,
                    thick: 2,
                  );
                 
                  await iminPrinter.labelAddArea(areaStyle: printBitmapStyle);
```
## draw image
- labelAddBitmap
- parameters：
- dynamic img -> Image path url or image binary stream
- 
- LabelBitmapStyle addBitmapStyle -> Image-related configuration properties

- | Available methods	     |Method description	|Parameter description	| default value               |
  |-----------| --- |-------|-----------------------------|
  | posX	     |Set the initial horizontal position of the image|	If the canvas size is exceeded, it will not be printed.| 	0                          |
  | posY      |Set the image's starting ordinate position on the canvas|If the canvas size is exceeded, it will not be printed.| 	0                          |
  | algorithm |Set image conversion method|	See ImageAlgorithm	| ImageAlgorithm.BINARIZATION |
  | value	    |Set algorithm float value	|The floating value varies according to the specific algorithm| See ImageAlgorithm          |
  | width	    |Specify the image scaling width	|When the zoom width is set, the image size will be forced to change| 	No scaling                        |
  | height    | Specify the image scaling height	|When the zoom width is set, the image size will be forced to change| 	No scaling                        |

```dart
LabelBitmapStyle addBitmapStyle = LabelBitmapStyle(

                    posX: 290,
                    posY: 30,
                    width: 80,
                    height: 80,

  
                  );

                  await iminPrinter.labelAddBitmap('https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',addBitmapStyle: addBitmapStyle);

```

## Print the drawn content
- labelPrintCanvas
- parameters：
- int printCount -> The number of times you want to print. If it is a label printer, it will be printed on each label separately. 
- The number of prints is greater than 0.
- Print result returns
```dart
 await iminPrinter.labelPrintCanvas(1);
```
## Print label image
- printLabelBitmap
- parameters：
- dynamic img -> Image path url or image binary stream
- LabelPrintBitmapStyle addBitmapStyle -> Image-related configuration properties

- |Available methods	|Method description	|Parameter description	|default value|
  | --- | --- |-------|-----|
  |width	|Specify the image scaling width	|When the zoom width is set, the image size will be forced to change|	No scaling|
  |height|	Specify the image scaling height	|When the zoom width is set, the image size will be forced to change|	No scaling|
-
```dart
LabelPrintBitmapStyle addBitmapStyle = LabelPrintBitmapStyle(
  
  width: 50,
  height: 30,

);
 await iminPrinter.printLabelBitmap('https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',addBitmapStyle: addBitmapStyle);
```

```dart

enum ImageAlgorithm {
  BINARIZATION,
  DITHERING;
}

enum Shape {
  RECT_FILL,
  RECT_WHITE,
  RECT_REVERSE,
  BOX,
  CIRCLE,
  OVAL,
  PATH
}

enum Rotate {
  ROTATE_0,
  ROTATE_90,
  ROTATE_180,
  ROTATE_270
}

enum ErrorLevel {
  L,
  M,
  Q,
  H
}

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

enum AlignLabel {
  DEFAULT,
  LEFT,
  CENTER,
  RIGHT
}

enum HumanReadable {
  HIDE,
  POS_ONE,
  POS_TWO,
  POS_THREE
}



```

