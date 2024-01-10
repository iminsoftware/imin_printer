import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';

class InfoPage extends StatefulWidget {
  final String type;
  const InfoPage({super.key, this.type = ""});
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final iminPrinter = IminPrinter();
  // 打印机板序列号
  String? printerSerialNumber;
  // 打印机型号
  String? printerModelName;
  // 打印机热敏头型号
  String? printerThermalHead;
  // 打印机固件版本号
  String? printerFirmwareVersion;
  // 打印服务版本号
  String? printServiceVersion;
  // 取打印机硬件版本号
  String? printerHardwareVersion;
  // USB 连接的 pid vid
  String? deviceUsbPrinterVidPid;
  // 连接的 USBDevices 的名称
  String? deviceUsbDevicesName;
  // 打印浓度
  int? printerPrintDensity;
  // 打印长度
  String? devicePrinterPaperDistance;
  // 当前打印机设定的纸张规格
  int? devicePrinterPaperType;
  // 切刀次数
  String? devicePrinterCutTimes;
  // 打印机模式
  int? devicePrinterMode;

  bool? drawerStatus;
  int? openDrawerTimes;
  @override
  void initState() {
    super.initState();
    // 获取设备打印机信息
    widget.type == 'Printer Info' ? getDevicePrinterInfo() : getOpenCashInfo();
  }

  Future<void> getOpenCashInfo() async {
    bool? status = await iminPrinter.getDrawerStatus();
    int? times = await iminPrinter.getOpenDrawerTimes();
    if (mounted) {
      setState(() {
        drawerStatus = status;
        openDrawerTimes = times;
      });
    }
  }

  Future<void> getDevicePrinterInfo() async {
    String? serialNumber = await iminPrinter.getPrinterSerialNumber();
    String? modelName = await iminPrinter.getPrinterModelName();
    String? thermalHead = await iminPrinter.getPrinterThermalHead();
    String? firmwareVersion = await iminPrinter.getPrinterFirmwareVersion();
    String? serviceVersion = await iminPrinter.getServiceVersion();
    String? hardwareVersion = await iminPrinter.getPrinterHardwareVersion();
    String? usbPrinterVidPid = await iminPrinter.getUsbPrinterVidPid();
    String? usbDevicesName = await iminPrinter.getUsbDevicesName();
    int? printerDensity = await iminPrinter.getPrinterDensity();
    String? printerPaperDistance = await iminPrinter.getPrinterPaperDistance();
    int? printerPaperType = await iminPrinter.getPrinterPaperType();
    String? printerCutTimes = await iminPrinter.getPrinterCutTimes();
    int? printerMode = await iminPrinter.getPrinterMode();
    debugPrint('打印机模式：$printerMode');
    if (mounted) {
      // 设置打印机信息
      setState(() {
        printerSerialNumber = serialNumber;
        printerModelName = modelName;
        printerThermalHead = thermalHead;
        printerFirmwareVersion = firmwareVersion;
        printServiceVersion = serviceVersion;
        printerHardwareVersion = hardwareVersion;
        deviceUsbPrinterVidPid = usbPrinterVidPid;
        deviceUsbDevicesName = usbDevicesName;
        printerPrintDensity = printerDensity;
        devicePrinterPaperDistance = printerPaperDistance;
        devicePrinterPaperType = printerPaperType;
        devicePrinterCutTimes = printerCutTimes;
        devicePrinterMode = printerMode;
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Table(
          border: TableBorder.all(color: Colors.black, width: 1),
          columnWidths: const {
            0: FixedColumnWidth(160),
            // 1: FlexColumnWidth(1),
            // 2: FractionColumnWidth(0.5),
            // 3: IntrinsicColumnWidth(flex: 0.2),
            // 4: MaxColumnWidth(FlexColumnWidth(100.0), FractionColumnWidth(0.1))
          },
          children: widget.type.toString() == 'Printer Info'
              ? <TableRow>[
                  TableRow(children: <Widget>[
                    const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'SerialNumber',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    TableCell(
                        child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                              child: Text(printerSerialNumber.toString())),
                        ),
                      ),
                    ))
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'ModelName',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(child: Text(printerModelName.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'ThermalHead',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            Center(child: Text(printerThermalHead.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'FirmwareVersion',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(printerFirmwareVersion.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PrintServiceVersion',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            Center(child: Text(printServiceVersion.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'HardwareVersion',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(printerHardwareVersion.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'UsbPrinterVidPid',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(deviceUsbPrinterVidPid.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'UsbDevicesName',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(deviceUsbDevicesName.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PrinterDensity',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            Center(child: Text(printerPrintDensity.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PaperDistance',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(
                                '${devicePrinterPaperDistance.toString()}cm')),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PaperType',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(devicePrinterPaperType.toString())),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PrinterCutTimes',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(
                                '${devicePrinterCutTimes?.toString() != "" ? devicePrinterCutTimes?.toString() : 0}n')),
                      ),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'PrinterMode',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(devicePrinterMode.toString() != '0'
                                ? 'Normal'
                                : 'Normal')),
                      ),
                    ),
                  ]),
                ]
              : <TableRow>[
                  TableRow(children: <Widget>[
                    const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Drawer Status',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    TableCell(
                        child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(child: Text(drawerStatus.toString())),
                        ),
                      ),
                    ))
                  ]),
                  TableRow(children: <Widget>[
                    const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'OpenDrawerTimes',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    TableCell(
                        child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child:
                              Center(child: Text(openDrawerTimes.toString())),
                        ),
                      ),
                    ))
                  ]),
                ],
        ),
      ),
    );
  }
}
