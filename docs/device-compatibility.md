# Device Compatibility

This document provides detailed information about iMin device compatibility and feature support.

## Supported Devices

This SDK supports all iMin devices with built-in thermal printers. The devices are categorized into the following series:

### Device Categories

**Handheld Finance Series**
- Compact handheld devices with 58mm paper width
- Portable design for mobile payment and receipt printing
- No cutter function

**Flat Panel Terminal Series**
- Tablet-style terminals with various screen sizes
- Support both 58mm and 80mm paper widths
- Some models include cutter functionality

**Desk Cash Register Equipment**
- Desktop POS terminals for retail and hospitality
- Primarily 80mm paper width with cutter support
- Enhanced performance for high-volume printing

### Paper Width Support
- **58mm devices**: Compact receipts, suitable for mobile scenarios
- **80mm devices**: Standard receipts, ideal for retail and restaurant use

### Cutter Support
- Devices with cutter function support both partial cut and full cut operations
- Cutter availability depends on specific device model
- Use `partialCut()` and `fullCut()` methods only on devices with cutter support

## Feature Compatibility Matrix

### Basic Printing Features
| Feature | All Devices | Notes |
|---------|-------------|-------|
| Text Printing | ✅ | Supported on all devices |
| Text Formatting | ✅ | Font size, style, alignment |
| Line Feed | ✅ | Standard line feed operations |
| Paper Feed | ✅ | Custom paper feed distances |

### Advanced Text Features
| Feature | Compatibility | Notes |
|---------|---------------|-------|
| Anti-White Text | ✅ | Reverse text printing |
| Text Bitmap | ✅ | Text as bitmap rendering |
| Column Text | ✅ | Table-like text formatting |
| Custom Fonts | ✅ | Multiple typeface support |

### Image Printing
| Feature | Compatibility | Notes |
|---------|---------------|-------|
| Single Bitmap | ✅ | URL and byte array support |
| Multiple Bitmaps | ✅ | Batch image printing |
| Black & White Images | ✅ | Monochrome image processing |
| Color Chart Images | ⚠️ | Limited device support |
| Image Translation | ✅ | Image positioning support |

### Barcode Support
| Barcode Type | Compatibility | Notes |
|--------------|---------------|-------|
| UPC-A | ✅ | Standard retail barcode |
| UPC-E | ✅ | Compact UPC format |
| EAN-13 | ✅ | European article number |
| EAN-8 | ✅ | Short EAN format |
| Code 39 | ✅ | Alphanumeric barcode |
| Code 93 | ✅ | Enhanced Code 39 |
| Code 128 | ✅ | High-density barcode |
| ITF | ✅ | Interleaved 2 of 5 |
| Codabar | ✅ | Variable-length barcode |

### QR Code Features
| Feature | Compatibility | Notes |
|---------|---------------|-------|
| Single QR Code | ✅ | Standard QR code printing |
| Double QR Code | ✅ | Side-by-side QR codes |
| Error Correction | ✅ | L, M, Q, H levels supported |
| Custom Size | ✅ | Adjustable QR code size |
| Positioning | ✅ | Left margin control |

### Label Printing
| Feature | Compatibility | Notes |
|---------|---------------|-------|
| Label Canvas | ✅ | Custom canvas creation |
| Label Text | ✅ | Positioned text on labels |
| Label Barcodes | ✅ | Barcodes on labels |
| Label QR Codes | ✅ | QR codes on labels |
| Label Images | ✅ | Images on labels |
| Label Shapes | ✅ | Geometric shapes |

### Paper Control
| Feature | 58mm Devices | 80mm Devices | Notes |
|---------|--------------|--------------|-------|
| Partial Cut | ❌ | ✅ | Only devices with cutter |
| Full Cut | ❌ | ✅ | Only devices with cutter |
| Paper Format | ✅ | ✅ | 58mm/80mm selection |

### Hardware Features
| Feature | Compatibility | Notes |
|---------|---------------|-------|
| Cash Drawer | ✅ | Electronic cash drawer control |
| Status Detection | ✅ | Paper, temperature, errors |
| Serial Communication | ✅ | Device information retrieval |
| Buffer Management | ✅ | Print job buffering |

## SDK Version Compatibility

### SDK Version Requirements

| SDK Version | Android Version | Recommended | Features |
|-------------|----------------|-------------|----------|
| SDK 2.0 | Android 13+ | ✅ Yes | Full feature set: label printing, text bitmap, buffer management, advanced configuration |
| SDK 1.0 | Android 11 and below | ❌ Legacy | Basic printing, image printing, barcode/QR code support |

> **Important**: Choose the SDK version based on your target Android version:
> - For devices running **Android 13 or higher**, use **SDK 2.0**
> - For devices running **Android 11 or lower**, use **SDK 1.0**

### SDK 1.0 vs 2.0 Feature Comparison

| Feature | SDK 1.0 | SDK 2.0 | Migration Required |
|---------|---------|---------|-------------------|
| Basic Printing | ✅ | ✅ | No |
| Image Printing | ✅ | ✅ | No |
| Barcode/QR | ✅ | ✅ | No |
| Label Printing | ❌ | ✅ | Yes |
| Text Bitmap | ❌ | ✅ | Yes |
| Buffer Management | ❌ | ✅ | Yes |
| Advanced Config | ❌ | ✅ | Yes |

### Device SDK Support
All iMin device series support both SDK 1.0 and SDK 2.0. The SDK version you should use depends on the Android OS version running on the device, not the device model itself.

## Testing Status

The SDK has been extensively tested across multiple iMin device series to ensure compatibility and reliability. All core features including text printing, image printing, barcode/QR code generation, and label printing have been verified on representative devices from each series.

## Known Issues and Limitations

### General Limitations
1. **Paper Width**: Cannot change paper width dynamically - requires device restart
2. **Cutter Function**: Only available on devices with physical cutter hardware
3. **Image Size**: Large images may cause memory issues - optimize image size before printing
4. **Concurrent Access**: Only one app can access printer at a time
5. **Cutter Alignment**: Cutter function requires proper paper alignment for best results

## Performance Recommendations

### For 58mm Devices
```dart
// Recommended settings for 58mm devices
await printer.setPageFormat(1); // 58mm format
await printer.setTextWidth(384); // Optimal width for 58mm
```

### For 80mm Devices
```dart
// Recommended settings for 80mm devices
await printer.setPageFormat(0); // 80mm format
await printer.setTextWidth(576); // Optimal width for 80mm
```

### Optimal Image Sizes
- **58mm devices**: Max width 384 pixels
- **80mm devices**: Max width 576 pixels
- **Height**: No strict limit, but consider memory usage

### Performance Tips
1. Use buffer mode for multiple operations
2. Optimize image sizes before printing
3. Test print jobs on target devices
4. Handle errors gracefully with status checks

## Troubleshooting by Device

### Common Issues

#### "Printer not connected"
1. Check USB/power connection
2. Verify device is powered on
3. Restart the application
4. Try `initPrinter()` again

#### "Paper running out"
1. Check paper roll installation
2. Ensure paper is properly fed
3. Clean paper sensors if necessary

#### "Print head open"
1. Close printer cover properly
2. Check for paper jams
3. Ensure print head is seated correctly

#### "Overheated"
1. Allow printer to cool down
2. Reduce print density if possible
3. Check ventilation around device

### Device-Specific Troubleshooting

#### Handheld Devices
- Reset device if unresponsive: `await printer.resetDevice()`
- Check battery level on battery-powered models
- Ensure stable USB connection

#### Desktop Devices
- Ensure proper paper alignment for cutter function
- Check cash drawer connection if using
- Verify power supply is stable

#### All Devices
- Increase timeout for large print jobs
- Use smaller batch sizes for image printing
- Use buffer mode for complex multi-operation prints

## Getting Support

### Before Contacting Support
1. Check device compatibility in this document
2. Verify SDK version compatibility
3. Test with simple print operations first
4. Check printer status with `getPrinterStatus()`

### Information to Provide
- Device model and firmware version
- SDK version being used
- Error messages or status codes
- Sample code that reproduces the issue
- Expected vs actual behavior

### Support Channels
- GitHub Issues: [imin_printer repository](https://github.com/iminsoftware/imin_printer)
- Official Documentation: [iMin Printer SDK Docs](https://oss-sg.imin.sg/docs/en/PrinterSDK.html)

## Future Device Support

iMin regularly releases new devices. This plugin is designed to be forward-compatible with new iMin devices that follow the standard printer SDK interface.

For the latest device compatibility information, check:
- Plugin changelog
- Official iMin documentation
- GitHub repository updates

---

*Last updated: January 2026*
*Plugin version: 0.6.14*