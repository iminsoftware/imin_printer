# 快速开始

## 创建一个flutter项目
在`windows系统(cmd)`或者`Macos系统(终端)`命令行工具以下命令
```bash
  flutter create my_app
```

## 安装iMin打印插件
  在您的生成的flutter项目中安装使用iMin内部打印插件。
  在您的flutter项目中运行以下命令：
```bash
flutter pub add imin_printer
```
或在`pubspec.yaml`中添加
```yaml
dependencies:
  imin_printer: ^0.5.7
```

## 项目中使用打印插件

在flutter项目中的`lib/main.dart`文件中使用打印插件
```dart
import 'package:imin_printer/imin_printer.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final iminPrinter = IminPrinter();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              iminPrinter.printText("Hello World");
            },
            child: const Text('打印文本'),
          )
        )
      )
     )
  }
}

```