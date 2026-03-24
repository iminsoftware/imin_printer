library enums;

// 打印机状态
enum PrinterStatus {
  initPrinterError('-1', 'Printer initialization failed!'),
  normal('0', 'Printer is normal'),
  notPoweredOn('1', 'Printer not connected or powered on!'),
  notLibraryMatch('2', 'Printer and call library mismatch!'),
  openPrintHead('3', 'Printer door is open!'),
  cutterNotReset('4', 'Cutter not reset!'),
  overHeated('5', 'Printer head overheated!'),
  blackLabelError('6', 'Black label error!'),
  notPaperFeed('7', 'Paper missing!'),
  outOfPaper('8', 'Paper is running out!'),
  otherError('99', 'Other errors!');

  const PrinterStatus(this.code, this.value);

  final String code;

  final String value;

  static String getValue(String code) => PrinterStatus.values
      .firstWhere((activity) => activity.code == code)
      .value;
}

// print typeface
enum IminTypeface {
  typefaceDefault,
  typefaceMonospace,
  typefaceDefaultBold,
  typefaceSansSerif,
  typefaceSerif
}

// print font Style
enum IminFontStyle { normal, bold, italic, boldItalic }

// print align
enum IminPrintAlign { left, center, right }

enum IminQrcodeCorrectionLevel {
  levelL(48),
  levelM(49),
  levelQ(50),
  levelH(51);

  final int level;
  const IminQrcodeCorrectionLevel(this.level);
}

enum IminBarcodeTextPos {
  noText(0),
  textAbove(1),
  textBelow(2),
  both(3);

  final int position;
  const IminBarcodeTextPos(this.position);
}

///Enum to set Barcode Type
enum IminBarcodeType {
  upcA(0),
  upcE(1),
  jan13(2),
  jan8(3),
  code39(4),
  itf(5),
  codabar(6),
  code93(7),
  code128(8);

  final int type;
  const IminBarcodeType(this.type);
}

enum IminFontRotate {
  zeroDeg(0),
  ninetyDeg(1);

  final int rotate;
  const IminFontRotate(this.rotate);
}

enum IminFontDirection {
  zeroDeg(0),
  oneHundredAndEightyDeg(1);

  final int direction;
  const IminFontDirection(this.direction);
}

enum IminPrinterDensity {
  seventy(70),
  eighty(80),
  ninety(90),
  oneHundred(100),
  oneHundredAndTen(110),
  oneHundredAndTwenty(120),
  oneHundredAndThirty(130),
  oneHundredAndForty(140),
  oneHundredAndFifty(150);

  final int density;
  const IminPrinterDensity(this.density);
}

enum IminBarCodeToBitmapFormat {
  aztec,
  codabar,
  code39,
  code93,
  code128,
  dataMatrix,
  ean13,
  itf,
  maxicode,
  pdf417,
  qrCode,
  rss14,
  rssExpanded,
  upcA,
  upcE,
  upcEanExteNsion;
}

enum ImageAlgorithm {
  BINARIZATION,
  DITHERING;
}

enum Shape { RECT_FILL, RECT_WHITE, RECT_REVERSE, BOX, CIRCLE, OVAL, PATH }

enum Rotate { ROTATE_0, ROTATE_90, ROTATE_180, ROTATE_270 }

enum ErrorLevel { L, M, Q, H }

enum Symbology {
  UPCA,
  UPCE,
  EAN13,
  EAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128;
}

enum AlignLabel { DEFAULT, LEFT, CENTER, RIGHT }

enum HumanReadable { HIDE, POS_ONE, POS_TWO, POS_THREE }

/// Label info query types for labelQueryInfo
enum IminLabelInfo {
  MODEL,
  VERSION,
  HEIGHT,
  DENSITY,
  SPEED,
  MODE,
  GAP_OFFSET,
  PRINT_LENGTH,
  NO_PAPER_THRESHOLD,
  HAS_PAPER_THRESHOLD,
  THRESHOLD_ADJUSTMENT,
  ORIGINAL_STATUS,
  LABEL_STATUS,
  PAPER_STATUS,
  HOST_RESULT,
  GAP_ERROR
}
