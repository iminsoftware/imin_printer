package com.imin.printer.imin_printer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.app.Application;
import android.annotation.SuppressLint;

import androidx.annotation.NonNull;


import com.imin.library.IminSDKManager;
import com.imin.library.SystemPropManager;
import com.imin.printerlib.Callback;
import com.imin.printerlib.IminPrintUtils;
import com.imin.printerlib.print.PrintUtils;


import java.lang.reflect.InvocationTargetException;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * IminPrinterPlugin
 */
public class IminPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private IminPrintUtils iminPrintUtils;
    private IminPrintUtils.PrintConnectType connectType = IminPrintUtils.PrintConnectType.USB;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "imin_printer");
        iminPrintUtils = IminPrintUtils.getInstance(Utils.getInstance().getContext());

        String deviceModel = SystemPropManager.getModel();
        if (deviceModel.contains("M2-203") || deviceModel.contains("M2-202") || deviceModel.contains("M2-Pro")) {
            connectType = IminPrintUtils.PrintConnectType.SPI;
        } else {
            connectType = IminPrintUtils.PrintConnectType.USB;
        }
        iminPrintUtils.resetDevice();
        channel.setMethodCallHandler(this);
    }

    @SuppressLint("NewApi")
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "initPrinter":
                iminPrintUtils.initPrinter(connectType);
                result.success(true);
                break;
            case "getPrinterStatus":
                if (connectType.equals(IminPrintUtils.PrintConnectType.SPI)) {
                    iminPrintUtils.getPrinterStatus(connectType, new Callback() {
                        @Override
                        public void callback(int status) {
                            result.success(String.format("%d", status));
                        }
                    });
                } else {
                    int status = iminPrintUtils.getPrinterStatus(connectType);
                    result.success(String.format("%d", status));
                }
                break;
            case "setTextSize":
                int size = call.argument("size");
                iminPrintUtils.setTextSize(size);
                result.success(true);
                break;
            case "setTextTypeface":
                int font = call.argument("font");
                switch (font) {
                    case 1:
                        iminPrintUtils.setTextTypeface(Typeface.MONOSPACE);
                        break;
                    case 2:
                        iminPrintUtils.setTextTypeface(Typeface.DEFAULT_BOLD);
                        break;
                    case 3:
                        iminPrintUtils.setTextTypeface(Typeface.SANS_SERIF);
                        break;
                    case 4:
                        iminPrintUtils.setTextTypeface(Typeface.SERIF);
                        break;
                    default:
                        iminPrintUtils.setTextTypeface(Typeface.DEFAULT);
                        break;
                }
                result.success(true);
                break;
            case "setTextStyle":
                int style = call.argument("style");
                iminPrintUtils.setTextStyle(style);
                result.success(true);
                break;
            case "setTextWidth":
                int textWidth = call.argument("width");
                iminPrintUtils.setTextStyle(textWidth);
                result.success(true);
                break;
            case "setAlignment":
                int alignment = call.argument("alignment");
                iminPrintUtils.setAlignment(alignment);
                result.success(true);
                break;
            case "setTextLineSpacing":
                float space = call.argument("space");
                iminPrintUtils.setTextLineSpacing(space);
                result.success(true);
                break;
            case "printColumnsText":
                String colsStr = call.argument("cols");
                try {
                    JSONArray cols = new JSONArray(colsStr);
                    String[] colsText = new String[cols.length()];
                    int[] colsWidth = new int[cols.length()];
                    int[] colsAlign = new int[cols.length()];
                    int[] colsFontSize = new int[cols.length()];
                    for (int i = 0; i < cols.length(); i++) {
                        JSONObject col = cols.getJSONObject(i);
                        String textColumn = col.getString("text");
                        int widthColumn = col.getInt("width");
                        int alignColumn = col.getInt("align");
                        int fontSizeColumn = col.getInt("fontSize");
                        colsText[i] = textColumn;
                        colsWidth[i] = widthColumn;
                        colsAlign[i] = alignColumn;
                        colsFontSize[i] = fontSizeColumn;
                    }
                    Log.e("IminPrinter", "printColumnsText == > "+Arrays.toString(colsText)+"    "+Arrays.toString(colsWidth)
                    +"   "+Arrays.toString(colsAlign)+"     "+Arrays.toString(colsFontSize));
                    iminPrintUtils.printColumnsText(colsText, colsWidth, colsAlign, colsFontSize);
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", err.getMessage());
                }
                break;
            case "printText":
                String text = call.argument("text");
                iminPrintUtils.printText(text);
                result.success(true);
                break;
            case "printAntiWhiteText":
                String whiteText = call.argument("text");
                Log.d("IminPrinter", whiteText);
                iminPrintUtils.printAntiWhiteText(whiteText);
                result.success(true);
                break;
            case "printAndLineFeed":
                iminPrintUtils.printAndLineFeed();
                result.success(true);
                break;
            case "printAndFeedPaper":
                int height = call.argument("height");
                iminPrintUtils.printAndFeedPaper(height);
                result.success(true);
                break;
            case "partialCut":
                iminPrintUtils.partialCut();
                result.success(true);
                break;
            case "printSingleBitmap":
                byte[] bytes = call.argument("bitmap");
                try {
                    Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                    if (call.argument("alignment") != null) {
                        int align = call.argument("alignment");
                        iminPrintUtils.printSingleBitmap(bitmap, align);
                    } else {
                        iminPrintUtils.printSingleBitmap(bitmap);
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printSingleBitmap:" + err.getMessage());
                }

                break;
            case "printSingleBitmapBlackWhite":
                byte[] blackWhiteBytes = call.argument("bitmap");
                try {
                    Bitmap blackWhiteBitmap = BitmapFactory.decodeByteArray(blackWhiteBytes, 0, blackWhiteBytes.length);
                    iminPrintUtils.printSingleBitmap(blackWhiteBitmap);
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printSingleBitmapBlackWhite:" + err.getMessage());
                }
                break;
            case "printMultiBitmap":
                ArrayList<byte[]> multiBytes = call.argument("bitmaps");
                try {
                    ArrayList<Bitmap> bitmaps = new ArrayList<Bitmap>();
                    for (int i = 0; i < multiBytes.size(); i++) {
                        bitmaps.add(BitmapFactory.decodeByteArray(multiBytes.get(i), 0, multiBytes.get(i).length));
                    }
                    if (call.argument("alignment") != null) {
                        int multiAlign = call.argument("alignment");
                        iminPrintUtils.printMultiBitmap(bitmaps, multiAlign);
                    } else {
                        iminPrintUtils.printMultiBitmap(bitmaps,0);
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printMultiBitmap:" + err.getMessage());
                }

                break;
            case "setQrCodeSize":
                int qrSize = call.argument("qrSize");
                iminPrintUtils.setQrCodeSize(qrSize);
                result.success(true);
                break;
            case "setLeftMargin":
                int margin = call.argument("margin");
                iminPrintUtils.setLeftMargin(margin);
                result.success(true);
                break;
            case "setQrCodeErrorCorrectionLev":
                int level = call.argument("level");
                iminPrintUtils.setLeftMargin(level);
                result.success(true);
                break;
            case "printQrCode":
                String qrStr = call.argument("data");
                if (call.argument("alignment") != null) {
                    int alignmentMode = call.argument("alignment");
                    iminPrintUtils.printQrCode(qrStr, alignmentMode);
                } else {
                    iminPrintUtils.printQrCode(qrStr);
                }
                result.success(true);
                break;
            case "setBarCodeWidth":
                int barCodeWidth = call.argument("width");
                iminPrintUtils.setBarCodeWidth(barCodeWidth);
                result.success(true);
                break;
            case "setBarCodeHeight":
                int barCodeHeight = call.argument("height");
                iminPrintUtils.setBarCodeHeight(barCodeHeight);
                result.success(true);
                break;
            case "setBarCodeContentPrintPos":
                int barCodePosition = call.argument("position");
                iminPrintUtils.setBarCodeContentPrintPos(barCodePosition);
                result.success(true);
                break;
            case "setPageFormat":
                int formatStyle = call.argument("style");
                iminPrintUtils.setPageFormat(formatStyle);
                result.success(true);
                break;
            case "printBarCode":
                try {
                    String barCodeContent = call.argument("data");
                    int barCodeType = call.argument("type");
                    if (call.argument("align") != null) {
                        int barCodeAlign = call.argument("align");
                        iminPrintUtils.printBarCode(barCodeType, barCodeContent, barCodeAlign);
                    } else {
                        iminPrintUtils.printBarCode(barCodeType, barCodeContent);
                    }
                    result.success(true);
                } catch (Exception e) {
                    Log.e("IminPrinter", e.getMessage());
                }
                break;
            case "printBarCodeToBitmapFormat":
                try {
                    // String barCodeFormatContent = call.argument("data");
                    // int barCodeFormatWidth = call.argument("width");
                    // int barCodeFormatHeight = call.argument("height");
                    // int barCodeFormat = call.argument("codeFormat");
                    // switch (barCodeFormat) {
                    //     case 0:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.AZTEC);
                    //         break;
                    //     case 1:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.CODABAR);
                    //         break;
                    //     case 2:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.CODE_39);
                    //         break;
                    //     case 3:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.CODE_93);
                    //         break;
                    //     case 4:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.CODE_128);
                    //         break;
                    //     case 5:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.DATA_MATRIX);
                    //         break;
                    //     case 6:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.EAN_13);
                    //         break;
                    //     case 7:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.ITF);
                    //         break;
                    //     case 8:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.PDF_417);
                    //         break;
                    //     case 9:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.MAXICODE);
                    //         break;
                    //     case 10:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.QR_CODE);
                    //         break;
                    //     case 11:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.RSS_14);
                    //         break;
                    //     case 12:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.RSS_EXPANDED);
                    //         break;
                    //     case 13:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.UPC_A);
                    //         break;
                    //     case 14:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.UPC_E);
                    //         break;
                    //     case 15:
                    //         iminPrintUtils.printBarCodeToBitmapFormat(barCodeFormatContent, barCodeFormatWidth, barCodeFormatHeight, CodeFormat.UPC_EAN_EXTENSION);
                    //         break;
                    // }
                    result.success(true);
                } catch (Exception e) {
                    Log.e("IminPrinter", e.getMessage());
                }
                break;
            case "setDoubleQRSize":
                int doubleQRSize = call.argument("size");
                iminPrintUtils.setDoubleQRSize(doubleQRSize);
                result.success(true);
                break;
            case "setDoubleQR1Level":
                int doubleQR1Level = call.argument("level");
                iminPrintUtils.setDoubleQR1Level(doubleQR1Level);
                result.success(true);
                break;
            case "setDoubleQR2Level":
                int doubleQR2Level = call.argument("level");
                iminPrintUtils.setDoubleQR2Level(doubleQR2Level);
                result.success(true);
                break;
            case "setDoubleQR1MarginLeft":
                int doubleQR1MarginLeft = call.argument("leftMargin");
                iminPrintUtils.setDoubleQR1MarginLeft(doubleQR1MarginLeft);
                result.success(true);
                break;
            case "setDoubleQR2MarginLeft":
                int doubleQR2MarginLeft = call.argument("leftMargin");
                iminPrintUtils.setDoubleQR2MarginLeft(doubleQR2MarginLeft);
                result.success(true);
                break;
            case "setDoubleQR1Version":
                int doubleQR1Version = call.argument("version");
                iminPrintUtils.setDoubleQR1Version(doubleQR1Version);
                break;
            case "setDoubleQR2Version":
                int doubleQR2Version = call.argument("version");
                iminPrintUtils.setDoubleQR2Version(doubleQR2Version);
                break;
            case "printDoubleQR":
                String qrCode1Text = call.argument("qrCode1Text");
                String qrCode2Text = call.argument("qrCode2Text");
                iminPrintUtils.printDoubleQR(qrCode1Text, qrCode2Text);
                result.success(true);
                break;
            case "setInitIminPrinter":
                boolean isDefault = call.argument("isDefault");
                iminPrintUtils.setInitIminPrinter(isDefault);
                result.success(true);
                break;    
            case "resetDevice": 
               iminPrintUtils.resetDevice();
               result.success(true);
               break;    
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
