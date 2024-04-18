import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'enums.dart';
import 'column_maker.dart';
import 'imin_style.dart';
import 'imin_printer_platform_interface.dart';
import 'package:logger/logger.dart';

var logger = Logger();

/// An implementation of [IminPrinterPlatform] that uses method channels.
class MethodChannelIminPrinter extends IminPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('imin_printer');

  final eventChannel = const EventChannel('imin_printer_event');

  @override
  Future<String?> getSdkVersion() async {
    return await methodChannel.invokeMethod<String>('getSdkVersion');
  }

  @override
  Stream<dynamic> initEventChannel() {
    return eventChannel.receiveBroadcastStream();
  }

  @override
  Future<bool?> initPrinter() async {
    final status = await methodChannel.invokeMethod<bool>('initPrinter');
    return status;
  }

  @override
  Future<Map<String, dynamic>> getPrinterStatus() async {
    final code = await methodChannel.invokeMethod<String>('getPrinterStatus');
    logger.d('code $code');
    Map<String, dynamic> printerStatus = <String, dynamic>{
      "code": code,
      "msg": PrinterStatus.getValue(code ?? '-1')
    };
    return printerStatus;
  }

  @override
  Future<void> printAndLineFeed() async {
    await methodChannel.invokeMethod<void>('printAndLineFeed');
  }

  @override
  Future<void> printAndFeedPaper(int height) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "height": height,
    };
    await methodChannel.invokeMethod<void>('printAndFeedPaper', arguments);
  }

  @override
  Future<void> partialCut() async {
    await methodChannel.invokeMethod<void>('partialCut');
  }

  @override
  Future<void> setAlignment(IminPrintAlign alignment) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "alignment": alignment.index,
    };
    await methodChannel.invokeMethod<void>('setAlignment', arguments);
  }

  @override
  Future<void> setTextSize(int size) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "size": size,
    };
    await methodChannel.invokeMethod<void>('setTextSize', arguments);
  }

  @override
  Future<void> setTextTypeface(IminTypeface typeface) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "font": typeface.index,
    };
    await methodChannel.invokeMethod<void>('setTextTypeface', arguments);
  }

  @override
  Future<void> setTextStyle(IminFontStyle style) async {
    logger.d('setTextStyle', style.index);
    Map<String, dynamic> arguments = <String, dynamic>{
      "style": style.index,
    };
    await methodChannel.invokeMethod<void>('setTextStyle', arguments);
  }

  @override
  Future<void> setTextLineSpacing(double space) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "space": space,
    };
    await methodChannel.invokeMethod<void>('setTextLineSpacing', arguments);
  }

  @override
  Future<void> setTextWidth(int width) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "width": width,
    };
    await methodChannel.invokeMethod<void>('setTextLineSpacing', arguments);
  }

  @override
  Future<void> printText(String text, {IminTextStyle? style}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (style != null) {
      if (style.wordWrap != null && style.wordWrap == false) {
        arguments.putIfAbsent('text', () => text);
      } else {
        arguments.putIfAbsent('text', () => '$text\n');
      }
      if (style.align != null) {
        await setAlignment(style.align!);
      }

      if (style.width != null) {
        await setTextWidth(style.width!);
      }

      if (style.fontSize != null) {
        await setTextSize(style.fontSize!);
      }
      if (style.typeface != null) {
        await setTextTypeface(style.typeface!);
      }
      if (style.fontStyle != null) {
        await setTextStyle(style.fontStyle!);
      }
    } else {
      arguments.putIfAbsent('text', () => '$text\n');
    }
    await methodChannel.invokeMethod<void>('printText', arguments);
    if (style != null) {
      if (style.align != null) {
        await setAlignment(IminPrintAlign.left);
      }
      if (style.typeface != null) {
        await setTextTypeface(IminTypeface.typefaceDefault);
      }
      if (style.fontStyle != null) {
        await setTextStyle(IminFontStyle.normal);
      }
    }
  }

  @override
  Future<void> printAntiWhiteText(String text, {IminTextStyle? style}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (style != null) {
      if (style.wordWrap != null && style.wordWrap == false) {
        arguments.putIfAbsent('text', () => text);
      }
      if (style.align != null) {
        await setAlignment(style.align!);
      }

      if (style.width != null) {
        await setTextWidth(style.width!);
      }

      if (style.fontSize != null) {
        await setTextSize(style.fontSize!);
      }
      if (style.typeface != null) {
        await setTextTypeface(style.typeface!);
      }
      if (style.fontStyle != null) {
        await setTextStyle(style.fontStyle!);
      }
    } else {
      arguments.putIfAbsent('text', () => '$text\n');
    }

    await methodChannel.invokeMethod<void>('printAntiWhiteText', arguments);
    if (style != null) {
      if (style.align != null) {
        await setAlignment(IminPrintAlign.left);
      }
    }
  }

  @override
  Future<void> printColumnsText({required List<ColumnMaker> cols}) async {
    final jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(jsonCols)
    };
    await methodChannel.invokeMethod<void>('printColumnsText', arguments);
  }

  @override
  Future<void> setBarCodeWidth(int width) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "width": width,
    };
    await methodChannel.invokeMethod<void>('setBarCodeWidth', arguments);
  }

  @override
  Future<void> setBarCodeHeight(int height) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "height": height,
    };
    await methodChannel.invokeMethod<void>('setBarCodeHeight', arguments);
  }

  @override
  Future<void> setBarCodeContentPrintPos(IminBarcodeTextPos position) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "position": position.position,
    };
    await methodChannel.invokeMethod<void>(
        'setBarCodeContentPrintPos', arguments);
  }

  @override
  Future<void> printBarCode(IminBarcodeType barCodeType, String barCodeContent,
      {IminBarCodeStyle? style}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": barCodeContent,
      "type": barCodeType.type
    };
    if (style != null) {
      if (style.align != null &&
          style.height != null &&
          style.width != null &&
          style.position != null) {
        arguments.putIfAbsent('width', () => style.width);
        arguments.putIfAbsent('align', () => style.align?.index);
        arguments.putIfAbsent('height', () => style.height);
        arguments.putIfAbsent('position', () => style.position?.position);
      } else {
        if (style.align != null) {
          arguments.putIfAbsent('align', () => style.align?.index);
        }
        if (style.height != null) {
          await setBarCodeHeight(style.height!);
        }
        if (style.width != null) {
          await setBarCodeWidth(style.width!);
        }
        if (style.position != null) {
          await setBarCodeContentPrintPos(style.position!);
        }
      }
    }
    logger.d('printBarCode: $arguments');
    await methodChannel.invokeMethod<void>('printBarCode', arguments);
  }

  @override
  Future<void> printBarCodeToBitmapFormat(String barCodeContent, int width,
      int height, IminBarCodeToBitmapFormat codeFormat) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": barCodeContent,
      "width": width,
      "height": height,
      "codeFormat": codeFormat.index
    };
    await methodChannel.invokeMethod<void>(
        'printBarCodeToBitmapFormat', arguments);
  }

  @override
  Future<void> setQrCodeSize(int qrSize) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "qrSize": qrSize,
    };
    await methodChannel.invokeMethod<void>('setQrCodeSize', arguments);
  }

  @override
  Future<void> setQrCodeErrorCorrectionLev(
      IminQrcodeCorrectionLevel level) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "level": level.level,
    };
    await methodChannel.invokeMethod<void>(
        'setQrCodeErrorCorrectionLev', arguments);
  }

  @override
  Future<void> setLeftMargin(int margin) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "margin": margin,
    };
    await methodChannel.invokeMethod<void>('setLeftMargin', arguments);
  }

  @override
  Future<void> printQrCode(String data, {IminQrCodeStyle? qrCodeStyle}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (qrCodeStyle != null) {
      if (qrCodeStyle.align != null &&
          qrCodeStyle.qrSize != null &&
          qrCodeStyle.errorCorrectionLevel != null) {
        arguments.putIfAbsent("alignment", () => qrCodeStyle.align?.index);
        arguments.putIfAbsent("qrSize", () => qrCodeStyle.qrSize!);
        arguments.putIfAbsent(
            "level", () => qrCodeStyle.errorCorrectionLevel?.level);
        if (qrCodeStyle.leftMargin != null) {
          await setLeftMargin(qrCodeStyle.leftMargin!);
        }
      } else {
        if (qrCodeStyle.align != null) {
          arguments.putIfAbsent("alignment", () => qrCodeStyle.align?.index);
        }
        if (qrCodeStyle.qrSize != null) {
          await setQrCodeSize(qrCodeStyle.qrSize!);
        }

        if (qrCodeStyle.leftMargin != null) {
          await setLeftMargin(qrCodeStyle.leftMargin!);
        }
        if (qrCodeStyle.errorCorrectionLevel != null) {
          await setQrCodeErrorCorrectionLev(qrCodeStyle.errorCorrectionLevel!);
        }
      }
    }
    arguments.putIfAbsent("data", () => data);
    await methodChannel.invokeMethod<void>('printQrCode', arguments);
  }

  @override
  Future<void> setPageFormat({int? style = 1}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "style": style,
    };
    await methodChannel.invokeMethod<void>('setPageFormat', arguments);
  }

  @override
  Future<void> printSingleBitmap(dynamic img,
      {IminPictureStyle? pictureStyle}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (pictureStyle != null) {
      if (pictureStyle.alignment != null) {
        arguments.putIfAbsent("alignment", () => pictureStyle.alignment?.index);
      }
      if (pictureStyle.width != null && pictureStyle.height != null) {
        arguments.putIfAbsent("width", () => pictureStyle.width);
        arguments.putIfAbsent("height", () => pictureStyle.height);
      }
    }
    arguments.putIfAbsent("bitmap", () => img);
    if (img is Uint8List) {
      await methodChannel.invokeMethod<void>('printSingleBitmap', arguments);
    } else {
      await methodChannel.invokeMethod<void>('printBitmapToUrl', arguments);
    }
  }

  @override
  Future<void> printMultiBitmap(List<dynamic> imgs,
      {IminPictureStyle? pictureStyle}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (pictureStyle != null) {
      if (pictureStyle.alignment != null) {
        arguments.putIfAbsent("alignment", () => pictureStyle.alignment?.index);
      }
      if (pictureStyle.width != null && pictureStyle.height != null) {
        arguments.putIfAbsent("width", () => pictureStyle.width);
        arguments.putIfAbsent("height", () => pictureStyle.height);
      }
    }
    arguments.putIfAbsent("bitmaps", () => imgs);
    if (imgs is List<Uint8List>) {
      await methodChannel.invokeMethod<void>('printMultiBitmap', arguments);
    } else {
      arguments.putIfAbsent("multiBitmap", () => 1);
      await methodChannel.invokeMethod<void>('printBitmapToUrl', arguments);
    }
  }

  @override
  Future<void> printSingleBitmapBlackWhite(dynamic img,
      {IminBaseStyle? baseStyle}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (baseStyle != null) {
      if (baseStyle.width != null && baseStyle.height != null) {
        arguments.putIfAbsent("width", () => baseStyle.width);
        arguments.putIfAbsent("height", () => baseStyle.height);
      }
    }
    arguments.putIfAbsent("bitmap", () => img);
    if (img is Uint8List) {
      await methodChannel.invokeMethod<void>(
          'printSingleBitmapBlackWhite', arguments);
    } else {
      arguments.putIfAbsent("blackWhite", () => 1);
      await methodChannel.invokeMethod<void>('printBitmapToUrl', arguments);
    }
  }

  @override
  Future<void> setDoubleQRSize(int size) async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": size};
    await methodChannel.invokeMethod<void>('setDoubleQRSize', arguments);
  }

  @override
  Future<void> setDoubleQR1Level(int level) async {
    Map<String, dynamic> arguments = <String, dynamic>{"level": level};
    await methodChannel.invokeMethod<void>('setDoubleQR1Level', arguments);
  }

  @override
  Future<void> setDoubleQR2Level(int level) async {
    Map<String, dynamic> arguments = <String, dynamic>{"level": level};
    await methodChannel.invokeMethod<void>('setDoubleQR2Level', arguments);
  }

  @override
  Future<void> setDoubleQR1MarginLeft(int leftMargin) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "leftMargin": leftMargin
    };
    await methodChannel.invokeMethod<void>('setDoubleQR1MarginLeft', arguments);
  }

  @override
  Future<void> setDoubleQR2MarginLeft(int leftMargin) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "leftMargin": leftMargin
    };
    await methodChannel.invokeMethod<void>('setDoubleQR2MarginLeft', arguments);
  }

  @override
  Future<void> setDoubleQR1Version(int version) async {
    Map<String, dynamic> arguments = <String, dynamic>{"version": version};
    await methodChannel.invokeMethod<void>('setDoubleQR1Version', arguments);
  }

  @override
  Future<void> setDoubleQR2Version(int version) async {
    Map<String, dynamic> arguments = <String, dynamic>{"version": version};
    await methodChannel.invokeMethod<void>('setDoubleQR2Version', arguments);
  }

  @override
  Future<void> printDoubleQR(
      {required IminDoubleQRCodeStyle qrCode1,
      required IminDoubleQRCodeStyle qrCode2,
      int? doubleQRSize}) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "qrCode1Text": qrCode1.text,
      "qrCode2Text": qrCode2.text
    };
    if (qrCode1.leftMargin != null) {
      await setDoubleQR1MarginLeft(qrCode1.leftMargin!);
    }
    if (qrCode2.leftMargin != null) {
      await setDoubleQR2MarginLeft(qrCode2.leftMargin!);
    }
    if (qrCode1.level != null) {
      await setDoubleQR1Level(qrCode1.level!);
    }
    if (qrCode2.level != null) {
      await setDoubleQR2Level(qrCode2.level!);
    }
    if (qrCode1.version != null) {
      await setDoubleQR1Version(qrCode1.version!);
    }
    if (qrCode2.version != null) {
      await setDoubleQR2Version(qrCode2.version!);
    }
    if (doubleQRSize != null) {
      await setDoubleQRSize(doubleQRSize);
    }

    await methodChannel.invokeMethod<void>('printDoubleQR', arguments);
  }

  @override
  Future<void> setInitIminPrinter(bool isDefaultPrinter) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "isDefault": isDefaultPrinter
    };
    await methodChannel.invokeMethod<void>('setInitIminPrinter', arguments);
  }

  @override
  Future<void> openCashBox() async {
    await methodChannel.invokeMethod<void>('openCashBox');
  }

  @override
  Future<void> resetDevice() async {
    await methodChannel.invokeMethod<void>('resetDevice');
  }

  @override
  Future<void> unBindService() async {
    await methodChannel.invokeMethod<void>('unBindService');
  }

  @override
  Future<void> initPrinterParams() async {
    await methodChannel.invokeMethod<void>('initPrinterParams');
  }

  @override
  Future<String?> getPrinterSerialNumber() async {
    return await methodChannel.invokeMethod<String>('getPrinterSerialNumber');
  }

  @override
  Future<String?> getPrinterModelName() async {
    return await methodChannel.invokeMethod<String>('getPrinterModelName');
  }

  @override
  Future<String?> getPrinterThermalHead() async {
    return await methodChannel.invokeMethod<String>('getPrinterThermalHead');
  }

  @override
  Future<String?> getPrinterFirmwareVersion() async {
    return await methodChannel
        .invokeMethod<String>('getPrinterFirmwareVersion');
  }

  @override
  Future<String?> getServiceVersion() async {
    return await methodChannel.invokeMethod<String>('getServiceVersion');
  }

  @override
  Future<String?> getPrinterHardwareVersion() async {
    return await methodChannel
        .invokeMethod<String>('getPrinterHardwareVersion');
  }

  @override
  Future<String?> getUsbPrinterVidPid() async {
    return await methodChannel.invokeMethod<String>('getUsbPrinterVidPid');
  }

  @override
  Future<String?> getUsbDevicesName() async {
    return await methodChannel.invokeMethod<String>('getUsbDevicesName');
  }

  @override
  Future<int?> getPrinterDensity() async {
    return await methodChannel.invokeMethod<int>('getPrinterDensity');
  }

  @override
  Future<String?> getPrinterPaperDistance() async {
    return await methodChannel.invokeMethod<String>('getPrinterPaperDistance');
  }

  @override
  Future<int?> getPrinterPaperType() async {
    return await methodChannel.invokeMethod<int>('getPrinterPaperType');
  }

  @override
  Future<String?> getPrinterCutTimes() async {
    return await methodChannel.invokeMethod<String>('getPrinterCutTimes');
  }

  @override
  Future<int?> getPrinterMode() async {
    return await methodChannel.invokeMethod<int>('getPrinterMode');
  }

  @override
  Future<bool?> getDrawerStatus() async {
    return await methodChannel.invokeMethod<bool>('getDrawerStatus');
  }

  @override
  Future<int?> getOpenDrawerTimes() async {
    return await methodChannel.invokeMethod<int>('getOpenDrawerTimes');
  }

  @override
  Future<void> printerSelfChecking() async {
    await methodChannel.invokeMethod<void>('printerSelfChecking');
  }

  @override
  Future<void> sendRAWData(Uint8List bytes) async {
    Map<String, dynamic> arguments = <String, dynamic>{"bytes": bytes};
    await methodChannel.invokeMethod<void>('sendRAWData', arguments);
  }

  @override
  Future<void> fullCut() async {
    await methodChannel.invokeMethod<void>('fullCut');
  }

  @override
  Future<void> setCodeAlignment(IminPrintAlign alignment) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "align": alignment.index,
    };
    await methodChannel.invokeMethod<void>('setCodeAlignment', arguments);
  }

  @override
  Future<void> setTextBitmapTypeface(IminTypeface typeface) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "font": typeface.index,
    };
    await methodChannel.invokeMethod<void>('setTextBitmapTypeface', arguments);
  }

  @override
  Future<void> setTextBitmapSize(int size) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "size": size,
    };
    await methodChannel.invokeMethod<void>('setTextBitmapSize', arguments);
  }

  @override
  Future<void> setTextBitmapStyle(IminFontStyle style) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "style": style.index,
    };
    await methodChannel.invokeMethod<void>('setTextBitmapStyle', arguments);
  }

  @override
  Future<void> setTextBitmapStrikeThru(bool strikeThru) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "strikeThru": strikeThru,
    };
    await methodChannel.invokeMethod<void>(
        'setTextBitmapStrikeThru', arguments);
  }

  @override
  Future<void> setTextBitmapUnderline(bool haveUnderline) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "haveUnderline": haveUnderline,
    };
    await methodChannel.invokeMethod<void>('setTextBitmapUnderline', arguments);
  }

  @override
  Future<void> setTextBitmapLineSpacing(double lineHeight) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "lineHeight": lineHeight,
    };
    await methodChannel.invokeMethod<void>(
        'setTextBitmapLineSpacing', arguments);
  }

  @override
  Future<void> setTextBitmapLetterSpacing(double space) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "letterSpacing": space,
    };
    await methodChannel.invokeMethod<void>(
        'setTextBitmapLetterSpacing', arguments);
  }

  @override
  Future<void> setTextBitmapAntiWhite(bool antiWhite) async {
    Map<String, dynamic> arguments = <String, dynamic>{
      "antiWhite": antiWhite,
    };
    await methodChannel.invokeMethod<void>('setTextBitmapAntiWhite', arguments);
  }

  @override
  Future<void> printTextBitmap(String text,
      {IminTextPictureStyle? style}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (style != null) {
      if (style.wordWrap != null && style.wordWrap == false) {
        arguments.putIfAbsent('text', () => text);
      } else {
        arguments.putIfAbsent('text', () => '$text\n');
      }
      if (style.fontSize != null) {
        logger.d('fontSize');
        await setTextBitmapSize(style.fontSize!);
      }
      if (style.typeface != null) {
        logger.d('typeface');
        await setTextBitmapTypeface(style.typeface!);
      }
      if (style.fontStyle != null) {
        logger.d('fontStyle');
        await setTextBitmapStyle(style.fontStyle!);
      }
      if (style.throughline != null) {
        logger.d('throughline');
        await setTextBitmapStrikeThru(style.throughline!);
      }
      if (style.underline != null) {
        logger.d('underline');
        await setTextBitmapUnderline(style.underline!);
      }

      if (style.lineHeight != null) {
        logger.d('lineHeight', style.lineHeight);
        await setTextBitmapLineSpacing(style.lineHeight!);
      }

      if (style.letterSpacing != null) {
        logger.d('letterSpacing');
        await setTextBitmapLetterSpacing(style.letterSpacing!);
      }

      if (style.reverseWhite != null) {
        logger.d('reverseWhite');
        await setTextBitmapAntiWhite(style.reverseWhite!);
      }
    } else {
      arguments.putIfAbsent('text', () => '$text\n');
    }
    if (style != null && style.align != null) {
      arguments.putIfAbsent('align', () => style.align!.index);
      await methodChannel.invokeMethod<void>(
          'printTextBitmapWithAli', arguments);
    } else {
      await methodChannel.invokeMethod<void>('printTextBitmap', arguments);
    }
  }

  @override
  Future<void> printSingleBitmapColorChart(dynamic img,
      {IminPictureStyle? pictureStyle}) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (pictureStyle != null) {
      if (pictureStyle.alignment != null) {
        arguments.putIfAbsent("alignment", () => pictureStyle.alignment?.index);
      }
      if (pictureStyle.width != null && pictureStyle.height != null) {
        arguments.putIfAbsent("width", () => pictureStyle.width);
        arguments.putIfAbsent("height", () => pictureStyle.height);
      }
    }
    arguments.putIfAbsent("bitmap", () => img);
    if (img is Uint8List) {
      await methodChannel.invokeMethod<void>(
          'printBitmapColorChart', arguments);
    } else {
      arguments.putIfAbsent("SingleBitmapColorChart", () => 1);
      await methodChannel.invokeMethod<void>('printBitmapToUrl', arguments);
    }
  }

  @override
  Future<void> printColumnsString({required List<ColumnMaker> cols}) async {
    final jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(jsonCols)
    };
    await methodChannel.invokeMethod<void>('printColumnsString', arguments);
  }

  @override
  Future<void> enterPrinterBuffer(bool isClean) async {
    Map<String, dynamic> arguments = <String, dynamic>{"isClean": isClean};
    await methodChannel.invokeMethod<void>('enterPrinterBuffer', arguments);
  }

  @override
  Future<void> commitPrinterBuffer() async {
    await methodChannel.invokeMethod<void>('commitPrinterBuffer');
  }

  @override
  Future<void> exitPrinterBuffer(bool isCommit) async {
    Map<String, dynamic> arguments = <String, dynamic>{"isCommit": isCommit};
    await methodChannel.invokeMethod<void>('exitPrinterBuffer', arguments);
  }

  @override
  Future<List<String>?> getFontCodepage() async {
    return await methodChannel.invokeMethod<List<String>>('getFontCodepage');
  }

  @override
  Future<void> setFontCodepage(int codepage) async {
    Map<String, dynamic> arguments = <String, dynamic>{"codepage": codepage};
    return await methodChannel.invokeMethod<void>('setFontCodepage', arguments);
  }

  @override
  Future<String?> getCurCodepage() async {
    return await methodChannel.invokeMethod<String>('getCurCodepage');
  }

  @override
  Future<List<String>?> getEncodeList() async {
    return await methodChannel.invokeMethod<List<String>>('getEncodeList');
  }

  @override
  Future<List<String>?> getPrinterDensityList() async {
    return await methodChannel
        .invokeMethod<List<String>>('getPrinterDensityList');
  }

  @override
  Future<List<String>?> getPrinterSpeedList() async {
    return await methodChannel
        .invokeMethod<List<String>>('getPrinterSpeedList');
  }

  @override
  Future<void> setPrinterSpeed(int speed) async {
    Map<String, dynamic> arguments = <String, dynamic>{"speed": speed};
    await methodChannel.invokeMethod<void>('setPrinterSpeed', arguments);
  }

  @override
  Future<int?> getPrinterSpeed() async {
    return await methodChannel.invokeMethod<int>('getPrinterSpeed');
  }

  @override
  Future<void> setPrinterEncode(int encode) async {
    Map<String, dynamic> arguments = <String, dynamic>{"encode": encode};
    await methodChannel.invokeMethod<void>('setPrinterEncode', arguments);
  }

  @override
  Future<List<String>?> getPrinterPaperTypeList() async {
    return await methodChannel
        .invokeMethod<List<String>>('getPrinterPaperTypeList');
  }

  @override
  Future<void> openLogs(int encode) async {
    Map<String, dynamic> arguments = <String, dynamic>{"open": encode};
    await methodChannel.invokeMethod<void>('setIsOpenLog', arguments);
  }

  @override
  Future<void> sendRAWDataHexStr(String bytes) async {
    Map<String, dynamic> arguments = <String, dynamic>{"hex": bytes};
    await methodChannel.invokeMethod<void>('sendRAWDataHexStr', arguments);
  }
}
