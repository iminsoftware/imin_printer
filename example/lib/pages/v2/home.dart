import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imin_printer/column_maker.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer_example/pages/v2/info.dart';
import 'package:imin_printer_example/pages/v2/print_sttings_form.dart';
import 'package:permission_handler/permission_handler.dart';

import 'transaction_print.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});
  final String title = '打印测试';
  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  final iminPrinter = IminPrinter();
  bool permissionStatus = false;
  @override
  void initState() {
    super.initState();
    //  getMediaFilePermission();
    if (!mounted) return;
  }

  /// 获取媒体文件读写权限
  Future<void> getMediaFilePermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.manageExternalStorage].request();
    if (!mounted) return;
    // debugPrint('initState: ${ await iminPrinter.listenerEvent()}');
    //granted 通过，denied 被拒绝，permanentlyDenied 拒绝且不在提示
    if (statuses[Permission.manageExternalStorage]!.isGranted) {
      setState(() {
        permissionStatus = true;
      });
    }
    setState(() {
      permissionStatus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'v2 Print Test',
            // style: TextStyle(
            //     color: Color(0xFF1D1D1F), fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          // backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 15,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: [
              OutlinedButton(
                  onPressed: () async {
                    await iminPrinter.initPrinter();
                  },
                  child: const Text('init Printer')),
              OutlinedButton(
                  onPressed: () async {
                    Map<String, dynamic> state =
                        await iminPrinter.getPrinterStatus();
                    Fluttertoast.showToast(
                        msg: state['msg'],
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM, // 消息框弹出的位置
                        // timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: const Text('printer Status')),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.initPrinterParams();
                },
                child: const Text('initPrinterParams'),
              ),
              // OutlinedButton(
              //   onPressed: () async {
              //     await iminPrinter.unBindService();
              //   },
              //   child: const Text('unbind printer'),
              // ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const InfoPage(type: 'Printer Info')),
                  );
                },
                child: const Text('printer info'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.openCashBox();
                },
                child: const Text('open CashBox'),
              ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const InfoPage(type: 'CashBox Info')),
                  );
                },
                child: const Text('cashBox info'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printerSelfChecking();
                },
                child: const Text('print Self Checking'),
              ),
              OutlinedButton(
                onPressed: () async {
                  final List<int> escPos = await customEscPos();
                  debugPrint('escPos: $escPos');

                  await iminPrinter.sendRAWData(Uint8List.fromList(escPos));
                    await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('sendRAWData'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printAndLineFeed();
                },
                child: const Text('printAndLineFeed'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('printAndFeedPaper'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.partialCut();
                    await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('partialCut'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.fullCut();
                  await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('fullCut'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.setCodeAlignment(IminPrintAlign.center);
                },
                child: const Text('setCodeAlignment'),
              ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrintSettingPage(
                            type: 'Printer Text Setting')),
                  );
                },
                child: const Text('print Text'),
              ),
              OutlinedButton(
                onPressed: () async {
                  // Uint8List byte =
                  //     await readFileBytes('assets/images/logo.png');
                  // await iminPrinter.printSingleBitmap(byte,
                  //     pictureStyle: IminPictureStyle(
                  //       alignment: IminPrintAlign.center,
                  //       width: 50,
                  //       height: 20,
                  //     ));

                  await iminPrinter.printSingleBitmap(
                      'https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',
                      pictureStyle: IminPictureStyle(
                        alignment: IminPrintAlign.right,
                        width: 150,
                        height: 50,
                      ));
                  await iminPrinter.printAndFeedPaper(70);
                  await iminPrinter.printText('232323');
                },
                child: const Text('print singleBitmap'),
              ),
              OutlinedButton(
                onPressed: () async {
                  // Uint8List byte1 =
                  //     await _getImageFromAsset('assets/images/logo.png');
                  // Uint8List byte2 =
                  //     await _getImageFromAsset('assets/images/logo.png');

                  // await iminPrinter.printMultiBitmap([byte1, byte2],
                  //     pictureStyle: IminPictureStyle(
                  //         alignment: IminPrintAlign.left));
                  await iminPrinter.printMultiBitmap([
                    'https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',
                    'https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png'
                  ],
                      pictureStyle: IminPictureStyle(
                        alignment: IminPrintAlign.left,
                        width: 250,
                        height: 30,
                      ));
                        await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print multiBitmap'),
              ),
              OutlinedButton(
                onPressed: () async {
                  // Uint8List byte =
                  //     await readFileBytes('assets/images/logo.png');
                  // await iminPrinter.printSingleBitmapColorChart(byte,
                  //     pictureStyle: IminPictureStyle(
                  //       alignment: IminPrintAlign.center,
                  //       width: 50,
                  //       height: 20,
                  //     ));

                  await iminPrinter.printSingleBitmapColorChart(
                      'https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',
                      pictureStyle: IminPictureStyle(
                        alignment: IminPrintAlign.center,
                        width: 150,
                        height: 50,
                      ));
                        await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print bitmapColorChart'),
              ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrintSettingPage(
                            type: 'Printer BarCode Setting')),
                  );
                },
                child: const Text('print barCode'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '语文',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '88',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A-',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '陈老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '数学',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '100',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A+',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '周老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '物理',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '100',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A+',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '张老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '英语',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '96',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A+',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '吴老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '化学',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '95',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A-',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '冯老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                  await iminPrinter.printColumnsText(cols: [
                    ColumnMaker(
                        text: '政治',
                        width: 100,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '65',
                        width: 70,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'B-',
                        width: 50,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '王老师',
                        width: 120,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                   await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print ColumnsText'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printColumnsString(cols: [
                    ColumnMaker(
                        text: '语文',
                        width: 1,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '88',
                        width: 1,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: 'A-',
                        width: 1,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                    ColumnMaker(
                        text: '陈老师',
                        width: 1,
                        fontSize: 26,
                        align: IminPrintAlign.left),
                  ]);
                    await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print ColumnsString'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printQrCode('https://www.imin.sg',
                      qrCodeStyle: IminQrCodeStyle(
                          errorCorrectionLevel:
                              IminQrcodeCorrectionLevel.levelH,
                          qrSize: 5,
                         ));
                           await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print Qrcode'),
              ),
              OutlinedButton(
                onPressed: () async {
                  await iminPrinter.printDoubleQR(
                      qrCode1: IminDoubleQRCodeStyle(
                        text: 'www.imin.sg',
                      ),
                      qrCode2: IminDoubleQRCodeStyle(
                        text: 'www.google.com',
                      ),
                      doubleQRSize: 5);
                        await iminPrinter.printAndFeedPaper(70);
                },
                child: const Text('print DoubleQR'),
              ),
              OutlinedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionPrintPage()),
                  );
                },
                child: const Text('transaction printing'),
              ),
              OutlinedButton(
                onPressed: () async {
                  // 创建一个 LabelCanvasStyle 对象
                  await iminPrinter.labelLearning();
                },
                child: const Text('labelLearning'),
              ),
              OutlinedButton(
                onPressed: () async {
                  // 创建一个 LabelCanvasStyle 对象
                  LabelCanvasStyle labelCanvasStyle = LabelCanvasStyle(width: 40 * 8,
                    height: 30 * 8,);
                  // 调用 labelInitCanvas 方法
                  await iminPrinter.labelInitCanvas(labelCanvasStyle: labelCanvasStyle);

                  LabelTextStyle labelTextStyle = LabelTextStyle(
                    posX: 0,
                    posY: 60,
                    align: AlignLabel.CENTER,
                    enableBold: true,
                    textSize: 30,
                  );
                  // // 调用 labelInitCanvas 方法
                  await iminPrinter.labelAddText("iMin Label Printer",labelTextStyle: labelTextStyle);

                  // 创建一个 LabelCanvasStyle 对象
                  LabelBarCodeStyle barCodeStyle = LabelBarCodeStyle(
                    posX: 30,
                    posY: 370,
                    align: AlignLabel.CENTER,
                    symbology: Symbology.CODABAR,
                    dotWidth: 2,
                    barHeight: 60,
                    readable: HumanReadable.POS_TWO,
                  );
                  // // 调用 labelInitCanvas 方法
                  await iminPrinter.labelAddBarCode("123456",barCodeStyle: barCodeStyle);

                  LabelQrCodeStyle qrCodeStyle = LabelQrCodeStyle(
                    posX: 290,
                    posY: 145,
                    size: 3,
                    errorLevel: ErrorLevel.H,
                  );
                  // // 调用 labelInitCanvas 方法
                  await iminPrinter.labelAddQrCode("12345658哈哈",qrCodeStyle: qrCodeStyle);

                  LabelBitmapStyle addBitmapStyle = LabelBitmapStyle(

                    posX: 290,
                    posY: 30,
                    width: 80,
                    height: 80,

                  );
                  // // 调用 labelInitCanvas 方法
                  await iminPrinter.labelAddBitmap('https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',addBitmapStyle: addBitmapStyle);

                  LabelAreaStyle printBitmapStyle = LabelAreaStyle(
                    style: Shape.PATH,
                    posX: 1,
                    posY: 40,
                    endX: 50 * 8 - 1,
                    endY: 60,
                    thick: 2,
                  );
                  // // 调用 labelInitCanvas 方法
                  await iminPrinter.labelAddArea(areaStyle: printBitmapStyle);

                  await iminPrinter.labelPrintCanvas(1);

                },
                child: const Text('labelPrint'),
              ),

              // OutlinedButton(
              //   onPressed: () async {
              //     LabelPrintBitmapStyle printBitmapStyle = LabelPrintBitmapStyle(
              //       width: 50 * 8,
              //       height: 30 * 8,
              //     );
              //     // // 调用 labelInitCanvas 方法
              //     await iminPrinter.printLabelBitmap('https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',printBitmapStyle: printBitmapStyle);
              //   },
              //   child: const Text('printLabelBitmap'),
              // ),
              OutlinedButton(
                onPressed: () async {
                  // 创建一个 LabelCanvasStyle 对象
                  int? mode = await iminPrinter.getPrinterMode();
                  Fluttertoast.showToast(
                      msg: mode.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM, // 消息框弹出的位置
                      // timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                },
                child: const Text('getPrinterMode'),
              ),
            ],
          ),
        )));
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('----------------！！！！！deactivate  111！！！！----------------');
  }

  @override
  void dispose() {
    super.dispose();
    iminPrinter.unBindService();
    debugPrint('----------------！！！！！dispose  111！！！！----------------');
  }
}

Future<List<int>> customEscPos({bool? isCustom}) async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];
  if (isCustom == null) {
    bytes = [
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x11,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x45,
      0x01,
      0x1b,
      0x47,
      0x01,
      0xb1,
      0xbe,
      0xb5,
      0xea,
      0xc1,
      0xf4,
      0xb4,
      0xe6,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x11,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x45,
      0x01,
      0x1b,
      0x47,
      0x01,
      0x1b,
      0x61,
      0x01,
      0x23,
      0x31,
      0x35,
      0x20,
      0xb0,
      0xd9,
      0xb6,
      0xc8,
      0xcd,
      0xe2,
      0xc2,
      0xf4,
      0x0a,
      0x5b,
      0xbb,
      0xf5,
      0xb5,
      0xbd,
      0xb8,
      0xb6,
      0xbf,
      0xee,
      0x5d,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x01,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xc6,
      0xda,
      0xcd,
      0xfb,
      0xcb,
      0xcd,
      0xb4,
      0xef,
      0xca,
      0xb1,
      0xbc,
      0xe4,
      0xa3,
      0xba,
      0xc1,
      0xa2,
      0xbc,
      0xb4,
      0xc5,
      0xe4,
      0xcb,
      0xcd,
      0x0a,
      0xb6,
      0xa9,
      0xb5,
      0xa5,
      0xb1,
      0xb8,
      0xd7,
      0xa2,
      0xa3,
      0xba,
      0xc7,
      0xeb,
      0xcb,
      0xcd,
      0xb5,
      0xbd,
      0xbf,
      0xfc,
      0xbf,
      0xc6,
      0xce,
      0xf7,
      0xc3,
      0xc5,
      0x2c,
      0xb2,
      0xbb,
      0xd2,
      0xaa,
      0xc0,
      0xb1,
      0x0a,
      0xb7,
      0xa2,
      0xc6,
      0xb1,
      0xd0,
      0xc5,
      0xcf,
      0xa2,
      0xa3,
      0xba,
      0xb0,
      0xd9,
      0xb6,
      0xc8,
      0xcd,
      0xe2,
      0xc2,
      0xf4,
      0xb7,
      0xa2,
      0xc6,
      0xb1,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xb6,
      0xa9,
      0xb5,
      0xa5,
      0xb1,
      0xe0,
      0xba,
      0xc5,
      0xa3,
      0xba,
      0x31,
      0x34,
      0x31,
      0x38,
      0x37,
      0x31,
      0x38,
      0x36,
      0x39,
      0x31,
      0x31,
      0x36,
      0x38,
      0x39,
      0x0a,
      0xcf,
      0xc2,
      0xb5,
      0xa5,
      0xca,
      0xb1,
      0xbc,
      0xe4,
      0xa3,
      0xba,
      0x32,
      0x30,
      0x31,
      0x34,
      0x2d,
      0x31,
      0x32,
      0x2d,
      0x31,
      0x36,
      0x20,
      0x31,
      0x36,
      0x3a,
      0x33,
      0x31,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x01,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xb2,
      0xcb,
      0xc6,
      0xb7,
      0xc3,
      0xfb,
      0xb3,
      0xc6,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0xca,
      0xfd,
      0xc1,
      0xbf,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0xbd,
      0xf0,
      0xb6,
      0xee,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x01,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xcf,
      0xe3,
      0xc0,
      0xb1,
      0xc3,
      0xe6,
      0xcc,
      0xd7,
      0xb2,
      0xcd,
      0x1b,
      0x24,
      0xf2,
      0x00,
      0x31,
      0x1b,
      0x24,
      0x25,
      0x01,
      0xa3,
      0xa4,
      0x34,
      0x30,
      0x2e,
      0x30,
      0x30,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x01,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xcb,
      0xd8,
      0xca,
      0xb3,
      0xcc,
      0xec,
      0xcf,
      0xc2,
      0xba,
      0xba,
      0xb1,
      0xa4,
      0x1b,
      0x24,
      0xf2,
      0x00,
      0x31,
      0x1b,
      0x24,
      0x25,
      0x01,
      0xa3,
      0xa4,
      0x33,
      0x38,
      0x2e,
      0x30,
      0x30,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x2d,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x01,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0xd0,
      0xd5,
      0xc3,
      0xfb,
      0xa3,
      0xba,
      0xb0,
      0xd9,
      0xb6,
      0xc8,
      0xb2,
      0xe2,
      0xca,
      0xd4,
      0x0a,
      0xb5,
      0xd8,
      0xd6,
      0xb7,
      0xa3,
      0xba,
      0xbf,
      0xfc,
      0xbf,
      0xc6,
      0xbf,
      0xc6,
      0xbc,
      0xbc,
      0xb4,
      0xf3,
      0xcf,
      0xc3,
      0x0a,
      0xb5,
      0xe7,
      0xbb,
      0xb0,
      0xa3,
      0xba,
      0x31,
      0x38,
      0x37,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x0a,
      0x1b,
      0x40,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0xb0,
      0xd9,
      0xb6,
      0xc8,
      0xb2,
      0xe2,
      0xca,
      0xd4,
      0xc9,
      0xcc,
      0xbb,
      0xa7,
      0x0a,
      0x31,
      0x38,
      0x37,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x30,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x2a,
      0x0a,
      0x1b,
      0x4d,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1d,
      0x21,
      0x00,
      0x1b,
      0x45,
      0x00,
      0x1b,
      0x47,
      0x00,
      0x1b,
      0x61,
      0x00,
      0x1b,
      0x61,
      0x01,
      0x23,
      0x31,
      0x35,
      0x20,
      0xb0,
      0xd9,
      0xb6,
      0xc8,
      0xcd,
      0xe2,
      0xc2,
      0xf4,
      0x20,
      0x20,
      0x31,
      0x31,
      0xd4,
      0xc2,
      0x30,
      0x39,
      0xc8,
      0xd5,
      0x20,
      0x31,
      0x37,
      0x3a,
      0x35,
      0x30,
      0x3a,
      0x33,
      0x30,
      0x0a,
      0x0a,
      0x0a,
      0x0a,
      0x0a
    ];
  } else {
    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.qrcode('Barcode by escpos',
        size: QRSize.Size4, cor: QRCorrection.H);
    bytes += generator.feed(2);
    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.reset();
    bytes += generator.cut();
  }

  return bytes;
}

Future<Uint8List> readFileBytes(String path) async {
  ByteData fileData = await rootBundle.load(path);
  Uint8List fileUnit8List = fileData.buffer
      .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}
