import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';

/// 新增功能测试页面
class NewFeaturesTestPage extends StatefulWidget {
  const NewFeaturesTestPage({super.key});

  @override
  State<NewFeaturesTestPage> createState() => _NewFeaturesTestPageState();
}

class _NewFeaturesTestPageState extends State<NewFeaturesTestPage> {
  final iminPrinter = IminPrinter();

  void _toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Features Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('ESC/POS Font Control', [
              _btn('setFontBold(true) + printText', () async {
                await iminPrinter.setFontBold(true);
                await iminPrinter.printText('ESC/POS Bold Text\n');
                await iminPrinter.setFontBold(false);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontMultiple(2,2) + printText', () async {
                await iminPrinter.setFontMultiple(2, 2);
                await iminPrinter.printText('2x Width & Height\n');
                await iminPrinter.setFontMultiple(1, 1);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontItalic + printText', () async {
                await iminPrinter.setFontItalic(true);
                await iminPrinter.printText('Italic Text\n');
                await iminPrinter.setFontItalic(false);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontUnderline + printText', () async {
                await iminPrinter.setFontUnderline(1);
                await iminPrinter.printText('Underline Text\n');
                await iminPrinter.setFontUnderline(0);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontAntiWhite + printText', () async {
                await iminPrinter.setFontAntiWhite(true);
                await iminPrinter.printText('Anti-White Text\n');
                await iminPrinter.setFontAntiWhite(false);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontLineSpacing(80)', () async {
                await iminPrinter.setFontLineSpacing(80);
                await iminPrinter.printText('Line 1\n');
                await iminPrinter.printText('Line 2 (spacing=80)\n');
                await iminPrinter.setFontLineSpacing(0);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('setFontCharSpace(5)', () async {
                await iminPrinter.setFontCharSpace(5);
                await iminPrinter.printText('Char Space = 5\n');
                await iminPrinter.setFontCharSpace(0);
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('getFontCountryCode', () async {
                final list = await iminPrinter.getFontCountryCode();
                _toast('Country codes: ${list?.join(", ")}');
              }),
            ]),
            _buildSection('printEscPosText (ESC/POS + Style)', [
              _btn('Bold + 2x size + Center', () async {
                await iminPrinter.printEscPosText(
                  'ESC/POS Styled Text',
                  style: IminEscPosTextStyle(
                    bold: true,
                    widthMultiple: 2,
                    heightMultiple: 2,
                    align: IminPrintAlign.center,
                  ),
                );
                await iminPrinter.printAndFeedPaper(30);
                // 还原
                await iminPrinter.initPrinterParams();
              }),
              _btn('Italic + Underline + Right', () async {
                await iminPrinter.printEscPosText(
                  'Italic Underline Right',
                  style: IminEscPosTextStyle(
                    italic: true,
                    underline: 1,
                    align: IminPrintAlign.right,
                  ),
                );
                await iminPrinter.printAndFeedPaper(30);
                // 还原
                await iminPrinter.initPrinterParams();
              }),
              _btn('No style (plain ESC/POS)', () async {
                await iminPrinter.printEscPosText('Plain ESC/POS text');
                await iminPrinter.printAndFeedPaper(30);
              }),
            ]),
            _buildSection('printText with Style (auto bitmap on 2.0)', [
              _btn('printText + fontSize:36 + bold + center', () async {
                await iminPrinter.printText(
                  'Bitmap styled text',
                  style: IminTextStyle(
                    fontSize: 36,
                    fontStyle: IminFontStyle.bold,
                    align: IminPrintAlign.center,
                  ),
                );
                await iminPrinter.printAndFeedPaper(30);
              }),
              _btn('printText no style (ESC/POS on 2.0)', () async {
                await iminPrinter.printText('No style = ESC/POS on 2.0\n');
                await iminPrinter.printAndFeedPaper(30);
              }),
            ]),
            _buildSection('Advanced 2D Codes', [
              _btn('printPDF417', () async {
                await iminPrinter.printPDF417(
                    'PDF417 Test Data', 3, 5, 2, 5, 2, 0, 1);
                await iminPrinter.printAndFeedPaper(50);
              }),
              _btn('printDataMatrix', () async {
                await iminPrinter.printDataMatrix(
                    'DataMatrix Test', 0, 0, 0, 4, 1);
                await iminPrinter.printAndFeedPaper(50);
              }),
              _btn('printAztecCode', () async {
                await iminPrinter.printAztecCode('Aztec Test', 0, 0, 6, 2, 1);
                await iminPrinter.printAndFeedPaper(50);
              }),
              _btn('printMaxiCode', () async {
                await iminPrinter.printMaxiCode('MaxiCode Test', 4, 1);
                await iminPrinter.printAndFeedPaper(50);
              }),
              _btn('print2DCode (QR via 2D API)', () async {
                await iminPrinter.print2DCode(
                    'https://www.imin.sg', 0, 6, 2, 1);
                await iminPrinter.printAndFeedPaper(50);
              }),
            ]),
            _buildSection('Paper Control', [
              _btn('printAndQuitPaper(100)', () async {
                await iminPrinter.printAndQuitPaper(100);
              }),
              _btn('partialCutAndFeedPaper(50)', () async {
                await iminPrinter.printText('partialCut + Feed\n');
                await iminPrinter.partialCutAndFeedPaper(50);
              }),
              _btn('fullCutAndFeedPaper(50)', () async {
                await iminPrinter.printText('fullCut + Feed\n');
                await iminPrinter.fullCutAndFeedPaper(50);
              }),
            ]),
            // _buildSection('Generic Key-Value API', [
            //   _btn('getPrinterInfoString("sdk_version")', () async {
            //     final info =
            //         await iminPrinter.getPrinterInfoString('sdk_version');
            //     _toast('sdk_version: $info');
            //   }),
            //   _btn('getPrinterInfoList("density_list")', () async {
            //     final list =
            //         await iminPrinter.getPrinterInfoList('density_list');
            //     _toast('density_list: ${list?.join(", ")}');
            //   }),
            //   _btn('getPrinterInfoByKey("printer_name")', () async {
            //     final info =
            //         await iminPrinter.getPrinterInfoByKey('printer_name');
            //     _toast('printer_name: $info');
            //   }),
            // ]),
            // _buildSection('Printer Info (New)', [
            //   _btn('getPrinterTemperature', () async {
            //     final temp = await iminPrinter.getPrinterTemperature();
            //     _toast('Temperature: $temp');
            //   }),
            //   _btn('supportCashBox', () async {
            //     final support = await iminPrinter.supportCashBox();
            //     _toast('Support CashBox: $support');
            //   }),
            //   _btn('getPrinterPatternList', () async {
            //     final list = await iminPrinter.getPrinterPatternList();
            //     _toast('Patterns: ${list?.join(", ")}');
            //   }),
            //   _btn('getPrinterSupplierName', () async {
            //     final name = await iminPrinter.getPrinterSupplierName();
            //     _toast('Supplier: $name');
            //   }),
            //   _btn('getPrinterKnifeReset', () async {
            //     final r = await iminPrinter.getPrinterKnifeReset();
            //     _toast('Knife Reset: $r');
            //   }),
            // ]),
            // _buildSection('Transaction Print (with callback)', [
            //   _btn('commitPrinterBufferWithCallback', () async {
            //     await iminPrinter.enterPrinterBuffer(true);
            //     await iminPrinter.printText('Transaction line 1\n');
            //     await iminPrinter.printText('Transaction line 2\n');
            //     final ok = await iminPrinter.commitPrinterBufferWithCallback();
            //     _toast('Commit result: $ok');
            //   }),
            //   _btn('exitPrinterBufferWithCallback(true)', () async {
            //     await iminPrinter.enterPrinterBuffer(true);
            //     await iminPrinter.printText('Exit buffer test\n');
            //     final ok =
            //         await iminPrinter.exitPrinterBufferWithCallback(true);
            //     _toast('Exit result: $ok');
            //   }),
            // ]),
            // _buildSection('Label Print (New)', [
            //   _btn('labelGapSensorCalibration', () async {
            //     final r = await iminPrinter.labelGapSensorCalibration();
            //     _toast('Calibration: $r');
            //   }),
            //   _btn('labelQueryInfo(MODEL)', () async {
            //     final r = await iminPrinter.labelQueryInfo(IminLabelInfo.MODEL);
            //     _toast('Label Model: $r');
            //   }),
            //   _btn('labelQueryInfo(VERSION)', () async {
            //     final r =
            //         await iminPrinter.labelQueryInfo(IminLabelInfo.VERSION);
            //     _toast('Label Version: $r');
            //   }),
            //   _btn('labelRestoreDefaults', () async {
            //     final r = await iminPrinter.labelRestoreDefaults();
            //     _toast('Restore: $r');
            //   }),
            //   _btn('setLabelContinuousPrint(true)', () async {
            //     await iminPrinter.setLabelContinuousPrint(true);
            //     _toast('Continuous print enabled');
            //   }),
            //   _btn('labelSetPrinterMode(1=Label)', () async {
            //     await iminPrinter.labelSetPrinterMode(1);
            //     _toast('Set to Label mode');
            //   }),
            // ]),
            _buildSection('Receipt Print Test (printText + style)', [
              _btn('Print Full Receipt', () async {
                _toast('Printing receipt...');
                try {
                  Map<String, dynamic> status =
                      await iminPrinter.getPrinterStatus();
                  debugPrint('Status: ${status['msg']}');

                  await iminPrinter.printText('STORE NAME',
                      style: IminTextStyle(align: IminPrintAlign.center));
                  await iminPrinter.printText('123 Main Street, City',
                      style: IminTextStyle(align: IminPrintAlign.center));
                  await iminPrinter.printText('Tel: (555) 123-4567',
                      style: IminTextStyle(align: IminPrintAlign.right));
                  await iminPrinter.printAndLineFeed();
                  await iminPrinter
                      .printText('--------------------------------');
                  await iminPrinter.printAndLineFeed();
                  await iminPrinter.printQrCode(
                      'https://store.com/receipt/12345',
                      qrCodeStyle: IminQrCodeStyle(
                        qrSize: 6,
                        align: IminPrintAlign.center,
                        errorCorrectionLevel: IminQrcodeCorrectionLevel.levelM,
                      ));
                  await iminPrinter.printAndLineFeed();
                  await iminPrinter.printText('Thank you for your business!',
                      style: IminTextStyle(align: IminPrintAlign.center));
                  await iminPrinter.printAndLineFeed();

                  _toast('Test print sent!');
                } catch (e) {
                  _toast('Print error: $e');
                }
              }),
            ]),
            // _buildSection('Status & Debug', [
            //   _btn('regesiterPrinterStatusCallback', () async {
            //     await iminPrinter.regesiterPrinterStatusCallback();
            //     _toast('Status callback registered');
            //   }),
            //   _btn('setDebugLogLevel(3)', () async {
            //     await iminPrinter.setDebugLogLevel(3);
            //     _toast('Log level set to 3');
            //   }),
            //   _btn('getDebugLogState', () async {
            //     final state = await iminPrinter.getDebugLogState();
            //     _toast('Log state: $state');
            //   }),
            // ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey)),
        const Divider(),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: buttons,
        ),
      ],
    );
  }

  Widget _btn(String label, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
