# iMin Printer API Reference

## Device Quick Reference

| Paper Width | Printable Pixels | Cutter | Use Case |
|-------------|-----------------|--------|----------|
| 80mm | 576px | ‚ú?Some models | Retail/restaurant receipts |
| 58mm | 384px | ‚ù?| Handheld mobile printing |

| SDK Version | Android Version | Notes |
|-------------|----------------|-------|
| SDK 2.0 | Android 13+ | Full feature set, recommended for new projects |
| SDK 1.0 | Android 11 and below | Basic printing features |

---

## Method Quick Reference

### Initialization & Status

| Method | Description | SDK |
|--------|-------------|-----|
| `initPrinter()` | Initialize printer | 1.0+ |
| `getPrinterStatus()` | Get printer status | 1.0+ |
| `getSdkVersion()` | Get SDK version | 1.0+ |
| `initPrinterParams()` | Reset print parameters to defaults | 1.0+ |
| `resetDevice()` | Restart printer | 1.0+ |
| `unBindService()` | Unbind print service | 1.0+ |
| `printerSelfChecking()` | Print self-test page | 1.0+ |
| `openLogs(int)` | Toggle logging | 1.0+ |

### Text Printing

| Method | Description | SDK |
|--------|-------------|-----|
| `printText(String, {IminTextStyle?})` | Print text (auto-routes to bitmap on 2.0 when style is provided) | 1.0+ |
| `printAntiWhiteText(String, {IminTextStyle?})` | Print reverse text | 1.0+ |
| `printTextBitmap(String, {IminTextPictureStyle?})` | Print text as bitmap | 1.0+ |
| `printColumnsText({List<ColumnMaker>})` | Print table row | 1.0+ |
| `printColumnsString({List<ColumnMaker>})` | Print table row (string mode) | 1.0+ |
| `printTextWithAli(String, int)` | Print text with alignment | 2.0 |
| `printTextWithEncode(String, String)` | Print text with encoding | 2.0 |
| `printEscPosText(String, {IminEscPosTextStyle?})` | ESC/POS text printing | 2.0 |

### Text Style Settings

| Method | Description | SDK |
|--------|-------------|-----|
| `setTextSize(int)` | Set font size | 1.0+ |
| `setTextTypeface(IminTypeface)` | Set typeface | 1.0+ |
| `setTextStyle(IminFontStyle)` | Set font style | 1.0+ |
| `setAlignment(IminPrintAlign)` | Set alignment | 1.0+ |
| `setTextWidth(int)` | Set text width | 1.0+ |
| `setTextLineSpacing(double)` | Set line spacing | 1.0+ |

### Text Bitmap Style Settings

| Method | Description | SDK |
|--------|-------------|-----|
| `setTextBitmapTypeface(IminTypeface)` | Bitmap typeface | 1.0+ |
| `setTextBitmapSize(int)` | Bitmap font size | 1.0+ |
| `setTextBitmapStyle(IminFontStyle)` | Bitmap font style | 1.0+ |
| `setTextBitmapStrikeThru(bool)` | Bitmap strikethrough | 1.0+ |
| `setTextBitmapUnderline(bool)` | Bitmap underline | 1.0+ |
| `setTextBitmapLineSpacing(double)` | Bitmap line spacing | 1.0+ |
| `setTextBitmapLetterSpacing(double)` | Bitmap letter spacing | 1.0+ |
| `setTextBitmapAntiWhite(bool)` | Bitmap reverse white | 1.0+ |

### ESC/POS Font Control

| Method | Description | SDK |
|--------|-------------|-----|
| `setFontMultiple(int, int)` | Width/height multiple | 2.0 |
| `setFontBold(bool)` | Bold | 2.0 |
| `setFontItalic(bool)` | Italic | 2.0 |
| `setFontAntiWhite(bool)` | Reverse white | 2.0 |
| `setFontUnderline(int)` | Underline | 2.0 |
| `setFontRotate(int)` | Rotation | 2.0 |
| `setFontDirection(int)` | Print direction | 2.0 |
| `setFontLineSpacing(int)` | Line spacing | 2.0 |
| `setFontCharSpace(int)` | Character spacing | 2.0 |
| `setFontChineseSpace(int, int)` | Chinese character spacing | 2.0 |
| `setFontChineseSize(int, int, int, int)` | Chinese font size | 2.0 |
| `setFontCharSize(int, int, int, int)` | ASCII font size | 2.0 |
| `setFontChineseMode(int)` | Chinese mode | 2.0 |
| `setFontCountryCode(int)` | Set country code | 2.0 |
| `getFontCountryCode()` | Get country code list | 2.0 |

### Image Printing

| Method | Description | SDK |
|--------|-------------|-----|
| `printSingleBitmap(dynamic, {IminPictureStyle?})` | Print single image | 1.0+ |
| `printSingleBitmapWithTranslation(dynamic, {IminPictureStyle?})` | Print single image (with translation) | 1.0+ |
| `printMultiBitmap(List, {IminPictureStyle?})` | Print multiple images | 1.0+ |
| `printSingleBitmapBlackWhite(dynamic, {IminBaseStyle?})` | Print black & white image | 1.0+ |
| `printSingleBitmapColorChart(dynamic, {IminPictureStyle?})` | Print color chart | 1.0+ |

### Barcode Printing

| Method | Description | SDK |
|--------|-------------|-----|
| `printBarCode(IminBarcodeType, String, {IminBarCodeStyle?})` | Print barcode | 1.0+ |
| `printBarCodeToBitmapFormat(String, int, int, IminBarCodeToBitmapFormat)` | Bitmap format barcode | 1.0+ |
| `setBarCodeWidth(int)` | Barcode width | 1.0+ |
| `setBarCodeHeight(int)` | Barcode height | 1.0+ |
| `setBarCodeContentPrintPos(IminBarcodeTextPos)` | HRI character position | 1.0+ |

### QR Code Printing

| Method | Description | SDK |
|--------|-------------|-----|
| `printQrCode(String, {IminQrCodeStyle?})` | Print QR code | 1.0+ |
| `setQrCodeSize(int)` | QR code size | 1.0+ |
| `setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel)` | Error correction level | 1.0+ |
| `setLeftMargin(int)` | Left margin | 1.0+ |
| `setCodeAlignment(IminPrintAlign)` | Code alignment | 1.0+ |
| `printDoubleQR({IminDoubleQRCodeStyle, IminDoubleQRCodeStyle, int?})` | Double QR code | 1.0+ |
| `setDoubleQRSize(int)` | Double QR size | 1.0+ |
| `setDoubleQR1Level(int)` / `setDoubleQR2Level(int)` | Double QR error level | 1.0+ |
| `setDoubleQR1MarginLeft(int)` / `setDoubleQR2MarginLeft(int)` | Double QR left margin | 1.0+ |
| `setDoubleQR1Version(int)` / `setDoubleQR2Version(int)` | Double QR version | 1.0+ |

### Advanced 2D Codes

| Method | Description | SDK |
|--------|-------------|-----|
| `print2DCode(String, int, int, int, int)` | Generic 2D code | 2.0 |
| `printPDF417(String, int, int, int, int, int, int, int)` | PDF417 code | 2.0 |
| `printDataMatrix(String, int, int, int, int, int)` | DataMatrix code | 2.0 |
| `printAztecCode(String, int, int, int, int, int)` | Aztec code | 2.0 |
| `printMaxiCode(String, int, int)` | MaxiCode | 2.0 |

### Paper Feed & Cut

| Method | Description | SDK |
|--------|-------------|-----|
| `printAndLineFeed()` | Feed one line | 1.0+ |
| `printAndFeedPaper(int)` | Feed paper by height (1-1016) | 1.0+ |
| `setPageFormat({int?})` | Set paper format 0=80mm 1=58mm | 1.0+ |
| `partialCut()` | Partial cut | 1.0+ |
| `fullCut()` | Full cut | 1.0+ |
| `printAndQuitPaper(int)` | Print and retract paper | 2.0 |
| `partialCutAndFeedPaper(int)` | Partial cut and feed | 2.0 |
| `fullCutAndFeedPaper(int)` | Full cut and feed | 2.0 |

### Transaction Printing (Buffer)

| Method | Description | SDK |
|--------|-------------|-----|
| `enterPrinterBuffer(bool)` | Enter buffer mode | 1.0+ |
| `commitPrinterBuffer()` | Commit buffer | 1.0+ |
| `exitPrinterBuffer(bool)` | Exit buffer mode | 1.0+ |
| `commitPrinterBufferWithCallback()` | Commit buffer (with callback) | 2.0 |
| `exitPrinterBufferWithCallback(bool)` | Exit buffer (with callback) | 2.0 |

### Label Printing

| Method | Description | SDK |
|--------|-------------|-----|
| `labelInitCanvas({LabelCanvasStyle?})` | Initialize label canvas | 1.0+ |
| `labelAddText(String, {LabelTextStyle?})` | Add text | 1.0+ |
| `labelAddBarCode(String, {LabelBarCodeStyle?})` | Add barcode | 1.0+ |
| `labelAddQrCode(String, {LabelQrCodeStyle?})` | Add QR code | 1.0+ |
| `labelAddArea({LabelAreaStyle?})` | Add shape/area | 1.0+ |
| `labelAddBitmap(dynamic, {LabelBitmapStyle?})` | Add image | 1.0+ |
| `labelPrintCanvas(int)` | Print label canvas | 1.0+ |
| `printLabelBitmap(dynamic, {LabelPrintBitmapStyle?})` | Print label bitmap | 1.0+ |
| `labelLearning()` | Label learning | 1.0+ |
| `setPrintModel(int)` | Set print mode 0=thermal 1=label | 1.0+ |
| `labelPrintBitmapDirect(Uint8List, int, int)` | Direct label bitmap print | 2.0 |
| `labelGapSensorCalibration()` | Gap sensor calibration | 2.0 |
| `labelSetPrinterMode(int)` | Set label printer mode | 2.0 |
| `labelQueryInfo(IminLabelInfo)` | Query label info | 2.0 |
| `labelRestoreDefaults()` | Restore label defaults | 2.0 |
| `setLabelContinuousPrint(bool)` | Continuous label print | 2.0 |

### Cash Drawer

| Method | Description | SDK |
|--------|-------------|-----|
| `openCashBox()` | Open cash drawer | 1.0+ |
| `getDrawerStatus()` | Drawer status | 1.0+ |
| `getOpenDrawerTimes()` | Open drawer count | 1.0+ |
| `supportCashBox()` | Check cash drawer support | 2.0 |

### Printer Info

| Method | Description | SDK |
|--------|-------------|-----|
| `getPrinterSerialNumber()` | Serial number | 1.0+ |
| `getPrinterModelName()` | Model name | 1.0+ |
| `getPrinterThermalHead()` | Thermal head model | 1.0+ |
| `getPrinterFirmwareVersion()` | Firmware version | 1.0+ |
| `getPrinterHardwareVersion()` | Hardware version | 1.0+ |
| `getServiceVersion()` | Service version | 1.0+ |
| `getUsbPrinterVidPid()` | USB VID/PID | 1.0+ |
| `getUsbDevicesName()` | USB device name | 1.0+ |
| `getPrinterDensity()` | Print density | 1.0+ |
| `getPrinterPaperDistance()` | Paper distance | 1.0+ |
| `getPrinterPaperType()` | Paper type | 1.0+ |
| `getPrinterCutTimes()` | Cut count | 1.0+ |
| `getPrinterMode()` | Printer mode | 1.0+ |
| `getPrinterTemperature()` | Print head temperature | 2.0 |
| `getPrinterSupplierName()` | Supplier name | 2.0 |
| `getPrinterPatternList()` | Pattern list | 2.0 |
| `getPrinterKnifeReset()` | Knife reset | 2.0 |

### Printer Configuration

| Method | Description | SDK |
|--------|-------------|-----|
| `getPrinterDensityList()` | Available density list | 1.0+ |
| `getPrinterSpeedList()` | Available speed list | 1.0+ |
| `setPrinterSpeed(int)` | Set speed | 1.0+ |
| `getPrinterSpeed()` | Get speed | 1.0+ |
| `getPrinterPaperTypeList()` | Available paper type list | 1.0+ |
| `getFontCodepage()` | Font codepage list | 1.0+ |
| `setFontCodepage(int)` | Set codepage | 1.0+ |
| `getCurCodepage()` | Current codepage | 1.0+ |
| `getEncodeList()` | Encoding list | 1.0+ |
| `getCurEncode()` | Current encoding | 1.0+ |
| `setPrinterEncode(int)` | Set encoding | 1.0+ |
| `setInitIminPrinter(bool)` | Set default printer | 1.0+ |

### Generic Key-Value API

| Method | Description | SDK |
|--------|-------------|-----|
| `setPrinterAction(String, String)` | Generic setting | 2.0 |
| `setPrinterActionList(String, List<String>)` | Generic setting (list) | 2.0 |
| `getPrinterInfoByKey(String)` | Generic query | 2.0 |
| `getPrinterInfoList(String)` | Generic query (list) | 2.0 |
| `getPrinterInfoString(String)` | Generic query (string) | 2.0 |

### RAW Data & Status Monitoring

| Method | Description | SDK |
|--------|-------------|-----|
| `sendRAWData(Uint8List)` | Send raw byte data | 1.0+ |
| `sendRAWDataHexStr(String)` | Send hex string | 1.0+ |
| `regesiterPrinterStatusCallback()` | Register status callback | 2.0 |
| `receiveBroadcastStream` | Status event stream (EventChannel) | 1.0+ |

---

## Detailed API


### Initialization & Status

#### initPrinter() `[1.0+]`

Initialize the printer. Must be called before any print operation.

- Returns: `Future<bool?>`

```dart
await iminPrinter.initPrinter();
```

#### getPrinterStatus() `[1.0+]`

Get printer status.

- Returns: `Future<Map<String, dynamic>>` ‚Ä?contains `code` and `msg` fields

**Status Codes:**

| code | Meaning | Action |
|------|---------|--------|
| -1 | Initialization failed | Check connection, restart app |
| 0 | Normal | - |
| 1 | Not connected / not powered on | Check power and connection |
| 2 | Printer and library mismatch | Update SDK or firmware |
| 3 | Print head open | Close printer cover |
| 4 | Cutter not reset | Reset cutter mechanism |
| 5 | Print head overheated | Wait for cooling |
| 6 | Black label error | Check label type |
| 7 | Paper missing | Install paper roll |
| 8 | Paper running out | Prepare replacement |
| 99 | Other error | Check logs |

```dart
Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
if (status['code'] == '0') {
  print('Printer ready');
} else {
  print('Error: ${status['msg']}');
}
```

#### getSdkVersion() `[1.0+]`

Get SDK version. Returns `"1.0.0"` or `"2.0.0"`.

- Returns: `Future<String?>`

```dart
String? version = await iminPrinter.getSdkVersion();
```

#### initPrinterParams() `[1.0+]`

Reset print parameters to defaults (font, alignment, style, etc.). Does not clear buffer data.

```dart
await iminPrinter.initPrinterParams();
```

#### resetDevice() `[1.0+]`

Restart the printer device.

```dart
await iminPrinter.resetDevice();
```

#### unBindService() `[1.0+]`

Unbind the print service.

```dart
await iminPrinter.unBindService();
```

#### printerSelfChecking() `[1.0+]`

Print a self-test page.

```dart
await iminPrinter.printerSelfChecking();
```

#### openLogs(int open) `[1.0+]`

Toggle print logging.

| Param | Type | Description |
|-------|------|-------------|
| open | int | 1=enable, 0=disable |

```dart
await iminPrinter.openLogs(1);
```

---

### Text Printing

#### printText(String text, {IminTextStyle? style}) `[1.0+]`

Print text.

> ‚ö†Ô∏è **SDK 2.0 behavior**: When `style` is provided, this method automatically routes to `printTextBitmap` (bitmap path) on 2.0 devices, because 2.0's native printText uses ESC/POS commands that don't recognize setTextSize etc. Without `style`, it uses native ESC/POS commands.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| text | String | ‚ú?| Text content |
| style | IminTextStyle | - | Text style |

**IminTextStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| fontSize | int? | Font size |
| fontStyle | IminFontStyle? | normal / bold / italic / boldItalic |
| typeface | IminTypeface? | Typeface |
| align | IminPrintAlign? | left / center / right |
| width | int? | Text width (pixels) ‚ö†Ô∏è Only effective on 1.0 devices |
| space | double? | Line spacing ‚ö†Ô∏è Only effective on 1.0 devices |
| wordWrap | bool? | Auto line wrap ‚ö†Ô∏è Only effective in `printAntiWhiteText` |

> ‚ö†Ô∏è On 2.0 devices, only `fontSize`, `fontStyle`, `typeface`, and `align` are effective when style is provided (bitmap path). `width`, `space`, and `wordWrap` are not passed through.

```dart
// Simple print
await iminPrinter.printText('Hello World');

// With style
await iminPrinter.printText('Title',
  style: IminTextStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    align: IminPrintAlign.center,
  ),
);
```

#### printAntiWhiteText(String text, {IminTextStyle? style}) `[1.0+]`

Print reverse text (white text on black background). Same parameters as `printText`.

```dart
await iminPrinter.printAntiWhiteText('Reverse Text',
  style: IminTextStyle(fontSize: 28, align: IminPrintAlign.center),
);
```

#### printTextBitmap(String text, {IminTextPictureStyle? style}) `[1.0+]`

Print text as bitmap with richer style control.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| text | String | ‚ú?| Text content |
| style | IminTextPictureStyle | - | Bitmap text style |

**IminTextPictureStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| fontSize | int? | Font size |
| fontStyle | IminFontStyle? | Font style |
| typeface | IminTypeface? | Typeface |
| align | IminPrintAlign? | Alignment |
| letterSpacing | double? | Letter spacing |
| underline | bool? | Underline |
| throughline | bool? | Strikethrough |
| lineHeight | double? | Line height |
| reverseWhite | bool? | Reverse white |

> `wordWrap` exists in the class definition but is not used in the `printTextBitmap` implementation. Passing it has no effect.

```dart
await iminPrinter.printTextBitmap('Bitmap Text',
  style: IminTextPictureStyle(
    fontSize: 32,
    fontStyle: IminFontStyle.bold,
    underline: true,
    align: IminPrintAlign.center,
  ),
);
```

#### printColumnsText({required List\<ColumnMaker\> cols}) `[1.0+]`

Print a table row.

> ‚ö†Ô∏è **width is pixel width**, not a proportional ratio. 58mm paper = 384px total, 80mm paper = 576px total. Column widths should not exceed paper width.

**ColumnMaker properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| text | String | '' | Column content |
| width | int | 2 | Column width (pixels) |
| fontSize | int | 26 | Font size |
| align | IminPrintAlign | left | Column alignment |

```dart
// 80mm paper example (576px total width)
await iminPrinter.printColumnsText(cols: [
  ColumnMaker(text: 'Coffee', width: 250, fontSize: 24, align: IminPrintAlign.left),
  ColumnMaker(text: 'x2',     width: 100, fontSize: 24, align: IminPrintAlign.center),
  ColumnMaker(text: '\$7.00', width: 150, fontSize: 24, align: IminPrintAlign.right),
]);
```

#### printColumnsString({required List\<ColumnMaker\> cols}) `[1.0+]`

Print a table row (string mode).

> ‚ö†Ô∏è Unlike `printColumnsText`, the `width` in `printColumnsString` is a proportional weight (e.g. 1:2:1), not pixel width.

#### printTextWithAli(String text, int align) `[2.0]`

Print text with alignment.

| Param | Type | Description |
|-------|------|-------------|
| text | String | Text content |
| align | int | 0=left 1=center 2=right |

```dart
await iminPrinter.printTextWithAli('Centered text', 1);
```

#### printTextWithEncode(String text, String encode) `[2.0]`

Print text with specified encoding.

| Param | Type | Description |
|-------|------|-------------|
| text | String | Text content |
| encode | String | Encoding name |

```dart
await iminPrinter.printTextWithEncode('Text', 'UTF-8');
```

#### printEscPosText(String text, {IminEscPosTextStyle? style}) `[2.0]`

ESC/POS command text printing with font styling support.

> ‚ö†Ô∏è This method temporarily sets ESC/POS font parameters. Call `initPrinterParams()` afterwards to reset.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| text | String | ‚ú?| Text content |
| style | IminEscPosTextStyle | - | ESC/POS text style |

**IminEscPosTextStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| widthMultiple | int? | Width multiple 1-8 |
| heightMultiple | int? | Height multiple 1-8 |
| bold | bool? | Bold |
| italic | bool? | Italic |
| antiWhite | bool? | Reverse white |
| underline | int? | Underline 0=none 1=single 2=double |
| lineSpacing | int? | Line spacing |
| charSpace | int? | Character spacing |
| align | IminPrintAlign? | Alignment |

```dart
await iminPrinter.printEscPosText('Bold Large Text',
  style: IminEscPosTextStyle(
    bold: true,
    widthMultiple: 2,
    heightMultiple: 2,
    align: IminPrintAlign.center,
  ),
);
// Reset
await iminPrinter.initPrinterParams();
```

---

### Text Style Settings

> These are global settings that affect subsequent `printText` (without style) calls. Call `initPrinterParams()` to reset.

#### setTextSize(int size) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| size | int | Font size |

```dart
await iminPrinter.setTextSize(28);
```

#### setTextTypeface(IminTypeface typeface) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| typeface | IminTypeface | typefaceDefault / typefaceMonospace / typefaceDefaultBold / typefaceSansSerif / typefaceSerif |

```dart
await iminPrinter.setTextTypeface(IminTypeface.typefaceMonospace);
```

#### setTextStyle(IminFontStyle style) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| style | IminFontStyle | normal / bold / italic / boldItalic |

```dart
await iminPrinter.setTextStyle(IminFontStyle.bold);
```

#### setAlignment(IminPrintAlign alignment) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| alignment | IminPrintAlign | left / center / right |

```dart
await iminPrinter.setAlignment(IminPrintAlign.center);
```

#### setTextWidth(int width) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| width | int | Text width (pixels). Max 576 for 80mm, 384 for 58mm |

```dart
await iminPrinter.setTextWidth(576);
```

#### setTextLineSpacing(double space) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| space | double | Line spacing |

```dart
await iminPrinter.setTextLineSpacing(1.0);
```

---

### Text Bitmap Style Settings

> These are global settings that affect subsequent `printTextBitmap` calls.

#### setTextBitmapTypeface(IminTypeface typeface) `[1.0+]`

```dart
await iminPrinter.setTextBitmapTypeface(IminTypeface.typefaceDefaultBold);
```

#### setTextBitmapSize(int size) `[1.0+]`

```dart
await iminPrinter.setTextBitmapSize(32);
```

#### setTextBitmapStyle(IminFontStyle style) `[1.0+]`

```dart
await iminPrinter.setTextBitmapStyle(IminFontStyle.bold);
```

#### setTextBitmapStrikeThru(bool strikeThru) `[1.0+]`

```dart
await iminPrinter.setTextBitmapStrikeThru(true);
```

#### setTextBitmapUnderline(bool haveUnderline) `[1.0+]`

```dart
await iminPrinter.setTextBitmapUnderline(true);
```

#### setTextBitmapLineSpacing(double lineHeight) `[1.0+]`

```dart
await iminPrinter.setTextBitmapLineSpacing(1.5);
```

#### setTextBitmapLetterSpacing(double space) `[1.0+]`

```dart
await iminPrinter.setTextBitmapLetterSpacing(2.0);
```

#### setTextBitmapAntiWhite(bool antiWhite) `[1.0+]`

```dart
await iminPrinter.setTextBitmapAntiWhite(true);
```

---

### ESC/POS Font Control

> üî¥ **Global settings warning**: These methods only affect `printEscPosText` or `printText` (without style). They do NOT affect `printTextBitmap`. These are global ‚Ä?you must manually reset after use (e.g. `setFontBold(false)`) or call `initPrinterParams()` to reset all at once.

#### setFontMultiple(int wide, int high) `[2.0]`

Set font width/height multiple.

| Param | Type | Description |
|-------|------|-------------|
| wide | int | Width multiple 1-8 |
| high | int | Height multiple 1-8 |

```dart
await iminPrinter.setFontMultiple(2, 2);
await iminPrinter.printText('2x Width & Height\n');
await iminPrinter.setFontMultiple(1, 1); // Reset
```

#### setFontBold(bool bold) `[2.0]`

```dart
await iminPrinter.setFontBold(true);
await iminPrinter.printText('Bold Text\n');
await iminPrinter.setFontBold(false); // Reset
```

#### setFontItalic(bool italic) `[2.0]`

```dart
await iminPrinter.setFontItalic(true);
await iminPrinter.printText('Italic Text\n');
await iminPrinter.setFontItalic(false);
```

#### setFontAntiWhite(bool antiWhite) `[2.0]`

```dart
await iminPrinter.setFontAntiWhite(true);
await iminPrinter.printText('Reverse Text\n');
await iminPrinter.setFontAntiWhite(false);
```

#### setFontUnderline(int underline) `[2.0]`

| Param | Type | Description |
|-------|------|-------------|
| underline | int | 0=none 1=single 2=double |

```dart
await iminPrinter.setFontUnderline(1);
await iminPrinter.printText('Underlined Text\n');
await iminPrinter.setFontUnderline(0);
```

#### setFontRotate(int rotate) `[2.0]`

| Param | Type | Description |
|-------|------|-------------|
| rotate | int | 0=0¬∞ 1=90¬∞ |

#### setFontDirection(int direction) `[2.0]`

| Param | Type | Description |
|-------|------|-------------|
| direction | int | 0=0¬∞ 1=180¬∞ |

#### setFontLineSpacing(int space) `[2.0]`

```dart
await iminPrinter.setFontLineSpacing(80);
```

#### setFontCharSpace(int space) `[2.0]`

```dart
await iminPrinter.setFontCharSpace(5);
```

#### setFontChineseSpace(int leftSpace, int rightSpace) `[2.0]`

```dart
await iminPrinter.setFontChineseSpace(2, 2);
```

#### setFontChineseSize(int height, int width, int underLine, int chineseType) `[2.0]`

```dart
await iminPrinter.setFontChineseSize(24, 24, 0, 0);
```

#### setFontCharSize(int height, int width, int underLine, int asciiType) `[2.0]`

```dart
await iminPrinter.setFontCharSize(24, 24, 0, 0);
```

#### setFontChineseMode(int mode) `[2.0]`

```dart
await iminPrinter.setFontChineseMode(0);
```

#### setFontCountryCode(int country) `[2.0]`

```dart
await iminPrinter.setFontCountryCode(0);
```

#### getFontCountryCode() `[2.0]`

- Returns: `Future<List<String>?>`

```dart
List<String>? codes = await iminPrinter.getFontCountryCode();
```


---

### Image Printing

#### printSingleBitmap(dynamic img, {IminPictureStyle? pictureStyle}) `[1.0+]`

Print a single image. Supports URL string or `Uint8List` byte data.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| img | dynamic | ‚ú?| Image URL or Uint8List |
| pictureStyle | IminPictureStyle | - | Image style |

**IminPictureStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| alignment | IminPrintAlign? | Alignment |
| width | int? | Image width (pixels) |
| height | int? | Image height (pixels) |

```dart
// URL
await iminPrinter.printSingleBitmap(
  'https://example.com/logo.png',
  pictureStyle: IminPictureStyle(
    alignment: IminPrintAlign.center,
    width: 250,
    height: 80,
  ),
);

// Byte data
Uint8List imageBytes = await loadImage();
await iminPrinter.printSingleBitmap(imageBytes,
  pictureStyle: IminPictureStyle(alignment: IminPrintAlign.center),
);
```

#### printSingleBitmapWithTranslation(dynamic img, {IminPictureStyle? pictureStyle}) `[1.0+]`

Print a single image with translation handling. Same parameters as `printSingleBitmap`.

#### printMultiBitmap(List\<dynamic\> imgs, {IminPictureStyle? pictureStyle}) `[1.0+]`

Print multiple images.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| imgs | List\<dynamic\> | ‚ú?| List of image URLs or Uint8List |
| pictureStyle | IminPictureStyle | - | Image style |

```dart
await iminPrinter.printMultiBitmap(
  ['https://example.com/img1.png', 'https://example.com/img2.png'],
  pictureStyle: IminPictureStyle(alignment: IminPrintAlign.center, width: 250, height: 80),
);
```

#### printSingleBitmapBlackWhite(dynamic img, {IminBaseStyle? baseStyle}) `[1.0+]`

Print a black & white image.

> ‚ö†Ô∏è The `baseStyle` parameter is not passed through in the current implementation. Passing it has no effect. Image size is determined by the original image.

```dart
await iminPrinter.printSingleBitmapBlackWhite(imageBytes);
```

#### printSingleBitmapColorChart(dynamic img, {IminPictureStyle? pictureStyle}) `[1.0+]`

Print a color chart image. Same parameters as `printSingleBitmap`.

---

### Barcode Printing

#### printBarCode(IminBarcodeType barCodeType, String barCodeContent, {IminBarCodeStyle? style}) `[1.0+]`

Print a barcode.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| barCodeType | IminBarcodeType | ‚ú?| Barcode type |
| barCodeContent | String | ‚ú?| Barcode content |
| style | IminBarCodeStyle | - | Barcode style |

**IminBarcodeType enum:**

| Value | Description |
|-------|-------------|
| upcA | UPC-A |
| upcE | UPC-E |
| jan13 | EAN-13 |
| jan8 | EAN-8 |
| code39 | Code 39 |
| itf | ITF |
| codabar | Codabar |
| code93 | Code 93 |
| code128 | Code 128 |

**IminBarCodeStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| width | int? | Barcode width 2-6 |
| height | int? | Barcode height 1-255 |
| align | IminPrintAlign? | Alignment |
| position | IminBarcodeTextPos? | HRI position: noText / textAbove / textBelow / both |

```dart
await iminPrinter.printBarCode(
  IminBarcodeType.code128,
  '{C009999789101',
  style: IminBarCodeStyle(
    width: 3,
    height: 100,
    align: IminPrintAlign.center,
    position: IminBarcodeTextPos.textBelow,
  ),
);
```

#### printBarCodeToBitmapFormat(String barCodeContent, int width, int height, IminBarCodeToBitmapFormat codeFormat) `[1.0+]`

Print barcode in bitmap format.

| Param | Type | Description |
|-------|------|-------------|
| barCodeContent | String | Barcode content |
| width | int | Width |
| height | int | Height |
| codeFormat | IminBarCodeToBitmapFormat | Format: aztec / codabar / code39 / code93 / code128 / dataMatrix / ean13 / itf / maxicode / pdf417 / qrCode / rss14 / rssExpanded / upcA / upcE / upcEanExteNsion |

```dart
await iminPrinter.printBarCodeToBitmapFormat('1234567890', 300, 120, IminBarCodeToBitmapFormat.code128);
```

#### setBarCodeWidth(int width) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| width | int | Barcode width 2-6 |

#### setBarCodeHeight(int height) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| height | int | Barcode height 1-255 |

#### setBarCodeContentPrintPos(IminBarcodeTextPos position) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| position | IminBarcodeTextPos | noText(0) / textAbove(1) / textBelow(2) / both(3) |

---

### QR Code Printing

#### printQrCode(String data, {IminQrCodeStyle? qrCodeStyle}) `[1.0+]`

Print a QR code.

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| data | String | ‚ú?| QR code content |
| qrCodeStyle | IminQrCodeStyle | - | QR code style |

**IminQrCodeStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| qrSize | int? | QR code size |
| align | IminPrintAlign? | Alignment |
| leftMargin | int? | Left margin |
| errorCorrectionLevel | IminQrcodeCorrectionLevel? | Error correction: levelL(48) ~7% / levelM(49) ~15% / levelQ(50) ~25% / levelH(51) ~30% |

```dart
await iminPrinter.printQrCode('https://www.imin.sg',
  qrCodeStyle: IminQrCodeStyle(
    qrSize: 6,
    align: IminPrintAlign.center,
    errorCorrectionLevel: IminQrcodeCorrectionLevel.levelH,
  ),
);
```

#### setQrCodeSize(int size) `[1.0+]`

```dart
await iminPrinter.setQrCodeSize(5);
```

#### setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel level) `[1.0+]`

```dart
await iminPrinter.setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel.levelH);
```

#### setLeftMargin(int margin) `[1.0+]`

Set left margin for QR codes and barcodes.

```dart
await iminPrinter.setLeftMargin(5);
```

#### setCodeAlignment(IminPrintAlign alignment) `[1.0+]`

Set alignment for codes (barcode/QR code).

```dart
await iminPrinter.setCodeAlignment(IminPrintAlign.center);
```

#### printDoubleQR({required IminDoubleQRCodeStyle qrCode1, required IminDoubleQRCodeStyle qrCode2, int? doubleQRSize}) `[1.0+]`

Print double QR codes side by side.

**IminDoubleQRCodeStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| text | String | QR code content |
| level | int? | Error correction level 1-3 |
| leftMargin | int? | Left margin 0-576 |
| version | int? | Version 1-40 |

```dart
await iminPrinter.printDoubleQR(
  qrCode1: IminDoubleQRCodeStyle(text: 'www.imin.sg'),
  qrCode2: IminDoubleQRCodeStyle(text: 'www.google.com'),
  doubleQRSize: 5,
);
```

#### setDoubleQRSize(int) / setDoubleQR1Level(int) / setDoubleQR2Level(int) `[1.0+]`

Double QR code size and error correction level settings.

#### setDoubleQR1MarginLeft(int) / setDoubleQR2MarginLeft(int) `[1.0+]`

Double QR code left margin settings, range 0-576.

#### setDoubleQR1Version(int) / setDoubleQR2Version(int) `[1.0+]`

Double QR code version settings, range 1-40.

---

### Advanced 2D Codes

#### print2DCode(String data, int symbology, int moduleSize, int errorLevel, int align) `[2.0]`

Generic 2D code printing.

| Param | Type | Description |
|-------|------|-------------|
| data | String | Content |
| symbology | int | Code type |
| moduleSize | int | Module size |
| errorLevel | int | Error correction level |
| align | int | Alignment 0=left 1=center 2=right |

```dart
await iminPrinter.print2DCode('https://www.imin.sg', 0, 6, 2, 1);
```

#### printPDF417(String data, int columns, int rows, int moduleWidth, int rowHeight, int errorLevel, int selectOptions, int align) `[2.0]`

Print PDF417 code.

| Param | Type | Description |
|-------|------|-------------|
| data | String | Content |
| columns | int | Columns |
| rows | int | Rows |
| moduleWidth | int | Module width |
| rowHeight | int | Row height |
| errorLevel | int | Error correction level |
| selectOptions | int | Options |
| align | int | Alignment 0=left 1=center 2=right |

```dart
await iminPrinter.printPDF417('PDF417 Data', 3, 5, 2, 5, 2, 0, 1);
```

#### printDataMatrix(String data, int symbolType, int columns, int rows, int moduleSize, int align) `[2.0]`

```dart
await iminPrinter.printDataMatrix('DataMatrix Data', 0, 0, 0, 4, 1);
```

#### printAztecCode(String data, int modeType, int dataLayers, int moduleSize, int errorLevel, int align) `[2.0]`

```dart
await iminPrinter.printAztecCode('Aztec Data', 0, 0, 6, 2, 1);
```

#### printMaxiCode(String data, int modeType, int align) `[2.0]`

```dart
await iminPrinter.printMaxiCode('MaxiCode Data', 4, 1);
```

---

### Paper Feed & Cut

#### printAndLineFeed() `[1.0+]`

Feed one line of paper.

```dart
await iminPrinter.printAndLineFeed();
```

#### printAndFeedPaper(int height) `[1.0+]`

Feed paper by specified height.

| Param | Type | Description |
|-------|------|-------------|
| height | int | Feed height 1-1016 |

```dart
await iminPrinter.printAndFeedPaper(100);
```

#### setPageFormat({int? style}) `[1.0+]`

Set paper format.

| Param | Type | Description |
|-------|------|-------------|
| style | int? | 0=80mm 1=58mm |

```dart
await iminPrinter.setPageFormat(style: 0); // 80mm
```

#### partialCut() `[1.0+]`

Partial paper cut. Only for devices with cutter hardware.

```dart
await iminPrinter.partialCut();
```

#### fullCut() `[1.0+]`

Full paper cut. Only for devices with cutter hardware.

```dart
await iminPrinter.fullCut();
```

#### printAndQuitPaper(int value) `[2.0]`

Print and retract paper.

| Param | Type | Description |
|-------|------|-------------|
| value | int | Retract distance |

```dart
await iminPrinter.printAndQuitPaper(100);
```

#### partialCutAndFeedPaper(int length) `[2.0]`

Partial cut and feed paper.

| Param | Type | Description |
|-------|------|-------------|
| length | int | Feed length |

```dart
await iminPrinter.partialCutAndFeedPaper(50);
```

#### fullCutAndFeedPaper(int length) `[2.0]`

Full cut and feed paper.

| Param | Type | Description |
|-------|------|-------------|
| length | int | Feed length |

```dart
await iminPrinter.fullCutAndFeedPaper(50);
```

---

### Transaction Printing (Buffer)

Transaction printing lets you cache multiple print commands and submit them at once for better efficiency and consistency.

```dart
try {
  // 1. Enter buffer mode
  await iminPrinter.enterPrinterBuffer(true);

  // 2. Add print commands
  await iminPrinter.printText('Line 1');
  await iminPrinter.printText('Line 2');
  await iminPrinter.printText('Line 3');

  // 3. Commit and print
  await iminPrinter.commitPrinterBuffer();

  // 4. Exit buffer
  await iminPrinter.exitPrinterBuffer(true);
} catch (e) {
  // Discard buffer on error
  await iminPrinter.exitPrinterBuffer(false);
}
```

#### enterPrinterBuffer(bool isClean) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| isClean | bool | Whether to clear previous buffer |

#### commitPrinterBuffer() `[1.0+]`

Commit buffer and execute printing.

#### exitPrinterBuffer(bool isCommit) `[1.0+]`

| Param | Type | Description |
|-------|------|-------------|
| isCommit | bool | true=commit then exit, false=discard then exit |

#### commitPrinterBufferWithCallback() `[2.0]`

Commit buffer with callback.

- Returns: `Future<bool?>`

```dart
bool? ok = await iminPrinter.commitPrinterBufferWithCallback();
```

#### exitPrinterBufferWithCallback(bool isCommit) `[2.0]`

Exit buffer with callback.

- Returns: `Future<bool?>`

```dart
bool? ok = await iminPrinter.exitPrinterBufferWithCallback(true);
```


---

### Label Printing

Label printing uses a canvas workflow: initialize canvas ‚Ü?add elements (text/barcode/QR/image/shape) ‚Ü?print canvas.

#### labelInitCanvas({LabelCanvasStyle? labelCanvasStyle}) `[1.0+]`

Initialize label canvas.

**LabelCanvasStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| width | int? | 50 | Canvas width |
| height | int? | 50 | Canvas height |
| posX | int? | 0 | X offset |
| posY | int? | 0 | Y offset |
| enableReverse | bool? | false | Reverse |
| enableMirror | bool? | false | Mirror |

```dart
await iminPrinter.labelInitCanvas(
  labelCanvasStyle: LabelCanvasStyle(width: 400, height: 240, posX: 0, posY: 0),
);
```

#### labelAddText(String text, {LabelTextStyle? labelTextStyle}) `[1.0+]`

Add text to label.

**LabelTextStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| posX | int? | 0 | X position |
| posY | int? | 0 | Y position |
| textSize | int? | 24 | Font size |
| textWidthRatio | int? | 1 | Width ratio |
| textHeightRatio | int? | 1 | Height ratio |
| width | int? | -1 | Text area width (-1=auto) |
| height | int? | -1 | Text area height (-1=auto) |
| align | AlignLabel? | DEFAULT | Alignment: DEFAULT / LEFT / CENTER / RIGHT |
| rotate | Rotate? | ROTATE_0 | Rotation: ROTATE_0 / ROTATE_90 / ROTATE_180 / ROTATE_270 |
| textSpace | int? | 0 | Character spacing |
| enableBold | bool? | false | Bold |
| enableUnderline | bool? | false | Underline |
| enableStrikethrough | bool? | false | Strikethrough |
| enableItalics | bool? | false | Italic |
| enAntiColor | bool? | false | Reverse color |

```dart
await iminPrinter.labelAddText('Product Name',
  labelTextStyle: LabelTextStyle(posX: 20, posY: 20, textSize: 28, enableBold: true),
);
```

#### labelAddBarCode(String barCode, {LabelBarCodeStyle? barCodeStyle}) `[1.0+]`

Add barcode to label.

**LabelBarCodeStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| posX | int? | 0 | X position |
| posY | int? | 0 | Y position |
| dotWidth | int? | 2 | Dot width |
| barHeight | int? | 162 | Bar height |
| readable | HumanReadable? | HIDE | HRI text: HIDE / POS_ONE / POS_TWO / POS_THREE |
| symbology | Symbology? | CODE39 | Symbology: UPCA / UPCE / EAN13 / EAN8 / CODE39 / ITF / CODABAR / CODE93 / CODE128 |
| align | AlignLabel? | DEFAULT | Alignment |
| rotate | Rotate? | ROTATE_0 | Rotation |
| width | int? | -1 | Barcode area width (-1=auto) |
| height | int? | -1 | Barcode area height (-1=auto) |

```dart
await iminPrinter.labelAddBarCode('{B123456',
  barCodeStyle: LabelBarCodeStyle(
    posX: 20, posY: 100,
    symbology: Symbology.CODE128,
    barHeight: 60,
    readable: HumanReadable.POS_TWO,
  ),
);
```

#### labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle}) `[1.0+]`

Add QR code to label.

**LabelQrCodeStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| posX | int? | 0 | X position |
| posY | int? | 0 | Y position |
| size | int? | 4 | QR code size |
| errorLevel | ErrorLevel? | L | Error correction: L / M / Q / H |
| rotate | Rotate? | ROTATE_0 | Rotation |
| width | int? | -1 | QR code area width (-1=auto) |
| height | int? | -1 | QR code area height (-1=auto) |

```dart
await iminPrinter.labelAddQrCode('https://www.imin.sg',
  qrCodeStyle: LabelQrCodeStyle(posX: 280, posY: 50, size: 6, errorLevel: ErrorLevel.M),
);
```

#### labelAddArea({LabelAreaStyle? areaStyle}) `[1.0+]`

Add shape/area to label.

**LabelAreaStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| style | Shape | RECT_FILL | Shape: RECT_FILL / RECT_WHITE / RECT_REVERSE / BOX / CIRCLE / OVAL / PATH |
| posX | int? | 0 | Start X |
| posY | int? | 0 | Start Y |
| endX | int? | 50 | End X (PATH mode) |
| endY | int? | 50 | End Y (PATH mode) |
| width | int? | 50 | Width |
| height | int? | 50 | Height |
| thick | int? | 1 | Line thickness |

```dart
await iminPrinter.labelAddArea(
  areaStyle: LabelAreaStyle(style: Shape.BOX, posX: 10, posY: 10, width: 380, height: 220, thick: 2),
);
```

#### labelAddBitmap(dynamic img, {LabelBitmapStyle? addBitmapStyle}) `[1.0+]`

Add image to label.

**LabelBitmapStyle properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| posX | int? | 0 | X position |
| posY | int? | 0 | Y position |
| algorithm | ImageAlgorithm? | BINARIZATION | Algorithm: BINARIZATION / DITHERING |
| value | int? | 200 | Threshold |
| width | int? | -1 | Width (-1=auto) |
| height | int? | -1 | Height (-1=auto) |

#### labelPrintCanvas(int printCount) `[1.0+]`

Print the label canvas.

| Param | Type | Description |
|-------|------|-------------|
| printCount | int | Number of copies |

```dart
await iminPrinter.labelPrintCanvas(1);
```

#### printLabelBitmap(dynamic img, {LabelPrintBitmapStyle? printBitmapStyle}) `[1.0+]`

Print label bitmap.

**LabelPrintBitmapStyle properties:**

| Property | Type | Description |
|----------|------|-------------|
| width | int? | Width |
| height | int? | Height |

#### labelLearning() `[1.0+]`

Label learning (auto-detect label gap).

```dart
await iminPrinter.labelLearning();
```

#### setPrintModel(int printModel) `[1.0+]`

Set print mode.

| Param | Type | Description |
|-------|------|-------------|
| printModel | int | 0=thermal 1=label |

```dart
await iminPrinter.setPrintModel(1); // Switch to label mode
```

#### labelPrintBitmapDirect(Uint8List bitmap, int width, int height) `[2.0]`

Direct label bitmap printing.

| Param | Type | Description |
|-------|------|-------------|
| bitmap | Uint8List | Bitmap data |
| width | int | Width |
| height | int | Height |

#### labelGapSensorCalibration() `[2.0]`

Gap sensor calibration.

- Returns: `Future<String?>`

```dart
String? result = await iminPrinter.labelGapSensorCalibration();
```

#### labelSetPrinterMode(int mode) `[2.0]`

Set label printer mode.

| Param | Type | Description |
|-------|------|-------------|
| mode | int | Mode value |

#### labelQueryInfo(IminLabelInfo labelInfo) `[2.0]`

Query label information.

- Returns: `Future<String?>`

**IminLabelInfo enum:**

| Value | Description |
|-------|-------------|
| MODEL | Model |
| VERSION | Version |
| HEIGHT | Height |
| DENSITY | Density |
| SPEED | Speed |
| MODE | Mode |
| GAP_OFFSET | Gap offset |
| PRINT_LENGTH | Print length |
| NO_PAPER_THRESHOLD | No paper threshold |
| HAS_PAPER_THRESHOLD | Has paper threshold |
| THRESHOLD_ADJUSTMENT | Threshold adjustment |
| ORIGINAL_STATUS | Original status |
| LABEL_STATUS | Label status |
| PAPER_STATUS | Paper status |
| HOST_RESULT | Host result |
| GAP_ERROR | Gap error |

```dart
String? model = await iminPrinter.labelQueryInfo(IminLabelInfo.MODEL);
String? version = await iminPrinter.labelQueryInfo(IminLabelInfo.VERSION);
```

#### labelRestoreDefaults() `[2.0]`

Restore label defaults.

- Returns: `Future<bool?>`

```dart
bool? ok = await iminPrinter.labelRestoreDefaults();
```

#### setLabelContinuousPrint(bool enable) `[2.0]`

Set continuous label printing.

| Param | Type | Description |
|-------|------|-------------|
| enable | bool | true=enable false=disable |

```dart
await iminPrinter.setLabelContinuousPrint(true);
```

---

### Full Label Printing Example

```dart
Future<void> printProductLabel() async {
  // Initialize canvas (50mm x 30mm, multiply by 8 for pixels)
  await iminPrinter.labelInitCanvas(
    labelCanvasStyle: LabelCanvasStyle(width: 400, height: 240, posX: 48),
  );

  // Add title
  await iminPrinter.labelAddText('Fuji Apple',
    labelTextStyle: LabelTextStyle(posX: 20, posY: 20, textSize: 28, enableBold: true),
  );

  // Add price
  await iminPrinter.labelAddText('\$16.98',
    labelTextStyle: LabelTextStyle(posX: 20, posY: 60, textSize: 40, enableBold: true),
  );

  // Add barcode
  await iminPrinter.labelAddBarCode('{B123456',
    barCodeStyle: LabelBarCodeStyle(
      posX: 20, posY: 120,
      symbology: Symbology.CODE128,
      dotWidth: 2, barHeight: 50,
      readable: HumanReadable.POS_TWO,
    ),
  );

  // Add border
  await iminPrinter.labelAddArea(
    areaStyle: LabelAreaStyle(style: Shape.BOX, posX: 5, posY: 5, width: 390, height: 230, thick: 2),
  );

  // Print 1 copy
  await iminPrinter.labelPrintCanvas(1);
}
```

---

### Cash Drawer

#### openCashBox() `[1.0+]`

Open cash drawer.

```dart
await iminPrinter.openCashBox();
```

#### getDrawerStatus() `[1.0+]`

Get cash drawer status.

- Returns: `Future<bool?>`

```dart
bool? isOpen = await iminPrinter.getDrawerStatus();
```

#### getOpenDrawerTimes() `[1.0+]`

Get cash drawer open count.

- Returns: `Future<int?>`

```dart
int? times = await iminPrinter.getOpenDrawerTimes();
```

#### supportCashBox() `[2.0]`

Check if device supports cash drawer.

- Returns: `Future<bool?>`

```dart
bool? supported = await iminPrinter.supportCashBox();
```

---

### Printer Info

All methods below return `Future<String?>` or `Future<int?>` with no parameters.

```dart
String? serialNumber = await iminPrinter.getPrinterSerialNumber();
String? modelName = await iminPrinter.getPrinterModelName();
String? thermalHead = await iminPrinter.getPrinterThermalHead();
String? firmwareVersion = await iminPrinter.getPrinterFirmwareVersion();
String? hardwareVersion = await iminPrinter.getPrinterHardwareVersion();
String? serviceVersion = await iminPrinter.getServiceVersion();
String? usbVidPid = await iminPrinter.getUsbPrinterVidPid();
String? usbName = await iminPrinter.getUsbDevicesName();
int? density = await iminPrinter.getPrinterDensity();
String? paperDistance = await iminPrinter.getPrinterPaperDistance();
int? paperType = await iminPrinter.getPrinterPaperType();
String? cutTimes = await iminPrinter.getPrinterCutTimes();
int? mode = await iminPrinter.getPrinterMode();

// 2.0 only
String? temperature = await iminPrinter.getPrinterTemperature();
String? supplierName = await iminPrinter.getPrinterSupplierName();
List<String>? patternList = await iminPrinter.getPrinterPatternList();
String? knifeReset = await iminPrinter.getPrinterKnifeReset();
```

---

### Printer Configuration

```dart
// Density
List<String>? densityList = await iminPrinter.getPrinterDensityList();

// Speed
List<String>? speedList = await iminPrinter.getPrinterSpeedList();
await iminPrinter.setPrinterSpeed(3);
int? speed = await iminPrinter.getPrinterSpeed();

// Paper type
List<String>? paperTypes = await iminPrinter.getPrinterPaperTypeList();

// Codepage
List<String>? codepages = await iminPrinter.getFontCodepage();
await iminPrinter.setFontCodepage(0);
String? curCodepage = await iminPrinter.getCurCodepage();

// Encoding
List<String>? encodeList = await iminPrinter.getEncodeList();
String? curEncode = await iminPrinter.getCurEncode();
await iminPrinter.setPrinterEncode(0);

// Default printer
await iminPrinter.setInitIminPrinter(true);
```

---

### Generic Key-Value API

Generic printer setting and query interface for accessing advanced features.

#### setPrinterAction(String keyName, String keyValue) `[2.0]`

- Returns: `Future<bool?>`

```dart
bool? ok = await iminPrinter.setPrinterAction('key', 'value');
```

#### setPrinterActionList(String keyName, List\<String\> keyValue) `[2.0]`

- Returns: `Future<bool?>`

#### getPrinterInfoByKey(String keyName) `[2.0]`

- Returns: `Future<String?>`

#### getPrinterInfoList(String keyName) `[2.0]`

- Returns: `Future<List<String>?>`

#### getPrinterInfoString(String keyName) `[2.0]`

- Returns: `Future<String?>`

---

### RAW Data & Status Monitoring

#### sendRAWData(Uint8List bytes) `[1.0+]`

Send raw ESC/POS byte data.

```dart
await iminPrinter.sendRAWData(Uint8List.fromList([0x1B, 0x40])); // ESC @ initialize
```

#### sendRAWDataHexStr(String hex) `[1.0+]`

Send hex string.

```dart
await iminPrinter.sendRAWDataHexStr('0A'); // Line feed
```

#### regesiterPrinterStatusCallback() `[2.0]`

Register printer status change callback. After registration, listen via `receiveBroadcastStream`.

```dart
await iminPrinter.regesiterPrinterStatusCallback();

iminPrinter.receiveBroadcastStream.listen((status) {
  print('Printer status changed: $status');
});
```
