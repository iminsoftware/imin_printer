# iMin 打印机 SDK 2.0

> **适用于 Android 13 及以上版本的 iMin 设备**

欢迎使用 iMin 打印机 Flutter SDK 2.0！本 SDK 为 iMin 设备的内置热敏打印机提供完整的 Flutter 接口。

---

## ✨ 主要特性

### 🎯 核心功能
- ✅ 文本打印（多种字体、样式、对齐）
- ✅ 图片打印（URL、字节数组、透明背景）
- ✅ 二维码打印（单个、双二维码）
- ✅ 条码打印（9种标准格式）
- ✅ 表格打印（固定宽度、权重比例）

### 🏷️ 标签打印（SDK 2.0 新增）
- ✅ Canvas 画布模式
- ✅ 自由布局文本、条码、二维码
- ✅ 图形绘制（矩形、圆形、线条）
- ✅ 图片元素支持

### 🚀 高级功能
- ✅ 文本位图渲染
- ✅ 事务打印管理
- ✅ 打印机配置（密度、速度、编码）
- ✅ 钱箱控制
- ✅ 切纸功能（部分设备）

---

## 📦 安装

```bash
flutter pub add imin_printer
```

或在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  imin_printer: ^0.6.14
```

---

## 🚀 快速开始

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

final iminPrinter = IminPrinter();

// 初始化
await iminPrinter.initPrinter();

// 检查状态
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('状态: ${status['msg']}');

// 打印文本
await iminPrinter.printText(
  '欢迎光临',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// 打印二维码
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
  ),
);

// 切纸
await iminPrinter.partialCut();
```

---

## 📚 文档导航

### 入门指南
- [快速开始](quickstart.md) - 5分钟上手指南
- [API 文档](api.md) - 完整的 API 参考

### 功能模块
- [基础打印](api.md#文本打印) - 文本、样式、对齐
- [图片打印](api.md#图片打印) - 单张、多张、透明背景
- [二维码打印](api.md#二维码打印) - 单个、双二维码
- [条码打印](api.md#条码打印) - 9种标准格式
- [表格打印](api.md#表格打印) - 固定宽度、权重比例
- [标签打印](api.md#标签打印) - Canvas 画布模式
- [事务打印](api.md#事务打印) - 批量打印优化
- [打印机配置](api.md#打印机配置) - 密度、速度、编码
- [钱箱控制](api.md#钱箱控制) - 开启钱箱

---

## 💡 使用示例

### 打印小票

```dart
// 标题
await iminPrinter.printText(
  '某某商店',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// 商品列表
await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: '商品', width: 150, fontSize: 24),
  ColumnMaker(text: '价格', width: 100, fontSize: 24, align: IminPrintAlign.right),
]);

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: '苹果', width: 150, fontSize: 24),
  ColumnMaker(text: '¥10.00', width: 100, fontSize: 24, align: IminPrintAlign.right),
]);

// 二维码
await iminPrinter.printQrCode('ORDER-12345');

// 切纸
await iminPrinter.partialCut();
```

### 打印标签

```dart
// 初始化画布
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 400,
    height: 300,
  ),
);

// 添加文本
await iminPrinter.labelAddText(
  'Product Name',
  labelTextStyle: LabelTextStyle(
    posX: 20,
    posY: 20,
    textSize: 28,
    enableBold: true,
  ),
);

// 添加条码
await iminPrinter.labelAddBarCode(
  '1234567890',
  barCodeStyle: LabelBarCodeStyle(
    posX: 20,
    posY: 60,
    symbology: Symbology.CODE128,
  ),
);

// 打印标签
await iminPrinter.labelPrintCanvas(1);
```

---

## 🔧 SDK 版本对比

| 功能 | SDK 1.0 | SDK 2.0 |
|------|---------|---------|
| Android 版本 | 11 及以下 | 13 及以上 |
| 基础打印 | ✅ | ✅ |
| 图片打印 | ✅ | ✅ |
| 二维码/条码 | ✅ | ✅ |
| 标签打印 | ❌ | ✅ |
| 文本位图 | ❌ | ✅ |
| 事务打印 | ❌ | ✅ |
| 高级配置 | 部分 | 完整 |

---

## 📱 设备兼容性

### 支持的设备类型
- **手持金融系列** - 58mm 纸张宽度
- **平板终端系列** - 58mm 或 80mm 纸张宽度
- **台式收银机** - 80mm 纸张宽度

### 切刀功能
- ✅ 80mm 打印机通常带切刀
- ❌ 58mm 打印机通常不带切刀

---

## ⚠️ 注意事项

1. **SDK 版本检测**
   ```dart
   String? version = await iminPrinter.getSdkVersion();
   // "2.0.0" 表示 SDK 2.0
   // "1.0.0" 表示 SDK 1.0
   ```

2. **状态检查**
   打印前始终检查打印机状态：
   ```dart
   Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
   if (status['code'] != '0') {
     print('打印机异常: ${status['msg']}');
   }
   ```

3. **错误处理**
   使用 try-catch 包裹所有打印操作：
   ```dart
   try {
     await iminPrinter.printText('测试');
   } catch (e) {
     print('打印失败: $e');
   }
   ```

---

## 🆘 获取帮助

- 📖 [完整文档](https://iminsoftware.github.io/imin_printer/)
- 🐛 [问题反馈](https://github.com/iminsoftware/imin_printer/issues)
- 📦 [Pub.dev](https://pub.dev/packages/imin_printer)
- 📧 [iMin 官方文档](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

---

## 📄 许可证

本项目遵循 LICENSE 文件中指定的许可证条款。

---

**开始使用**: [快速开始指南](quickstart.md) | [API 文档](api.md)
