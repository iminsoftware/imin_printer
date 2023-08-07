library enums;

// 打印机状态
enum PrinterStatus {
  initPrinterError('-1', 'Failed to initialize the printer!'),
  normal('0', 'The printer is normally!'),
  notPoweredOn('1', 'The printer is not connected or powered on!'),
  notLibraryMatch('2', 'The printer and call library do not match'),
  openPrintHead('3', 'Print head open!'),
  cutterNotReset('4', 'The cutter is not reset!'),
  overHeated('5', 'Overheated'),
  blackLabelError('6', 'Black label error!'),
  notPaperFeed('7', 'No Paper Feed'),
  outOfPaper('8', 'Paper Running Out!'),
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
  code128(73);

  final int type;
  const IminBarcodeType(this.type);
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