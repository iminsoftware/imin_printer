import 'enums.dart';

class ColumnMaker {
  String text;
  int width;
  IminPrintAlign align;
  int fontSize;

  ColumnMaker({
    this.text = '',
    this.width = 2,
    this.fontSize = 26,
    this.align = IminPrintAlign.left,
  });
  Map<String, String> toJson() {
    return {
      "text": text,
      "width": width.toString(),
      "fontSize": fontSize.toString(),
      "align": align.index.toString()
    };
  }
}
