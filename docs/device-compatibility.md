# Device Compatibility

This document provides detailed information about iMin device compatibility and feature support.

## Supported Devices

### Handheld Finance Series
| Device Model | Paper Width | Cutter | Tested | Notes |
|--------------|-------------|---------|---------|-------|
| M2-202 | 58mm | ❌ | ✅ | Compact handheld device |
| M2-203 | 58mm | ❌ | ✅ | Enhanced handheld device |
| M2 Pro | 58mm | ❌ | ✅ | Professional handheld device |
| Swift 1 | 58mm | ❌ | ⚠️ | Basic model |
| Swift 2 | 58mm | ❌ | ⚠️ | Improved performance |
| Swift 2 Pro | 58mm | ❌ | ⚠️ | Professional features |
| Swift 2 Ultra | 58mm | ❌ | ⚠️ | Ultra-fast processing |

### Flat Panel Terminal Series
| Device Model | Paper Width | Cutter | Tested | Notes |
|--------------|-------------|---------|---------|-------|
| M2 Max | 58mm | ❌ | ⚠️ | Large screen terminal |
| D1 | 58mm | ❌ | ⚠️ | Basic terminal |
| D1 Pro | 58mm | ❌ | ⚠️ | Enhanced terminal |
| Falcon 1 | 80mm | ✅ | ⚠️ | 80mm with cutter support |
| Swan 2 | 58mm/80mm | ✅ | ⚠️ | Dual paper width support |
| Falcon 2 | 80mm | ✅ | ⚠️ | Advanced 80mm terminal |

### Desk Cash Register Equipment
| Device Model | Paper Width | Cutter | Tested | Notes |
|--------------|-------------|---------|---------|-------|
| D4 | 80mm | ✅ | ⚠️ | Desktop cash register |
| Swan 2 | 80mm | ✅ | ⚠️ | Multi-purpose device |
| Falcon 2 | 80mm | ✅ | ⚠️ | Professional cash register |

**Legend:**
- ✅ Fully tested and confirmed working
- ⚠️ Compatible but not extensively tested
- ❌ Not supported
- 🔄 Testing in progress

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

### SDK 1.0 vs 2.0
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
| Device Series | SDK 1.0 | SDK 2.0 | Recommended |
|---------------|---------|---------|-------------|
| M2 Series | ✅ | ✅ | SDK 2.0 |
| Swift Series | ✅ | ✅ | SDK 2.0 |
| D Series | ✅ | ✅ | SDK 2.0 |
| Falcon Series | ✅ | ✅ | SDK 2.0 |

## Testing Status

### Extensively Tested Devices
- **M2-202**: Full feature testing completed
- **M2-203**: Full feature testing completed  
- **M2 Pro**: Full feature testing completed

### Partially Tested Devices
- **Swift Series**: Basic functionality tested
- **D Series**: Core features verified
- **Falcon Series**: Standard operations confirmed

### Pending Testing
- Advanced label printing on all devices
- Color chart printing capabilities
- Performance benchmarks across device types

## Known Issues and Limitations

### General Limitations
1. **Paper Width**: Cannot change paper width dynamically - requires device restart
2. **Cutter Function**: Only available on 80mm devices with physical cutter
3. **Image Size**: Large images may cause memory issues on older devices
4. **Concurrent Access**: Only one app can access printer at a time

### Device-Specific Issues

#### M2 Series
- No known critical issues
- Excellent stability and performance

#### Swift Series
- Occasional timeout on large print jobs
- Recommend using buffer mode for complex prints

#### D Series
- Image printing may be slower than other series
- Consider reducing image resolution for better performance

#### Falcon Series
- Cutter function requires proper paper alignment
- Full cut may not work with all paper types

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

#### M2 Series
- Reset device if unresponsive: `await printer.resetDevice()`
- Check battery level on handheld models

#### Swift Series
- Increase timeout for large jobs
- Use smaller batch sizes for image printing

#### D/Falcon Series
- Ensure proper paper alignment for cutter function
- Check cash drawer connection if using

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