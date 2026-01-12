# Error Codes and Troubleshooting

This document provides comprehensive information about error codes, status messages, and troubleshooting steps for the iMin Printer SDK.

## Printer Status Codes

When calling `getPrinterStatus()`, you'll receive a response with a `code` and `msg` field. Here are the possible status codes:

### Status Code Reference

| Code | Status | Description | Severity | Action Required |
|------|--------|-------------|----------|-----------------|
| `-1` | `initPrinterError` | Failed to initialize the printer | ❌ Critical | Check connection, restart app |
| `0` | `normal` | The printer is working normally | ✅ OK | None |
| `1` | `notPoweredOn` | Printer not connected or powered on | ❌ Critical | Check power and connection |
| `2` | `notLibraryMatch` | Printer and library version mismatch | ⚠️ Warning | Update SDK or firmware |
| `3` | `openPrintHead` | Print head is open | ❌ Critical | Close printer cover |
| `4` | `cutterNotReset` | Cutter is not reset | ⚠️ Warning | Reset cutter mechanism |
| `5` | `overHeated` | Printer is overheated | ❌ Critical | Wait for cooling |
| `6` | `blackLabelError` | Black label detection error | ⚠️ Warning | Check label type |
| `7` | `notPaperFeed` | No paper feed detected | ❌ Critical | Check paper installation |
| `8` | `outOfPaper` | Paper is running out | ⚠️ Warning | Replace paper roll |
| `99` | `otherError` | Other unspecified errors | ❌ Critical | Check logs, restart |

### Status Check Example

```dart
Future<void> checkPrinterStatus() async {
  try {
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    String code = status['code'] ?? '-1';
    String message = status['msg'] ?? 'Unknown status';
    
    switch (code) {
      case '0':
        print('✅ Printer ready: $message');
        break;
      case '1':
        print('❌ Connection issue: $message');
        // Handle connection problem
        break;
      case '3':
        print('❌ Cover open: $message');
        // Prompt user to close cover
        break;
      case '5':
        print('❌ Overheated: $message');
        // Wait and retry
        await Future.delayed(Duration(seconds: 30));
        break;
      case '8':
        print('⚠️ Low paper: $message');
        // Warn user about paper
        break;
      default:
        print('❌ Error $code: $message');
        // Handle other errors
    }
  } catch (e) {
    print('Failed to check status: $e');
  }
}
```

## Common Error Scenarios

### 1. Initialization Errors

#### Error: "Failed to initialize the printer"
**Possible Causes:**
- Printer not connected via USB
- Printer not powered on
- USB permissions not granted
- Another app is using the printer

**Solutions:**
```dart
Future<bool> initializeWithRetry() async {
  for (int i = 0; i < 3; i++) {
    try {
      bool? result = await iminPrinter.initPrinter();
      if (result == true) {
        return true;
      }
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      print('Init attempt ${i + 1} failed: $e');
    }
  }
  return false;
}
```

### 2. Connection Issues

#### Error: "Printer not connected or powered on"
**Troubleshooting Steps:**
1. Check USB cable connection
2. Verify printer power status
3. Try different USB port
4. Restart the printer
5. Restart the application

```dart
Future<void> handleConnectionError() async {
  print('Connection lost. Attempting to reconnect...');
  
  // Wait a moment
  await Future.delayed(Duration(seconds: 2));
  
  // Try to reinitialize
  bool success = await initializeWithRetry();
  if (success) {
    print('Reconnected successfully');
  } else {
    print('Failed to reconnect. Please check hardware.');
  }
}
```

### 3. Paper Issues

#### Error: "Paper Running Out" or "No Paper Feed"
**Solutions:**
```dart
Future<void> handlePaperIssue(String statusCode) async {
  if (statusCode == '8') {
    // Paper running out
    print('⚠️ Paper is running low. Please replace soon.');
    // You might want to show a warning but continue printing
  } else if (statusCode == '7') {
    // No paper feed
    print('❌ No paper detected. Please install paper roll.');
    throw Exception('Cannot print: No paper installed');
  }
}
```

### 4. Hardware Issues

#### Error: "Print head open"
```dart
Future<void> handlePrintHeadOpen() async {
  print('❌ Print head is open. Please close the printer cover.');
  
  // Wait for user to close cover
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] == '0') {
      print('✅ Print head closed. Ready to print.');
      break;
    }
  }
}
```

#### Error: "Overheated"
```dart
Future<void> handleOverheating() async {
  print('❌ Printer is overheated. Waiting for cooling...');
  
  int waitTime = 30; // seconds
  for (int i = waitTime; i > 0; i--) {
    print('Cooling down... ${i}s remaining');
    await Future.delayed(Duration(seconds: 1));
  }
  
  // Check if cooled down
  Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
  if (status['code'] == '0') {
    print('✅ Printer cooled down. Ready to print.');
  } else {
    print('⚠️ Still overheated. Please wait longer.');
  }
}
```

## Platform-Specific Errors

### Android Errors

#### PlatformException: "SERVICE_NOT_AVAILABLE"
**Cause:** iMin printer service is not running
**Solution:**
```dart
try {
  await iminPrinter.initPrinter();
} on PlatformException catch (e) {
  if (e.code == 'SERVICE_NOT_AVAILABLE') {
    print('Printer service not available. Please restart the device.');
  }
}
```

#### PlatformException: "PERMISSION_DENIED"
**Cause:** USB permissions not granted
**Solution:**
1. Check Android manifest permissions
2. Grant USB device permissions when prompted
3. Try reconnecting the USB cable

### Method Channel Errors

#### Error: "Method not implemented"
**Cause:** Using unsupported method on current SDK version
**Solution:**
```dart
try {
  await iminPrinter.someNewMethod();
} on MissingPluginException catch (e) {
  print('Method not available in current SDK version');
  // Use alternative approach
} on PlatformException catch (e) {
  if (e.code == 'UNIMPLEMENTED') {
    print('Feature not implemented on this device');
  }
}
```

## Error Handling Best Practices

### 1. Comprehensive Error Handler

```dart
class PrinterErrorHandler {
  static Future<bool> handlePrintOperation(
    Future<void> Function() operation,
  ) async {
    try {
      // Check status before operation
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      await _handleStatus(status);
      
      // Execute operation
      await operation();
      return true;
      
    } on PlatformException catch (e) {
      await _handlePlatformException(e);
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }
  
  static Future<void> _handleStatus(Map<String, dynamic> status) async {
    String code = status['code'] ?? '-1';
    String message = status['msg'] ?? 'Unknown';
    
    switch (code) {
      case '0':
        return; // OK to proceed
      case '1':
        throw PrinterException('Printer not connected: $message');
      case '3':
        throw PrinterException('Print head open: $message');
      case '5':
        throw PrinterException('Printer overheated: $message');
      case '8':
        print('Warning: Paper running low');
        return; // Can still print
      default:
        throw PrinterException('Printer error $code: $message');
    }
  }
  
  static Future<void> _handlePlatformException(PlatformException e) async {
    switch (e.code) {
      case 'SERVICE_NOT_AVAILABLE':
        print('Printer service unavailable');
        break;
      case 'PERMISSION_DENIED':
        print('USB permission denied');
        break;
      case 'TIMEOUT':
        print('Operation timed out');
        break;
      default:
        print('Platform error: ${e.message}');
    }
  }
}

class PrinterException implements Exception {
  final String message;
  PrinterException(this.message);
  
  @override
  String toString() => 'PrinterException: $message';
}
```

### 2. Usage Example

```dart
Future<void> printWithErrorHandling() async {
  bool success = await PrinterErrorHandler.handlePrintOperation(() async {
    await iminPrinter.printText('Test Print');
    await iminPrinter.printAndLineFeed();
  });
  
  if (success) {
    print('Print completed successfully');
  } else {
    print('Print failed - check error messages above');
  }
}
```

### 3. Retry Logic

```dart
Future<bool> printWithRetry(
  Future<void> Function() printOperation, {
  int maxRetries = 3,
  Duration delay = const Duration(seconds: 2),
}) async {
  for (int attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
      
      if (status['code'] == '0') {
        await printOperation();
        return true;
      } else if (status['code'] == '5') {
        // Overheated - wait longer
        print('Printer overheated, waiting...');
        await Future.delayed(Duration(seconds: 30));
        continue;
      } else {
        print('Printer not ready: ${status['msg']}');
        if (attempt < maxRetries) {
          await Future.delayed(delay);
          continue;
        }
      }
    } catch (e) {
      print('Print attempt $attempt failed: $e');
      if (attempt < maxRetries) {
        await Future.delayed(delay);
        continue;
      }
    }
  }
  
  return false;
}
```

## Debugging Tips

### 1. Enable Logging

```dart
// Enable detailed logging
await iminPrinter.openLogs(1);

// Your print operations here

// Disable logging when done
await iminPrinter.openLogs(0);
```

### 2. Status Monitoring

```dart
class PrinterStatusMonitor {
  Timer? _statusTimer;
  
  void startMonitoring() {
    _statusTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
        print('Status: ${status['code']} - ${status['msg']}');
      } catch (e) {
        print('Status check failed: $e');
      }
    });
  }
  
  void stopMonitoring() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }
}
```

### 3. Device Information

```dart
Future<void> printDeviceInfo() async {
  try {
    String? model = await iminPrinter.getPrinterModelName();
    String? serial = await iminPrinter.getPrinterSerialNumber();
    String? firmware = await iminPrinter.getPrinterFirmwareVersion();
    String? hardware = await iminPrinter.getPrinterHardwareVersion();
    
    print('Device Info:');
    print('  Model: $model');
    print('  Serial: $serial');
    print('  Firmware: $firmware');
    print('  Hardware: $hardware');
  } catch (e) {
    print('Failed to get device info: $e');
  }
}
```

## Recovery Procedures

### 1. Soft Reset

```dart
Future<void> softReset() async {
  try {
    print('Performing soft reset...');
    await iminPrinter.resetDevice();
    await Future.delayed(Duration(seconds: 2));
    await iminPrinter.initPrinter();
    print('Soft reset completed');
  } catch (e) {
    print('Soft reset failed: $e');
  }
}
```

### 2. Service Restart

```dart
Future<void> restartService() async {
  try {
    print('Restarting printer service...');
    await iminPrinter.unBindService();
    await Future.delayed(Duration(seconds: 3));
    await iminPrinter.initPrinter();
    print('Service restarted');
  } catch (e) {
    print('Service restart failed: $e');
  }
}
```

### 3. Complete Recovery

```dart
Future<bool> performCompleteRecovery() async {
  print('Starting complete recovery procedure...');
  
  try {
    // Step 1: Unbind service
    await iminPrinter.unBindService();
    await Future.delayed(Duration(seconds: 2));
    
    // Step 2: Reset device
    await iminPrinter.resetDevice();
    await Future.delayed(Duration(seconds: 3));
    
    // Step 3: Reinitialize
    bool? result = await iminPrinter.initPrinter();
    if (result != true) {
      throw Exception('Failed to reinitialize after recovery');
    }
    
    // Step 4: Verify status
    Map<String, dynamic> status = await iminPrinter.getPrinterStatus();
    if (status['code'] != '0') {
      throw Exception('Printer not ready after recovery: ${status['msg']}');
    }
    
    print('✅ Complete recovery successful');
    return true;
    
  } catch (e) {
    print('❌ Complete recovery failed: $e');
    return false;
  }
}
```

## Getting Help

If you continue to experience issues after following this guide:

1. **Check device compatibility** in [Device Compatibility](device-compatibility.md)
2. **Review examples** in [Practical Examples](examples.md)
3. **Enable logging** and collect detailed error information
4. **Test with simple operations** first
5. **Report issues** on [GitHub](https://github.com/iminsoftware/imin_printer/issues)

When reporting issues, please include:
- Device model and firmware version
- Plugin version
- Complete error messages
- Steps to reproduce
- Sample code that demonstrates the issue

---

*Error codes documentation last updated: January 2026*