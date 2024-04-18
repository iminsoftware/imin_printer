import 'package:flutter/material.dart';
import 'dart:async';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:imin_printer/column_maker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool permissionStatus = false;
  final iminPrinter = IminPrinter();
  @override
  void initState() {
    super.initState();
    getMediaFilePermission();
  }

  int open = 1;
  /// 获取媒体文件读写权限
  Future<void> getMediaFilePermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.manageExternalStorage].request();
    if (!mounted) return;
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('v1 Print Test'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: const Text('init Printer'),
                        onPressed: () async {
                          await iminPrinter.initPrinter();
                        }),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic>? state =
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
                        child: const Text('getPrinterStatus')),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.printText(
                              'iMin advocates the core values of "Integrity, Customer First, Invention&Creation, Patience”, using cloud-based technology to help businesses to get  access to the Internet and also increases their data base, by providing more solutions so that their business can take a step further. Through their efficiency enhancement, cost improvement, service innovation, and  better services for consumers, these aspect will drives the entire industry development.',
                              style: IminTextStyle(wordWrap: true));
                          await iminPrinter.printAndFeedPaper(100);
                          await iminPrinter.sendRAWDataHexStr("0A");
                        },
                        child: const Text('Text in word wrap')),
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.printText('居中',
                              style:
                                  IminTextStyle(align: IminPrintAlign.center));
                                  await iminPrinter.printAndFeedPaper(100);
                          await iminPrinter.sendRAWDataHexStr("0A");
                        },
                        child: const Text('text alignment'))
                  ]),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printText('测试字体大小',
                            style: IminTextStyle(fontSize: 25));
                            await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('Text fontSize')),
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printText('测试打印字体',
                            style: IminTextStyle(
                                typeface: IminTypeface.typefaceMonospace));
                                await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('Text typeface'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printText('PHOENIX POS',
                            style: IminTextStyle(
                                space: 3,
                                align: IminPrintAlign.center,
                                fontSize: 28,
                                typeface: IminTypeface.typefaceDefaultBold
                                // fontStyle: IminFontStyle.boldItalic
                                ));
                        await iminPrinter.printText('Looney Tunes Tweety',
                            style: IminTextStyle(
                                space: 3,
                                align: IminPrintAlign.center,
                                fontSize: 25,
                                // typeface: IminTypeface.typefaceDefault
                                fontStyle: IminFontStyle.italic));
                                await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('Text style')),
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printSingleBitmap(
                          'https://oss-sg.imin.sg/web/iMinPartner2/images/logo.png',
                           pictureStyle: IminPictureStyle(
                              width: 250,
                              height: 50,
                            )
                        );
                        await iminPrinter.sendRAWDataHexStr("0A");
                        await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print singleBitmap'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printAndLineFeed();
                      },
                      child: const Text('print AndLineFeed')),
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print AndFeedPaper'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printText(
                            '测试打印字体iMin is a service provider who focuses mainly on the field of business intelligence, bringing IoT, AI and cloud service to the business sector. We develop and provide a wide range of intelligent commercial hardware solutions which help businesses to run more cost effectively.');
                        await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print Text')),
                  ElevatedButton(
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
                              alignment: IminPrintAlign.center,
                              width: 250,
                              height: 70,
                            ));
                        await iminPrinter.sendRAWDataHexStr("0A");
                        await iminPrinter.printAndFeedPaper(200);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print singleBitmap in align'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printQrCode('https://www.imin.sg',
                            qrCodeStyle: IminQrCodeStyle(
                                errorCorrectionLevel:
                                    IminQrcodeCorrectionLevel.levelH,
                                qrSize: 4,
                                align: IminPrintAlign.left));
                                await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print QrCode')),
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printColumnsText(cols: [
                          ColumnMaker(
                              text: '张三',
                              width: 1,
                              fontSize: 26,
                              align: IminPrintAlign.center),
                          ColumnMaker(
                              text: '50',
                              width: 2,
                              fontSize: 26,
                              align: IminPrintAlign.left),
                          ColumnMaker(
                              text: 'A+',
                              width: 1,
                              fontSize: 26,
                              align: IminPrintAlign.right)
                        ]);
                        await iminPrinter.sendRAWDataHexStr("0A");
                        await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print ColumnsText'))
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await iminPrinter.printBarCode(
                            IminBarcodeType.jan13, "0123456789012",
                            style: IminBarCodeStyle(
                                align: IminPrintAlign.center,
                                position: IminBarcodeTextPos.textAbove));
                                await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print barCode')),
                  ElevatedButton(
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
                              alignment: IminPrintAlign.center,
                              width: 250,
                              height: 30,
                            ));
                        await iminPrinter.sendRAWDataHexStr("0A");
                        await iminPrinter.printAndFeedPaper(100);
                        await iminPrinter.sendRAWDataHexStr("0A");
                      },
                      child: const Text('print multiBitmap'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.printAntiWhiteText(
                              'iMin is a service provider who focuses mainly on the field of business intelligence, bringing IoT, AI and cloud service to the business sector. We develop and provide a wide range of intelligent commercial hardware solutions which help businesses to run more cost effectively.');
                          await iminPrinter.printAndFeedPaper(100);
                          await iminPrinter.sendRAWDataHexStr("0A");
                        },
                        child: const Text('print antiWhiteText')),
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.printDoubleQR(
                              qrCode1: IminDoubleQRCodeStyle(
                                text: 'www.imin.sg',
                              ),
                              qrCode2: IminDoubleQRCodeStyle(
                                text: 'www.google.com',
                              ),
                              doubleQRSize: 5);
                              await iminPrinter.printAndFeedPaper(100);
                          await iminPrinter.sendRAWDataHexStr("0A");
                        },
                        child: const Text('print DoubleQR'))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.partialCut();
                        },
                        child: const Text('partialCut')),
                    ElevatedButton(
                        onPressed: () async {
                          await iminPrinter.openCashBox();
                        },
                        child: const Text('opencashBox'))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          open = (open==1?0:1);
                          await iminPrinter.openLogs(open==1?1:0);
                        },
                        child: const Text('openLogs')),

                  ]),
            ),
          ],
        )),
      ),
    );
  }
}

// Future<Uint8List> readFileBytes(String path) async {
//   ByteData fileData = await rootBundle.load(path);
//   Uint8List fileUnit8List = fileData.buffer
//       .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//   return fileUnit8List;
// }

// Future<Uint8List> _getImageFromAsset(String iconPath) async {
//   return await readFileBytes(iconPath);
// }
