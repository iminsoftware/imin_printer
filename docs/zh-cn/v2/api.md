# iMin 打印机 SDK 2.0 API 文档

> **适用版本**：Android 13 及以上  
> **SDK 版本**：2.0.0  
> **Flutter 插件版本**：0.6.14+

## 📋 目录

- [基础操作](#基础操作)
- [打印机状态与信息](#打印机状态与信息)
- [文本打印](#文本打印)
- [图片打印](#图片打印)
- [二维码打印](#二维码打印)
- [条码打印](#条码打印)
- [表格打印](#表格打印)
- [标签打印](#标签打印)
- [事务打印](#事务打印)
- [打印机配置](#打印机配置)
- [钱箱控制](#钱箱控制)
- [高级功能](#高级功能)

---

## 基础操作

### 初始化打印机

在使用打印机之前，必须先初始化。

**方法：** `initPrinter()`

**参数：** 无

**返回值：** `Future<bool?>`

**示例：**
```dart
final iminPrinter = IminPrinter();
await iminPrinter.initPrinter();
```

---

### 获取 SDK 版本

获取当前使用的 SDK 版本号。

**方法：** `getSdkVersion()`

**参数：** 无

**返回值：** `Future<String?>` - 返回 "1.0.0" 或 "2.0.0"

**示例：**
```dart
String? version = await iminPrinter.getSdkVersion();
print('SDK 版本: $version');
```


### 初始化打印机参数

初始化打印机的默认参数设置。

**方法：** `initPrinterParams()`

**参数：** 无

**返回值：** `Future<void>`

**示例：**
```dart
await iminPrinter.initPrinterParams();
```

---

### 走纸

#### 走纸一行

**方法：** `printAndLineFeed()`

**参数：** 无

**示例：**
```dart
await iminPrinter.printAndLineFeed();
```

#### 走纸指定高度

**方法：** `printAndFeedPaper(int height)`

**参数：**
- `height` - 走纸高度，单位：像素，取值范围：1-1016

**示例：**
```dart
await iminPrinter.printAndFeedPaper(100);
```

---

### 切纸

> **注意**：仅适用于带切刀功能的 iMin 设备（通常是 80mm 打印机）

#### 部分切纸

**方法：** `partialCut()`

**参数：** 无

**示例：**
```dart
await iminPrinter.partialCut();
```

#### 完全切纸

**方法：** `fullCut()`

**参数：** 无

**示例：**
```dart
await iminPrinter.fullCut();
```

---

## 打印机状态与信息

### 获取打印机状态

检查打印机当前状态，用于判断打印机是否就绪。

**方法：** `getPrinterStatus()`

**参数：** 无

**返回值：** `Future<Map<String, dynamic>>`

**返回数据结构：**
```dart
{
  "code": "0",        // 状态码
  "msg": "正常"       // 状态描述
}
```

**状态码说明：**
| 状态码 | 说明 |
|--------|------|
| 0 | 打印机正常 |
| 1 | 打印机未连接或未开机 |
| 2 | 打印机与调用库不匹配 |
| 3 | 打印头打开 |
| 4 | 切刀未复位 |
| 5 | 过热 |
| 6 | 黑标错误 |
| 7 | 未进纸 |
| 8 | 缺纸 |
| 99 | 其他错误 |

**示例：**
```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
print('状态码: ${status['code']}');
print('状态信息: ${status['msg']}');

if (status['code'] == '0') {
  print('打印机就绪');
} else {
  print('打印机异常: ${status['msg']}');
}
```


### 获取打印机信息

#### 获取打印机序列号

**方法：** `getPrinterSerialNumber()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? serialNumber = await iminPrinter.getPrinterSerialNumber();
print('序列号: $serialNumber');
```

#### 获取打印机型号

**方法：** `getPrinterModelName()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? modelName = await iminPrinter.getPrinterModelName();
print('型号: $modelName');
```

#### 获取打印头型号

**方法：** `getPrinterThermalHead()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? thermalHead = await iminPrinter.getPrinterThermalHead();
print('打印头型号: $thermalHead');
```

#### 获取固件版本

**方法：** `getPrinterFirmwareVersion()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? firmwareVersion = await iminPrinter.getPrinterFirmwareVersion();
print('固件版本: $firmwareVersion');
```

#### 获取服务版本

**方法：** `getServiceVersion()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? serviceVersion = await iminPrinter.getServiceVersion();
print('服务版本: $serviceVersion');
```

#### 获取硬件版本

**方法：** `getPrinterHardwareVersion()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? hardwareVersion = await iminPrinter.getPrinterHardwareVersion();
print('硬件版本: $hardwareVersion');
```

#### 获取打印机密度

**方法：** `getPrinterDensity()`

**返回值：** `Future<int?>`

**示例：**
```dart
int? density = await iminPrinter.getPrinterDensity();
print('打印密度: $density');
```

#### 获取纸张类型

**方法：** `getPrinterPaperType()`

**返回值：** `Future<int?>` - 0: 80mm, 1: 58mm

**示例：**
```dart
int? paperType = await iminPrinter.getPrinterPaperType();
print('纸张类型: ${paperType == 0 ? "80mm" : "58mm"}');
```

#### 获取打印机模式

**方法：** `getPrinterMode()`

**返回值：** `Future<int?>` - 0: 普通模式, 1: 标签模式

**示例：**
```dart
int? mode = await iminPrinter.getPrinterMode();
print('打印机模式: ${mode == 0 ? "普通" : "标签"}');
```

---

## 文本打印

### 打印文本

打印文本内容，支持自定义样式。

**方法：** `printText(String text, {IminTextStyle? style})`

**参数：**
- `text` - 要打印的文本内容
- `style` - 文本样式（可选）

**IminTextStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| wordWrap | bool | 是否自动换行 | true |
| fontSize | int | 字体大小 | 26 |
| space | double | 行间距 | - |
| width | int | 文本宽度 | - |
| typeface | IminTypeface | 字体类型 | typefaceDefault |
| fontStyle | IminFontStyle | 字体样式 | normal |
| align | IminPrintAlign | 对齐方式 | left |

**枚举类型：**

```dart
// 字体类型
enum IminTypeface {
  typefaceDefault,      // 默认字体
  typefaceMonospace,    // 等宽字体
  typefaceDefaultBold,  // 默认粗体
  typefaceSansSerif,    // 无衬线字体
  typefaceSerif         // 衬线字体
}

// 字体样式
enum IminFontStyle {
  normal,      // 正常
  bold,        // 粗体
  italic,      // 斜体
  boldItalic   // 粗斜体
}

// 对齐方式
enum IminPrintAlign {
  left,    // 左对齐
  center,  // 居中
  right    // 右对齐
}
```

**示例：**

```dart
// 简单打印
await iminPrinter.printText('Hello World');

// 打印居中标题
await iminPrinter.printText(
  '欢迎光临',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);

// 打印小票内容
await iminPrinter.printText(
  '商品名称：苹果',
  style: IminTextStyle(
    fontSize: 24,
    align: IminPrintAlign.left,
  ),
);
```


### 打印反白文本

打印黑底白字的反白文本。

**方法：** `printAntiWhiteText(String text, {IminTextStyle? style})`

**参数：** 与 `printText` 相同

**示例：**
```dart
await iminPrinter.printAntiWhiteText(
  '重要提示',
  style: IminTextStyle(
    fontSize: 28,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

---

### 文本位图打印

将文本转换为位图后打印，支持更多样式效果。

**方法：** `printTextBitmap(String text, {IminTextPictureStyle? style})`

**参数：**
- `text` - 要打印的文本
- `style` - 文本图片样式（可选）

**IminTextPictureStyle 属性：**

| 属性 | 类型 | 说明 |
|------|------|------|
| fontSize | int | 字体大小 |
| typeface | IminTypeface | 字体类型 |
| fontStyle | IminFontStyle | 字体样式 |
| align | IminPrintAlign | 对齐方式 |
| letterSpacing | double | 字母间距 |
| underline | bool | 是否下划线 |
| throughline | bool | 是否删除线 |
| lineHeight | double | 行高 |
| reverseWhite | bool | 是否反白 |

**示例：**
```dart
await iminPrinter.printTextBitmap(
  '特殊效果文本',
  style: IminTextPictureStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    underline: true,
    align: IminPrintAlign.center,
  ),
);
```

---

## 图片打印

### 打印单张图片

支持打印 URL 图片或 Uint8List 字节数组图片。

**方法：** `printSingleBitmap(dynamic img, {IminPictureStyle? pictureStyle})`

**参数：**
- `img` - 图片数据，可以是：
  - `String` - 图片 URL 地址
  - `Uint8List` - 图片字节数组
- `pictureStyle` - 图片样式（可选）

**IminPictureStyle 属性：**

| 属性 | 类型 | 说明 |
|------|------|------|
| width | int | 图片宽度（像素） |
| height | int | 图片高度（像素） |
| alignment | IminPrintAlign | 对齐方式 |

**示例：**

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

// 打印本地图片（字节数组）
Uint8List imageBytes = await readFileBytes('assets/images/logo.png');
await iminPrinter.printSingleBitmap(
  imageBytes,
  pictureStyle: IminPictureStyle(
    width: 200,
    height: 100,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### 打印透明背景图片

打印带透明背景的图片，自动将透明部分转换为白色。

**方法：** `printSingleBitmapWithTranslation(dynamic img, {IminPictureStyle? pictureStyle})`

**参数：** 与 `printSingleBitmap` 相同

**示例：**
```dart
await iminPrinter.printSingleBitmapWithTranslation(
  imageBytes,
  pictureStyle: IminPictureStyle(
    width: 300,
    height: 200,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### 打印多张图片

一次性打印多张图片。

**方法：** `printMultiBitmap(List<dynamic> imgs, {IminPictureStyle? pictureStyle})`

**参数：**
- `imgs` - 图片数组，可以是 URL 数组或 Uint8List 数组
- `pictureStyle` - 图片样式（可选）

**示例：**
```dart
// 打印多张网络图片
await iminPrinter.printMultiBitmap(
  [
    'https://example.com/image1.png',
    'https://example.com/image2.png',
  ],
  pictureStyle: IminPictureStyle(
    width: 250,
    height: 100,
    alignment: IminPrintAlign.center,
  ),
);
```

---

### 打印彩色图表

打印彩色图表或彩色图片（仅支持彩色打印机）。

**方法：** `printSingleBitmapColorChart(dynamic img, {IminPictureStyle? pictureStyle})`

**参数：** 与 `printSingleBitmap` 相同

**示例：**
```dart
await iminPrinter.printSingleBitmapColorChart(
  'https://example.com/chart.png',
  pictureStyle: IminPictureStyle(
    width: 400,
    height: 300,
    alignment: IminPrintAlign.center,
  ),
);
```

---

## 二维码打印

### 打印二维码

打印标准二维码。

**方法：** `printQrCode(String data, {IminQrCodeStyle? qrCodeStyle})`

**参数：**
- `data` - 二维码内容
- `qrCodeStyle` - 二维码样式（可选）

**IminQrCodeStyle 属性：**

| 属性 | 类型 | 说明 |
|------|------|------|
| qrSize | int | 二维码大小（1-10） |
| align | IminPrintAlign | 对齐方式 |
| leftMargin | int | 左边距 |
| errorCorrectionLevel | IminQrcodeCorrectionLevel | 纠错级别 |

**纠错级别：**
```dart
enum IminQrcodeCorrectionLevel {
  levelL(48),  // 约 7% 纠错能力
  levelM(49),  // 约 15% 纠错能力
  levelQ(50),  // 约 25% 纠错能力
  levelH(51);  // 约 30% 纠错能力
}
```

**示例：**
```dart
// 简单打印
await iminPrinter.printQrCode('https://www.imin.sg');

// 自定义样式
await iminPrinter.printQrCode(
  'https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
  ),
);
```


### 打印双二维码

在一行内打印两个二维码。

**方法：** `printDoubleQR({required IminDoubleQRCodeStyle qrCode1, required IminDoubleQRCodeStyle qrCode2, int? doubleQRSize})`

**参数：**
- `qrCode1` - 第一个二维码配置
- `qrCode2` - 第二个二维码配置
- `doubleQRSize` - 双二维码大小（可选）

**IminDoubleQRCodeStyle 属性：**

| 属性 | 类型 | 说明 |
|------|------|------|
| text | String | 二维码内容 |
| level | int | 纠错级别（1-3） |
| leftMargin | int | 左边距 |
| version | int | 二维码版本（1-40） |

**示例：**
```dart
await iminPrinter.printDoubleQR(
  qrCode1: IminDoubleQRCodeStyle(
    text: 'https://www.imin.sg',
  ),
  qrCode2: IminDoubleQRCodeStyle(
    text: 'https://www.google.com',
  ),
  doubleQRSize: 5,
);
```

---

## 条码打印

### 打印条码

打印一维条码。

**方法：** `printBarCode(IminBarcodeType barCodeType, String barCodeContent, {IminBarCodeStyle? style})`

**参数：**
- `barCodeType` - 条码类型
- `barCodeContent` - 条码内容
- `style` - 条码样式（可选）

**IminBarcodeType 条码类型：**
```dart
enum IminBarcodeType {
  upcA(0),      // UPC-A
  upcE(1),      // UPC-E
  jan13(2),     // JAN13 (EAN13)
  jan8(3),      // JAN8 (EAN8)
  code39(4),    // Code 39
  itf(5),       // ITF
  codabar(6),   // Codabar
  code93(7),    // Code 93
  code128(8);   // Code 128
}
```

**IminBarCodeStyle 属性：**

| 属性 | 类型 | 说明 |
|------|------|------|
| width | int | 条码宽度 |
| height | int | 条码高度 |
| position | IminBarcodeTextPos | 文本位置 |
| align | IminPrintAlign | 对齐方式 |

**文本位置：**
```dart
enum IminBarcodeTextPos {
  noText(0),     // 不显示文本
  textAbove(1),  // 文本在上方
  textBelow(2),  // 文本在下方
  both(3);       // 文本在上下方
}
```

**示例：**
```dart
// 简单打印
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '1234567890',
);

// 自定义样式
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '1234567890',
  style: IminBarCodeStyle(
    width: 300,
    height: 80,
    align: IminPrintAlign.center,
    position: IminBarcodeTextPos.textBelow,
  ),
);
```

---

### 打印条码为位图格式

将条码转换为位图格式打印。

**方法：** `printBarCodeToBitmapFormat(String barCodeContent, int width, int height, IminBarCodeToBitmapFormat codeFormat)`

**参数：**
- `barCodeContent` - 条码内容
- `width` - 宽度
- `height` - 高度
- `codeFormat` - 条码格式

**IminBarCodeToBitmapFormat 格式：**
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

**示例：**
```dart
await iminPrinter.printBarCodeToBitmapFormat(
  '1234567890',
  300,
  100,
  IminBarCodeToBitmapFormat.code128,
);
```

---

## 表格打印

### 打印表格（固定宽度）

使用固定像素宽度打印表格。

**方法：** `printColumnsText({required List<ColumnMaker> cols})`

**参数：**
- `cols` - 列数组

**ColumnMaker 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| text | String | 列内容 | '' |
| width | int | 列宽度（像素） | 2 |
| fontSize | int | 字体大小 | 26 |
| align | IminPrintAlign | 对齐方式 | left |

**示例：**
```dart
import 'package:imin_printer/column_maker.dart';

// 打印成绩单表格
await iminPrinter.printColumnsText(cols: [
  ColumnMaker(
    text: '科目',
    width: 100,
    fontSize: 26,
    align: IminPrintAlign.left,
  ),
  ColumnMaker(
    text: '分数',
    width: 70,
    fontSize: 26,
    align: IminPrintAlign.center,
  ),
  ColumnMaker(
    text: '等级',
    width: 50,
    fontSize: 26,
    align: IminPrintAlign.right,
  ),
]);

await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: '语文', width: 100, fontSize: 26),
  ColumnMaker(text: '88', width: 70, fontSize: 26),
  ColumnMaker(text: 'A-', width: 50, fontSize: 26),
]);
```

---

### 打印表格（权重比例）

使用权重比例自动分配列宽。

**方法：** `printColumnsString({required List<ColumnMaker> cols})`

**参数：**
- `cols` - 列数组，`width` 表示权重比例

**示例：**
```dart
// 打印商品清单（1:1:1:1 比例）
await iminPrinter.printColumnsString(cols: [
  ColumnMaker(
    text: '商品',
    width: 1,
    fontSize: 24,
    align: IminPrintAlign.left,
  ),
  ColumnMaker(
    text: '数量',
    width: 1,
    fontSize: 24,
    align: IminPrintAlign.center,
  ),
  ColumnMaker(
    text: '单价',
    width: 1,
    fontSize: 24,
    align: IminPrintAlign.right,
  ),
  ColumnMaker(
    text: '小计',
    width: 1,
    fontSize: 24,
    align: IminPrintAlign.right,
  ),
]);
```


---

## 标签打印

> **注意**：标签打印功能仅在 SDK 2.0 中可用

标签打印使用画布（Canvas）模式，可以在标签上自由布局文本、条码、二维码、图片和图形。

### 初始化标签画布

创建标签打印画布。

**方法：** `labelInitCanvas({LabelCanvasStyle? labelCanvasStyle})`

**参数：**
- `labelCanvasStyle` - 画布样式配置

**LabelCanvasStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| width | int | 画布宽度（像素） | 50 |
| height | int | 画布高度（像素） | 50 |
| posX | int | X 坐标 | 0 |
| posY | int | Y 坐标 | 0 |

**示例：**
```dart
import 'package:imin_printer/imin_style.dart';

// 创建 50mm x 30mm 的标签画布
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 50 * 8,   // 50mm
    height: 30 * 8,  // 30mm
    posX: 48,
  ),
);
```

---

### 添加文本到标签

在标签上添加文本元素。

**方法：** `labelAddText(String text, {LabelTextStyle? labelTextStyle})`

**参数：**
- `text` - 文本内容
- `labelTextStyle` - 文本样式

**LabelTextStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| posX | int | X 坐标 | 0 |
| posY | int | Y 坐标 | 0 |
| textSize | int | 文字大小 | 24 |
| textWidthRatio | int | 文字宽度比例 | 1 |
| textHeightRatio | int | 文字高度比例 | 1 |
| width | int | 宽度 | -1 |
| height | int | 高度 | -1 |
| align | AlignLabel | 对齐方式 | DEFAULT |
| rotate | Rotate | 旋转角度 | ROTATE_0 |
| textSpace | int | 文字间距 | 0 |
| enableBold | bool | 是否粗体 | false |
| enableUnderline | bool | 是否下划线 | false |
| enableStrikethrough | bool | 是否删除线 | false |
| enableItalics | bool | 是否斜体 | false |
| enAntiColor | bool | 是否反色 | false |

**示例：**
```dart
// 添加标题
await iminPrinter.labelAddText(
  'PACKED ON',
  labelTextStyle: LabelTextStyle(
    posX: 30,
    posY: 30,
    textSize: 18,
    enableBold: true,
  ),
);

// 添加产品名称
await iminPrinter.labelAddText(
  'Fuji Apple',
  labelTextStyle: LabelTextStyle(
    posX: 220,
    posY: 45,
    textSize: 30,
  ),
);
```

---

### 添加条码到标签

在标签上添加条码元素。

**方法：** `labelAddBarCode(String barCode, {LabelBarCodeStyle? barCodeStyle})`

**参数：**
- `barCode` - 条码内容
- `barCodeStyle` - 条码样式

**LabelBarCodeStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| posX | int | X 坐标 | 0 |
| posY | int | Y 坐标 | 0 |
| dotWidth | int | 点宽度 | 2 |
| barHeight | int | 条码高度 | 162 |
| readable | HumanReadable | 文本显示位置 | HIDE |
| symbology | Symbology | 条码类型 | CODE39 |
| align | AlignLabel | 对齐方式 | DEFAULT |
| rotate | Rotate | 旋转角度 | ROTATE_0 |
| width | int | 宽度 | -1 |
| height | int | 高度 | -1 |

**枚举类型：**
```dart
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

enum HumanReadable {
  HIDE,      // 隐藏文本
  POS_ONE,   // 位置1
  POS_TWO,   // 位置2
  POS_THREE; // 位置3
}
```

**示例：**
```dart
await iminPrinter.labelAddBarCode(
  '{B123456',
  barCodeStyle: LabelBarCodeStyle(
    posX: 160,
    posY: 125,
    symbology: Symbology.CODE128,
    dotWidth: 2,
    barHeight: 50,
    readable: HumanReadable.POS_TWO,
  ),
);
```

---

### 添加二维码到标签

在标签上添加二维码元素。

**方法：** `labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle})`

**参数：**
- `qrCode` - 二维码内容
- `qrCodeStyle` - 二维码样式

**LabelQrCodeStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| posX | int | X 坐标 | 0 |
| posY | int | Y 坐标 | 0 |
| size | int | 二维码大小 | 4 |
| errorLevel | ErrorLevel | 纠错级别 | L |
| rotate | Rotate | 旋转角度 | ROTATE_0 |
| width | int | 宽度 | -1 |
| height | int | 高度 | -1 |

**ErrorLevel 纠错级别：**
```dart
enum ErrorLevel {
  L,  // 约 7% 纠错
  M,  // 约 15% 纠错
  Q,  // 约 25% 纠错
  H;  // 约 30% 纠错
}
```

**示例：**
```dart
await iminPrinter.labelAddQrCode(
  'https://www.imin.sg',
  qrCodeStyle: LabelQrCodeStyle(
    posX: 280,
    posY: 60,
    size: 4,
    errorLevel: ErrorLevel.M,
  ),
);
```

---

### 添加图形到标签

在标签上添加图形元素（矩形、圆形、线条等）。

**方法：** `labelAddArea({LabelAreaStyle? areaStyle})`

**参数：**
- `areaStyle` - 图形样式

**LabelAreaStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| style | Shape | 图形类型 | RECT_FILL |
| width | int | 宽度 | 50 |
| height | int | 高度 | 50 |
| posX | int | 起始 X 坐标 | 0 |
| posY | int | 起始 Y 坐标 | 0 |
| endX | int | 结束 X 坐标 | 50 |
| endY | int | 结束 Y 坐标 | 50 |
| thick | int | 线条粗细 | 1 |

**Shape 图形类型：**
```dart
enum Shape {
  RECT_FILL,     // 填充矩形
  RECT_WHITE,    // 白色矩形
  RECT_REVERSE,  // 反色矩形
  BOX,           // 空心矩形
  CIRCLE,        // 圆形
  OVAL,          // 椭圆
  PATH;          // 路径/线条
}
```

**示例：**
```dart
// 添加边框
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.BOX,
    posX: 10,
    posY: 10,
    width: 380,
    height: 280,
    thick: 2,
  ),
);

// 添加分隔线
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.PATH,
    posX: 24,
    posY: 80,
    endX: 50 * 8 - 4,
    endY: 80,
    thick: 2,
  ),
);
```

---

### 添加图片到标签

在标签上添加图片元素。

**方法：** `labelAddBitmap(dynamic img, {LabelBitmapStyle? addBitmapStyle})`

**参数：**
- `img` - 图片数据（URL 或 Uint8List）
- `addBitmapStyle` - 图片样式

**LabelBitmapStyle 属性：**

| 属性 | 类型 | 说明 | 默认值 |
|------|------|------|--------|
| posX | int | X 坐标 | 0 |
| posY | int | Y 坐标 | 0 |
| algorithm | ImageAlgorithm | 图像算法 | BINARIZATION |
| value | int | 算法参数值 | 200 |
| width | int | 宽度 | -1 |
| height | int | 高度 | -1 |

**ImageAlgorithm 图像算法：**
```dart
enum ImageAlgorithm {
  BINARIZATION,  // 二值化
  DITHERING;     // 抖动
}
```

**示例：**
```dart
await iminPrinter.labelAddBitmap(
  'https://example.com/logo.png',
  addBitmapStyle: LabelBitmapStyle(
    posX: 50,
    posY: 50,
    width: 100,
    height: 100,
    algorithm: ImageAlgorithm.BINARIZATION,
  ),
);
```

---

### 打印标签

完成标签设计后，打印标签。

**方法：** `labelPrintCanvas(int printCount)`

**参数：**
- `printCount` - 打印份数

**示例：**
```dart
// 打印 1 份标签
await iminPrinter.labelPrintCanvas(1);
```

---

### 标签学习

执行标签学习功能，用于校准标签纸。

**方法：** `labelLearning()`

**参数：** 无

**示例：**
```dart
await iminPrinter.labelLearning();
```

---

### 完整标签打印示例

```dart
// 1. 初始化画布
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(
    width: 50 * 8,
    height: 30 * 8,
    posX: 48,
  ),
);

// 2. 添加标题
await iminPrinter.labelAddText(
  'PACKED ON',
  labelTextStyle: LabelTextStyle(
    posX: 30,
    posY: 30,
    textSize: 18,
  ),
);

// 3. 添加产品名称
await iminPrinter.labelAddText(
  'Fuji Apple',
  labelTextStyle: LabelTextStyle(
    posX: 220,
    posY: 45,
    textSize: 30,
  ),
);

// 4. 添加价格
await iminPrinter.labelAddText(
  '\$16.98',
  labelTextStyle: LabelTextStyle(
    posX: 10,
    posY: 190,
    textSize: 45,
    enableBold: true,
  ),
);

// 5. 添加条码
await iminPrinter.labelAddBarCode(
  '{B123456',
  barCodeStyle: LabelBarCodeStyle(
    posX: 160,
    posY: 125,
    symbology: Symbology.CODE128,
    dotWidth: 2,
    barHeight: 50,
    readable: HumanReadable.POS_TWO,
  ),
);

// 6. 添加边框
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(
    style: Shape.BOX,
    posX: 10,
    posY: 10,
    width: 380,
    height: 280,
    thick: 2,
  ),
);

// 7. 打印标签
await iminPrinter.labelPrintCanvas(1);
```


---

## 事务打印

事务打印允许将多个打印命令缓存后一次性提交打印，提高打印效率和一致性。

### 进入打印缓冲区

开启缓冲区模式，后续的打印命令将被缓存。

**方法：** `enterPrinterBuffer(bool isClean)`

**参数：**
- `isClean` - 进入前是否清空缓冲区

**示例：**
```dart
// 进入缓冲区并清空
await iminPrinter.enterPrinterBuffer(true);
```

---

### 提交打印缓冲区

将缓冲区中的所有打印命令一次性提交执行。

**方法：** `commitPrinterBuffer()`

**参数：** 无

**示例：**
```dart
await iminPrinter.commitPrinterBuffer();
```

---

### 退出打印缓冲区

退出缓冲区模式。

**方法：** `exitPrinterBuffer(bool isCommit)`

**参数：**
- `isCommit` - 退出前是否提交缓冲区内容

**示例：**
```dart
// 退出并提交
await iminPrinter.exitPrinterBuffer(true);

// 退出但不提交（丢弃缓冲区内容）
await iminPrinter.exitPrinterBuffer(false);
```

---

### 事务打印使用示例

**场景说明**：事务打印（缓冲区管理）适用于需要批量打印多张小票的场景，例如外卖订单、批量发票等。通过缓冲区模式，可以将多个打印任务缓存后一次性提交，提高打印效率和一致性。

#### 完整调用流程

```dart
final iminPrinter = IminPrinter();

try {
  // 1. 进入打印缓冲区（清空之前的缓冲区）
  iminPrinter.enterPrinterBuffer(true);
  
  // 2. 发送 RAW 数据到缓冲区
  await iminPrinter.sendRAWData(Uint8List.fromList(ticketData));
  
  // 3. 提交缓冲区，执行打印
  await iminPrinter.commitPrinterBuffer();
  
  // 4. 退出缓冲区模式（提交剩余内容）
  iminPrinter.exitPrinterBuffer(true);
  
} catch (e) {
  // 出错时退出但不提交（丢弃缓冲区内容）
  iminPrinter.exitPrinterBuffer(false);
  print('打印失败: $e');
}
```

> **注意**：
> - `enterPrinterBuffer(true)` - 进入缓冲区并清空之前的内容
> - `sendRAWData()` - 发送 ESC/POS 原始数据到缓冲区
> - `commitPrinterBuffer()` - 提交缓冲区内容并执行打印
> - `exitPrinterBuffer(true)` - 退出缓冲区模式并提交剩余内容
> - `exitPrinterBuffer(false)` - 退出缓冲区模式但丢弃内容（用于错误处理）

#### 基础示例：打印单张小票

```dart
try {
  // 1. 开启事务打印
  await iminPrinter.enterPrinterBuffer(true);
  
  // 2. 添加多个打印命令到缓冲区
  await iminPrinter.printText('订单 #12345');
  await iminPrinter.printText('商品1: ¥10.00');
  await iminPrinter.printText('商品2: ¥20.00');
  await iminPrinter.printText('总计: ¥30.00');
  await iminPrinter.printQrCode('ORDER-12345');
  
  // 3. 提交所有命令，一次性打印
  await iminPrinter.commitPrinterBuffer();
  
  // 4. 退出事务打印模式
  await iminPrinter.exitPrinterBuffer(true);
  
} catch (e) {
  // 出错时退出但不提交（丢弃缓冲区内容）
  await iminPrinter.exitPrinterBuffer(false);
  print('打印失败: $e');
}
```

**批量打印多张小票示例：**

```dart
Future<void> printMultipleTickets() async {
  final iminPrinter = IminPrinter();
  
  // 准备多张小票的数据
  List<Uint8List> ticketDataList = [
    await getTicket1Data(),
    await getTicket2Data(),
    await getTicket3Data(),
  ];
  
  try {
    // 1. 开启事务打印模式
    await iminPrinter.enterPrinterBuffer(true);
    
    // 2. 将所有小票数据添加到缓冲区
    for (var ticketData in ticketDataList) {
      await iminPrinter.sendRAWData(ticketData);
    }
    
    // 3. 一次性提交打印所有小票
    await iminPrinter.commitPrinterBuffer();
    
    // 4. 退出事务打印模式
    await iminPrinter.exitPrinterBuffer(true);
    
    print('批量打印成功！共打印 ${ticketDataList.length} 张小票');
    
  } catch (e) {
    // 出错时放弃打印
    await iminPrinter.exitPrinterBuffer(false);
    print('批量打印失败: $e');
  }
}

// 生成小票数据的辅助函数
Future<Uint8List> getTicket1Data() async {
  // 这里可以使用 ESC/POS 命令生成小票数据
  List<int> bytes = [
    0x1b, 0x40,  // 初始化
    // ... 更多 ESC/POS 命令
  ];
  return Uint8List.fromList(bytes);
}
```

**实际应用场景 - 外卖订单批量打印：**

```dart
class OrderPrinter {
  final iminPrinter = IminPrinter();
  
  // 批量打印外卖订单
  Future<void> printDeliveryOrders(List<Order> orders) async {
    try {
      // 开启事务打印
      await iminPrinter.enterPrinterBuffer(true);
      
      // 为每个订单生成打印内容
      for (var order in orders) {
        await _printSingleOrder(order);
      }
      
      // 一次性提交打印
      await iminPrinter.commitPrinterBuffer();
      await iminPrinter.exitPrinterBuffer(true);
      
      print('成功打印 ${orders.length} 个订单');
      
    } catch (e) {
      await iminPrinter.exitPrinterBuffer(false);
      print('批量打印失败: $e');
    }
  }
  
  // 打印单个订单
  Future<void> _printSingleOrder(Order order) async {
    await iminPrinter.printText(
      '订单 #${order.id}',
      style: IminTextStyle(
        fontSize: 28,
        fontStyle: IminFontStyle.bold,
        align: IminPrintAlign.center,
      ),
    );
    
    await iminPrinter.printText('顾客: ${order.customerName}');
    await iminPrinter.printText('地址: ${order.address}');
    await iminPrinter.printText('电话: ${order.phone}');
    await iminPrinter.printText('--------------------------------');
    
    // 打印商品列表
    for (var item in order.items) {
      await iminPrinter.printColumnsText(cols: [
        ColumnMaker(text: item.name, width: 150, fontSize: 24),
        ColumnMaker(text: 'x${item.quantity}', width: 50, fontSize: 24),
        ColumnMaker(text: '¥${item.price}', width: 100, fontSize: 24, align: IminPrintAlign.right),
      ]);
    }
    
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printText('总计: ¥${order.total}');
    await iminPrinter.printAndFeedPaper(100);
    await iminPrinter.partialCut();
  }
}

// 订单数据模型
class Order {
  final String id;
  final String customerName;
  final String address;
  final String phone;
  final List<OrderItem> items;
  final double total;
  
  Order({
    required this.id,
    required this.customerName,
    required this.address,
    required this.phone,
    required this.items,
    required this.total,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;
  
  OrderItem({required this.name, required this.quantity, required this.price});
}
```

**事务打印的优势：**

1. **提高效率** - 多个打印任务一次性提交，减少通信开销
2. **保证一致性** - 要么全部打印成功，要么全部失败
3. **减少错误** - 避免打印过程中的中断导致部分打印
4. **适合批量** - 特别适合外卖、快递等需要批量打印的场景

---

## 打印机配置

### 设置打印模式

设置打印机工作模式。

**方法：** `setPrintModel(int printModel)`

**参数：**
- `printModel` - 打印模式
  - `0` - 普通模式（热敏打印）
  - `1` - 标签模式

**示例：**
```dart
// 设置为普通模式
await iminPrinter.setPrintModel(0);

// 设置为标签模式
await iminPrinter.setPrintModel(1);
```

---

### 字体编码管理

#### 获取字体代码页列表

**方法：** `getFontCodepage()`

**返回值：** `Future<List<String>?>`

**示例：**
```dart
List<String>? codepages = await iminPrinter.getFontCodepage();
print('支持的代码页: $codepages');
```

#### 设置字体代码页

**方法：** `setFontCodepage(int codepage)`

**参数：**
- `codepage` - 代码页编号

**示例：**
```dart
await iminPrinter.setFontCodepage(0);
```

#### 获取当前代码页

**方法：** `getCurCodepage()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? currentCodepage = await iminPrinter.getCurCodepage();
print('当前代码页: $currentCodepage');
```

---

### 编码管理

#### 获取编码列表

**方法：** `getEncodeList()`

**返回值：** `Future<List<String>?>`

**示例：**
```dart
List<String>? encodeList = await iminPrinter.getEncodeList();
print('支持的编码: $encodeList');
```

#### 设置打印机编码

**方法：** `setPrinterEncode(int encode)`

**参数：**
- `encode` - 编码编号

**示例：**
```dart
await iminPrinter.setPrinterEncode(0);
```

#### 获取当前编码

**方法：** `getCurEncode()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? currentEncode = await iminPrinter.getCurEncode();
print('当前编码: $currentEncode');
```

---

### 打印密度和速度

#### 获取打印密度列表

**方法：** `getPrinterDensityList()`

**返回值：** `Future<List<String>?>`

**示例：**
```dart
List<String>? densityList = await iminPrinter.getPrinterDensityList();
print('支持的密度: $densityList');
```

#### 获取打印速度列表

**方法：** `getPrinterSpeedList()`

**返回值：** `Future<List<String>?>`

**示例：**
```dart
List<String>? speedList = await iminPrinter.getPrinterSpeedList();
print('支持的速度: $speedList');
```

#### 设置打印速度

**方法：** `setPrinterSpeed(int speed)`

**参数：**
- `speed` - 速度值

**示例：**
```dart
await iminPrinter.setPrinterSpeed(3);
```

#### 获取打印速度

**方法：** `getPrinterSpeed()`

**返回值：** `Future<int?>`

**示例：**
```dart
int? speed = await iminPrinter.getPrinterSpeed();
print('当前速度: $speed');
```

---

### 纸张类型管理

#### 获取纸张类型列表

**方法：** `getPrinterPaperTypeList()`

**返回值：** `Future<List<String>?>`

**示例：**
```dart
List<String>? paperTypes = await iminPrinter.getPrinterPaperTypeList();
print('支持的纸张类型: $paperTypes');
```

#### 获取纸张距离

**方法：** `getPrinterPaperDistance()`

**返回值：** `Future<String?>` - 返回纸张距离（单位：cm）

**示例：**
```dart
String? paperDistance = await iminPrinter.getPrinterPaperDistance();
print('纸张距离: ${paperDistance}cm');
```

---

### 其他配置

#### 获取 USB 打印机 VID/PID

**方法：** `getUsbPrinterVidPid()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? vidPid = await iminPrinter.getUsbPrinterVidPid();
print('USB VID/PID: $vidPid');
```

#### 获取 USB 设备名称

**方法：** `getUsbDevicesName()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? deviceName = await iminPrinter.getUsbDevicesName();
print('USB 设备名称: $deviceName');
```

#### 获取切刀次数

**方法：** `getPrinterCutTimes()`

**返回值：** `Future<String?>`

**示例：**
```dart
String? cutTimes = await iminPrinter.getPrinterCutTimes();
print('切刀次数: $cutTimes');
```

---

## 钱箱控制

### 打开钱箱

控制连接的钱箱打开。

**方法：** `openCashBox()`

**参数：** 无

**示例：**
```dart
await iminPrinter.openCashBox();
```

---

### 获取钱箱状态

**方法：** `getDrawerStatus()`

**返回值：** `Future<bool?>` - true: 打开, false: 关闭

**示例：**
```dart
bool? isOpen = await iminPrinter.getDrawerStatus();
print('钱箱状态: ${isOpen ? "打开" : "关闭"}');
```

---

### 获取钱箱打开次数

**方法：** `getOpenDrawerTimes()`

**返回值：** `Future<int?>`

**示例：**
```dart
int? openTimes = await iminPrinter.getOpenDrawerTimes();
print('钱箱打开次数: $openTimes');
```

---

## 高级功能

### 打印机自检

执行打印机自检程序。

**方法：** `printerSelfChecking()`

**参数：** 无

**示例：**
```dart
await iminPrinter.printerSelfChecking();
```

---

### 重置打印机

重置打印机到初始状态。

**方法：** `resetDevice()`

**参数：** 无

**示例：**
```dart
await iminPrinter.resetDevice();
```

---

### 发送原始数据

发送原始 ESC/POS 命令到打印机。

**方法：** `sendRAWData(Uint8List bytes)`

**参数：**
- `bytes` - 原始字节数据

**示例：**
```dart
// 发送 ESC/POS 命令
Uint8List escPosCommand = Uint8List.fromList([0x1B, 0x40]); // 初始化命令
await iminPrinter.sendRAWData(escPosCommand);
```

---

### 发送十六进制字符串

发送十六进制格式的原始数据。

**方法：** `sendRAWDataHexStr(String hex)`

**参数：**
- `hex` - 十六进制字符串

**示例：**
```dart
// 发送换行命令
await iminPrinter.sendRAWDataHexStr('0A');
```

---

### 开启日志

开启或关闭打印机调试日志。

**方法：** `openLogs(int open)`

**参数：**
- `open` - 0: 关闭, 1: 开启

**示例：**
```dart
// 开启日志
await iminPrinter.openLogs(1);

// 关闭日志
await iminPrinter.openLogs(0);
```

---

### 解绑服务

解除与打印服务的绑定。

**方法：** `unBindService()`

**参数：** 无

**示例：**
```dart
await iminPrinter.unBindService();
```

---

### 设置代码对齐

设置条码和二维码的对齐方式。

**方法：** `setCodeAlignment(IminPrintAlign alignment)`

**参数：**
- `alignment` - 对齐方式

**示例：**
```dart
await iminPrinter.setCodeAlignment(IminPrintAlign.center);
```

---

## 完整示例

### 打印小票示例

```dart
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';

Future<void> printReceipt() async {
  final iminPrinter = IminPrinter();
  
  try {
    // 1. 初始化打印机
    await iminPrinter.initPrinter();
    
    // 2. 检查打印机状态
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('打印机未就绪: ${status['msg']}');
    }
    
    // 3. 打印店铺名称
    await iminPrinter.printText(
      '欢迎光临',
      style: IminTextStyle(
        fontSize: 32,
        fontStyle: IminFontStyle.bold,
        align: IminPrintAlign.center,
      ),
    );
    
    await iminPrinter.printText(
      '某某商店',
      style: IminTextStyle(
        fontSize: 28,
        align: IminPrintAlign.center,
      ),
    );
    
    // 4. 打印分隔线
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printAndLineFeed();
    
    // 5. 打印订单信息
    await iminPrinter.printText('订单编号: 20240116001');
    await iminPrinter.printText('下单时间: 2024-01-16 14:30');
    await iminPrinter.printText('--------------------------------');
    
    // 6. 打印商品表格
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: '商品', width: 150, fontSize: 24),
      ColumnMaker(text: '数量', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: '单价', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: '小计', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: '苹果', width: 150, fontSize: 24),
      ColumnMaker(text: '2', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: '5.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: '10.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: '香蕉', width: 150, fontSize: 24),
      ColumnMaker(text: '3', width: 50, fontSize: 24, align: IminPrintAlign.center),
      ColumnMaker(text: '3.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
      ColumnMaker(text: '9.00', width: 70, fontSize: 24, align: IminPrintAlign.right),
    ]);
    
    // 7. 打印总计
    await iminPrinter.printText('--------------------------------');
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(text: '合计', width: 270, fontSize: 28, align: IminPrintAlign.right),
      ColumnMaker(text: '¥19.00', width: 70, fontSize: 28, align: IminPrintAlign.right),
    ]);
    
    // 8. 打印二维码
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printQrCode(
      'ORDER-20240116001',
      qrCodeStyle: IminQrCodeStyle(
        qrSize: 6,
        align: IminPrintAlign.center,
      ),
    );
    
    // 9. 打印结束语
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printText(
      '谢谢惠顾，欢迎再次光临！',
      style: IminTextStyle(
        fontSize: 24,
        align: IminPrintAlign.center,
      ),
    );
    
    // 10. 走纸并切纸
    await iminPrinter.printAndFeedPaper(100);
    await iminPrinter.partialCut();
    
    print('打印成功！');
    
  } catch (e) {
    print('打印失败: $e');
  }
}
```

---

## 常见问题

### 1. 如何判断设备使用哪个 SDK 版本？

```dart
String? version = await iminPrinter.getSdkVersion();
if (version == '2.0.0') {
  print('使用 SDK 2.0');
} else {
  print('使用 SDK 1.0');
}
```

### 2. 打印前如何检查打印机状态？

```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] == '0') {
  // 打印机正常，可以打印
  await iminPrinter.printText('Hello');
} else {
  // 打印机异常
  print('错误: ${status['msg']}');
}
```

### 3. 如何处理打印错误？

```dart
try {
  await iminPrinter.printText('测试打印');
} catch (e) {
  print('打印失败: $e');
  // 可以尝试重置打印机
  await iminPrinter.resetDevice();
}
```

### 4. 标签打印和普通打印有什么区别？

- **普通打印**：适用于小票、收据等连续纸张
- **标签打印**：适用于固定尺寸的标签纸，需要使用 `labelInitCanvas` 等标签 API

### 5. 如何提高打印效率？

使用缓冲区管理，将多个打印命令批量提交：

```dart
await iminPrinter.enterPrinterBuffer(true);
// 添加多个打印命令
await iminPrinter.commitPrinterBuffer();
await iminPrinter.exitPrinterBuffer(true);
```

---

## 相关资源

- [GitHub 仓库](https://github.com/iminsoftware/imin_printer)
- [Pub.dev 包](https://pub.dev/packages/imin_printer)
- [iMin 官方文档](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)
- [完整文档站点](https://iminsoftware.github.io/imin_printer/)

---

**文档版本**: v2.0  
**最后更新**: 2024-01-16  
**适用插件版本**: imin_printer ^0.6.14
