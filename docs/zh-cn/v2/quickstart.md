# 快速开始 - SDK 2.0

> **适用版本**：Android 13 及以上  
> **SDK 版本**：2.0.0

本指南将帮助您快速上手 iMin 打印机 SDK 2.0。

---

## 前置要求

- Flutter SDK 3.3.0 或更高版本
- Dart SDK 3.0.6 或更高版本
- iMin 设备（Android 13+）
- 内置热敏打印机

---

## 安装

### 方法一：使用命令行

```bash
flutter pub add imin_printer
```

### 方法二：手动添加依赖

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  imin_printer: ^0.7.1
```

然后运行：

```bash
flutter pub get
```

---

## 基础使用

### 1. 导入包

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';
```

### 2. 创建打印机实例

```dart
final iminPrinter = IminPrinter();
```

### 3. 初始化打印机

```dart
await iminPrinter.initPrinter();
```

### 4. 检查打印机状态

```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] == '0') {
  print('打印机就绪');
} else {
  print('打印机异常: ${status['msg']}');
}
```

### 5. 打印文本

```dart
await iminPrinter.printText('Hello World');
```

---

## 完整示例

创建一个简单的打印应用：

```dart
import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMin 打印机示例',
      home: const PrinterDemo(),
    );
  }
}

class PrinterDemo extends StatefulWidget {
  const PrinterDemo({super.key});

  @override
  State<PrinterDemo> createState() => _PrinterDemoState();
}

class _PrinterDemoState extends State<PrinterDemo> {
  final iminPrinter = IminPrinter();
  String _status = '未初始化';

  @override
  void initState() {
    super.initState();
    _initPrinter();
  }

  // 初始化打印机
  Future<void> _initPrinter() async {
    try {
      await iminPrinter.initPrinter();
      
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      setState(() {
        _status = status['code'] == '0' ? '就绪' : '异常: ${status['msg']}';
      });
    } catch (e) {
      setState(() {
        _status = '错误: $e';
      });
    }
  }

  // 打印测试内容
  Future<void> _printTest() async {
    try {
      // 检查状态
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      if (status['code'] != '0') {
        _showMessage('打印机未就绪: ${status['msg']}');
        return;
      }

      // 打印标题
      await iminPrinter.printText(
        '测试打印',
        style: IminTextStyle(
          fontSize: 32,
          fontStyle: IminFontStyle.bold,
          align: IminPrintAlign.center,
        ),
      );

      // 打印内容
      await iminPrinter.printText('这是一条测试消息');
      await iminPrinter.printText('打印时间: ${DateTime.now()}');

      // 打印二维码
      await iminPrinter.printQrCode(
        'https://www.imin.sg',
        qrCodeStyle: IminQrCodeStyle(
          qrSize: 6,
          align: IminPrintAlign.center,
        ),
      );

      // 走纸并切纸
      await iminPrinter.printAndFeedPaper(100);
      await iminPrinter.partialCut();

      _showMessage('打印成功！');
    } catch (e) {
      _showMessage('打印失败: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iMin 打印机示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '打印机状态: $_status',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _printTest,
              child: const Text('测试打印'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 常用功能示例

### 打印文本

```dart
// 简单文本
await iminPrinter.printText('Hello World');

// 带样式的文本
await iminPrinter.printText(
  '欢迎光临',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

### 打印图片

```dart
// 打印网络图片
await iminPrinter.printSingleBitmap(
  'https://example.com/logo.png',
  pictureStyle: IminPictureStyle(
    width: 250,
    height: 80,
    alignment: IminPrintAlign.center,
  ),
);
```

### 打印二维码

```dart
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
  ),
);
```

### 打印条码

```dart
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '1234567890',
  style: IminBarCodeStyle(
    width: 2,
    height: 100,
    align: IminPrintAlign.center,
    position: IminBarcodeTextPos.textBelow,
  ),
);
```

### 打印表格

```dart
import 'package:imin_printer/column_maker.dart';

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(
    text: '商品',
    width: 150,
    fontSize: 24,
    align: IminPrintAlign.left,
  ),
  ColumnMaker(
    text: '价格',
    width: 100,
    fontSize: 24,
    align: IminPrintAlign.right,
  ),
]);
```

---

## 错误处理

始终使用 try-catch 包裹打印操作：

```dart
try {
  // 检查状态
  Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
  if (status['code'] != '0') {
    throw Exception('打印机未就绪: ${status['msg']}');
  }

  // 执行打印
  await iminPrinter.printText('测试');
  
} catch (e) {
  print('打印错误: $e');
  // 处理错误
}
```

---

## 下一步

- 📖 查看 [完整 API 文档](api.md)
- 💡 学习 [标签打印](api.md#标签打印)
- 🔧 了解 [事务打印](api.md#事务打印)
- 📋 查看 [完整示例代码](api.md#完整示例)

---

## 常见问题

### 如何判断使用哪个 SDK 版本？

```dart
String? version = await iminPrinter.getSdkVersion();
print('SDK 版本: $version'); // "2.0.0" 或 "1.0.0"
```

### 打印机无响应怎么办？

1. 检查打印机状态
2. 尝试重新初始化
3. 检查设备连接

```dart
await iminPrinter.resetDevice();
await iminPrinter.initPrinter();
```

### 如何提高打印效率？

使用事务打印批量提交：

```dart
await iminPrinter.enterPrinterBuffer(true);
// 添加多个打印命令
await iminPrinter.printText('行1');
await iminPrinter.printText('行2');
await iminPrinter.commitPrinterBuffer();
await iminPrinter.exitPrinterBuffer(true);
```

---

## 支持

- 📚 [完整文档](https://iminsoftware.github.io/imin_printer/)
- 🐛 [问题反馈](https://github.com/iminsoftware/imin_printer/issues)
- 📧 [iMin 官方文档](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
