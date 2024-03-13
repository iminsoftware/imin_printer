import 'package:flutter/material.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/imin_style.dart';

class PrintSettingPage extends StatelessWidget {
  final String type;
  const PrintSettingPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type.toString(),
        ),
      ),
      body: Form(
          child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0),
          child: type.toString() == 'Printer Text Setting'
              ? const TextSettingComponent()
              : const BarCodeSettingComponent(),
        ),
      )),
    );
  }
}

class TextSettingComponent extends StatefulWidget {
  const TextSettingComponent({super.key});
  @override
  State<TextSettingComponent> createState() => _TextSettingComponentState();
}

class _TextSettingComponentState extends State<TextSettingComponent> {
  final iminPrinter = IminPrinter();
  dynamic wordWrap;
  dynamic reverseWhite;
  dynamic underline;
  dynamic throughline;
  dynamic align;
  dynamic typeface;
  dynamic fontStyle;
  TextEditingController descController = TextEditingController();
  String descriptionCount =
      'iMin advocates the core values of "Integrity, Customer First, Invention&Creation, Patience”, using cloud-based technology to help businesses to get  access to the Internet and also increases their data base, by providing more solutions so that their business can take a step further. Through their efficiency enhancement, cost improvement, service innovation, and  better services for consumers, these aspect will drives the entire industry development.';
  final focusNode = FocusNode();
  String letterSpacing = '';
  String lineHeight = '';
  String fontSize = '';
  @override
  void initState() {
    descController = TextEditingController.fromValue(TextEditingValue(
        text: descriptionCount,
        selection: TextSelection.fromPosition(
          TextPosition(
              offset: descriptionCount.length,
              affinity: TextAffinity.downstream),
        )));
    focusNode.requestFocus();
    // descController.selection =
    //     TextSelection(baseOffset: 0, extentOffset: descController.text.length);
    super.initState();
    // init();
  }

  // Future<void> init() async {
  //   if (mounted) {
  //     setState(() {
  //       descriptionCount = descController.text;
  //     });
  //   }
  // }
  @override
  void dispose() {
    focusNode.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TextField(
        keyboardType: TextInputType.multiline,
        controller: descController,
        onChanged: (value) {
          setState(() {
            descriptionCount = value;
          });
        },
        focusNode: focusNode,
        decoration: InputDecoration(
            hintText: 'Please enter the printed text',
            prefixIcon: const Icon(Icons.description),
            counterText: "${descController.text.length}/1000",
            labelText: "Text"),
        maxLines: 3,
        maxLength: 1000,
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            letterSpacing = value;
          });
        },
        decoration: const InputDecoration(
            hintText: '1<=spacing<=60', labelText: "Letter Spacing"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            lineHeight = value;
          });
        },
        decoration: const InputDecoration(
            hintText: '1<=height<=255', labelText: "Line Height"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            fontSize = value;
          });
        },
        decoration: const InputDecoration(
            hintText: 'default 28', labelText: "Font Size"),
      ),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Word Wrap"),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('True'),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('False'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              wordWrap = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Reverse White"),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('True'),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('False'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              reverseWhite = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Under Line"),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('True'),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('False'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              underline = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Through Line"),
          items: const [
            DropdownMenuItem(
              value: true,
              child: Text('True'),
            ),
            DropdownMenuItem(
              value: false,
              child: Text('False'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              throughline = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Align"),
          items: const [
            DropdownMenuItem(
              value: IminPrintAlign.left,
              child: Text('Left'),
            ),
            DropdownMenuItem(
              value: IminPrintAlign.center,
              child: Text('Center'),
            ),
            DropdownMenuItem(
              value: IminPrintAlign.right,
              child: Text('Right'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              align = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Typeface"),
          items: const [
            DropdownMenuItem(
              value: IminTypeface.typefaceDefault,
              child: Text('Default'),
            ),
            DropdownMenuItem(
              value: IminTypeface.typefaceMonospace,
              child: Text('Monospace'),
            ),
            DropdownMenuItem(
              value: IminTypeface.typefaceDefaultBold,
              child: Text('DefaultBold'),
            ),
            DropdownMenuItem(
              value: IminTypeface.typefaceSansSerif,
              child: Text('SansSerif'),
            ),
            DropdownMenuItem(
              value: IminTypeface.typefaceSerif,
              child: Text('Serif'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              typeface = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "FontStyle"),
          items: const [
            DropdownMenuItem(
              value: IminFontStyle.normal,
              child: Text('Normal'),
            ),
            DropdownMenuItem(
              value: IminFontStyle.bold,
              child: Text('Bold'),
            ),
            DropdownMenuItem(
              value: IminFontStyle.italic,
              child: Text('Italic'),
            ),
            DropdownMenuItem(
              value: IminFontStyle.boldItalic,
              child: Text('BoldItalic'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              fontStyle = value;
            });
          }),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            child: const Text('Print Text'),
            onPressed: () {
              debugPrint('FontStyle: $fontStyle');
              debugPrint('FontSize: $fontSize');
              debugPrint('typeface: $typeface');
              debugPrint('wordWrap: $wordWrap');
              debugPrint(
                  'lineHeight: ${lineHeight != '' ? double.parse(lineHeight) : ''}');
              iminPrinter.printTextBitmap(descriptionCount,
                  style: IminTextPictureStyle(
                      fontSize: fontSize != '' ? int.parse(fontSize) : null,
                      wordWrap: wordWrap,
                      align: align,
                      fontStyle: fontStyle,
                      typeface: typeface,
                      letterSpacing: letterSpacing != ''
                          ? double.parse(letterSpacing)
                          : null,
                      lineHeight:
                          lineHeight != '' ? double.parse(lineHeight) : null,
                      underline: underline,
                      throughline: throughline,
                      reverseWhite: reverseWhite));
               iminPrinter.printAndLineFeed();
            }),
      )
    ]);
  }
}

class BarCodeSettingComponent extends StatefulWidget {
  const BarCodeSettingComponent({super.key});
  @override
  State<BarCodeSettingComponent> createState() =>
      _BarCodeSettingComponentState();
}

class _BarCodeSettingComponentState extends State<BarCodeSettingComponent> {
  final iminPrinter = IminPrinter();
  String barCodeContent = '';
  String barCodeWidth = '';
  dynamic barCodeHeight = '';
  dynamic align;
  dynamic barCodeTextPos;
  dynamic barCodeType;
  final TextEditingController barContentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    barContentController.text = '1234567890121';
    if (mounted) {
      setState(() {
        barCodeType = IminBarcodeType.jan13;
        barCodeContent = barContentController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TextField(
        onChanged: (value) {
          setState(() {
            barCodeContent = value;
          });
        },
        controller: barContentController,
        decoration: const InputDecoration(
            hintText: 'Please enter content', labelText: "BarCode Content"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            barCodeWidth = value;
          });
        },
        decoration: const InputDecoration(
            hintText: '2<= width <= 6', labelText: "BarCode Width"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            barCodeHeight = value;
          });
        },
        decoration: const InputDecoration(
            hintText: '24<= height<= 250', labelText: "BarCode Height"),
      ),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "BarCode Type"),
          value: barCodeType,
          items: const [
            DropdownMenuItem(
              value: IminBarcodeType.upcA,
              child: Text('UPC-A'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.upcE,
              child: Text('UPC-E'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.jan13,
              child: Text('JAN13（EAN13）'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.jan8,
              child: Text('JAN8（EAN8）'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.code39,
              child: Text('CODE39'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.itf,
              child: Text('ITF'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.codabar,
              child: Text('CODABAR'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.code93,
              child: Text('CODE93'),
            ),
            DropdownMenuItem(
              value: IminBarcodeType.code128,
              child: Text('CODE128'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              barCodeType = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "BarCode HRI Position"),
          items: const [
            DropdownMenuItem(
              value: IminBarcodeTextPos.noText,
              child: Text('Do not print'),
            ),
            DropdownMenuItem(
              value: IminBarcodeTextPos.textAbove,
              child: Text('Above the barcode'),
            ),
            DropdownMenuItem(
              value: IminBarcodeTextPos.textBelow,
              child: Text('Below the barcode'),
            ),
            DropdownMenuItem(
              value: IminBarcodeTextPos.both,
              child: Text('Barcodes are printed above and below'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              barCodeTextPos = value;
            });
          }),
      DropdownButtonFormField(
          hint: const Text('Please select'),
          decoration: const InputDecoration(labelText: "Align"),
          items: const [
            DropdownMenuItem(
              value: IminPrintAlign.left,
              child: Text('Left'),
            ),
            DropdownMenuItem(
              value: IminPrintAlign.center,
              child: Text('Center'),
            ),
            DropdownMenuItem(
              value: IminPrintAlign.right,
              child: Text('Right'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              align = value;
            });
          }),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            child: const Text('Print BarCode'),
            onPressed: () {
              final barcodeStyle = IminBarCodeStyle(
                  width: barCodeWidth != '' ? int.parse(barCodeWidth) : null,
                  height: barCodeHeight != '' ? int.parse(barCodeHeight) : null,
                  align: align,
                  position: barCodeTextPos);
              iminPrinter.printBarCode(barCodeType, barCodeContent,
                  style: barcodeStyle);
            }),
      )
    ]);
  }
}
