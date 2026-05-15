# iMin Printer Flutter 插件

> 🌐 Language / 语言: [English](README.md) | **中文**

iMin 内置热敏打印�?Flutter 插件，支持文本、图片、条码、QR 码、标签打印等功能�?

## 设备信息

| 纸宽 | 可打印像素宽�?| 有切刀 |
|------|--------------|--------|
| 80mm | 576px | �?部分型号 |
| 58mm | 384px | �?|

| SDK 版本 | Android 版本 | 说明 |
|---------|-------------|------|
| SDK 2.0 | Android 13+ | 完整功能，推荐新项目使用 |
| SDK 1.0 | Android 11 及以�?| 基础打印功能 |

## 安装

```yaml
dependencies:
  imin_printer: ^0.7.5
```

```bash
flutter pub get
```

## 快速开�?

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';

final iminPrinter = IminPrinter();

// 1. 初始�?
await iminPrinter.initPrinter();

// 2. 检查状�?
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] != '0') {
  print('打印机异�? ${status['msg']}');
  return;
}

// 3. 打印
await iminPrinter.printText('Hello World',
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// 4. 走纸
await iminPrinter.printAndLineFeed();
```

## 小票打印示例

```dart
Future<void> printReceipt() async {
  final printer = IminPrinter();
  await printer.initPrinter();

  await printer.printText('COFFEE SHOP',
    style: IminTextStyle(fontSize: 32, fontStyle: IminFontStyle.bold, align: IminPrintAlign.center),
  );
  await printer.printText('123 Main Street',
    style: IminTextStyle(fontSize: 24, align: IminPrintAlign.center),
  );
  await printer.printAndLineFeed();
  await printer.printText('--------------------------------');
  await printer.printAndLineFeed();

  // width 是像素宽度，80mm 纸总宽 576px
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'Coffee', width: 200, fontSize: 24, align: IminPrintAlign.left),
    ColumnMaker(text: 'x2',     width: 100, fontSize: 24, align: IminPrintAlign.center),
    ColumnMaker(text: '\$7.00', width: 150, fontSize: 24, align: IminPrintAlign.right),
  ]);
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'Muffin', width: 200, fontSize: 24, align: IminPrintAlign.left),
    ColumnMaker(text: 'x1',     width: 100, fontSize: 24, align: IminPrintAlign.center),
    ColumnMaker(text: '\$2.50', width: 150, fontSize: 24, align: IminPrintAlign.right),
  ]);

  await printer.printText('--------------------------------');
  await printer.printColumnsText(cols: [
    ColumnMaker(text: 'TOTAL',  width: 300, fontSize: 28, align: IminPrintAlign.left),
    ColumnMaker(text: '\$9.50', width: 150, fontSize: 28, align: IminPrintAlign.right),
  ]);
  await printer.printAndLineFeed();

  await printer.printQrCode('receipt-12345',
    qrCodeStyle: IminQrCodeStyle(qrSize: 5, align: IminPrintAlign.center),
  );
  await printer.printAndLineFeed();
  await printer.printText('Thank you!',
    style: IminTextStyle(fontSize: 24, align: IminPrintAlign.center),
  );
  await printer.partialCut();
}
```

## 错误处理

```dart
Future<void> safePrint() async {
  try {
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('打印机异�? ${status['msg']}');
    }
    await iminPrinter.printText('Hello World');
  } on PlatformException catch (e) {
    print('平台错误: ${e.message}');
  } catch (e) {
    print('打印错误: $e');
  }
}
```

## API 文档

完整方法参�?�?[api-zh.md](api-zh.md)

## 资源

- [Pub Package](https://pub.dev/packages/imin_printer)
- [GitHub Repository](https://github.com/iminsoftware/imin_printer)
- [iMin 官方打印 SDK 文档](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
