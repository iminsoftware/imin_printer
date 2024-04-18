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
  String version = '1.0.0';
  @override
  void initState() {
    super.initState();
     getSdkVersion();
  }
  Future<void> getSdkVersion() async {
     final sdkVersion = await iminPrinter.getSdkVersion();
     if (!mounted) return;
      setState( () {
          version = sdkVersion!;
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: version == '2.0.0' ? const NewHome() : const Home() ,
    );
  }
}
