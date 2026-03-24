import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'imin_printer_method_channel.dart';
import 'enums.dart';
import 'imin_style.dart';
import 'column_maker.dart';

abstract class IminPrinterPlatform extends PlatformInterface {
  /// Constructs a IminPrinterPlatform.
  IminPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static IminPrinterPlatform _instance = MethodChannelIminPrinter();

  /// The default instance of [IminPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelIminPrinter].
  static IminPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IminPrinterPlatform] when
  /// they register themselves.
  static set instance(IminPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<dynamic> initEventChannel() {
    throw UnimplementedError('initEventChannel() has not been implemented.');
  }

  Future<String?> getSdkVersion() {
    throw UnimplementedError('getSdkVersion() has not been implemented.');
  }

  Future<bool?> initPrinter() {
    throw UnimplementedError('initPrinter() has not been implemented.');
  }

  Future<Map<String, dynamic>> getPrinterStatus() {
    throw UnimplementedError('getPrinterStatus() has not been implemented.');
  }

  Future<void> setTextSize(int size) {
    throw UnimplementedError('setTextSize() has not been implemented.');
  }

  Future<void> setTextTypeface(IminTypeface typeface) {
    throw UnimplementedError('setTextTypeface() has not been implemented.');
  }

  Future<void> setTextStyle(IminFontStyle style) {
    throw UnimplementedError('setTextStyle() has not been implemented.');
  }

  Future<void> setAlignment(IminPrintAlign alignment) {
    throw UnimplementedError('setAlignment() has not been implemented.');
  }

  Future<void> setTextLineSpacing(double space) {
    throw UnimplementedError('setTextLineSpacing() has not been implemented.');
  }

  Future<void> printText(String text, {IminTextStyle? style}) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<void> printAntiWhiteText(String text, {IminTextStyle? style}) {
    throw UnimplementedError('printAntiWhiteText() has not been implemented.');
  }

  Future<void> setTextWidth(int width) {
    throw UnimplementedError('setTextWidth() has not been implemented.');
  }

  Future<void> printAndLineFeed() {
    throw UnimplementedError('printAndLineFeed() has not been implemented.');
  }

  Future<void> printAndFeedPaper(int height) {
    throw UnimplementedError('printAndFeedPaper() has not been implemented.');
  }

  Future<void> printColumnsText({required List<ColumnMaker> cols}) {
    throw UnimplementedError('printColumnsText() has not been implemented.');
  }

  Future<void> setPageFormat({int? style}) {
    throw UnimplementedError('setPageFormat() has not been implemented.');
  }

  Future<void> partialCut() {
    throw UnimplementedError('partialCut() has not been implemented.');
  }

  Future<void> printSingleBitmap(dynamic img,
      {IminPictureStyle? pictureStyle}) {
    throw UnimplementedError('printSingleBitmap() has not been implemented.');
  }

  Future<void> printSingleBitmapWithTranslation(dynamic img,
      {IminPictureStyle? pictureStyle}) {
    throw UnimplementedError(
        'printSingleBitmapWithTranslation() has not been implemented.');
  }

  Future<void> printMultiBitmap(List<dynamic> imgs,
      {IminPictureStyle? pictureStyle}) {
    throw UnimplementedError('printMultiBitmap() has not been implemented.');
  }

  Future<void> printSingleBitmapBlackWhite(dynamic img,
      {IminBaseStyle? baseStyle}) {
    throw UnimplementedError(
        'printSingleBitmapBlackWhite() has not been implemented.');
  }

  Future<void> setQrCodeSize(int qrSize) {
    throw UnimplementedError('setQrCodeSize() has not been implemented.');
  }

  Future<void> setLeftMargin(int margin) {
    throw UnimplementedError('setLeftMargin() has not been implemented.');
  }

  Future<void> setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel level) {
    throw UnimplementedError(
        'setQrCodeErrorCorrectionLev() has not been implemented.');
  }

  Future<void> printQrCode(String data, {IminQrCodeStyle? qrCodeStyle}) {
    throw UnimplementedError('printQrCode() has not been implemented.');
  }

  Future<void> setBarCodeWidth(int width) {
    throw UnimplementedError('setBarCodeWidth() has not been implemented.');
  }

  Future<void> setBarCodeHeight(int height) {
    throw UnimplementedError('setBarCodeHeight() has not been implemented.');
  }

  Future<void> setBarCodeContentPrintPos(IminBarcodeTextPos position) {
    throw UnimplementedError(
        'setBarCodeContentPrintPos() has not been implemented.');
  }

  Future<void> printBarCode(IminBarcodeType barCodeType, String barCodeContent,
      {IminBarCodeStyle? style}) {
    throw UnimplementedError('printBarCode() has not been implemented.');
  }

  Future<void> printBarCodeToBitmapFormat(String barCodeContent, int width,
      int height, IminBarCodeToBitmapFormat codeFormat) {
    throw UnimplementedError(
        'printBarCodeToBitmapFormat() has not been implemented.');
  }

  Future<void> setDoubleQRSize(int size) {
    throw UnimplementedError('setDoubleQRSize() has not been implemented.');
  }

  Future<void> setDoubleQR1Level(int level) {
    throw UnimplementedError('setDoubleQR1Level() has not been implemented.');
  }

  Future<void> setDoubleQR2Level(int level) {
    throw UnimplementedError('setDoubleQR1Level() has not been implemented.');
  }

  Future<void> setDoubleQR1MarginLeft(int leftMargin) {
    throw UnimplementedError(
        'setDoubleQR1MarginLeft() has not been implemented.');
  }

  Future<void> setDoubleQR2MarginLeft(int leftMargin) {
    throw UnimplementedError(
        'setDoubleQR2MarginLeft() has not been implemented.');
  }

  Future<void> setDoubleQR1Version(int version) {
    throw UnimplementedError('setDoubleQR1Version() has not been implemented.');
  }

  Future<void> setDoubleQR2Version(int version) {
    throw UnimplementedError('setDoubleQR2Version() has not been implemented.');
  }

  Future<void> printDoubleQR(
      {required IminDoubleQRCodeStyle qrCode1,
      required IminDoubleQRCodeStyle qrCode2,
      int? doubleQRSize}) {
    throw UnimplementedError('printDoubleQR() has not been implemented.');
  }

  Future<void> setInitIminPrinter(bool isDefaultPrinter) {
    throw UnimplementedError('setInitIminPrinter() has not been implemented.');
  }

  Future<void> resetDevice() {
    throw UnimplementedError('resetDevice() has not been implemented.');
  }

  Future<void> openCashBox() {
    throw UnimplementedError('openCashBox() has not been implemented.');
  }

  Future<void> unBindService() {
    throw UnimplementedError('unBindService() has not been implemented.');
  }

  Future<void> initPrinterParams() {
    throw UnimplementedError('initPrinterParams() has not been implemented.');
  }

  Future<String?> getPrinterSerialNumber() {
    throw UnimplementedError(
        'getPrinterSerialNumber() has not been implemented.');
  }

  Future<String?> getPrinterModelName() {
    throw UnimplementedError('getPrinterModelName() has not been implemented.');
  }

  Future<String?> getPrinterThermalHead() {
    throw UnimplementedError(
        'getPrinterThermalHead() has not been implemented.');
  }

  Future<String?> getPrinterFirmwareVersion() {
    throw UnimplementedError(
        'getPrinterFirmwareVersion() has not been implemented.');
  }

  Future<String?> getServiceVersion() {
    throw UnimplementedError('getServiceVersion() has not been implemented.');
  }

  Future<String?> getPrinterHardwareVersion() {
    throw UnimplementedError('getServiceVersion() has not been implemented.');
  }

  Future<String?> getUsbPrinterVidPid() {
    throw UnimplementedError('getUsbPrinterVidPid() has not been implemented.');
  }

  Future<String?> getUsbDevicesName() {
    throw UnimplementedError('getUsbDevicesName() has not been implemented.');
  }

  Future<int?> getPrinterDensity() {
    throw UnimplementedError('getPrinterDensity() has not been implemented.');
  }

  Future<String?> getPrinterPaperDistance() {
    throw UnimplementedError(
        'getPrinterPaperDistance() has not been implemented.');
  }

  Future<int?> getPrinterPaperType() {
    throw UnimplementedError('getPrinterPaperType() has not been implemented.');
  }

  Future<String?> getPrinterCutTimes() {
    throw UnimplementedError('getPrinterCutTimes() has not been implemented.');
  }

  Future<int?> getPrinterMode() {
    throw UnimplementedError('getPrinterMode() has not been implemented.');
  }

  Future<bool?> getDrawerStatus() {
    throw UnimplementedError('getDrawerStatus() has not been implemented.');
  }

  Future<void> setPrinterDensity(IminPrinterDensity density) {
    throw UnimplementedError('setPrinterDensity() has not been implemented.');
  }

  Future<void> setPrinterMode() {
    throw UnimplementedError('getPrinterMode() has not been implemented.');
  }

  Future<int?> getOpenDrawerTimes() {
    throw UnimplementedError('getOpenDrawerTimes() has not been implemented.');
  }

  Future<void> printerSelfChecking() {
    throw UnimplementedError('printerSelfChecking() has not been implemented.');
  }

  Future<void> sendRAWData(Uint8List bytes) {
    throw UnimplementedError('sendRAWData() has not been implemented.');
  }

  Future<void> fullCut() {
    throw UnimplementedError('fullCut() has not been implemented.');
  }

  Future<void> setCodeAlignment(IminPrintAlign alignment) {
    throw UnimplementedError('setCodeAlignment() has not been implemented.');
  }

  Future<void> setTextBitmapTypeface(IminTypeface typeface) {
    throw UnimplementedError(
        'setTextBitmapTypeface() has not been implemented.');
  }

  Future<void> setTextBitmapSize(int size) {
    throw UnimplementedError('setTextBitmapSize() has not been implemented.');
  }

  Future<void> setTextBitmapStyle(IminFontStyle style) {
    throw UnimplementedError('setTextBitmapStyle() has not been implemented.');
  }

  Future<void> setTextBitmapStrikeThru(bool strikeThru) {
    throw UnimplementedError(
        'setTextBitmapStrikeThru() has not been implemented.');
  }

  Future<void> setTextBitmapUnderline(bool haveUnderline) {
    throw UnimplementedError(
        'setTextBitmapUnderline() has not been implemented.');
  }

  Future<void> setTextBitmapLineSpacing(double lineHeight) {
    throw UnimplementedError(
        'setTextBitmapLineSpacing() has not been implemented.');
  }

  Future<void> setTextBitmapLetterSpacing(double space) {
    throw UnimplementedError(
        'setTextBitmapLetterSpacing() has not been implemented.');
  }

  Future<void> setTextBitmapAntiWhite(bool antiWhite) {
    throw UnimplementedError(
        'setTextBitmapLetterSpacing() has not been implemented.');
  }

  Future<void> printTextBitmap(String text, {IminTextPictureStyle? style}) {
    throw UnimplementedError('printTextBitmap() has not been implemented.');
  }

  Future<void> printSingleBitmapColorChart(dynamic img,
      {IminPictureStyle? pictureStyle}) {
    throw UnimplementedError(
        'printSingeBitmapColorChart() has not been implemented.');
  }

  Future<void> printColumnsString({required List<ColumnMaker> cols}) {
    throw UnimplementedError('printColumnsString() has not been implemented.');
  }

  Future<void> enterPrinterBuffer(bool isClean) {
    throw UnimplementedError('enterPrinterBuffer() has not been implemented.');
  }

  Future<void> commitPrinterBuffer() {
    throw UnimplementedError('commitPrinterBuffer() has not been implemented.');
  }

  Future<void> exitPrinterBuffer(bool isCommit) {
    throw UnimplementedError('exitPrinterBuffer() has not been implemented.');
  }

  Future<List<String>?> getFontCodepage() {
    throw UnimplementedError('getFontCodepage() has not been implemented.');
  }

  Future<void> setFontCodepage(int codepage) {
    throw UnimplementedError('setFontCodepage() has not been implemented.');
  }

  Future<String?> getCurCodepage() {
    throw UnimplementedError('getCurCodepage() has not been implemented.');
  }

  Future<List<String>?> getEncodeList() {
    throw UnimplementedError('getEncodeList() has not been implemented.');
  }

  Future<String?> getCurEncode() {
    throw UnimplementedError('getCurEncode() has not been implemented.');
  }

  Future<List<String>?> getPrinterDensityList() {
    throw UnimplementedError(
        'getPrinterDensityList() has not been implemented.');
  }

  Future<List<String>?> getPrinterSpeedList() {
    throw UnimplementedError('getPrinterSpeedList() has not been implemented.');
  }

  Future<void> setPrinterSpeed(int speed) {
    throw UnimplementedError('setPrinterSpeed() has not been implemented.');
  }

  Future<int?> getPrinterSpeed() {
    throw UnimplementedError('getPrinterSpeed() has not been implemented.');
  }

  Future<List<String>?> getPrinterPaperTypeList() {
    throw UnimplementedError(
        'getPrinterPaperTypeList() has not been implemented.');
  }

  Future<void> setPrinterEncode(int encode) {
    throw UnimplementedError('setPrinterEncode() has not been implemented.');
  }

  Future<void> openLogs(int encode) {
    throw UnimplementedError('openLogs() has not been implemented.');
  }

  Future<void> sendRAWDataHexStr(String bytes) {
    throw UnimplementedError('sendRAWDataHexStr() has not been implemented.');
  }

  Future<void> labelInitCanvas({LabelCanvasStyle? labelCanvasStyle}) {
    throw UnimplementedError('labelInitCanvas() has not been implemented.');
  }

  Future<void> labelAddText(String text, {LabelTextStyle? labelTextStyle}) {
    throw UnimplementedError('labelAddText() has not been implemented.');
  }

  Future<void> labelAddBarCode(String barCode,
      {LabelBarCodeStyle? barCodeStyle}) {
    throw UnimplementedError('labelAddBarCode() has not been implemented.');
  }

  Future<void> labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle}) {
    throw UnimplementedError('labelAddQrCode() has not been implemented.');
  }

  Future<void> labelAddArea({LabelAreaStyle? areaStyle}) {
    throw UnimplementedError('labelAddArea() has not been implemented.');
  }

  Future<void> labelAddBitmap(dynamic img, {LabelBitmapStyle? addBitmapStyle}) {
    throw UnimplementedError('labelAddBitmap() has not been implemented.');
  }

  Future<void> labelPrintCanvas(int printCount) {
    throw UnimplementedError('labelPrintCanvas() has not been implemented.');
  }

  Future<void> printLabelBitmap(dynamic img,
      {LabelPrintBitmapStyle? printBitmapStyle}) {
    throw UnimplementedError('printLabelBitmap() has not been implemented.');
  }

  Future<void> labelLearning() {
    throw UnimplementedError('labelLearning() has not been implemented.');
  }

  Future<void> setPrintModel(int printModel) {
    throw UnimplementedError('setPrintModel() has not been implemented.');
  }

  // ==================== 新增方法 ====================

  // --- ESC/POS 字体控制 ---
  Future<void> setFontMultiple(int wide, int high) {
    throw UnimplementedError('setFontMultiple() has not been implemented.');
  }

  Future<void> setFontBold(bool bold) {
    throw UnimplementedError('setFontBold() has not been implemented.');
  }

  Future<void> setFontAntiWhite(bool antiWhite) {
    throw UnimplementedError('setFontAntiWhite() has not been implemented.');
  }

  Future<void> setFontItalic(bool italic) {
    throw UnimplementedError('setFontItalic() has not been implemented.');
  }

  Future<void> setFontUnderline(int underline) {
    throw UnimplementedError('setFontUnderline() has not been implemented.');
  }

  Future<void> setFontRotate(int rotate) {
    throw UnimplementedError('setFontRotate() has not been implemented.');
  }

  Future<void> setFontDirection(int direction) {
    throw UnimplementedError('setFontDirection() has not been implemented.');
  }

  Future<void> setFontLineSpacing(int space) {
    throw UnimplementedError('setFontLineSpacing() has not been implemented.');
  }

  Future<void> setFontChineseSpace(int leftSpace, int rightSpace) {
    throw UnimplementedError('setFontChineseSpace() has not been implemented.');
  }

  Future<void> setFontCharSpace(int space) {
    throw UnimplementedError('setFontCharSpace() has not been implemented.');
  }

  Future<void> setFontChineseSize(
      int height, int width, int underLine, int chineseType) {
    throw UnimplementedError('setFontChineseSize() has not been implemented.');
  }

  Future<void> setFontCharSize(
      int height, int width, int underLine, int asciiType) {
    throw UnimplementedError('setFontCharSize() has not been implemented.');
  }

  Future<void> setFontChineseMode(int mode) {
    throw UnimplementedError('setFontChineseMode() has not been implemented.');
  }

  Future<void> setFontCountryCode(int country) {
    throw UnimplementedError('setFontCountryCode() has not been implemented.');
  }

  Future<List<String>?> getFontCountryCode() {
    throw UnimplementedError('getFontCountryCode() has not been implemented.');
  }

  // --- 文本打印补充 ---
  Future<void> printTextWithAli(String text, int align) {
    throw UnimplementedError('printTextWithAli() has not been implemented.');
  }

  Future<void> printEscPosText(String text, {IminEscPosTextStyle? style}) {
    throw UnimplementedError('printEscPosText() has not been implemented.');
  }

  Future<void> printTextWithEncode(String text, String encode) {
    throw UnimplementedError('printTextWithEncode() has not been implemented.');
  }

  // --- 走纸/切纸补充 ---
  Future<void> printAndQuitPaper(int value) {
    throw UnimplementedError('printAndQuitPaper() has not been implemented.');
  }

  Future<void> partialCutAndFeedPaper(int length) {
    throw UnimplementedError(
        'partialCutAndFeedPaper() has not been implemented.');
  }

  Future<void> fullCutAndFeedPaper(int length) {
    throw UnimplementedError('fullCutAndFeedPaper() has not been implemented.');
  }

  // --- 高级2D码 ---
  Future<void> print2DCode(
      String data, int symbology, int moduleSize, int errorLevel, int align) {
    throw UnimplementedError('print2DCode() has not been implemented.');
  }

  Future<void> printPDF417(String data, int columns, int rows, int moduleWidth,
      int rowHeight, int errorLevel, int selectOptions, int align) {
    throw UnimplementedError('printPDF417() has not been implemented.');
  }

  Future<void> printMaxiCode(String data, int modeType, int align) {
    throw UnimplementedError('printMaxiCode() has not been implemented.');
  }

  Future<void> printAztecCode(String data, int modeType, int dataLayers,
      int moduleSize, int errorLevel, int align) {
    throw UnimplementedError('printAztecCode() has not been implemented.');
  }

  Future<void> printDataMatrix(String data, int symbolType, int columns,
      int rows, int moduleSize, int align) {
    throw UnimplementedError('printDataMatrix() has not been implemented.');
  }

  // --- 通用 Key-Value 接口 ---
  Future<bool?> setPrinterAction(String keyName, String keyValue) {
    throw UnimplementedError('setPrinterAction() has not been implemented.');
  }

  Future<bool?> setPrinterActionList(String keyName, List<String> keyValue) {
    throw UnimplementedError(
        'setPrinterActionList() has not been implemented.');
  }

  Future<String?> getPrinterInfoByKey(String keyName) {
    throw UnimplementedError('getPrinterInfoByKey() has not been implemented.');
  }

  Future<List<String>?> getPrinterInfoList(String keyName) {
    throw UnimplementedError('getPrinterInfoList() has not been implemented.');
  }

  Future<String?> getPrinterInfoString(String keyName) {
    throw UnimplementedError(
        'getPrinterInfoString() has not been implemented.');
  }

  // --- 打印机信息/设置补充 ---
  Future<String?> getPrinterTemperature() {
    throw UnimplementedError(
        'getPrinterTemperature() has not been implemented.');
  }

  Future<bool?> supportCashBox() {
    throw UnimplementedError('supportCashBox() has not been implemented.');
  }

  Future<List<String>?> getPrinterPatternList() {
    throw UnimplementedError(
        'getPrinterPatternList() has not been implemented.');
  }

  Future<String?> getPrinterSupplierName() {
    throw UnimplementedError(
        'getPrinterSupplierName() has not been implemented.');
  }

  Future<String?> getPrinterKnifeReset() {
    throw UnimplementedError(
        'getPrinterKnifeReset() has not been implemented.');
  }

  // --- 事务打印带回调 ---
  Future<bool?> commitPrinterBufferWithCallback() {
    throw UnimplementedError(
        'commitPrinterBufferWithCallback() has not been implemented.');
  }

  Future<bool?> exitPrinterBufferWithCallback(bool isCommit) {
    throw UnimplementedError(
        'exitPrinterBufferWithCallback() has not been implemented.');
  }

  // --- 标签打印补充 ---
  Future<void> labelPrintBitmap(Uint8List bitmap, int width, int height) {
    throw UnimplementedError('labelPrintBitmap() has not been implemented.');
  }

  Future<String?> labelGapSensorCalibration() {
    throw UnimplementedError(
        'labelGapSensorCalibration() has not been implemented.');
  }

  Future<void> labelSetPrinterMode(int mode) {
    throw UnimplementedError('labelSetPrinterMode() has not been implemented.');
  }

  Future<String?> labelQueryInfo(IminLabelInfo labelInfo) {
    throw UnimplementedError('labelQueryInfo() has not been implemented.');
  }

  Future<bool?> labelRestoreDefaults() {
    throw UnimplementedError(
        'labelRestoreDefaults() has not been implemented.');
  }

  Future<void> setLabelContinuousPrint(bool enable) {
    throw UnimplementedError(
        'setLabelContinuousPrint() has not been implemented.');
  }

  // --- 状态监听 ---
  Future<void> regesiterPrinterStatusCallback() {
    throw UnimplementedError(
        'regesiterPrinterStatusCallback() has not been implemented.');
  }
}
