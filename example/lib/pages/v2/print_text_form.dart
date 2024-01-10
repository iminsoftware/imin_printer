import 'package:flutter/material.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/imin_style.dart';

class PrintTextSettingPage extends StatefulWidget {
  final String type;
  const PrintTextSettingPage({super.key, this.type = ""});
  @override
  State<PrintTextSettingPage> createState() => _PrintTextSettingPageState();
}

class _PrintTextSettingPageState extends State<PrintTextSettingPage> {
  final iminPrinter = IminPrinter();
  dynamic wordWrap;
  dynamic reverseWhite;
  dynamic underline;
  dynamic throughline;
  dynamic align;
  dynamic typeface;
  dynamic fontStyle;
  final TextEditingController descController = TextEditingController();
  String descriptionCount = '';
  String letterSpacing = '';
  String lineHeight = '';
  String fontSize = '';
  @override
  void initState() {
    descController.text =
        'iMin advocates the core values of "Integrity, Customer First, Invention&Creation, Patience”, using cloud-based technology to help businesses to get  access to the Internet and also increases their data base, by providing more solutions so that their business can take a step further. Through their efficiency enhancement, cost improvement, service innovation, and  better services for consumers, these aspect will drives the entire industry development.';
    descController.selection =
        TextSelection(baseOffset: 0, extentOffset: descController.text.length);
    super.initState();
    init();
  }

  Future<void> init() async {
    if (mounted) {
      setState(() {
        descriptionCount = descController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type.toString(),
        ),
      ),
      body: Form(
          child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0),
          child: ListView(children: [
            TextField(
              keyboardType: TextInputType.multiline,
              controller: descController,
              onChanged: (value) {
                setState(() {
                  descriptionCount = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Please enter the printed text',
                  prefixIcon: const Icon(Icons.description),
                  counterText: "${descriptionCount.length}/1000",
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
                  hintText: '1<=spacing<=255', labelText: "Letter Spacing"),
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
                  child: const Text('Print'),
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
                          letterSpacing: letterSpacing != '' ? double.parse(letterSpacing) : null,
                          lineHeight: lineHeight != '' ? double.parse(lineHeight) : null,
                          underline: underline,
                          throughline: throughline,
                          reverseWhite: reverseWhite
                        ));
                  }),
            )
          ]),
        ),
      )),
    );
  }
}
