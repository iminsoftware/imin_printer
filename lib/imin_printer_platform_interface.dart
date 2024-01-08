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

  Future<bool?> initPrinter() {
    throw UnimplementedError('initPrinter() has not been implemented.');
  }

  Future<String?> getPrinterStatus() {
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
  
  Future<void> openCashBox () {
      throw UnimplementedError('openCashBox() has not been implemented.');
  }
   
  Future<void> initPrinterService() {
   throw UnimplementedError('resetDevice() has not been implemented.');
  }

  // Future<void> getPrinterSerialNumber() {
  //   throw UnimplementedError(
  //       'getPrinterSerialNumber() has not been implemented.');
  // }

  // Future<void> getPrinterModelName() {
  //   throw UnimplementedError('getPrinterModelName() has not been implemented.');
  // }

  // Future<void> getPrinterThermalHead() {
  //   throw UnimplementedError(
  //       'getPrinterThermalHead() has not been implemented.');
  // }

  // Future<void> getPrinterFirmwareVersion() {
  //   throw UnimplementedError(
  //       'getPrinterFirmwareVersion() has not been implemented.');
  // }

  // Future<void> getServiceVersion() {
  //   throw UnimplementedError('getServiceVersion() has not been implemented.');
  // }

  // Future<void> getPrinterHardwareVersion() {
  //   throw UnimplementedError('getServiceVersion() has not been implemented.');
  // }

  // Future<void> getUsbPrinterVidPid() {
  //   throw UnimplementedError('getUsbPrinterVidPid() has not been implemented.');
  // }

  // Future<void> getUsbDevicesName() {
  //   throw UnimplementedError('getUsbDevicesName() has not been implemented.');
  // }

  // Future<void> setPrinterDensity(IminPrinterDensity density) {
  //   throw UnimplementedError('setPrinterDensity() has not been implemented.');
  // }

  // Future<void> getPrinterDensity() {
  //   throw UnimplementedError('getPrinterDensity() has not been implemented.');
  // }

  // Future<void> getPrinterSpeed() {
  //   throw UnimplementedError('getPrinterSpeed() has not been implemented.');
  // }

  // Future<void> getPrinterPaperDistance() {
  //   throw UnimplementedError(
  //       'getPrinterPaperDistance() has not been implemented.');
  // }

  // Future<void> getPrinterPaperType() {
  //   throw UnimplementedError('getPrinterPaperType() has not been implemented.');
  // }

  // Future<void> getPrinterCutTimes() {
  //   throw UnimplementedError('getPrinterCutTimes() has not been implemented.');
  // }

  // Future<void> getPrinterMode() {
  //   throw UnimplementedError('getPrinterMode() has not been implemented.');
  // }

  // Future<void> getConfigurationInfo() {
  //   throw UnimplementedError(
  //       'getConfigurationInfo() has not been implemented.');
  // }

  // Future<void> updatePrinterInfo() {
  //   throw UnimplementedError('updatePrinterInfo() has not been implemented.');
  // }

  // Future<void> openDrawer() {
  //   throw UnimplementedError('openDrawer() has not been implemented.');
  // }

  // Future<void> getDrawerStatus() {
  //   throw UnimplementedError('getDrawerStatus() has not been implemented.');
  // }

  // Future<void> getOpenDrawerTimes() {
  //   throw UnimplementedError('getOpenDrawerTimes() has not been implemented.');
  // }

  // Future<void> printerSelfChecking() {
  //   throw UnimplementedError('printerSelfChecking() has not been implemented.');
  // }

  // Future<void> setFontMultiple(int width, int height) {
  //   throw UnimplementedError('printerSelfChecking() has not been implemented.');
  // }

  // Future<void> setFontBold(bool bold) {
  //   throw UnimplementedError('setFontBold() has not been implemented.');
  // }

  // Future<void> setFontAntiWhite(bool antiWhite) {
  //   throw UnimplementedError('setFontAntiWhite() has not been implemented.');
  // }

  // Future<void> setFontItalic(bool italic) {
  //   throw UnimplementedError('setFontItalic() has not been implemented.');
  // }

  // Future<void> setFontUnderline(bool underline) {
  //   throw UnimplementedError('setFontUnderline() has not been implemented.');
  // }

  // Future<void> setFontRotate(IminFontRotate rotate) {
  //   throw UnimplementedError('setFontUnderline() has not been implemented.');
  // }

  // Future<void> setFontDirection(IminFontDirection direction) {
  //   throw UnimplementedError('setFontDirection() has not been implemented.');
  // }

  // Future<void> setFontLineSpacing(int space) {
  //   throw UnimplementedError('setFontLineSpacing() has not been implemented.');
  // }

  // Future<void> setFontChineseSpace(int chsLeftSpace, int chsRightSpace) {
  //   throw UnimplementedError('setFontChineseSpace() has not been implemented.');
  // }

  // Future<void> setFontCharSpace(int space) {
  //   throw UnimplementedError('setFontCharSpace() has not been implemented.');
  // }

  // Future<void> setFontCharSize(
  //     int height, int width, int underLine, int asciitype) {
  //   throw UnimplementedError('setFontCharSize() has not been implemented.');
  // }

  // Future<void> setFontChineseMode(int mode) {
  //   throw UnimplementedError('setFontChineseMode() has not been implemented.');
  // }

  // Future<void> setFontChineseSize(
  //     int height, int width, int underLine, int chineseType) {
  //   throw UnimplementedError('setFontChineseSize() has not been implemented.');
  // }

  // Future<void> setCodeAlignment(IminPrintAlign align) {
  //   throw UnimplementedError('setCodeAlignment() has not been implemented.');
  // }

  // Future<void> setFontCountryCode(int country) {
  //   throw UnimplementedError('setFontCountryCode() has not been implemented.');
  // }

  // Future<void> getFontCountryCode() {
  //   throw UnimplementedError('getFontCountryCode() has not been implemented.');
  // }

  // Future<void> setFontCodepage(int codepage) {
  //   throw UnimplementedError('setFontCodepage() has not been implemented.');
  // }

  // Future<void> getFontCodepage() {
  //   throw UnimplementedError('getFontCodepage() has not been implemented.');
  // }
  // Future<void> setTextBitmapTypeface(IminTypeface typeface) {
  //   throw UnimplementedError('setTextBitmapTypeface() has not been implemented.');
  // }
  // Future<void> setTextBitmapSize(int size) {
  //   throw UnimplementedError('setTextBitmapSize() has not been implemented.');
  // }
  // Future<void> setTextBitmapStyle(int style) {
  //   throw UnimplementedError('setTextBitmapStyle() has not been implemented.');
  // }
  
}
