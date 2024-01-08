import 'imin_printer_platform_interface.dart';
import 'enums.dart';
import 'imin_style.dart';
import 'column_maker.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class IminPrinter {
  /// Reset the printer’s logic program (for example: layout settings, bold and other style settings), but do not clear the buffer data, so unfinished print jobs will continue after reset.
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.initPrinter()
  /// ```
  /// {@end-tool}
  Future<bool?> initPrinter() {
    return IminPrinterPlatform.instance.initPrinter();
  }

  /// status of the printer.
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.getPrinterStatus()
  /// ```
  /// {@end-tool}
  Future<String?> getPrinterStatus() {
    return IminPrinterPlatform.instance.getPrinterStatus();
  }

  /// set the print text size in your printer.
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setTextSize(25)
  /// ```
  /// {@end-tool}
  Future<void> setTextSize(int size) {
    return IminPrinterPlatform.instance.setTextSize(size);
  }

  /// set the print text typeface in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setTextTypeface(IminTypeface.typefaceMonospace)
  /// ```
  /// {@end-tool}
  Future<void> setTextTypeface(IminTypeface typeface) {
    return IminPrinterPlatform.instance.setTextTypeface(typeface);
  }

  /// set the print text style in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setTextStyle(IminFontStyle.bold)
  /// ```
  /// {@end-tool}
  Future<void> setTextStyle(IminFontStyle style) {
    return IminPrinterPlatform.instance.setTextStyle(style);
  }

  /// set the print text align in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setAlignment(IminPrintAlign.center)
  /// ```
  /// {@end-tool}
  Future<void> setAlignment(IminPrintAlign alignment) {
    return IminPrinterPlatform.instance.setAlignment(alignment);
  }

  /// set the print text width in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setTextWidth(576)
  /// ```
  /// {@end-tool}
  Future<void> setTextWidth(int width) {
    return IminPrinterPlatform.instance.setTextWidth(width);
  }

  /// set the print text line spacing in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setTextLineSpacing(1.0f)
  /// ```
  /// {@end-tool}
  Future<void> setTextLineSpacing(double space) {
    return IminPrinterPlatform.instance.setTextLineSpacing(space);
  }

  /// print text in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printText('打印文字');
  /// iminPrinter.printText('print', style: IminTextStyle(wordWrap: true, fontSize: 20, space: 1.0f, width: 576, typeface: IminTypeface.typefaceMonospace, fontStyle: IminFontStyle.boldItalic,align: IminPrintAlign.center ))
  /// ```
  /// {@end-tool}
  Future<void> printText(String text, {IminTextStyle? style}) {
    return IminPrinterPlatform.instance.printText(text, style: style);
  }

  /// set the print anti white text in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printAntiWhiteText('打印反白文字');
  /// iminPrinter.printAntiWhiteText('打印反白文字', style: IminTextStyle(wordWrap: true, fontSize: 20, space: 1.0f, width: 576, typeface: IminTypeface.typefaceMonospace, fontStyle: IminFontStyle.boldItalic,align: IminPrintAlign.center ))
  /// ```
  /// {@end-tool}
  Future<void> printAntiWhiteText(String text, {IminTextStyle? style}) {
    return IminPrinterPlatform.instance.printAntiWhiteText(text, style: style);
  }

  /// set the print table text in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printColumnsText(
  /// cols: [
  ///   ColumnMaker(
  ///       text: '1',
  ///      width: 1,
  ///      fontSize: 26,
  ///      align: IminPrintAlign.center),
  ///  ColumnMaker(
  ///      text: 'iMin',
  ///      width: 2,
  ///      fontSize: 26,
  ///      align: IminPrintAlign.left),
  ///  ColumnMaker(
  ///      text: 'iMin',
  ///      width: 1,
  ///      fontSize: 26,
  ///      align: IminPrintAlign.right)
  /// ]
  /// )
  /// ```
  /// {@end-tool}
  Future<void> printColumnsText({
    required List<ColumnMaker> cols,
  }) {
    return IminPrinterPlatform.instance.printColumnsText(cols: cols);
  }

  /// set the print and line feed in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printAndLineFeed()
  /// ```
  /// {@end-tool}
  Future<void> printAndLineFeed() {
    return IminPrinterPlatform.instance.printAndLineFeed();
  }

  /// set the print and feed paper in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printAndFeedPaper(100)
  /// ```
  /// {@end-tool}
  Future<void> printAndFeedPaper(int height) {
    return IminPrinterPlatform.instance.printAndFeedPaper(height);
  }

  /// set the print page format in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setPageFormat(0)
  /// ```
  /// {@end-tool}
  Future<void> setPageFormat({int? style}) {
    return IminPrinterPlatform.instance.setPageFormat(style: style);
  }

  /// print partial cut in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.partialCut()
  /// ```
  /// {@end-tool}
  Future<void> partialCut() {
    return IminPrinterPlatform.instance.partialCut();
  }

  /// print singele bitmap in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  ///   Uint8List byte = await _getImageFromAsset('xxx.jpg');
  /// iminPrinter.printSingleBitmap(byte)
  /// ```
  /// {@end-tool}
  Future<void> printSingleBitmap(dynamic img,
      {IminPictureStyle? pictureStyle}) {
    return IminPrinterPlatform.instance
        .printSingleBitmap(img, pictureStyle: pictureStyle);
  }

  /// print multi bitmap in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  ///   Uint8List byte1 = await _getImageFromAsset('xxx.jpg');
  ///   Uint8List byte2 = await _getImageFromAsset('xxx.jpg');
  /// iminPrinter.printMultiBitmap([byte1, byte2], alignment: IminPrintAlign.center)
  /// ```
  /// {@end-tool}
  Future<void> printMultiBitmap(List<dynamic> imgs,
      {IminPictureStyle? pictureStyle}) {
    return IminPrinterPlatform.instance
        .printMultiBitmap(imgs, pictureStyle: pictureStyle);
  }

  /// print single bitmap black white in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  ///   Uint8List byte = await _getImageFromAsset('xxx.jpg');
  /// iminPrinter.printSingleBitmapBlackWhite(byte)
  /// ```
  /// {@end-tool}
  Future<void> printSingleBitmapBlackWhite(dynamic img,
      {IminBaseStyle? baseStyle}) {
    return IminPrinterPlatform.instance.printSingleBitmapBlackWhite(img);
  }

  /// set qrcode size in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setQrCodeSize(2)
  /// ```
  /// {@end-tool}
  Future<void> setQrCodeSize(int size) {
    return IminPrinterPlatform.instance.setQrCodeSize(size);
  }

  /// set qrcode and brcode left margin in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setLeftMargin(0)
  /// ```
  /// {@end-tool}
  Future<void> setLeftMargin(int margin) {
    return IminPrinterPlatform.instance.setLeftMargin(margin);
  }

  /// set qrcode error correct level in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setQrCodeErrorCorrectionLev(48)
  /// ```
  /// {@end-tool}
  Future<void> setQrCodeErrorCorrectionLev(IminQrcodeCorrectionLevel level) {
    return IminPrinterPlatform.instance.setQrCodeErrorCorrectionLev(level);
  }

  /// prin qrcode in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printQrCode('https://www.imin.sg');
  /// iminPrinter.printQrCode('https://www.imin.sg',
  ///   qrCodeStyle: IminQrCodeStyle(
  ///    errorCorrectionLevel:IminQrcodeCorrectionLevel.levelH,
  ///    qrSize: 4,
  ///    align: IminPrintAlign.right
  ///   )
  /// )
  /// ```
  /// {@end-tool}
  Future<void> printQrCode(String data, {IminQrCodeStyle? qrCodeStyle}) {
    return IminPrinterPlatform.instance
        .printQrCode(data, qrCodeStyle: qrCodeStyle);
  }

  /// set  double  qrcode  size  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQRSize(5)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQRSize(int size) {
    return IminPrinterPlatform.instance.setDoubleQRSize(size);
  }

  /// set  double  qrcode1  level  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR1Level(1)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR1Level(int level) {
    return IminPrinterPlatform.instance.setDoubleQR1Level(level);
  }

  /// set  double  qrcode2  level  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR2Level(2)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR2Level(int level) {
    return IminPrinterPlatform.instance.setDoubleQR2Level(level);
  }

  /// set  double  qrcode1  left margin  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR1MarginLeft(-80)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR1MarginLeft(int leftMargin) {
    return IminPrinterPlatform.instance.setDoubleQR1MarginLeft(leftMargin);
  }

  /// set  double  qrcode2  left margin  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR2MarginLeft(-80)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR2MarginLeft(int leftMargin) {
    return IminPrinterPlatform.instance.setDoubleQR2MarginLeft(leftMargin);
  }

  /// set  double  qrcode1  version  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR1Version(0)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR1Version(int version) {
    return IminPrinterPlatform.instance.setDoubleQR1Version(version);
  }

  /// set  double  qrcode2  version  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setDoubleQR2Version(6)
  /// ```
  /// {@end-tool}
  Future<void> setDoubleQR2Version(int version) {
    return IminPrinterPlatform.instance.setDoubleQR2Version(version);
  }

  /// print  double  qrcode  version  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printDoubleQR(qrCode1:  IminDoubleQRCodeStyle( text: 'www.imin.sg',), qrCode2: IminDoubleQRCodeStyle( text: 'www.google.com'))
  /// iminPrinter.printDoubleQR(qrCode1:  IminDoubleQRCodeStyle( text: 'www.imin.sg',), qrCode2: IminDoubleQRCodeStyle( text: 'www.google.com',  doubleQRSize: 5))
  /// ```
  /// {@end-tool}
  Future<void> printDoubleQR(
      {required IminDoubleQRCodeStyle qrCode1,
      required IminDoubleQRCodeStyle qrCode2,
      int? doubleQRSize}) {
    return IminPrinterPlatform.instance.printDoubleQR(
        qrCode1: qrCode1, qrCode2: qrCode2, doubleQRSize: doubleQRSize);
  }

  /// set  barcode  width  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setBarCodeWidth(3)
  /// ```
  /// {@end-tool}
  Future<void> setBarCodeWidth(int width) {
    return IminPrinterPlatform.instance.setBarCodeWidth(width);
  }

  /// set  barcode  height  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setBarCodeHeight(100)
  /// ```
  /// {@end-tool}
  Future<void> setBarCodeHeight(int height) {
    return IminPrinterPlatform.instance.setBarCodeHeight(height);
  }

  /// set  barcode  content print position  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setBarCodeContentPrintPos(IminBarcodeTextPos.textAbove)
  /// ```
  /// {@end-tool}
  Future<void> setBarCodeContentPrintPos(IminBarcodeTextPos position) {
    return IminPrinterPlatform.instance.setBarCodeContentPrintPos(position);
  }

  /// print  barcode in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printBarCode(IminBarcodeType.code128, '{C009999789101')
  /// iminPrinter.printBarCode(IminBarcodeType.code128, '{C009999789101', style: IminBarCodeStyle(align: IminPrintAlign.center, position: IminBarcodeTextPos.textAbove))
  /// ```
  /// {@end-tool}
  Future<void> printBarCode(IminBarcodeType barCodeType, String barCodeContent,
      {IminBarCodeStyle? style}) {
    return IminPrinterPlatform.instance
        .printBarCode(barCodeType, barCodeContent, style: style);
  }

  /// set  barcode to bitmap format  in your printer
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.printBarCodeToBitmapFormat("11110AQ899015859344",1300,120, IminBarCodeToBitmapFormat.code128)
  /// ```
  /// {@end-tool}
  Future<void> printBarCodeToBitmapFormat(String barCodeContent, int width,
      int height, IminBarCodeToBitmapFormat codeFormat) {
    return IminPrinterPlatform.instance
        .printBarCodeToBitmapFormat(barCodeContent, width, height, codeFormat);
  }

  /// set  init imin priner
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.setInitIminPrinter(true)
  /// ```
  /// {@end-tool}
  Future<void> setInitIminPrinter(bool isDefaultPrinter) {
    return IminPrinterPlatform.instance.setInitIminPrinter(isDefaultPrinter);
  }

  /// set  rest  device
  ///
  /// {@tool snippet}
  ///
  ///  ```dart
  /// iminPrinter.resetDevice()
  /// ```
  /// {@end-tool}
  Future<void> resetDevice() {
    return IminPrinterPlatform.instance.resetDevice();
  }
  Future<void> openCashBox() {
    return IminPrinterPlatform.instance.openCashBox();
  }
}
