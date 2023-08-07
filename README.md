# imin_printer

It is used to print text, pictures, two-dimensional code, bar code and other functions sdk in imin printer using Android system



### Resources:

- [Pub Package](https://pub.dev/packages/imin_printer)
- [GitHub Repository](https://github.com/iminsoftware/imin_printer)


#### Platform Support

| Android |
| :-----: | 
|   ✅   |


[Official Imin Inner Printer Doc](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

## Getting Started

## Installation  

```bash
flutter pub add imin_printer
```




## Tested Devices

```bash
Imin M2-203 
Imin M2-202
Imin M2-Pro
```

## Just see the example folder!

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
```

## Example code when use for transaction printing

```dart 
  // all method from imin printer need to async await
 await iminPrinter.initPrinter();   // must init the printer first. for more exmaple.. pls refer to example tab.

 await iminPrinter.getPrinterStatus();
 await iminPrinter.printText('print example', style: IminTextStyle(wordWrap: true));
```

### List of enum Alignments
```dart
enum IminPrintAlign { 
  left, 
  center, 
  right 
}

```

### List of enum Qrcode levels
```dart
enum IminQrcodeCorrectionLevel {
  levelL(48),
  levelM(49),
  levelQ(50),
  levelH(51);

  final int level;
  const IminQrcodeCorrectionLevel(this.level);
}
```

### IminTextStyle
``` dart
class IminTextStyle {
  bool? wordWrap;
  int? fontSize;
  double? space;
  IminTypeface? typeface;
  IminFontStyle? fontStyle;
  IminPrintAlign? align;
}
```