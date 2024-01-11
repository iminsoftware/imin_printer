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

class IminTextPictureStyle {
  bool? wordWrap;
  int? fontSize;
  IminTypeface? typeface;
  IminFontStyle? fontStyle;
  IminPrintAlign? align;
  double? letterSpacing;
  bool? underline;
  bool? throughline;
  double? lineHeight;
  bool? reverseWhite;

  IminTextPictureStyle(
      {this.wordWrap,
      this.fontSize,
      this.align,
      this.fontStyle,
      this.letterSpacing,
      this.underline,
      this.throughline,
      this.reverseWhite,
      this.lineHeight,
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

class IminBarCodeStyle extends IminBaseStyle {
  IminBarcodeTextPos? position;
  IminPrintAlign? align;

  IminBarCodeStyle({this.align, this.position, height, width})
      : super(width: width, height: height);
}

class IminDoubleQRCodeStyle {
  String text;
  int? level;
  int? leftMargin;
  int? version;
  IminDoubleQRCodeStyle(
      {this.level, this.text = '', this.leftMargin, this.version});
}

class IminBaseStyle {
  int? width;
  int? height;
  IminBaseStyle({this.width, this.height});
}

class IminPictureStyle extends IminBaseStyle {
  IminPrintAlign? alignment;
  IminPictureStyle({this.alignment, width, height})
      : super(width: width, height: height);
}
