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

class LabelAreaStyle {
  Shape style = Shape.RECT_FILL;
  int? width = 50;
  int? height = 50;
  int? posX = 0;
  int? posY = 0;
  int? endX = 50;
  int? endY = 50;
  int? thick = 1;

  // LabelAreaStyle(this.style, this.width, this.height, this.posX, this.posY,
  //     this.endX, this.endY, this.thick);

  LabelAreaStyle({
    this.style = Shape.RECT_FILL,
    this.width = 50,
    this.height = 50,
    this.posX = 0,
    this.posY = 0,
    this.endX = 50,
    this.endY = 50,
    this.thick = 1,
  });

  // Method to convert the object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'style': style.toString().split('.').last, // Convert enum to string
      'width': width,
      'height': height,
      'posX': posX,
      'posY': posY,
      'endX': endX,
      'endY': endY,
      'thick': thick,
    };
  }

  // Factory method to create an instance from a Map
  factory LabelAreaStyle.fromMap(Map<String, dynamic> map) {
    return LabelAreaStyle(
      style: Shape.values.firstWhere((e) => e.toString() == 'Shape.${map['style']}'),
      width: map['width'],
      height: map['height'],
      posX: map['posX'],
      posY: map['posY'],
      endX: map['endX'],
      endY: map['endY'],
      thick: map['thick'],
    );
  }
}

class LabelBarCodeStyle {
  int? posX;
  int? posY;
  int? dotWidth;
  int? barHeight;
  HumanReadable? readable;
  Symbology? symbology;
  AlignLabel? align;
  Rotate? rotate;
  int? width;
  int? height;

  // 构造函数，带有默认参数值
  LabelBarCodeStyle({
    this.posX = 0,
    this.posY = 0,
    this.dotWidth = 2,
    this.barHeight = 162,
    this.readable = HumanReadable.HIDE,
    this.symbology = Symbology.CODE39,
    this.align = AlignLabel.DEFAULT,
    this.rotate = Rotate.ROTATE_0,
    this.width = -1,
    this.height = -1,
  });

  // 将对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'posX': posX,
      'posY': posY,
      'dotWidth': dotWidth,
      'barHeight': barHeight,
      'readable': readable.toString().split('.').last, // Convert enum to string
      'symbology': symbology.toString().split('.').last, // Convert enum to string
      'align': align.toString().split('.').last, // Convert enum to string
      'rotate': rotate.toString().split('.').last, // Convert enum to string
      'width': width,
      'height': height,
    };
  }

  // 从 Map 创建对象
  factory LabelBarCodeStyle.fromMap(Map<String, dynamic> map) {
    return LabelBarCodeStyle(
      posX: map['posX'],
      posY: map['posY'],
      dotWidth: map['dotWidth'],
      barHeight: map['barHeight'],
      readable: HumanReadable.values.firstWhere((e) => e.toString() == 'HumanReadable.${map['readable']}'),
      symbology: Symbology.values.firstWhere((e) => e.toString() == 'Symbology.${map['symbology']}'),
      align: AlignLabel.values.firstWhere((e) => e.toString() == 'AlignLabel.${map['align']}'),
      rotate: Rotate.values.firstWhere((e) => e.toString() == 'Rotate.${map['rotate']}'),
      width: map['width'],
      height: map['height'],
    );
  }

}

class LabelBitmapStyle {
  int? posX;
  int? posY;
  ImageAlgorithm? algorithm;
  int? value;
  int? width;
  int? height;

  // 构造函数，带有默认参数值
  LabelBitmapStyle({
    this.posX = 0,
    this.posY = 0,
    this.algorithm = ImageAlgorithm.BINARIZATION,
    this.value = 200,
    this.width = -1,
    this.height = -1,
  });

  // 将对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'posX': posX,
      'posY': posY,
      'algorithm': algorithm.toString().split('.').last, // Convert enum to string
      'value': value,
      'width': width,
      'height': height,
    };
  }

  // 从 Map 创建对象
  factory LabelBitmapStyle.fromMap(Map<String, dynamic> map) {
    return LabelBitmapStyle(
      posX: map['posX'],
      posY: map['posY'],
      algorithm: ImageAlgorithm.values.firstWhere((e) => e.toString() == 'ImageAlgorithm.${map['algorithm']}'),
      value: map['value'],
      width: map['width'],
      height: map['height'],
    );
  }
}

class LabelCanvasStyle{
  int? width;
  int? height;
  int? posX;
  int? posY;


  LabelCanvasStyle({
    this.width = 50,
    this.height = 50,
    this.posX = 0,
    this.posY = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'posX': posX,
      'posY': posY,
    };
  }

  factory LabelCanvasStyle.fromMap(Map<String, dynamic> map) {
    return LabelCanvasStyle(
      width: map['width'],
      height: map['height'],
      posX: map['posX'],
      posY: map['posY'],
    );
  }
}

class LabelQrCodeStyle{
  int? posX;
  int? posY;
  int? size;
  ErrorLevel? errorLevel;
  Rotate? rotate;
  int? width;
  int? height;

  // 构造函数，带有默认参数值
  LabelQrCodeStyle({
    this.posX = 0,
    this.posY = 0,
    this.size = 4,
    this.errorLevel = ErrorLevel.L,
    this.rotate = Rotate.ROTATE_0,
    this.width = -1,
    this.height = -1,
  });

  // 将对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'posX': posX,
      'posY': posY,
      'size': size,
      'errorLevel': errorLevel.toString().split('.').last, // Convert enum to string
      'rotate': rotate.toString().split('.').last, // Convert enum to string
      'width': width,
      'height': height,
    };
  }

  // 从 Map 创建对象
  factory LabelQrCodeStyle.fromMap(Map<String, dynamic> map) {
    return LabelQrCodeStyle(
      posX: map['posX'],
      posY: map['posY'],
      size: map['size'],
      errorLevel: ErrorLevel.values.firstWhere((e) => e.toString() == 'ErrorLevel.${map['errorLevel']}'),
      rotate: Rotate.values.firstWhere((e) => e.toString() == 'Rotate.${map['rotate']}'),
      width: map['width'],
      height: map['height'],
    );
  }
}

class LabelTextStyle{
  int? posX;
  int? posY;
  int? textSize;
  int? textWidthRatio;
  int? textHeightRatio;
  int? width;
  int? height;
  AlignLabel? align;
  Rotate? rotate;
  int? textSpace;
  bool? enableBold;
  bool? enableUnderline;
  bool? enableStrikethrough;
  bool? enableItalics;
  bool? enAntiColor;

  // 构造函数，带有默认参数值
  LabelTextStyle({
    this.posX = 0,
    this.posY = 0,
    this.textSize = 24,
    this.textWidthRatio = 1,
    this.textHeightRatio = 1,
    this.width = -1,
    this.height = -1,
    this.align = AlignLabel.DEFAULT,
    this.rotate = Rotate.ROTATE_0,
    this.textSpace = 0,
    this.enableBold = false,
    this.enableUnderline = false,
    this.enableStrikethrough = false,
    this.enableItalics = false,
    this.enAntiColor = false,
  });

  // 将对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'posX': posX,
      'posY': posY,
      'textSize': textSize,
      'textWidthRatio': textWidthRatio,
      'textHeightRatio': textHeightRatio,
      'width': width,
      'height': height,
      'align': align.toString().split('.').last, // Convert enum to string
      'rotate': rotate.toString().split('.').last, // Convert enum to string
      'textSpace': textSpace,
      'enableBold': enableBold,
      'enableUnderline': enableUnderline,
      'enableStrikethrough': enableStrikethrough,
      'enableItalics': enableItalics,
      'enAntiColor': enAntiColor,
    };
  }

  // 从 Map 创建对象
  factory LabelTextStyle.fromMap(Map<String, dynamic> map) {
    return LabelTextStyle(
      posX: map['posX'],
      posY: map['posY'],
      textSize: map['textSize'],
      textWidthRatio: map['textWidthRatio'],
      textHeightRatio: map['textHeightRatio'],
      width: map['width'],
      height: map['height'],
      align: AlignLabel.values.firstWhere((e) => e.toString() == 'AlignLabel.${map['align']}'),
      rotate: Rotate.values.firstWhere((e) => e.toString() == 'Rotate.${map['rotate']}'),
      textSpace: map['textSpace'],
      enableBold: map['enableBold'],
      enableUnderline: map['enableUnderline'],
      enableStrikethrough: map['enableStrikethrough'],
      enableItalics: map['enableItalics'],
      enAntiColor: map['enAntiColor'],
    );
  }
}


class LabelPrintBitmapStyle{
  int? width;
  int? height;

  LabelPrintBitmapStyle({this.width, this.height});
  // 将对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
    };
  }

  // 从 Map 创建对象
  factory LabelPrintBitmapStyle.fromMap(Map<String, dynamic> map) {
    return LabelPrintBitmapStyle(
      width: map['width'],
      height: map['height'],
    );
  }
}





