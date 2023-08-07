import 'enums.dart';

class IminTextStyle {
  bool? wordWrap;
  int? fontSize;
  double? space;
  int? width;
  IminTypeface? typeface;
  IminFontStyle? fontStyle;
  IminPrintAlign? align;

  IminTextStyle(
      {this.wordWrap,
      this.fontSize,
      this.align,
      this.space,
      this.width,
      this.fontStyle,
      this.typeface});
}

class IminQrCodeStyle {
  int? qrSize;
  IminPrintAlign? align;
  int? leftMargin;
  IminQrcodeCorrectionLevel? errorCorrectionLevel;

  IminQrCodeStyle(
      {this.align, this.qrSize, this.leftMargin, this.errorCorrectionLevel});
}

class IminBarCodeStyle {
  int? width;
  int? height;
  IminBarcodeTextPos? position;
  IminPrintAlign? align;

  IminBarCodeStyle({this.width, this.height, this.align, this.position});
}

class IminDoubleQRCodeStyle {
  String text;
  int? level;
  int? leftMargin;
  int? version;
  IminDoubleQRCodeStyle(
      {this.level, this.text = '', this.leftMargin, this.version});
}
