import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/column_maker.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/imin_printer_platform_interface.dart';
import 'package:imin_printer/imin_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIminPrinterPlatform
    with MockPlatformInterfaceMixin
    implements IminPrinterPlatform {
    
  @override
  Future<String?> getSdkVersion() => Future.value('1.0.0');
  @override
  Stream<dynamic> initEventChannel() => const Stream.empty();
  @override
  Future<bool?> initPrinter() => Future.value(true);
  @override
  Future<Map<String, dynamic>> getPrinterStatus() =>
      Future.value({"code": 0, "msg": 'sdsd'});
  @override
  Future<void> setTextSize(int size) => Future.value();
  @override
  Future<void> setTextTypeface(IminTypeface typeface) => Future.value();
  @override
  Future<void> setTextStyle(IminFontStyle style) => Future.value();
  @override
  Future<void> setAlignment(IminPrintAlign alignment) => Future.value();
  @override
  Future<void> printText(String text, {IminTextStyle? style}) => Future.value();
  @override
  Future<void> printAntiWhiteText(String text, {IminTextStyle? style}) =>
      Future.value();
  @override
  Future<void> setPrinterEncode(int encode) =>
      Future.value();
  @override
  Future<void> printColumnsText({required List<ColumnMaker> cols}) =>
      Future.value();
  @override
  Future<void> printSingleBitmap(dynamic img,
          {IminPictureStyle? pictureStyle}) =>
      Future.value();
  @override
  Future<void> printSingleBitmapWithTranslation(dynamic img,
      {IminPictureStyle? pictureStyle}) =>
      Future.value();
  @override
  Future<void> printSingleBitmapBlackWhite(dynamic img,
          {IminBaseStyle? baseStyle}) =>
      Future.value();
  @override
  Future<void> printMultiBitmap(List<dynamic> imgs,
          {IminPictureStyle? pictureStyle}) =>
      Future.value();
  @override
  Future<void> setQrCodeSize(int size) => Future.value();
  @override
  Future<void> setTextLineSpacing(double space) => Future.value();
  @override
  Future<void> printAndLineFeed() => Future.value();
  @override
  Future<void> printAndFeedPaper(int height) => Future.value();
  @override
  Future<void> partialCut() => Future.value();
  @override
  Future<void> setPageFormat({int? style}) => Future.value();
  @override
  Future<void> setLeftMargin(int margin) => Future.value();
  @override
  Future<void> setTextWidth(int width) => Future.value();
  @override
  Future<void> setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel level) =>
      Future.value();
  @override
  Future<void> printQrCode(String data, {IminQrCodeStyle? qrCodeStyle}) =>
      Future.value();
  @override
  Future<void> setDoubleQRSize(int size) => Future.value();
  @override
  Future<void> setDoubleQR1Level(int level) => Future.value();
  @override
  Future<void> setDoubleQR2Level(int level) => Future.value();
  @override
  Future<void> setDoubleQR1MarginLeft(int leftMargin) => Future.value();
  @override
  Future<void> setDoubleQR2MarginLeft(int leftMargin) => Future.value();
  @override
  Future<void> setDoubleQR1Version(int version) => Future.value();
  @override
  Future<void> setDoubleQR2Version(int version) => Future.value();
  @override
  Future<void> printDoubleQR(
          {required IminDoubleQRCodeStyle qrCode1,
          required IminDoubleQRCodeStyle qrCode2,
          int? doubleQRSize}) =>
      Future.value();
  @override
  Future<void> setBarCodeWidth(int width) => Future.value();
  @override
  Future<void> setBarCodeHeight(int height) => Future.value();
  @override
  Future<void> setBarCodeContentPrintPos(IminBarcodeTextPos position) =>
      Future.value();
  @override
  Future<void> printBarCode(IminBarcodeType barCodeType, String barCodeContent,
          {IminBarCodeStyle? style}) =>
      Future.value();
  @override
  Future<void> printBarCodeToBitmapFormat(String barCodeContent, int width,
          int height, IminBarCodeToBitmapFormat codeFormat) =>
      Future.value();
  @override
  Future<void> setInitIminPrinter(bool isDefaultPrinter) => Future.value();
  @override
  Future<void> resetDevice() => Future.value();
  @override
  Future<void> openCashBox() => Future.value();
  @override
  Future<void> unBindService() => Future.value();
  @override
  Future<String?> initPrinterParams() => Future.value();
  @override
  Future<String?> getPrinterSerialNumber() => Future.value();
  @override
  Future<String?> getPrinterModelName() => Future.value();
  @override
  Future<String?> getPrinterThermalHead() => Future.value();
  @override
  Future<String?> getPrinterFirmwareVersion() => Future.value();
  @override
  Future<String?> getServiceVersion() => Future.value();
  @override
  Future<String?> getPrinterHardwareVersion() => Future.value();
  @override
  Future<String?> getUsbPrinterVidPid() => Future.value();
  @override
  Future<String?> getUsbDevicesName() => Future.value();
  @override
  Future<int?> getPrinterDensity() => Future.value();
  @override
  Future<String?> setPrinterDensity(IminPrinterDensity density) =>
      Future.value();
  @override
  Future<String?> getPrinterPaperDistance() => Future.value();
  @override
  Future<int?> getPrinterPaperType() => Future.value();
  @override
  Future<String?> getPrinterCutTimes() => Future.value();
  @override
  Future<int?> getPrinterMode() => Future.value();
  @override
  Future<String?> setPrinterMode() => Future.value();
  @override
  Future<bool?> getDrawerStatus() => Future.value();
  @override
  Future<int?> getOpenDrawerTimes() => Future.value();
  @override
  Future<void> printerSelfChecking() => Future.value();
  @override
  Future<void> sendRAWData(Uint8List bytes) => Future.value();
  @override
  Future<void> fullCut() => Future.value();
  @override
  Future<void> setCodeAlignment(IminPrintAlign alignment) => Future.value();
  @override
  Future<void> printTextBitmap(String text, {IminTextPictureStyle? style}) =>
      Future.value();
  @override
  Future<void> setTextBitmapTypeface(IminTypeface typeface) => Future.value();
  @override
  Future<void> setTextBitmapSize(int size) => Future.value();
  @override
  Future<void> setTextBitmapStyle(IminFontStyle style) => Future.value();
  @override
  Future<void> setTextBitmapStrikeThru(bool strikeThru) => Future.value();
  @override
  Future<void> setTextBitmapUnderline(bool haveUnderline) => Future.value();
  @override
  Future<void> setTextBitmapLineSpacing(double lineHeight) => Future.value();
  @override
  Future<void> setTextBitmapLetterSpacing(double space) => Future.value();
  @override
  Future<void> setTextBitmapAntiWhite(bool antiWhite) => Future.value();
  @override
  Future<void> printSingleBitmapColorChart(dynamic img,
          {IminPictureStyle? pictureStyle}) =>
      Future.value();
  @override
  Future<void> printColumnsString({required List<ColumnMaker> cols}) =>
      Future.value();
  @override
  Future<void> enterPrinterBuffer(bool isClean) => Future.value();
  @override
  Future<void> commitPrinterBuffer() => Future.value();
  @override
  Future<void> exitPrinterBuffer(bool isCommit) => Future.value();
  @override
  Future<List<String>?> getFontCodepage() => Future.value();
  @override
  Future<void> setFontCodepage(int codepage) => Future.value();
  @override
  Future<String?> getCurCodepage() => Future.value();
  @override
  Future<List<String>?> getEncodeList() => Future.value();
  @override
  Future<String?> getCurEncode() => Future.value();
  @override
  Future<List<String>?> getPrinterDensityList() => Future.value();
  @override
  Future<List<String>?> getPrinterSpeedList() => Future.value();
  @override
  Future<void> setPrinterSpeed(int speed) => Future.value();
  @override
  Future<int?> getPrinterSpeed() => Future.value();
  @override
  Future<List<String>?> getPrinterPaperTypeList() => Future.value();
  @override
  Future<int?> openLogs(int encode) => Future.value();
  @override
  Future<List<String>?> sendRAWDataHexStr(String hex) => Future.value();

  @override
  Future<void> labelInitCanvas({LabelCanvasStyle? labelCanvasStyle}) => Future.value();
  @override
  Future<void> labelAddArea({LabelAreaStyle? areaStyle}) => Future.value();
  @override
  Future<void> labelAddBarCode(String barCode, {LabelBarCodeStyle? barCodeStyle}) => Future.value();
  @override
  Future<void> labelAddBitmap(dynamic img,{LabelBitmapStyle? addBitmapStyle}) => Future.value();
  @override
  Future<void> labelAddQrCode(String qrCode, {LabelQrCodeStyle? qrCodeStyle}) => Future.value();
  @override
  Future<void> labelAddText(String text, {LabelTextStyle? labelTextStyle}) => Future.value();
  @override
  Future<void> labelLearning() => Future.value();
  @override
  Future<void> labelPrintCanvas(int printCount) => Future.value();

  @override
  Future<void> printLabelBitmap(dynamic img,{LabelPrintBitmapStyle? printBitmapStyle}) => Future.value();
  @override
  Future<void> setPrintModel(int printModel) => Future.value();


}

void main() {
  final IminPrinterPlatform initialPlatform = IminPrinterPlatform.instance;

  test('$MethodChannelIminPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIminPrinter>());
  });

  test('initPrinter', () async {
    IminPrinter iminPrinterPlugin = IminPrinter();
    MockIminPrinterPlatform fakePlatform = MockIminPrinterPlatform();
    IminPrinterPlatform.instance = fakePlatform;

    expect(await iminPrinterPlugin.initPrinter(), true);
  });

  test('getPrinterStatus', () async {
    IminPrinter iminPrinterPlugin = IminPrinter();
    MockIminPrinterPlatform fakePlatform = MockIminPrinterPlatform();
    IminPrinterPlatform.instance = fakePlatform;

    expect(await iminPrinterPlugin.getPrinterStatus(), '-1');
  });
}
