# iMin内部打印机flutter提供的相关方法

## 初始化iMin内部打印机
 - initPrinter()
    - 无参数
    
```dart
  iminPrinter.initPrinter();
```

## 获取打印机状态
 - getPrinterStatus()
    - 无参数

```dart
  iminPrinter.getPrinterStatus().then((value){
    // 打印机状态
    print(state['msg']);    
  });   
```

## 打印表格 (宽度数值的方式)
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

## 打印表格 (宽度权重比例)
  - printColumnsString()
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

## 打印文字图片
   - printTextBitmap()
     - 参数:
       - String text -> 打印文字
       - IminTextPictureStyle style -> 打印文字图片相关设置项（可选）

IminTextPictureStyle 相关API:

  | 属性 | 说明 | 类型 | 默认值  |
  | ---- | ---- | ---- | ---- |
  | wordWrap | 打印文字内容是否加入`\n`, `true`或者不设置自动加`\n`, 为`false`不加`\n` | bool  | 无 |
  | fontSize | 打印文字大小 | int | 无 |
  | typeface | 打印文字字体 | IminTypeface  | 无 |
  | letterSpacing | 打印文字间距 取值：1-60|  double | 无 |
  | underline | 打印文字下划线 | bool | 无 |
  | throughline | 打印文字删除线 | bool | 无 |
  | lineHeight | 打印文字行高 取值：1-255 | double | 无 |
  | reverseWhite | 打印文字是否反白 | bool | 无 |
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
iminPrinter.printTextBitmap("Hello World");

///设置打印文字图片相关设置项
iminPrinter.printTextBitmap("Hello World", IminTextPictureStyle(
  fontSize: 20,
  letterSpacing: 1,
  typeface: IminTypeface.typefaceDefaultBold,
  fontStyle: IminFontStyle.boldItalic,
  align: IminPrintAlign.center
));

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

## 切刀（切纸部分切）
此方法只适用于带`切刀功能`的iMin（一敏）设备。
 - partialCut() 
   - 无参数

示例:
```dart
  iminPrinter.partialCut();
```

## 切刀（切纸全切）
 此方法只适用于带`切刀功能`的iMin（一敏）设备。
 - fullCut() 
      - 无参数

示例:
```dart
  iminPrinter.fullCut();
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
iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove);
```

## 设置纸张规格
  - setPageFormat()
    - 参数:
      - int style -> 纸张规格  0-80mm 1-58mm;

示例:
```dart
  iminPrinter.setPageFormat(1);
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

## 打开钱箱
  - openCashBox()
     - 无参数:

示例:  
```dart
  iminPrinter.openCashBox();
```

## 解绑打印服务
  - unBindService()
     - 无参数:

示例:  
```dart
  iminPrinter.unBindService();
```

## 重置打印机参数
   - initPrinterParams()
    - 无参数:

示例:  
```dart
  iminPrinter.initPrinterParams();
```

## 获取打印机版序列号
   - getPrinterSerialNumber()
      - 无参数:

示例:  
```dart
  iminPrinter.getPrinterSerialNumber().then((value){
    // 打印机版序列号
    print(value);    
  });
```

## 获取打印机型号
  - getPrinterModelName  
    - 无参数:

示例:  
```dart
  iminPrinter.getPrinterModelName().then((value){
    // 打印机型号
    print(value);    
  });
```

## 获取打印机热敏头型号
  - getPrinterThermalHead()
    - 无参数:

示例:  
```dart
  iminPrinter.getPrinterThermalHead().then((value){
    // 打印机热敏头型号
    print(value);    
  });
```

##  获取打印机固件版本号
  - getPrinterFirmwareVersion()
     - 无参数:

示例:  
```dart
  iminPrinter.getPrinterFirmwareVersion().then((value){
   // 打印机固件版本号
    print(value); 
  })
```

## 获取打印服务版本号
   - getServiceVersion()
       - 无参数:

示例:  
```dart
  iminPrinter.getServiceVersion().then((value){
   // 打印服务版本号
    print(value); 
  })
```

##  获取打印机硬件版本号
   -  getPrinterHardwareVersion()
      - 无参数:

示例:  
```dart
  iminPrinter.getPrinterHardwareVersion().then((value){
   // 打印机硬件版本号
    print(value); 
  })
```


## 获取 USB 连接的 pid vid
   - getUsbPrinterVidPid()
      - 无参数:

示例:  
```dart
  iminPrinter.getUsbPrinterVidPid().then((value){
   // USB 连接的 pid vid
    print(value); 
  });
```

## 获取连接的 USB Devices 的名称
   - getUsbDevicesName()
     -  无参数:

示例:  
```dart
  iminPrinter.getUsbDevicesName().then((value){
   // 连接的 USB Devices 的名称
    print(value); 
  });
```

## 获取打印浓度
   - getPrinterDensity()
      - 无参数:

示例:  
```dart
  iminPrinter.getPrinterDensity().then((value){
   // 打印浓度
    print(value); 
  });
```

## 获取打印长度
   - getPrinterPaperDistance()
      - 无参数:

示例:  
```dart
  iminPrinter.getPrinterPaperDistance().then((value){
   // 打印长度
    print(value); 
  });
```

## 获取当前打印机速度
     - getPrinterSpeed()
         - 无参数:

示例:  
```dart
  iminPrinter.getPrinterSpeed().then((value){
   // 当前打印机速度
    print(value); 
  });
```

## 获取当前打印机设定的纸张规格
   - getPrinterPaperType()
       - 无参数:


示例:  
```dart
  iminPrinter.getPrinterPaperType().then((value){
   // 当前打印机设定的纸张规格
    print(value); 
  });
```

## 获取切刀次数
   - getPrinterCutTimes()
       - 无参数:
  

示例:  
```dart
  iminPrinter.getPrinterCutTimes().then((value){
   // 获取切刀次数
    print(value); 
  });
```

## 获取当前打印机模式
   - getPrinterMode()
      - 无参数:
  
示例:  
```dart
  iminPrinter.getPrinterMode().then((value){
   // 当前打印机模式
    print(value); 
  });
```

## 获取钱箱状态
   - getDrawerStatus()
        - 无参数:

示例:  
```dart
  iminPrinter.getDrawerStatus().then((value){
   // 钱箱状态
    print(value); 
  });
```

##  获取钱箱打开的次数
   - getOpenDrawerTimes()
      - 无参数:

示例:  
```dart
  iminPrinter.getOpenDrawerTimes().then((value){
   // 钱箱打开的次数
    print(value); 
  });
```


## 打印自检页
  - printerSelfChecking()
     -  无参数:

示例:  
```dart
  iminPrinter.printerSelfChecking();
```

##  ESC/POS 指令打印
  -  sendRAWData()
     - Uint8List bytes -> 打印数据:


示例:  
```dart
  iminPrinter.sendRAWData(bytes);
```

## 设置打印全局对齐方式
  - setCodeAlignment()
     -  IminPrintAlign alignment -> 打印对齐方式:

```dart
enum IminPrintAlign { left, center, right }
```

示例：

```dart
import 'package:imin_printer/enums.dart'; /// 必须导入

  iminPrinter.setCodeAlignment(IminPrintAlign.left)
```

## 设置打印的字体
  - setTextBitmapTypeface()
    - IminTypeface typeface -> 字体类型:


```dart
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}
```

示例：
```dart
import 'package:imin_printer/enums.dart'; /// 必须导入

  iminPrinter.setTextBitmapTypeface(IminTypeface.typefaceDefault)
```

## 设置文本图片打印字体大小
   - setTextBitmapSize()
      - int size -> 字体大小:

示例：
```dart
  iminPrinter.setTextBitmapSize(16)
```

## 设置文本图片打印字体样式
   - setTextBitmapStyle()
      - 参数：
         - IminFontStyle style -> 文本图片打印字体样式:
  
```dart
enum IminFontStyle { normal, bold, italic, boldItalic }
```

示例:
```dart
import 'package:imin_printer/enums.dart'; /// 必须导入

  iminPrinter.setTextBitmapStyle(IminFontStyle.italic);
```

## 设置文本字体删除线
  - setTextBitmapStrikeThru()
      - 参数：
          - bool strikeThru -> 是否删除线:

示例:
```dart

  iminPrinter.setTextBitmapStrikeThru(true);
```

## 设置文本字体下划线
  - setTextBitmapUnderline()
     - 参数：
          - bool haveUnderline -> 是否下划线:
    
示例:
```dart
  iminPrinter.setTextBitmapUnderline(true);
```

## 设置文本字体的行高
  -  setTextBitmapLineSpacing()
     - 参数：
          -  double lineHeight  -> 行高:

示例:
```dart
  iminPrinter.setTextBitmapLineSpacing(1);
```

## 设置文本字体字间距
   - setTextBitmapLetterSpacing()
      - 参数：
          - double space  -> 间距:

示例:
```dart
  iminPrinter.setTextBitmapLetterSpacing(1);
```  

## 设置文本字体反白
   - setTextBitmapAntiWhite()
      - 参数：
        - bool antiWhite -> 是否反白:


示例:
```dart
  iminPrinter.setTextBitmapAntiWhite(true);
```

## 图片单色处理并打印
   - printSingleBitmapColorChart()
      - 参数：
         -  dynamic img -> 图片路径url或者图片二进制流。
         -  IminPictureStyle pictureStyle -> 图片样式(可选)

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
iminPrinter.printSingleBitmapColorChart(Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0]));

/// 传递图片使用图片二进制流并设置图片样式
iminPrinter.printSingleBitmapColorChart(
    Uint8List.fromList([0x1B, 0x2A, 0x00, 0x00, 0x00, 0])
      pictureStyle: IminPictureStyle(
              alignment: IminPrintAlign.center,
          )
    )


/// 传递图片使用url地址并设置图片样式
iminPrinter.printSingleBitmapColorChart(
    'https://www.example.com/image.jpg',
     pictureStyle: IminPictureStyle(
        alignment: IminPrintAlign.center,
        width: 250,
        height: 50,
      ));
```

##  进入事务模式
   - enterPrinterBuffer()
     - 参数：
        - bool isClean -> 是否清空打印缓冲区

 示例:   
 ```dart
 iminPrinter.enterPrinterBuffer(true);
 ```   

##  提交事务
   - commitPrinterBuffer()
     - 无参数

 示例:   
 ```dart
 iminPrinter.commitPrinterBuffer();
 ```   

 ## 退出事务模式
  - exitPrinterBuffer()
      - 参数：
        - bool isCommit -> 是否清空打印缓冲区


 示例:   
 ```dart
 iminPrinter.exitPrinterBuffer();
 ```   

## 获取字体码页
   - getFontCodepage()
      -无参数


示例:   
 ```dart
 iminPrinter.getFontCodepage((value){
       print(value); /// 获取字体码页
   });
 ```   

## 设置字体码页
   - setFontCodepage()
      - 参数:
         - int codepage -> 字体码页

 示例:   
 ```dart
  iminPrinter.setFontCodepage(0);
 ```

## 获取当前字体码页
   - getCurCodepage()
       - 无参数

 示例:   
 ```dart
  iminPrinter.getCurCodepage((value){
       print(value); /// 当前字体码页
   });
 ```

 ## 获取编码列表
    - getEncodeList()
       - 无参数


 示例:   
 ```dart
   iminPrinter.getEncodeList((value){
       print(value); // 打印编码列表
   });
 ```
 ## 设置打印机编码
    - setPrinterEncode()
       - 无参数


 示例:   
 ```dart
   iminPrinter.setPrinterEncode(1);
 ```

 ## 获取当前编码
   - getCurEncode()
      - 无参数

 示例:   
 ```dart
   iminPrinter.getCurEncode((value){
       print(value); // 当前编码
   });
 ```

 ## 获取打印机打印浓度列表
   - getPrinterDensityList()
      - 无参数
      - 返回值：
        - List<String> -> 打印浓度列表

 示例:
 ```dart
  iminPrinter.getPrinterDensityList((value){
       print(value); // 打印机打印浓度列表
   });
```

## 获取打印机打印速度列表
   - getPrinterSpeedList()
      - 无参数
      - 返回值：
        - List<String> -> 打印速度列表

 示例:
 ```dart
  iminPrinter.getPrinterSpeedList((value){
       print(value); // 打印机打印速度列表
   });
```

## 设置打印机打印速度
   - setPrinterSpeed()
      - 参数:
         -  int speed -> 打印速度

 示例:
 ```dart
  iminPrinter.setPrinterSpeed(1);
```

## 获取打印机打印速度
   - getPrinterSpeed()
     - 无参数
     - 返回值：
        - int -> 打印速度

 示例:
 ```dart
  iminPrinter.getPrinterSpeed((value) {
     print(value); // 打印机打印速度
  });
```

## 获取打印机走纸类型列表
  - getPrinterPaperTypeList()
     - 无参数
     - 返回值：
        - List<String> ->走纸类型列表

 示例:
 ```dart
  iminPrinter.getPrinterPaperTypeList((value) {
     print(value); // 打印机走纸类型列表
  });
```



## 标签打印
## 画布设置
- labelInitCanvas
- 参数：
- LabelCanvasStyle labelCanvasStyle ->指定标签画布的位置  大小
- LabelCanvasStyle 相关API:
- | 属性 | 描述 | 参数说明 | 默认值 |
  | --- | --- | --- | --- |
  | width | 预渲染的画布宽度 | 可设置大小不超过打印纸宽度 | 50 |
  | height | 预渲染的画布高度 | 可设置大小不超过打印纸高度 | 30 |
  | posX | 画布相对标签的起始横坐标 | 单位像素 | 0 |
  | posY | 画布相对标签的起始纵坐标 | 单位像素 | 0 |

```dart
LabelCanvasStyle labelCanvasStyle = LabelCanvasStyle(width: 40 * 8,
height: 30 * 8,);
// 调用 labelInitCanvas 方法
await iminPrinter.labelInitCanvas(labelCanvasStyle: labelCanvasStyle);
```
## 绘制文本内容
- labelAddText
- 参数：
- String text ->指定区域绘制的打印内容
- LabelTextStyle labelTextStyle -> 绘制内容指令内容的属性
- LabelTextStyle 相关API:
-    |可用方法|	方法说明	|参数说明|	默认值|
     | --- | --- | --- | --- |
     |posX	|设置文本内容在画布起始横坐标位置	|单位像素|	0|
     |posY	|设置文本内容在画布起始纵坐标位置|	单位像素	|0|
     |textSize	|指定文本字符大小	|有效范围6~96像素	|24|
     |textWidthRatio	|指定倍宽大小	|有效范围0-9|	0|
     |textHeightRatio	|指定倍高大小	|有效范围0-9	|0|
     |width	|设置文本限制宽度|	若设置宽度限制，超过宽度将自动换行|	不限制（-1）|
     |height	|设置文本限制高度|	若设置高度限制，超过部分将不显示	|不限制（-1）|
     |align	|设置文本内容相对起始坐标的位置|	见Align	|Align.DEFAUL|
     |rotate	|设置文本内容的方向	|见Rotate	|水平方向|
     |textSpace	|设置文本字间距	|0~100像素	|0|
     |enableBold	|设置文本加粗	|开启文本加粗功能	|不开启|
     |enableUnderline	|设置文本下划线|	开启文本下划线功能	|不开启|
     |enableStrikethrough	|设置文本删除线	|开启文本删除线功能	|不开启|
     |enableItalics	|设置文本斜体|	开启文本斜体功能	|不开启|
     |enAntiColor	|设置文本反白	|开启文本反白功能	|不开启|



```dart
LabelTextStyle labelTextStyle = LabelTextStyle(
                    posX: 0,
                    posY: 60,
                    align: AlignLabel.CENTER,
                    enableBold: true,
                    textSize: 30,
                  );
                  // // 
                  await iminPrinter.labelAddText("iMin Label Printer",labelTextStyle: labelTextStyle);
```
## 绘制条形码内容
- labelAddBarCode
- 参数：
- String barCode -> 条形码内容
- LabelBarCodeStyle barCodeStyle -> 条形码内容相关指定属性
- LabelBarCodeStyle 相关api
- | 可用方法       |	方法说明|	参数说明	|默认值|
  |------------| --- | --- | --- |
  | posX       |	设置条码内容在画布起始横坐标位置	|单位像素|	0|
  | posY       |	设置条码内容在画布起始纵坐标位置|	单位像素|	0|
  | dotWidth   |	设置码块宽度|	1~16像素| 将影响最终条码的总宽度   |	2|
  | barHeight	 |设置条码高度	|1~255像素| 将影响最终条码的总高度   |	162|
  | readable	  |设置HRI位置	|见HumanReadable|	不展示|
  | symbology	 |设置条码类型	|见Symbology|	code128|
  | align	     |设置条码相对起始坐标位置|	见Align|	Align.DEFAUL|
  | rotate     |	设置条码旋转方向	|见Rotate	|水平方向|
  | width	     |指定条码缩放宽度	|当设置缩放宽度后将强制改变码内容大小	|不缩放|
  | height     |	指定条码缩放高度	|当设置缩放宽度后将强制改变码内容大小	|不缩放|

```dart
 // 创建一个 LabelCanvasStyle 对象
                  LabelBarCodeStyle barCodeStyle = LabelBarCodeStyle(
                    posX: 30,
                    posY: 370,
                    align: AlignLabel.CENTER,
                    symbology: Symbology.CODABAR,
                    dotWidth: 2,
                    barHeight: 60,
                    readable: HumanReadable.POS_TWO,
                  );
                  // // 
                  await iminPrinter.labelAddBarCode("123456",barCodeStyle: barCodeStyle);
```
## 绘制二维码内容
- labelAddQrCode
- 参数：
- String qrCode -> 打印的二维码内容
- LabelQrCodeStyle qrCodeStyle -> 二维码配置的相关属性
- LabelQrCodeStyle 相关api说明

  | 可用方法	       |方法说明	| 参数说明	 | 默认值 |
  |-------------| --- |-------|-----|
  | posX	       |设置二维码内容在画布起始横坐标位置	|单位像素	|0|
  | posY	       |设置二维码内容在画布起始纵坐标位置	|单位像素|	0|
  | size	       |设置二维码块大小	|1~16像素|最终将影响二维码大小 |	4|
  | errorLevel	 | 设置二维码纠错等级	|见ErrorLevel|	ErrorLevel.L|
  | rotate	     |设置二维码旋转方向	|见Rotate|	水平方向|
  | width	      |指定二维码缩放宽度	|当设置缩放宽度后将强制改变码内容大小|	不缩放|
  | height	     |指定二维码缩放高度|	当设置缩放宽度后将强制改变码内容大小	|不缩放|

```dart
LabelQrCodeStyle qrCodeStyle = LabelQrCodeStyle(
                    posX: 290,
                    posY: 145,
                    size: 3,
                    errorLevel: ErrorLevel.H,
                  );
                  // // 
                  await iminPrinter.labelAddQrCode("12345658哈哈",qrCodeStyle: qrCodeStyle);
```
## 绘制特殊图形
- labelAddArea
- 参数：
- LabelAreaStyle areaStyle -> 图形相关配置属性
- | 可用方法    |	方法说明|	参数说明|	默认值|
  |---------| --- |-------|-----|
  | style   |	设置绘制形状|	见Shape	|Shape.RECT_FILL|
  | width	  |设置图形的宽度| 形状为线段时无效形状为圆形时表示圆形直径	|单位像素	|50|
  | height	 |设置图形的高度| 形状为线段时无效 |	单位像素|	50|
  | posX	   |设置起始x坐标	|单位像素|	0|
  | posY	   |设置起始y坐标|	单位像素|	0|
  | endX	   |设置线段的终点x坐标	|单位像素|	50|
  | endY	   |设置线段的终点y坐标|	单位像素|	50|
  | thick	  |设置描边|	描边宽度|	1|

```dart
LabelAreaStyle printBitmapStyle = LabelAreaStyle(
                    style: Shape.PATH,
                    posX: 1,
                    posY: 40,
                    endX: 50 * 8 - 1,
                    endY: 60,
                    thick: 2,
                  );
                  // // 
                  await iminPrinter.labelAddArea(areaStyle: printBitmapStyle);
```
## 绘制图像
- labelAddBitmap
- 参数：
- dynamic img -> 图片路径url或者图片二进制流
- LabelBitmapStyle addBitmapStyle -> 图像相关配置属性

- | 可用方法	     |方法说明	|参数说明	|默认值|
  |-----------| --- |-------|-----|
  | posX	     |设置图片在画布起始横坐标位置|	超出画布大小将不打印|	0|
  | posY      |	设置图片在画布起始纵坐标位置|	超出画布大小将不打印|	0|
  | algorithm |	设置图片转换方式|	见ImageAlgorithm	|ImageAlgorithm.BINARIZATION|
  | value	    |设置算法浮动值	|根据具体的算法浮动值不同|	见ImageAlgorithm|
  | width	    |指定图片缩放宽度	|当设置缩放宽度后将强制改变图片大小|	不缩放|
  | height    |	指定图片缩放高度	|当设置缩放宽度后将强制改变图片大小|	不缩放|

```dart
LabelBitmapStyle addBitmapStyle = LabelBitmapStyle(

                    posX: 290,
                    posY: 30,
                    width: 80,
                    height: 80,

                  );
                  // // 
                  await iminPrinter.labelAddBitmap('https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',addBitmapStyle: addBitmapStyle);

```

## 打印绘制的内容
- labelPrintCanvas
- 参数：
- int printCount -> 欲打印的次数，如果是标签打印机，将分别打印到每张标签上, 打印数量大于0张
- 打印结果返回
```dart
 await iminPrinter.labelPrintCanvas(1);
```
## 打印标签图片
- printLabelBitmap
- 参数：
- dynamic img -> 图片路径url或者图片二进制流
- LabelPrintBitmapStyle addBitmapStyle -> 图像相关配置属性

- |可用方法	|方法说明	|参数说明	|默认值|
  | --- | --- |-------|-----|
  |width	|指定图片缩放宽度	|当设置缩放宽度后将强制改变图片大小|	不缩放|
  |height|	指定图片缩放高度	|当设置缩放宽度后将强制改变图片大小|	不缩放|
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