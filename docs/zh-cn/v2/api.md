# iMin内部打印机flutter提供的相关方法

## 初始化iMin内部打印机
 - initPrinter()
    - 无参数
    
```dart
  iminPrinter.initPrinter();
```

## 获取打印机状态
 - getPrinterStatus()
    - 无参数

```dart
  iminPrinter.getPrinterStatus().then((value){
    // 打印机状态
    print(state['msg']);    
  });   
```