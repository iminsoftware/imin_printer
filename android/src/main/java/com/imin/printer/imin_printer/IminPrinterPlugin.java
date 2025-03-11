package com.imin.printer.imin_printer;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;

import androidx.annotation.NonNull;

import com.imin.printer.ILabelPrintResult;
import com.imin.printer.INeoPrinterCallback;
import com.imin.printer.IPrinterCallback;
import com.imin.printer.PrinterHelper;
import com.imin.printer.enums.Align;
import com.imin.printer.enums.ErrorLevel;
import com.imin.printer.enums.HumanReadable;
import com.imin.printer.enums.ImageAlgorithm;
import com.imin.printer.enums.Rotate;
import com.imin.printer.enums.Shape;
import com.imin.printer.enums.Symbology;
import com.imin.printer.label.LabelAreaStyle;
import com.imin.printer.label.LabelBarCodeStyle;
import com.imin.printer.label.LabelBitmapStyle;
import com.imin.printer.label.LabelCanvasStyle;
import com.imin.printer.label.LabelQrCodeStyle;
import com.imin.printer.label.LabelTextStyle;
import com.imin.printerlib.Callback;
import com.imin.printerlib.IminPrintUtils;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.ExecutionException;

import android.graphics.Typeface;
import android.content.Context;
import android.os.IBinder;
import android.os.RemoteException;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

import android.content.Intent;
import android.content.IntentFilter;
import android.content.BroadcastReceiver;


/**
 * IminPrinterPlugin
 */
public class IminPrinterPlugin implements FlutterPlugin, MethodCallHandler, StreamHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private IminPrintUtils iminPrintUtils;
    private EventChannel eventChannel;
    private Context _context;
    private IminPrintUtils.PrintConnectType connectType = IminPrintUtils.PrintConnectType.USB;
    private EventSink eventSink;
    private String sdkVersion = "1.0.0";
    private static final String ACTION_PRITER_STATUS_CHANGE = "com.imin.printerservice.PRITER_STATUS_CHANGE";
    private static final String ACTION_POGOPIN_STATUS_CHANGE = "com.imin.printerservice.PRITER_CONNECT_STATUS_CHANGE";
    private static final String ACTION_PRITER_STATUS = "status";
    private static final String TAG = "IminPrinterPlugin";
    private BroadcastReceiver chargingStateChangeReceiver;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "imin_printer");
        _context = flutterPluginBinding.getApplicationContext();
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "imin_printer_event");
        if (Build.MODEL.contains("I23D") || Build.MODEL.contains("I23M") || Build.MODEL.contains("I24D") || Build.MODEL.contains("I24T") || Build.MODEL.contains("I24M")) {
              //初始化 2.0 的 SDK。
            PrinterHelper.getInstance().initPrinterService(_context);
            sdkVersion = "2.0.0";
            }
        else {
            //初始化 1.0 SDK
            iminPrintUtils = IminPrintUtils.getInstance(_context);
            String deviceModel = Utils.getInstance().getModel();
            if (deviceModel.contains("M2-203") || deviceModel.contains("M2-202") || deviceModel.contains("M2-Pro")) {
                connectType = IminPrintUtils.PrintConnectType.SPI;
            } else {
                connectType = IminPrintUtils.PrintConnectType.USB;
            }
            iminPrintUtils.resetDevice();
            sdkVersion = "1.0.0";
        }
        eventChannel.setStreamHandler(this);
        channel.setMethodCallHandler(this);

    }

    @SuppressLint("NewApi")
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "getSdkVersion":
                result.success(sdkVersion);
                break;
            case "initPrinter":
                if (iminPrintUtils != null) {
                    iminPrintUtils.initPrinter(connectType);
                    result.success(true);
                } else {
                    Log.d(TAG, _context.getPackageName());
                    PrinterHelper.getInstance().initPrinter(_context.getPackageName(), null);
                }
                break;
            case "getPrinterStatus":
                if (iminPrintUtils != null) {
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
                } else {
                    int status = PrinterHelper.getInstance().getPrinterStatus();
                    result.success(String.format("%d", status));
                }
                break;
            case "setTextSize":
                int size = call.argument("size");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setTextSize(size);
                }
                result.success(true);
                break;
            case "setTextTypeface":
                int font = call.argument("font");
                if (iminPrintUtils != null) {
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
                }
                result.success(true);
                break;
            case "setTextStyle":
                int style = call.argument("style");
                if (iminPrintUtils != null) {
                    switch (style) {
                        case 1:
                            iminPrintUtils.setTextTypeface(Typeface.DEFAULT_BOLD);
                            break;
                        case 2:
                            iminPrintUtils.setTextTypeface(Typeface.defaultFromStyle(Typeface.ITALIC));
                            break;
                        case 3:
                            iminPrintUtils.setTextTypeface(Typeface.defaultFromStyle(Typeface.BOLD_ITALIC));
                            break;
                        default:
                            iminPrintUtils.setTextTypeface(Typeface.DEFAULT);
                            break;
                    }
                }
                result.success(true);
                break;
            case "setTextWidth":
                int textWidth = call.argument("width");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setTextWidth(textWidth);
                }
                result.success(true);
                break;
            case "setAlignment":
                int alignment = call.argument("alignment");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setAlignment(alignment);
                }
                result.success(true);
                break;
            case "setTextLineSpacing":
                double space = call.argument("space");
                float c = ((Double) space).floatValue();
                if (iminPrintUtils != null) {
                    iminPrintUtils.setTextLineSpacing(c);
                }
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
                    if (iminPrintUtils != null) {
                        iminPrintUtils.printColumnsText(colsText, colsWidth, colsAlign, colsFontSize);
                    } else {
                        PrinterHelper.getInstance().printColumnsText(colsText, colsWidth, colsAlign, colsFontSize, null);
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", err.getMessage());
                }
                break;
            case "printText":
                String text = call.argument("text");
                if (iminPrintUtils != null) {
                    iminPrintUtils.printText(text + "\n");
                } else {
                    PrinterHelper.getInstance().printText(text + "\n", null);
                }
                result.success(true);
                break;
            case "printAntiWhiteText":
                String whiteText = call.argument("text");
                if (iminPrintUtils != null) {
                    iminPrintUtils.printAntiWhiteText(whiteText + "\n");
                }
                result.success(true);
                break;
            case "printAndLineFeed":
                if (iminPrintUtils != null) {
                    iminPrintUtils.printAndLineFeed();
                } else {
                    PrinterHelper.getInstance().printAndLineFeed();
                }
                result.success(true);
                break;
            case "printAndFeedPaper":
                int height = call.argument("height");
                if (iminPrintUtils != null) {
                    iminPrintUtils.printAndFeedPaper(height);
                } else {
                    PrinterHelper.getInstance().printAndFeedPaper(height);
                }
                result.success(true);
                break;
            case "partialCut":
                if (iminPrintUtils != null) {
                    iminPrintUtils.partialCut();
                } else {
                    PrinterHelper.getInstance().partialCut();
                }
                result.success(true);
                break;
            case "fullCut":
                if (iminPrintUtils != null) {
                    //TODO
                } else {
                    PrinterHelper.getInstance().fullCut();
                }
                result.success(true);
                break;
            case "printSingleBitmap":
                try {
                    byte[] img = call.argument("bitmap");
                    Bitmap bitmap = BitmapFactory.decodeByteArray(img, 0, img.length);
                    if (call.argument("alignment") != null) {
                        int align = call.argument("alignment");
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printSingleBitmap(bitmap, align);
                        } else {
                            PrinterHelper.getInstance().printBitmapWithAlign(bitmap, align, null);
                        }

                    } else {
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printSingleBitmap(bitmap);
                        } else {
                            PrinterHelper.getInstance().printBitmap(bitmap, null);
                        }

                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printSingleBitmap:" + err.getMessage());
                    result.success(false);
                }
                break;
            case "printBitmapToUrl":
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            if (call.argument("height") != null && call.argument("width") != null) {
                                int imageWidth = call.argument("width");
                                int imageHeight = call.argument("height");
                                if (call.argument("alignment") != null) {
                                    int align = call.argument("alignment");
                                    if (call.argument("multiBitmap") != null) {
                                        ArrayList<String> multiBytes = call.argument("bitmaps");
                                        ArrayList<Bitmap> bitmaps = new ArrayList<Bitmap>();
                                        for (int i = 0; i < multiBytes.size(); i++) {
                                            String url = multiBytes.get(i);
                                            Bitmap image = Glide.with(_context).asBitmap().load(url).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(imageWidth, imageHeight).get();
                                            bitmaps.add(image);
                                        }
                                        if (iminPrintUtils != null) {
                                            iminPrintUtils.printMultiBitmap(bitmaps, align);
                                        } else {
                                            PrinterHelper.getInstance().printMultiBitmapWithAlign(bitmaps, align, null);
                                        }
                                    } else {
                                        String img = call.argument("bitmap");
                                        Bitmap image = Glide.with(_context).asBitmap().load(img).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(imageWidth, imageHeight).get();
                                        if (iminPrintUtils != null) {
                                            iminPrintUtils.printSingleBitmap(image, align);
                                        } else {
                                            if (call.argument("SingleBitmapColorChart") != null) {
                                                PrinterHelper.getInstance().printBitmapColorChartWithAlign(image, align, null);
                                            } else {
                                                PrinterHelper.getInstance().printBitmapWithAlign(image, align, null);
                                            }
                                        }
                                    }
                                } else {
                                    if (call.argument("multiBitmap") != null) {
                                        ArrayList<String> multiBytes = call.argument("bitmaps");
                                        ArrayList<Bitmap> bitmaps = new ArrayList<Bitmap>();
                                        for (int i = 0; i < multiBytes.size(); i++) {
                                            String url = multiBytes.get(i);
                                            Bitmap image = Glide.with(_context).asBitmap().load(url).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(imageWidth, imageHeight).get();
                                            bitmaps.add(image);
                                        }
                                        if (iminPrintUtils != null) {
                                            iminPrintUtils.printMultiBitmap(bitmaps, 0);
                                        } else {
                                            PrinterHelper.getInstance().printMultiBitmap(bitmaps, null);
                                        }
                                    } else {
                                        String img = call.argument("bitmap");
                                        Bitmap bitmap = Glide.with(_context).asBitmap().load(img).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(imageWidth, imageHeight).get();
                                        if (iminPrintUtils != null) {
                                            if (call.argument("blackWhite") != null) {
                                                iminPrintUtils.printSingleBitmapBlackWhite(bitmap);
                                            } else {
                                                iminPrintUtils.printSingleBitmap(bitmap);

                                            }
                                        } else {
                                            if (call.argument("SingleBitmapColorChart") != null) {
                                                PrinterHelper.getInstance().printBitmapColorChart(bitmap, null);
                                            } else {
                                                PrinterHelper.getInstance().printBitmap(bitmap, null);
                                            }
                                        }
                                    }
                                }
                            }
                            result.success(true);
                        } catch (Exception err) {
                            Log.e("IminPrinter", "printBitmapToUrl:" + err.getMessage());
                            result.success(false);
                        }
                    }
                }).start();
                break;
            case "printSingleBitmapBlackWhite":
                byte[] blackWhiteBytes = call.argument("bitmap");
                try {
                    Bitmap blackWhiteBitmap = BitmapFactory.decodeByteArray(blackWhiteBytes, 0, blackWhiteBytes.length);
                    if (iminPrintUtils != null) {
                        iminPrintUtils.printSingleBitmapBlackWhite(blackWhiteBitmap);
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printSingleBitmapBlackWhite:" + err.getMessage());
                    result.success(false);
                }
                break;
            case "printMultiBitmap":
                ArrayList<byte[]> multiBytes = call.argument("bitmaps");
                ArrayList<Bitmap> bitmaps = new ArrayList<Bitmap>();
                try {
                    for (int i = 0; i < multiBytes.size(); i++) {
                        bitmaps.add(BitmapFactory.decodeByteArray(multiBytes.get(i), 0, multiBytes.get(i).length));
                    }
                    if (call.argument("alignment") != null) {
                        int multiAlign = call.argument("alignment");
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printMultiBitmap(bitmaps, multiAlign);
                        } else {
                            PrinterHelper.getInstance().printMultiBitmapWithAlign(bitmaps, multiAlign, null);
                        }
                    } else {
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printMultiBitmap(bitmaps, 0);
                        } else {
                            PrinterHelper.getInstance().printMultiBitmap(bitmaps, null);
                        }
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printMultiBitmap:" + err.getMessage());
                    result.success(false);
                }
                break;
            case "setQrCodeSize":
                int qrSize = call.argument("qrSize");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setQrCodeSize(qrSize);
                } else {
                    PrinterHelper.getInstance().setQrCodeSize(qrSize);
                }
                result.success(true);
                break;
            case "setLeftMargin":
                int margin = call.argument("margin");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setLeftMargin(margin);
                } else {
                    PrinterHelper.getInstance().setLeftMargin(margin);
                }
                result.success(true);
                break;
            case "setQrCodeErrorCorrectionLev":
                int level = call.argument("level");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setQrCodeErrorCorrectionLev(level);
                } else {
                    PrinterHelper.getInstance().setQrCodeErrorCorrectionLev(level);
                }
                result.success(true);
                break;
            case "printQrCode":
                String qrStr = call.argument("data");
                if (call.argument("alignment") != null) {
                    int alignmentMode = call.argument("alignment");
                    if (iminPrintUtils != null) {
                        Log.e("IminPrinter", "  printQrCode ==> " + qrStr + "  " + alignmentMode);

                        iminPrintUtils.printQrCode(qrStr, alignmentMode);
                    } else {
                        if (call.argument("qrSize") != null && call.argument("level") != null) {
                            int qrFullSize = call.argument("qrSize");
                            int qrFullLevel = call.argument("level");
                            PrinterHelper.getInstance().printQRCodeWithFull(qrStr, qrFullSize, qrFullLevel, alignmentMode, null);
                        } else {
                            PrinterHelper.getInstance().printQrCodeWithAlign(qrStr, alignmentMode, null);
                        }
                    }
                } else {
                    if (iminPrintUtils != null) {
                        iminPrintUtils.printQrCode(qrStr);
                    } else {
                        PrinterHelper.getInstance().printQrCode(qrStr, null);
                    }
                }
                result.success(true);
                break;
            case "setBarCodeWidth":
                int barCodeWidth = call.argument("width");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setBarCodeWidth(barCodeWidth);
                } else {
                    PrinterHelper.getInstance().setBarCodeWidth(barCodeWidth);
                }
                result.success(true);
                break;
            case "setBarCodeHeight":
                int barCodeHeight = call.argument("height");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setBarCodeHeight(barCodeHeight);
                } else {
                    PrinterHelper.getInstance().setBarCodeHeight(barCodeHeight);
                }
                result.success(true);
                break;
            case "setBarCodeContentPrintPos":
                int barCodePosition = call.argument("position");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setBarCodeContentPrintPos(barCodePosition);
                } else {
                    PrinterHelper.getInstance().setBarCodeContentPrintPos(barCodePosition);
                }
                result.success(true);
                break;
            case "setPageFormat":
                int formatStyle = call.argument("style");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setPageFormat(formatStyle);
                } else {
                    PrinterHelper.getInstance().setPageFormat(formatStyle);
                }
                result.success(true);
                break;
            case "printBarCode":
                try {
                    String barCodeContent = call.argument("data");
                    int barCodeType = call.argument("type");
                    if (call.argument("align") != null) {
                        int barCodeAlign = call.argument("align");
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printBarCode(barCodeType, barCodeContent, barCodeAlign);
                        } else {
                            if (call.argument("position") != null && call.argument("height") != null && call.argument("width") != null) {
                                int barCodeFullPosition = call.argument("position");
                                int barCodeFullHeight = call.argument("height");
                                int barCodeFullWidth = call.argument("width");
                                PrinterHelper.getInstance().printBarCodeWithFull(barCodeContent, barCodeType, barCodeFullWidth, barCodeFullHeight, barCodeAlign, barCodeFullPosition, null);
                            } else {
                                PrinterHelper.getInstance().printBarCodeWithAlign(barCodeContent, barCodeType, barCodeAlign, null);
                            }
                        }
                    } else {
                        if (iminPrintUtils != null) {
                            iminPrintUtils.printBarCode(barCodeType, barCodeContent);
                        } else {
                            Log.d("IminPrinter:printBarCode", "barCodeType:" + barCodeType);
                            Log.d("IminPrinter:printBarCode", "barCodeContent:" + barCodeContent);
                            PrinterHelper.getInstance().printBarCode(barCodeContent, barCodeType, null);
                        }
                    }
                    result.success(true);
                } catch (Exception e) {
                    Log.e("IminPrinter", e.getMessage());
                    result.success(false);
                }
                break;
            case "setDoubleQRSize":
                int doubleQRSize = call.argument("size");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQRSize(doubleQRSize);
                } else {
                    PrinterHelper.getInstance().setDoubleQRSize(doubleQRSize);
                }
                result.success(true);
                break;
            case "setDoubleQR1Level":
                int doubleQR1Level = call.argument("level");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR1Level(doubleQR1Level);
                } else {
                    PrinterHelper.getInstance().setDoubleQR1Level(doubleQR1Level);
                }
                result.success(true);
                break;
            case "setDoubleQR2Level":
                int doubleQR2Level = call.argument("level");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR2Level(doubleQR2Level);
                } else {
                    PrinterHelper.getInstance().setDoubleQR2Level(doubleQR2Level);
                }
                result.success(true);
                break;
            case "setDoubleQR1MarginLeft":
                int doubleQR1MarginLeft = call.argument("leftMargin");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR1MarginLeft(doubleQR1MarginLeft);
                } else {
                    PrinterHelper.getInstance().setDoubleQR1MarginLeft(doubleQR1MarginLeft);
                }
                result.success(true);
                break;
            case "setDoubleQR2MarginLeft":
                int doubleQR2MarginLeft = call.argument("leftMargin");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR2MarginLeft(doubleQR2MarginLeft);
                } else {
                    PrinterHelper.getInstance().setDoubleQR2MarginLeft(doubleQR2MarginLeft);
                }
                result.success(true);
                break;
            case "setDoubleQR1Version":
                int doubleQR1Version = call.argument("version");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR1Version(doubleQR1Version);
                } else {
                    PrinterHelper.getInstance().setDoubleQR1Version(doubleQR1Version);
                }
                result.success(true);
                break;
            case "setDoubleQR2Version":
                int doubleQR2Version = call.argument("version");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setDoubleQR2Version(doubleQR2Version);
                } else {
                    PrinterHelper.getInstance().setDoubleQR2Version(doubleQR2Version);
                }
                result.success(true);
                break;
            case "printDoubleQR":
                String qrCode1Text = call.argument("qrCode1Text");
                String qrCode2Text = call.argument("qrCode2Text");
                if (iminPrintUtils != null) {
                    iminPrintUtils.printDoubleQR(qrCode1Text, qrCode2Text);
                } else {
                    PrinterHelper.getInstance().printDoubleQR(qrCode1Text, qrCode2Text, null);
                }
                result.success(true);
                break;
            case "openCashBox":
                if (iminPrintUtils != null) {
                    Utils.getInstance().opencashBox();
                } else {
                    PrinterHelper.getInstance().openDrawer();
                }
                result.success(true);
                break;
            case "setInitIminPrinter":
                boolean isDefault = call.argument("isDefault");
                if (iminPrintUtils != null) {
                    iminPrintUtils.setInitIminPrinter(isDefault);
                }
                result.success(true);
                break;
            case "resetDevice":
                if (iminPrintUtils != null) {
                    iminPrintUtils.resetDevice();
                }
                result.success(true);
                break;
            case "initPrinterParams":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().initPrinterParams();
                }
                result.success(true);
                break;
            case "unBindService":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().deInitPrinterService(_context);
                }
                result.success(true);
                break;

            case "getFontCodepage"://1. codepage
                if (iminPrintUtils == null) {
                    List<String> fontCodepage = PrinterHelper.getInstance().getFontCodepage();
                    result.success(fontCodepage);
                }
                result.success(true);
                break;
            case "setFontCodepage":
                if (iminPrintUtils == null) {
                    int codepage = call.argument("codepage");//从getFontCodepage 列表的脚标（0、1、3...）
                    PrinterHelper.getInstance().setFontCodepage(codepage);
                }
                result.success(true);
                break;
            case "getCurCodepage":
                if (iminPrintUtils == null) {
                    String curCodepage = PrinterHelper.getInstance().getCurCodepage();
                    result.success(curCodepage);
                }
                result.success(true);
                break;

            case "getEncodeList"://2. encode
                if (iminPrintUtils == null) {
                    List<String> encodeList = PrinterHelper.getInstance().getEncodeList();
                    result.success(encodeList);
                }
                break;
            case "setPrinterEncode":
                if (iminPrintUtils == null) {
                    int encode = call.argument("encode");
                    PrinterHelper.getInstance().setPrinterEncode(encode);
                }
                result.success(true);
                break;
            case "getCurEncode":
                if (iminPrintUtils == null) {
                    String curEncode = PrinterHelper.getInstance().getCurEncode();
                    result.success(curEncode);
                }
                break;

            case "getPrinterDensityList"://3. density
                if (iminPrintUtils == null) {
                    List<String> printerDensityList = PrinterHelper.getInstance().getPrinterDensityList();
                    result.success(printerDensityList);
                }
                break;
            case "setPrinterDensity":
                if (iminPrintUtils == null) {
                    int density = call.argument("density");
                    PrinterHelper.getInstance().setPrinterDensity(density);
                }
                result.success(true);
                break;
            case "getPrinterDensity":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getPrinterDensity());
                }
                break;
            case "getPrinterSpeedList"://4. speed
                if (iminPrintUtils == null) {
                    List<String> printerSpeedList = PrinterHelper.getInstance().getPrinterSpeedList();
                    result.success(printerSpeedList);
                }
                break;
            case "setPrinterSpeed":
                if (iminPrintUtils == null) {
                    int speed = call.argument("speed");
                    PrinterHelper.getInstance().setPrinterSpeed(speed);
                }
                result.success(true);
                break;
            case "getPrinterSpeed":
                if (iminPrintUtils == null) {
                    int printerSpeed = PrinterHelper.getInstance().getPrinterSpeed();
                    result.success(printerSpeed);
                }
                break;
            case "getPrinterPaperTypeList"://5. Paper width
                if (iminPrintUtils == null) {
                    List<String> printerPaperTypeList = PrinterHelper.getInstance().getPrinterPaperTypeList();
                    result.success(printerPaperTypeList);
                }
                break;
            case "getPrinterPaperType":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getPrinterPaperType());
                }
                break;
            case "getPrinterSerialNumber":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterSerialNumber(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
            case "getPrinterModelName":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterModelName(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
            case "getPrinterThermalHead":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterThermalHead(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
            case "getPrinterFirmwareVersion":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterFirmwareVersion(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
            case "getServiceVersion":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getServiceVersion());
                }
                break;
            case "getPrinterHardwareVersion":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterHardwareVersion(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
            case "getUsbPrinterVidPid":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getUsbPrinterVidPid());
                }
                break;
            case "getUsbDevicesName":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getUsbDevicesName());
                }
                break;

            case "getPrinterPaperDistance":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterPaperDistance(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;

            case "getPrinterCutTimes":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().getPrinterCutTimes(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {
                            result.success(isSuccess);//"true 绑定服务成功" : "false 绑定服务失败"
                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            result.success(s);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }
                break;
//            case "getPrinterMode":
//                if (iminPrintUtils == null) {
//                    result.success(PrinterHelper.getInstance().getPrinterMode());
//                }
//                break;
            case "getDrawerStatus":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getDrawerStatus());
                }
                break;
            case "getOpenDrawerTimes":
                if (iminPrintUtils == null) {
                    result.success(PrinterHelper.getInstance().getOpenDrawerTimes());
                }
                break;
            case "printerSelfChecking":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().printerSelfChecking(null);
                }
                break;
            case "sendRAWData":
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().sendRAWData((byte[]) call.argument("bytes"), null);
                }
                result.success(true);
                break;
            case "setCodeAlignment":
                if (iminPrintUtils == null) {
                    int align = call.argument("align");
                    Log.d("TAG", "setCodeAlignment: " + align);
                    PrinterHelper.getInstance().setCodeAlignment(align);
                }
                result.success(true);
                break;
            case "setTextBitmapTypeface":
                if (iminPrintUtils == null) {
                    int textBitmapFont = call.argument("font");
                    switch (textBitmapFont) {
                        case 1:
                            PrinterHelper.getInstance().setTextBitmapTypeface("Typeface.MONOSPACE");
                            break;
                        case 2:
                            PrinterHelper.getInstance().setTextBitmapTypeface("Typeface.DEFAULT_BOLD");
                            break;
                        case 3:
                            PrinterHelper.getInstance().setTextBitmapTypeface("Typeface.SANS_SERIF");
                            break;
                        case 4:
                            PrinterHelper.getInstance().setTextBitmapTypeface("Typeface.SERIF");
                            break;
                        default:
                            PrinterHelper.getInstance().setTextBitmapTypeface("Typeface.DEFAULT");
                            break;
                    }
                }
                result.success(true);
                break;
            case "setTextBitmapSize":
                if (iminPrintUtils == null) {
                    int textBitmapSize = call.argument("size");
                    PrinterHelper.getInstance().setTextBitmapSize(textBitmapSize);
                }
                result.success(true);
                break;
            case "setTextBitmapStyle":
                if (iminPrintUtils == null) {
                    int textBitmapStyle = call.argument("style");
                    Log.d("setTextBitmapStyle", "setTextBitmapStyle: " + textBitmapStyle);
                    PrinterHelper.getInstance().setTextBitmapStyle(textBitmapStyle);
                }
                result.success(true);
                break;
            case "setTextBitmapStrikeThru":
                if (iminPrintUtils == null) {
                    boolean strikeThru = call.argument("strikeThru");
                    PrinterHelper.getInstance().setTextBitmapStrikeThru(strikeThru);
                }
                result.success(true);
                break;
            case "setTextBitmapUnderline":
                if (iminPrintUtils == null) {
                    boolean haveUnderline = call.argument("haveUnderline");
                    PrinterHelper.getInstance().setTextBitmapUnderline(haveUnderline);
                }
                result.success(true);
                break;
            case "setTextBitmapLineSpacing":
                if (iminPrintUtils == null) {
                    double lineHeight = call.argument("lineHeight");
                    float s = ((Double) lineHeight).floatValue();
                    PrinterHelper.getInstance().setTextBitmapLineSpacing(s);
                }
                result.success(true);
                break;
            case "setTextBitmapLetterSpacing":
                if (iminPrintUtils == null) {
                    double letterSpacing = call.argument("letterSpacing");
                    float a = ((Double) letterSpacing).floatValue();
                    PrinterHelper.getInstance().setTextBitmapLetterSpacing(a);
                }
                result.success(true);
                break;
            case "setTextBitmapAntiWhite":
                if (iminPrintUtils == null) {
                    boolean antiWhite = call.argument("antiWhite");
                    PrinterHelper.getInstance().setTextBitmapAntiWhite(antiWhite);
                }
                result.success(true);
                break;
            case "printTextBitmap":
                if (iminPrintUtils == null) {
                    String textStr = call.argument("text");
                    PrinterHelper.getInstance().printTextBitmap(textStr + "\n", null);
                }
                result.success(true);
                break;
            case "printTextBitmapWithAli":
                if (iminPrintUtils == null) {
                    String textBitmapString = call.argument("text");
                    int textBitmapAlign = call.argument("align");
                    PrinterHelper.getInstance().printTextBitmapWithAli(textBitmapString + "\n", textBitmapAlign, null);
                }
                result.success(true);
                break;
            case "printBitmapColorChart":
                try {
                    byte[] img = call.argument("bitmap");
                    Bitmap bitmap = BitmapFactory.decodeByteArray(img, 0, img.length);
                    if (call.argument("alignment") != null) {
                        int align = call.argument("alignment");
                        if (iminPrintUtils == null) {
                            PrinterHelper.getInstance().printBitmapColorChartWithAlign(bitmap, align, null);
                        }

                    } else {
                        if (iminPrintUtils == null) {
                            PrinterHelper.getInstance().printBitmapColorChart(bitmap, null);
                        }
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", "printBitmapColorChart:" + err.getMessage());
                }
                result.success(true);
                break;
            case "printColumnsString":
                String colsString = call.argument("cols");
                Log.e("IminPrinter","printColumnsString ===> "+colsString);
                try {
                    JSONArray cols = new JSONArray(colsString);
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
                    if (iminPrintUtils == null) {
                        PrinterHelper.getInstance().printColumnsString(colsText, colsWidth, colsAlign, colsFontSize, null);
                    }
                    result.success(true);
                } catch (Exception err) {
                    Log.e("IminPrinter", err.getMessage());
                    result.success(false);
                }

                break;
            case "getPrinterIsUpdateStatus":
                // if (iminPrintUtils == null) {
                //      result.success(PrinterHelper.getInstance().getPrinterIsUpdateStatus());
                // }
                result.success(true);
                break;

            case "enterPrinterBuffer"://进入事务模式
                if (iminPrintUtils == null) {
                    boolean isClean = call.argument("isClean");
                    PrinterHelper.getInstance().enterPrinterBuffer(isClean);
                }
                result.success(true);
                break;
            case "commitPrinterBuffer"://提交事务打印
                if (iminPrintUtils == null) {
                    PrinterHelper.getInstance().commitPrinterBuffer(null);
                }
                result.success(true);
                break;

            case "exitPrinterBuffer"://exit事务模式
                if (iminPrintUtils == null) {
                    boolean isCommit = call.argument("isCommit");
                    PrinterHelper.getInstance().exitPrinterBuffer(isCommit);
                }
                result.success(true);
                break;
            case "setIsOpenLog":
                if (iminPrintUtils != null) {
                    int open = call.argument("open");
                    iminPrintUtils.setIsOpenLog(open);
                }
                result.success(true);
                break;
            case "sendRAWDataHexStr":
                if (iminPrintUtils != null) {
                    String open = call.argument("hex");
                    iminPrintUtils.sendRAWData(open);
                }
                result.success(true);
                break;
            ////标签打印

            case "labelInitCanvas"://标签初始化
            {
                if (iminPrintUtils == null) {
                    Map<String, Object> labelCanvasStyleMap = call.argument("labelCanvasStyle");

                    if (labelCanvasStyleMap != null) {
                        Integer width = (Integer) labelCanvasStyleMap.get("width");
                        Integer height1 = (Integer) labelCanvasStyleMap.get("height");
                        Integer posX = (Integer) labelCanvasStyleMap.get("posX");
                        Integer posY = (Integer) labelCanvasStyleMap.get("posY");

                        // 使用解析后的数据
                        Log.e("IminPrinter", "labelInitCanvas:" + width+" "+height1+" "+posX+" ,y= "+posY);
                        PrinterHelper.getInstance().labelInitCanvas(LabelCanvasStyle.getCanvasStyle()
                                .setWidth(width)
                                .setHeight(height1)
                                .setPosX(posX)
                                .setPosY(posY)
                        );
                    }
                    result.success(true);
                }
            }
                break;
            case "labelAddText"://绘制文本内容
            {
                Log.e("IminPrinter", "labelAddText: 点击绘制文本" );
                if (iminPrintUtils == null){
                    String textLabel = call.argument("text");
                    Map<String, Object> labelAddTexteMap = call.argument("labelTexStyle");
                    if (labelAddTexteMap != null) {
                        // 手动解析每个参数
                        Integer posX = (Integer) labelAddTexteMap.get("posX");
                        Integer posY = (Integer) labelAddTexteMap.get("posY");
                        Integer textSize = (Integer) labelAddTexteMap.get("textSize");
                        Integer textWidthRatio = (Integer) labelAddTexteMap.get("textWidthRatio");
                        Integer textHeightRatio = (Integer) labelAddTexteMap.get("textHeightRatio");
                        Integer width = (Integer) labelAddTexteMap.get("width");
                        Integer height1 = (Integer) labelAddTexteMap.get("height");
                        String alignStr = (String) labelAddTexteMap.get("align");
                        String rotateStr = (String) labelAddTexteMap.get("rotate");
                        Integer textSpace = (Integer) labelAddTexteMap.get("textSpace");
                        Boolean enableBold = (Boolean) labelAddTexteMap.get("enableBold");
                        Boolean enableUnderline = (Boolean) labelAddTexteMap.get("enableUnderline");
                        Boolean enableStrikethrough = (Boolean) labelAddTexteMap.get("enableStrikethrough");
                        Boolean enableItalics = (Boolean) labelAddTexteMap.get("enableItalics");
                        Boolean enAntiColor = (Boolean) labelAddTexteMap.get("enAntiColor");

                        Log.e("IminPrinter", "labelAddText: 点击绘制文本 " +textLabel+",width=" +
                                width+" ,height1= "+height1+" ,posX= "+posX+" ,posY= "+posY+" ,rotateStr= "+rotateStr+" ,enableBold= "+enableBold);

                        // 将字符串转换为枚举类型
                        Align align = Align.valueOf(alignStr);
                        Rotate rotate = Rotate.valueOf(rotateStr);

                        PrinterHelper.getInstance().labelAddText(textLabel, LabelTextStyle.getTextStyle()
                                .setPosX(posX)
                                .setPosY(posY)
                                .setTextSize(textSize)
                                .setTextWidthRatio(textWidthRatio)
                        .setTextHeightRatio(textHeightRatio)
                        .setWidth (width)
                        .setHeight(height1)
                        .setAlign(align)
                        .setRotate(rotate)
                        .setTextSpace(textSpace)
                        .setEnableBold (enableBold)
                        .setEnableUnderline (enableUnderline)
                        .setEnableStrikethrough(enableStrikethrough)
                        .setEnableItalics(enableItalics)
                        .setEnAntiColor(enAntiColor)
                        );
                    }
                    result.success(true);
                }
            }
                break;
            case "labelAddBarCode"://绘制条形码内容
            {
                if (iminPrintUtils == null){
                    String barCode = call.argument("barCode");
                    Map<String, Object> barCodeStyleMap = call.argument("barCodeStyle");
                    if (barCodeStyleMap != null) {
                        // 直接从 map 获取各个属性
                        Integer posX = (Integer) barCodeStyleMap.get("posX");
                        Integer posY = (Integer) barCodeStyleMap.get("posY");
                        Integer dotWidth = (Integer) barCodeStyleMap.get("dotWidth");
                        Integer barHeight = (Integer) barCodeStyleMap.get("barHeight");
                        String readable = (String) barCodeStyleMap.get("readable");
                        String symbology = (String) barCodeStyleMap.get("symbology");
                        String alignStr = (String) barCodeStyleMap.get("align");
                        String rotateStr = (String) barCodeStyleMap.get("rotate");
                        Integer width = (Integer) barCodeStyleMap.get("width");
                        Integer height1 = (Integer) barCodeStyleMap.get("height");

                        Rotate rotate = Rotate.valueOf(rotateStr);
                        Align align = Align.valueOf(alignStr);
                        HumanReadable readable1 = HumanReadable.valueOf(readable);
                        Symbology symbology1 = Symbology.valueOf(symbology);

                        Log.e("IminPrinter", "labelAddBarCode: 绘制条形码内容 " +barCode+",width=" +
                                width+" ,height1= "+height1+" ,posX= "+posX+" ,posY= "+posY+" ,readable= "+readable+" ,symbology= "+symbology+"  ,HumanReadable=>   "+readable1);

                        PrinterHelper.getInstance().labelAddBarCode(barCode, LabelBarCodeStyle.getBarCodeStyle()
                                .setPosX(posX)
                                .setPosY(posY)
                                .setSymbology(symbology1)
                                .setDotWidth(dotWidth)
                                .setBarHeight(barHeight)
                                .setReadable(readable1)
                                .setAlign(align)
                                .setRotate(rotate)
                                .setWidth(width)
                                .setHeight(height1)
                        );

                    }
                    result.success(true);
                }

                Log.e("IminPrinter", "labelAddBarCode: 绘制条形码内容" );

            }
                break;
            case "labelAddQrCode"://绘制二维码内容
            {
                Log.e("IminPrinter", "labelAddQrCode: 绘制二维码内容" );
                if (iminPrintUtils == null){
                    String qrCode = call.argument("qrCode");
                    Map<String, Object> qrCodeStyleMap = call.argument("qrCodeStyle");
                    if (qrCodeStyleMap != null) {
                        // 直接从 map 获取各个属性
                        Integer posX = (Integer) qrCodeStyleMap.get("posX");
                        Integer posY = (Integer) qrCodeStyleMap.get("posY");
                        Integer size1 = (Integer) qrCodeStyleMap.get("size");
                        String errorLevelStr = (String) qrCodeStyleMap.get("errorLevel");
                        String rotateStr = (String) qrCodeStyleMap.get("rotate");
                        Integer width = (Integer) qrCodeStyleMap.get("width");
                        Integer height1 = (Integer) qrCodeStyleMap.get("height");
                        Log.e("IminPrinter", "labelAddQrCode: 绘制二维码内容 " +qrCode+",width=" +
                                width+" ,height1= "+height1+" ,posX= "+posX+" ,posY= "+posY+" ,errorLevelStr= "+errorLevelStr+" ,size= "+size1);

                        Rotate rotate = Rotate.valueOf(rotateStr);
                        ErrorLevel errorLevel = ErrorLevel.valueOf(errorLevelStr);


                        PrinterHelper.getInstance().labelAddQrCode(qrCode, LabelQrCodeStyle.getQrCodeStyle()
                                .setPosX(posX)
                                .setPosY(posY)
                                .setSize(size1)
                                .setErrorLevel(errorLevel)
                                .setRotate(rotate)
                                .setWidth(width)
                                .setHeight(height1)
                        );

                    }
                    result.success(true);
                }
            }
                break;
            case "labelAddBitmap"://绘制图像
            {
                Log.e("IminPrinter", "labelAddBitmap: 绘制图像" );
                if (iminPrintUtils == null){
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                byte[] bitmapBase64 = call.argument("bitmap");
                                String bitmapUrl = call.argument("bitmapUrl");
                                Map<String, Object> labelAddAreaMap = call.argument("addBitmapStyle");
                                Integer posX = (Integer) labelAddAreaMap.get("posX");
                                Integer posY = (Integer) labelAddAreaMap.get("posY");
                                String algorithm = (String) labelAddAreaMap.get("algorithm");
                                Integer value = (Integer) labelAddAreaMap.get("value");
                                Integer width = (Integer) labelAddAreaMap.get("width");
                                Integer height1 = (Integer) labelAddAreaMap.get("height");
                                ImageAlgorithm imageAlgorithm = ImageAlgorithm.valueOf(algorithm);

                                Log.e("IminPrinter", "labelAddBitmap: 绘制图像 " +bitmapUrl+" ,width=" + width+" ,height1= "+height1+" ,posX= "+posX+" ,posY= "+posY+" ,algorithm= "+algorithm+" ,value= "+value);

                                Bitmap bitmap = null;
                                if (bitmapUrl == null || bitmapUrl.isEmpty()){
                                    bitmap = BitmapFactory.decodeByteArray(bitmapBase64, 0, bitmapBase64.length);
                                }else {
                                    bitmap = Glide.with(_context).asBitmap().load(bitmapUrl).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(width, height1).get();
                                }

                                PrinterHelper.getInstance().labelAddBitmap(bitmap, LabelBitmapStyle.getBitmapStyle()
                                        .setPosX(posX)
                                        .setPosY(posY)
                                        .setAlgorithm(imageAlgorithm)
                                        .setValue(value)
                                        .setWidth(width)
                                        .setHeight(height1)
                                );

                                result.success(true);
                            }catch (Exception e){
                                Log.e("IminPrinter", "labelAddBitmap: 绘制图像 e"+e.getMessage() );
                                result.success(false);
                            }
                        }
                    }).start();

                }

            }
                break;
            case "printLabelBitmap"://打印标签样式的图片
            {
                Log.e("IminPrinter", "printLabelBitmap: 打印标签样式的图片" );
                if (iminPrintUtils == null){
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                byte[] bitmapBase64 = call.argument("bitmap");
                                String bitmapUrl = call.argument("bitmapUrl");
                                Map<String, Object> labelAddAreaMap = call.argument("printBitmapStyle");
                                Integer width = (Integer) labelAddAreaMap.get("width");
                                Integer height1 = (Integer) labelAddAreaMap.get("height");

                                Log.e("IminPrinter", "labelAddArea: 绘制特殊图形 " +",width=" +
                                        width+" ,height1= "+height1+"  ,bitmapUrl= "+bitmapUrl+(bitmapBase64==null));

                                Bitmap bitmap = null;
                                if (bitmapUrl == null || bitmapUrl.isEmpty()){
                                    bitmap = BitmapFactory.decodeByteArray(bitmapBase64, 0, bitmapBase64.length);
                                }else {
                                    bitmap = Glide.with(_context).asBitmap().load(bitmapUrl).diskCacheStrategy(DiskCacheStrategy.NONE).skipMemoryCache(true).submit(width, height1).get();
                                }

                                PrinterHelper.getInstance().labelAddBitmap(bitmap, LabelBitmapStyle.getBitmapStyle()
                                        .setWidth(width)
                                        .setHeight(height1)
                                );

                                result.success(true);
                            }catch (Exception e){
                                Log.e("IminPrinter", "printLabelBitmap: 打印标签样式的图片 e " +e.getMessage());
                                result.success(false);
                            }
                        }
                    }).start();

                }

            }
                break;
            case "labelAddArea"://绘制特殊图形
            {
                if (iminPrintUtils == null){
                    Map<String, Object> labelAddAreaMap = call.argument("areaStyle");

                    if (labelAddAreaMap != null) {
                        // 获取具体的参数
                        String styleString = (String) labelAddAreaMap.get("style");
                        Integer width = (Integer) labelAddAreaMap.get("width");
                        Integer height1 = (Integer) labelAddAreaMap.get("height");
                        Integer posX = (Integer) labelAddAreaMap.get("posX");
                        Integer posY = (Integer) labelAddAreaMap.get("posY");
                        Integer endX = (Integer) labelAddAreaMap.get("endX");
                        Integer endY = (Integer) labelAddAreaMap.get("endY");
                        Integer thick = (Integer) labelAddAreaMap.get("thick");
                        Log.e("IminPrinter", "labelAddArea: 绘制特殊图形 " +styleString+",width=" +
                                width+" ,height1= "+height1+" ,posX= "+posX+" ,posY= "+posY+" ,endX= "+endX+" ,endY= "+endY+" ,thick= "+thick);
                        // 转换字符串到枚举
                        Shape styleShape = Shape.valueOf(styleString);
                        PrinterHelper.getInstance().labelAddArea(LabelAreaStyle.getAreaStyle()
                                .setStyle(styleShape)
                                        .setWidth(width)
                                        .setHeight(height1)
                                .setPosX(posX)
                                .setPosY(posY)
                                .setEndX(endX)
                                .setEndY(endY)
                                .setThick(thick));
                    }
                    result.success(true);
                }
                
            }
                break;
            case "labelPrintCanvas"://打印绘制的内容
            {

                if (iminPrintUtils == null){
                    int printCount = call.argument("printCount");
                    Log.e("IminPrinter", "labelPrintCanvas: 打印绘制的内容 =>" +printCount);
                    PrinterHelper.getInstance().labelPrintCanvas(printCount, new ILabelPrintResult() {
                        @Override
                        public void onResult(int resultCode, String message) throws RemoteException {

                            result.success(true);
                        }

                        @Override
                        public IBinder asBinder() {
                            return null;
                        }
                    });
                }

            }
                break;
            case "labelLearning"://标签学习
            {

                if (iminPrintUtils == null){
                    Log.e("IminPrinter", "labelLearning: 标签学习");
                    PrinterHelper.getInstance().labelPaperLearning(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {

                        }

                        @Override
                        public void onReturnString(String s) throws RemoteException {
                            Log.e("IminPrinter", "labelLearning: 标签学习" +s);
                            result.success(true);
                        }

                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {

                        }

                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {

                        }
                    });
                }

            }
                break;
            case "setPrintModel"://设置打印模式
            {

                if (iminPrintUtils == null){
                    int printModel = call.argument("printModel");
                    Log.e("IminPrinter", "setPrintModel: 设置打印模式" +printModel);
                    PrinterHelper.getInstance().setPrinterMode(printModel);
                    result.success(true);
                }
            }
                break;
            case "getPrinterMode"://获取当前打印机模式
            {

                if (iminPrintUtils == null){
                    Log.e("IminPrinter", "getPrintModel: 获取当前打印机模式" );
                    PrinterHelper.getInstance().labelGetPrinterMode(new INeoPrinterCallback() {
                        @Override
                        public void onRunResult(boolean isSuccess) throws RemoteException {

                        }
                        @Override
                        public void onReturnString(String string) throws RemoteException {
                            Log.e("IminPrinter", "getPrintModel: 获取当前打印机模式"+ string);
                            if (string != null && !string.isEmpty()){
                                if (string.equalsIgnoreCase("Label")){
                                    result.success(1);
                                }else {
                                    result.success(0);
                                }
                            }
                        }
                        @Override
                        public void onRaiseException(int code, String msg) throws RemoteException {
                        }
                        @Override
                        public void onPrintResult(int code, String msg) throws RemoteException {
                        }
                        @Override
                        public IBinder asBinder() {
                            return null;
                        }
                    });
                }
            }

                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private BroadcastReceiver createChargingStateChangeReceiver(EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = intent.getIntExtra(ACTION_PRITER_STATUS, -1);
                Log.d("TAG", "打印机状态：" + intent.getAction());
                if (intent.getAction().equals(ACTION_PRITER_STATUS_CHANGE)) {
                    Map<String, Object> result = new HashMap<String, Object>();
                    result.put("status", status);
                    result.put("action", "printer_status");
                    events.success(result);
                } else {
                    events.success(true);
                }
            }
        };
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onListen(Object argument, EventChannel.EventSink events) {
        eventSink = events;
        chargingStateChangeReceiver = createChargingStateChangeReceiver(eventSink);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(ACTION_PRITER_STATUS_CHANGE);
        intentFilter.addAction(ACTION_POGOPIN_STATUS_CHANGE);
        _context.registerReceiver(chargingStateChangeReceiver, intentFilter);
    }

    @Override
    public void onCancel(Object argument) {
        _context.unregisterReceiver(chargingStateChangeReceiver);
        eventSink = null;
        chargingStateChangeReceiver = null;
    }

}
