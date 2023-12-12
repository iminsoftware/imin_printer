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
  Future<bool?> initPrinter() => Future.value(true);
  @override
  Future<String?> getPrinterStatus() => Future.value('-1');
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
  Future<void> printColumnsText({required List<ColumnMaker> cols}) =>
      Future.value();
  @override
  Future<void> printSingleBitmap(dynamic img, {IminPictureStyle? pictureStyle}) =>
      Future.value();
  @override
  Future<void> printSingleBitmapBlackWhite(dynamic img, {IminBaseStyle? baseStyle }) => Future.value();
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
