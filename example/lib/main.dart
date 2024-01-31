// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer_example/pages/v2/home.dart';
import 'package:imin_printer_example/pages/v1/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final iminPrinter = IminPrinter();
  bool? version = false;
  @override
  void initState() {
    super.initState();
      iminPrinter.receiveBroadcastStream.listen((event) {
      debugPrint('broadcastStream: ${event['action'] }');
      if(event['action'] == 'printer_sdk_version') {
            setState(() {
              version = event['status'];
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: version == true ? const NewHome() : const Home() ,
    );
  }
}
