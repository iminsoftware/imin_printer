# Changelog
# 0.7.0 (2026/03/24)

> **Note:** All new features below are only available on Android 13 (API 33) and above devices using SDK 2.0. On older devices (SDK 1.0), these methods will be silently ignored.
> 
> 以下新增功能仅适用于 Android 13 (API 33) 及以上设备（SDK 2.0）。在旧设备（SDK 1.0）上调用这些方法会被静默忽略。

### Bug Fixes
- Fix `setTextBitmapLetterSpacing` calling wrong method internally (修复setTextBitmapLetterSpacing内部调用错误方法)
- Fix `setTextWidth` calling wrong MethodChannel name (修复setTextWidth调用了错误的MethodChannel名称)
- Fix `printText` with style not working on SDK 2.0 devices — now auto routes to printTextBitmap path (修复2.0设备上printText带style参数无效的问题，自动走位图打印路径)
- Fix `LabelCanvasStyle` missing `enableReverse` and `enableMirror` fields (修复LabelCanvasStyle缺少enableReverse和enableMirror字段)

### New Features — ESC/POS Font Control (2.0 SDK)

> **Important:** These methods only take effect when used with `printEscPosText` or `printText` (without style). They do NOT affect `printTextBitmap`. These are global settings — you must manually reset them after use (e.g. `setFontBold(false)` or call `initPrinterParams()`), otherwise they will affect all subsequent prints.
> 
> 重要提示：这些方法仅对 `printEscPosText` 或不带 style 的 `printText` 生效，对 `printTextBitmap` 无效。这些是全局配置，使用后需手动还原（如 `setFontBold(false)` 或调用 `initPrinterParams()`），否则会影响后续所有打印。

- Add `setFontMultiple` — set font width/height multiple (设置字体倍宽倍高)
- Add `setFontBold` — set font bold (设置字体加粗)
- Add `setFontItalic` — set font italic (设置字体斜体)
- Add `setFontAntiWhite` — set font anti-white (设置字体反白)
- Add `setFontUnderline` — set font underline (设置字体下划线)
- Add `setFontRotate` — set font rotate (设置字体旋转)
- Add `setFontDirection` — set print direction (设置打印方向)
- Add `setFontLineSpacing` — set line spacing (设置行间距)
- Add `setFontCharSpace` — set char spacing (设置字符间距)
- Add `setFontChineseSpace` — set Chinese char spacing (设置中文左右间距)
- Add `setFontChineseSize` — set Chinese font size (设置中文字号)
- Add `setFontCharSize` — set ASCII font size (设置ASCII字号)
- Add `setFontChineseMode` — set Chinese mode (设置中文模式)
- Add `setFontCountryCode` / `getFontCountryCode` — country code setting (国家代码设置)

### New Features — printEscPosText
- Add `printEscPosText` — ESC/POS text print with style (ESC/POS指令文本打印，支持倍宽倍高/加粗/斜体/反白/下划线/对齐等)
- Add `IminEscPosTextStyle` style class

### New Features — Advanced 2D Codes
- Add `print2DCode` — generic 2D code print (通用2D码打印)
- Add `printPDF417` — PDF417 barcode print (PDF417码打印)
- Add `printDataMatrix` — DataMatrix code print (DataMatrix码打印)
- Add `printAztecCode` — Aztec code print (Aztec码打印)
- Add `printMaxiCode` — MaxiCode print (MaxiCode打印)

### New Features — Text Print
- Add `printTextWithAli` — print text with alignment (带对齐的文本打印)
- Add `printTextWithEncode` — print text with encoding (带编码的文本打印)

### New Features — Paper Control
- Add `printAndQuitPaper` — print and retract paper (打印并退纸)
- Add `partialCutAndFeedPaper` — partial cut and feed (半切并走纸)
- Add `fullCutAndFeedPaper` — full cut and feed (全切并走纸)

### New Features — Printer Info
- Add `getPrinterTemperature` — get print head temperature (获取打印头温度)
- Add `supportCashBox` — check cash box support (检查是否支持钱箱)
- Add `getPrinterPatternList` — get pattern list (获取模式列表)
- Add `getPrinterSupplierName` — get supplier name (获取供应商名称)
- Add `getPrinterKnifeReset` — knife reset (切刀复位)

### New Features — Transaction Print
- Add `commitPrinterBufferWithCallback` — commit with callback (带回调的事务提交)
- Add `exitPrinterBufferWithCallback` — exit with callback (带回调的事务退出)

### New Features — Label Print
- Add `labelPrintBitmapDirect` — direct label bitmap print (直接标签位图打印)
- Add `labelGapSensorCalibration` — gap sensor calibration (缝隙传感器校准)
- Add `labelSetPrinterMode` — set label printer mode (设置标签打印机模式)
- Add `labelQueryInfo` — query label info (查询标签信息)
- Add `labelRestoreDefaults` — restore label defaults (恢复标签默认设置)
- Add `setLabelContinuousPrint` — continuous label print (标签连续打印)
- Add `IminLabelInfo` enum for label query types

### New Features — Status
- Add `regesiterPrinterStatusCallback` — register printer status callback via EventChannel (注册打印机状态变化回调)

### Dependencies
- Upgrade NeoPrinterLibrary from V1.0.0.15 to V2.0.0.18

# 0.6.17 (2026/03/24)
- Fix initPrinter not returning result on SDK 2.0 (Android 15+), causing Flutter await to hang indefinitely (修复SDK 2.0模式下initPrinter未返回result导致Flutter端await永久挂起的问题)
# 0.6.16 (2026/03/23)
- Remove unused JAR files from libs directory to reduce package size (移除libs目录下未使用的JAR文件，减小包体积)
# 0.6.15 (2026/03/23)
- Optimize build.gradle, remove unnecessary dependencies (优化build.gradle，清除无用的依赖引用)
# 0.6.14 (2025/09/13  14:42)
- Adaptation and compatibility with Android 15 适配兼容android15
- Update Flutter plugin v0.6.14更新Flutter 插件v0.6.14
# 0.6.13 （2025/7/2216:31）
- Adapt and update the latest android SDK （适配并更新最新android SDK）
- Update the reference to SDK on the Android side of the plugin to avoid differences between the old and new versions of SDK(更新插件安卓端对SDK的引用，避免出现sdk 新旧版本差异化问题)
# 0.6.12 （2025/7/2216:31）
- Adapt and update the latest android SDK （适配并更新最新android SDK） 
# 0.6.11
- Add transparent background image printing
- Add 64-bit so file adaptation
# 0.6.10
 - Fixed bug
# 0.6.9
 - update Label API
 - 
# 0.6.6
 - update jar package version
# 0.6.5
 - update jar package version
# 0.6.4
 - fixed  example bug
 - Add openLogs method
 - Add sendRAWDataHexStr method

# 0.6.3
 - fixed  printSingleBitmap To Url bug

# 0.6.2
 - Fixed  bug and Optimize the money box function
 - Fixed Package name collisions  bug

# 0.6.1
 - Fixed bug

## 0.6.0
- Added 1.0 and 2.0 printing apis
- Compatible with iMin devices that use the 1.0 print api and the 2.0 print api
- Fixed the money box opening bugqq

## 0.5.6
- added openCashBox method

## 0.5.5
- added printSingleBitmap And printMultiBitmap Supports network url printing  method

## 0.5.4
- added setTextStyle method

## 0.5.3
- changed setTextStyle method
- edited  andorid jar libs

## 0.5.2

- Included printAndLineFeed method
- Included printAndFeedPaper method
- Included partialCut method
- Included setAlignment method
- Included setTextSize method
- Included setTextTypeface method
- Included setTextStyle method
- Included setTextLineSpacing method
- Included setTextWidth method
- Included printAntiWhiteText method
- Included printColumnsText method
- Included setBarCodeWidth method
- Included setBarCodeHeight method
- Included setBarCodeContentPrintPos method
- Included printBarCode method
- Included setLeftMargin method
- Included setPageFormat method
- Included printSingleBitmap method
- Included printMultiBitmap method
- Included printSingleBitmapBlackWhite method
- Included setDoubleQRSize method
- Included setDoubleQR1Level method
- Included setDoubleQR2Level method
- Included setDoubleQR1MarginLeft method
- Included setDoubleQR2MarginLeft method
- Included setDoubleQR1Version method
- Included setDoubleQR2Version method
- Included printDoubleQR method
- Included setInitIminPrinter method
- Included resetDevice method

## 0.5.1

- 0.5.1 release

## 0.5.0

- 0.5.0 release

## 0.4.3

- 0.4.3 release

## 0.4.2

- 0.4.2 release

## 0.4.1

- 0.4.1 release

## 0.4.0

- 0.4.0 release
- Update Readme
- Included Qrcode print
- Included text print
