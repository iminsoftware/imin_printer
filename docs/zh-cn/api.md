# iMin内部打印机flutter提供的相关方法

## 初始化iMin内部打印机
 - initPrinter()
    - 无参数

示例: 
```dart
  iminPrinter.initPrinter();
```

## 获取打印机状态
 - getPrinterStatus()
    - 无参数

示例:
```dart
  iminPrinter.getPrinterStatus().then((value){
    // 打印机状态
    print(state['msg']);    
  });   
```

## 走纸一行
  - printAndLineFeed()
    - 无参数

示例:
```dart
  iminPrinter.printAndLineFeed();
```


## 走纸若干行,自定义高度
  - printAndFeedPaper()
    - 参数:
      - int lineHeight 行高, 取值范围: 1-1016

示例:
```dart
  iminPrinter.printAndFeedPaper(100); 
```

## 设置纸张规格
  - setPageFormat()
    - 参数:
      - int style -> 纸张规格  0-80mm 1-58mm;

示例:
```dart
  iminPrinter.setPageFormat(1);
```

## 切刀（切纸）
此方法只适用于带`切刀功能`的iMin（一敏）设备。
 - partialCut()
   - 无参数

示例:
```dart
  iminPrinter.partialCut();
```

## 设置对齐方式
  - setAlignment
    - 参数:
      - IminPrintAlign alignment -> 对齐方式

```dart
  enum IminPrintAlign { left, center, right }
```

示例:
```dart
import 'package:imin_printer/enums.dart';  ///需要导入
  iminPrinter.setAlignment(IminPrintAlign.center);
```

## 设置文字大小
  - setTextSize()
    - 参数:
      - int size -> 字体大小

示例:
```dart
  iminPrinter.setTextSize(25);
```

## 设置文字字体
   - setTextTypeface()
      - 参数:
          - IminTypeface typeface -> 字体

```dart
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
```   

示例:
```dart
import 'package:imin_printer/enums.dart';  ///需要导入

 iminPrinter.setTextTypeface(IminTypeface.typefaceMonospace);
```

## 设置文字样式
  - setTextStyle()
      - 参数:
          - IminFontStyle style -> 文字样式

```dart
  enum IminFontStyle { normal, bold, italic, boldItalic }
```

示例:
```dart
import 'package:imin_printer/enums.dart';  ///需要导入
  
  
  iminPrinter.setTextStyle(IminFontStyle.bold);
```

## 设置文字行间距
  - setTextLineSpacing()
       - 参数:
          - double space -> 行间距

示例:
```dart
  iminPrinter.setTextLineSpacing(1.0f);
```

## 设置打印文字宽度
  - setTextWidth()
    - 参数:
      - int width -> 宽度

示例:
```dart
  iminPrinter.setTextWidth(200);
```

## 打印文字
   - printText()
     - 参数:
       - String text -> 打印文字
       - IminTextStyle style -> 打印文字相关设置项（可选）

IminTextStyle 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | 打印文字内容是否加入`\n`, `true`或者不设置自动加`\n`, 为`false`不加`\n` | bool  | 无 |
  | fontSize | 打印文字大小 | int | 无 |
  | space | 打印文字行间距 | double | 无 |
  | width | 打印文字宽度 | int | 无 |
  | typeface | 打印文字字体 | IminTypeface | 无 |
  | fontStyle | 打印文字样式  | IminFontStyle | 无 |
  | align | 打印文字对齐方式 | IminPrintAlign | 无 |

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

示例:
```dart
import 'package:imin_printer/imin_style.dart';  ///需要导入
import 'package:imin_printer/enums.dart';  ///需要导入

///简单使用
iminPrinter.printText("Hello World");

///设置打印文字相关设置项
iminPrinter.printText("Hello World", IminTextStyle(
  fontSize: 20,
  space: 1.0f,
  width: 100,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

```

## 打印反白文字
  - printAntiWhiteText()
    - 参数:
       - String text -> 打印文字
       - IminTextStyle style -> 打印文字相关设置项（可选）

IminTextStyle 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | 打印文字内容是否加入`\n`, `true`或者不设置自动加`\n`, 为`false`不加`\n` | bool  | 无 |
  | fontSize | 打印文字大小 | int | 无 |
  | space | 打印文字行间距 | double | 无 |
  | width | 打印文字宽度 | int | 无 |
  | typeface | 打印文字字体 | IminTypeface | 无 |
  | fontStyle | 打印文字样式  | IminFontStyle | 无 |
  | align | 打印文字对齐方式 | IminPrintAlign | 无 |

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

示例:
```dart
import 'package:imin_printer/imin_style.dart';  ///需要导入
import 'package:imin_printer/enums.dart';  ///需要导入

///简单使用
iminPrinter.printAntiWhiteText("Hello World");

///设置打印文字相关设置项
iminPrinter.printAntiWhiteText("Hello World", IminTextStyle(
  fontSize: 20,
  space: 1.0f,
  width: 100,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

```


## 打印表格
  - printColumnsText()
      - 参数:
        - List<ColumnMaker> cols -> 列数组

ColumnMaker 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | text | 列内容 | String  | 无 |
  | width | 列宽度 | int | 无 |
  | align | 列对齐方式 | IminPrintAlign | 无 |
  | fontSize | 字体大小 | int | 无 |

示例:
```dart
import 'package:imin_printer/column_maker.dart'; ///需要导入
import 'package:imin_printer/enums.dart'; ///需要导入


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


## 打印单张图片
 - printSingleBitmap()
   - 参数:
      - dynamic img -> 图片路径url或者图片二进制流。
      - IminPictureStyle pictureStyle -> 图片样式相关设置（可选）。

IminPictureStyle 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | width | 图片的宽度 | int  | 无 |
  | height | 图片的高度 | int| 无 |
  | alignment | 打印的图片对齐方式 | enum IminPrintAlign { left, center, right }  | 无 |


```dart
  enum IminPrintAlign { left, center, right }
```

示例:
```dart
import 'package:imin_printer/imin_style.dart'; ///如果传递图片样式设置项需要导入
import 'package:imin_printer/enums.dart';  ///如果传递图片样式设置项需要导入

/// 简单使用
iminPrinter.printSingleBitmap(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]));

/// 传递图片使用图片二进制流并设置图片样式
iminPrinter.printSingleBitmap(
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0])
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// 传递图片使用url地址并设置图片样式
iminPrinter.printSingleBitmap(
    'https://www.example.com/image.jpg',
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```


## 打印多张图片
 - printMultiBitmap()
   - 参数:
      - List<dynamic> img -> 图片路径url数组或者图片二进制流数组。
      - IminPictureStyle pictureStyle -> 图片样式相关设置（可选）。

IminPictureStyle 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | width | 图片的宽度 | int  | 无 |
  | height | 图片的高度 | int| 无 |
  | alignment | 打印的图片对齐方式 | enum IminPrintAlign { left, center, right }  | 无 |

```dart
  enum IminPrintAlign { left, center, right }
```

示例:
```dart
import 'package:imin_printer/imin_style.dart'; ///如果传递图片样式设置项需要导入
import 'package:imin_printer/enums.dart';  ///如果传递图片样式设置项需要导入

/// 简单使用

iminPrinter.printMultiBitmap([Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00]]);

/// 传递图片使用图片二进制流并设置图片样式
iminPrinter.printMultiBitmap(
   [Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]), Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00])],
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// 传递图片使用url地址并设置图片样式
iminPrinter.printSingleBitmap(
    ['https://www.example.com/image.jpg', 'https://www.example.com/image.jpg'],
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```


## 打印单个反白图片
 - printSingleBitmapBlackWhite
    - 参数:
      - dynamic img -> 图片路径url或者图片二进制流。
      - IminBaseStyle baseStyle -> 图片样式相关设置（可选）。

IminBaseStyle 相关API:

| 属性 | 说明 | 类型 | 默认值  |
| ---- | ----| ----| ---- |
| width | 图片的宽度 | int  | 无 |
| height | 图片的高度 | int| 无 |

示例:
```dart

/// 传递图片使用图片二进制流
iminPrinter.printSingleBitmapBlackWhite(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]))

/// 传递图片使用url地址并设置图片样式
iminPrinter.printSingleBitmapBlackWhite('https://www.example.com/image.jpg',
     pictureStyle: IminBaseStyle(
        width: 250,
        height: 50,
      ));

```

## 设置二维码大小
 - setQrCodeSize
    - 参数:
      - int size -> 二维码大小。

示例:
```dart
iminPrinter.setQrCodeSize(5); // 设置二维码大小为5。
```

## 设置二维码和条形码左边距
  - setLeftMargin
    - 参数:
      - int  margin -> 左边距。

示例:
```dart
iminPrinter.setLeftMargin(5); // 设置左边距为5。
```

## 设置二维码的纠错级别
 - setQrCodeErrorCorrectionLev
    - 参数:
      -  IminQrcodeCorrectionLevel level -> 纠错级别。

```dart
  enum IminQrcodeCorrectionLevel {
    levelL(48),
    levelM(49),
    levelQ(50),
    levelH(51);
  }
```

示例:
```dart
import 'package:imin_printer/enums.dart';  ///需要导入


iminPrinter.IminQrcodeCorrectionLevel(IminQrcodeCorrectionLevel.levelL); 

```

## 打印二维码
 - printQrCode
    - 参数:
      - String content -> 二维码内容。
      - IminQrCodeStyle qrCodeStyle -> 二维码样式相关（可选）

IminQrCodeStyle 二维码样式相关API:

  | 属性 | 描述 | 类型 | 默认值 |
  | --- | --- | --- | --- |
  | qrSize | 二维码大小 | int | 无 |
  | align  | 二维码对齐方式 | enum IminPrintAlign { left, center, right } | 无 |
  | leftMargin | 二维码左边距 | int | 无 |
  | errorCorrectionLevel | 纠错级别 | enum IminQrcodeCorrectionLevel { levelL(48), levelM(49), levelQ(50), levelH(51)} | 无 |

```dart
enum IminPrintAlign { left, center, right }

enum IminQrcodeCorrectionLevel {
  levelL(48),
  levelM(49),
  levelQ(50),
  levelH(51);
}
```

示例:
```dart
import 'package:imin_printer/enums.dart';  ///需要导入

  iminPrinter.printQrCode('https://www.baidu.com', 
  IminQrCodeStyle(
    qrSize: 4,  
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
    leftMargin: 2,
     align: IminPrintAlign.left 
  ));
```

## 设置双二维码大小
 - setDoubleQRSize
   - 参数:
      - int qrSize -> 二维码大小。

示例:
```dart
iminPrinter.setDoubleQRSize(4);
```

## 设置双二维码(QR1)误差
  - setDoubleQR1Level()
     - 参数:
        - int  level -> 误差大小 取值范围:1-3。

示例:
```dart
iminPrinter.setDoubleQR1Level(2);
```

## 设置双二维码(QR2)误差
  - setDoubleQR2Level()
     - 参数:
        - int  level -> 误差大小 取值范围:1-3。

示例:
```dart
iminPrinter.setDoubleQR2Level(2);
``` 

## 设置双二维码(QR1) 左边距
  - setDoubleQR1MarginLeft()
     - 参数:
        - int  leftMargin -> 左边距 取值范围:0-576。

示例:
```dart
iminPrinter.setDoubleQR1MarginLeft(2);
```

## 设置双二维码(QR2) 左边距
  - setDoubleQR2MarginLeft()
     - 参数:
        - int  leftMargin -> 左边距 取值范围:0-576。
   
示例:
```dart
iminPrinter.setDoubleQR2MarginLeft(2);
```

## 设置双二维码(QR1)版本
  - setDoubleQR1Version()
     - 参数:
        - int  version -> 版本 取值范围:1-40。

示例:
```dart
iminPrinter.setDoubleQR1Version(2);
```

## 设置双二维码(QR2)版本
  - setDoubleQR2Version()
     - 参数:
        - int  version -> 版本 取值范围:1-40。

示例:
```dart
iminPrinter.setDoubleQR2Version(2); 
```

## 打印双二维码
 - printDoubleQR()
   - 参数:
      - IminDoubleQRCodeStyle qr1 -> 第一个二维码设置。
      - IminDoubleQRCodeStyle qr2 -> 第二个二维码设置。
      - int doubleQRSize -> 双二维码大小(可选)

IminDoubleQRCodeStyle 二维码设置相关API:
  
  | 属性 | 描述 | 类型 | 默认值 |
  | --- | --- | --- | --- |
  | text | 二维码内容 | String | - |
  | level | 二维码误差等级（可选） | int | - |
  | leftMargin | 二维码左边距（可选） | int | - |
  | version | 二维码版本（可选） | int | - |

示例:

```dart
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';  ///需要导入

iminPrinter.printDoubleQR( qrCode1: IminDoubleQRCodeStyle(
            text: 'www.imin.sg',
          ),
          qrCode2: IminDoubleQRCodeStyle(
            text: 'www.google.com',
          ),
          doubleQRSize: 5)
```


## 设置条形码宽度
  - setBarCodeWidth()
     - 参数:
        - int  width -> 条形码宽度 取值范围:2-6。
      
示例:
```dart
iminPrinter.setBarCodeWidth(2);
```

## 设置条形码高度
  - setBarCodeHeight()
     - 参数:
        - int  height -> 条形码高度 取值范围:1-255。

示例:
```dart
iminPrinter.setBarCodeHeight(2);
```

## 打印条形时HRI字符的打印位置
   - setBarCodeContentPrintPos()
      - 参数:
         - IminBarcodeTextPos position -> 条形码内容打印位置。

```dart
enum IminBarcodeTextPos {
  noText(0),
  textAbove(1),
  textBelow(2),
  both(3);
}
```

示例:
```dart
import 'package:imin_printer/enums.dart';

  iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove);
```

## 打印条形码
  - printBarCode()
    - 参数:
       - IminBarcodeType barCodeType -> 条形码类型。
       - String barCodeContent -> 条形码内容。
       - IminBarCodeStyle style -> 条形码样式相关设置项（可选）。
  
IminBarCodeStyle 相关API:
  | 属性 | 描述 | 类型 | 默认值 |
  | --- | --- | --- | --- |
  | width | 条形码宽度 | int | 无 |
  | height | 条形码高度 | int | 无 |
  | position | 条形码内容打印位置 | IminBarcodeTextPos | 无 |
  | align | 条形码对齐方式 | IminPrintAlign | 无 |


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

示例:
```dart
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/enums.dart';

  /// 简单使用
   iminPrinter.printBarCode(IminBarcodeType.jan13, "0123456789012",);

  /// 设置条形码样式
     iminPrinter.printBarCode(
          IminBarcodeType.jan13, "0123456789012",
          style: IminBarCodeStyle(
               width: 150,
               height: 50,
              align: IminPrintAlign.center,
              position: IminBarcodeTextPos.textAbove));
```


## 打印条形码设置格式
   - printBarCodeToBitmapFormat()
       - 参数:
          - String barCodeContent -> 条形码内容。
          - int width -> 条形码宽度。
          - int height -> 条形码高度。
          - IminBarCodeToBitmapFormat codeFormat -> 条形码格式。

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

示例:
```dart
import 'package:imin_printer/enums.dart';

 iminPrinter.printBarCodeToBitmapFormat( "0123456789012", 100, 50, IminBarCodeToBitmapFormat.code39);

```


## 打开钱箱
  - openCashBox()
     - 无参数:

```dart
  iminPrinter.openCashBox();
```

## 复位打印机
  - resetDevice()
    -  无参数:

```dart
  iminPrinter.resetDevice();
```

## 设置初始化打印机
  - setInitIminPrinter
      - 参数:
         - bool isDefault -> 是否默认设置。

```dart
  iminPrinter.setInitIminPrinter(true);
```

## 开启调试日志
  - openLogs
     - 参数:
         - int 0 or 1 -> 是否开启。

```dart
   iminPrinter.openLogs(1);
```

## 发送原始数据字符串
  - sendRAWDataHexStr
   - 参数: 
   - String bytes -> byte字符串。


```dart
   iminPrinter.sendRAWDataHexStr('0A');
```