# Quick start

## Create a flutter project
In 'windows system (cmd)' or 'Macos system (Terminal)' command line tool following command
```bash
  flutter create my_app
```

## Install the iMin printing plug-in
  Install the internal print plugin using iMin in your generated flutter project.
  Run the following command in your flutter project:
```bash
flutter pub add imin_printer
```
Or add in 'pubspec.yaml'
```yaml
dependencies:
  imin_printer: ^0.5.7
```

## Use the print plug-in in your project

Use the print plugin in the 'lib/main.dart' file in the flutter project
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

class _MyAppState  extends State<MyApp> {
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
            child: const Text('Print text'),
          )
        )
      )
     )
  }
}

```