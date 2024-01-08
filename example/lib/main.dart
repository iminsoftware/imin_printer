// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:imin_printer_example/pages/v2/vertical/home.dart';
// import 'package:imin_printer_example/pages/v1/home.dart';
// import 'package:flutter/services.dart';

// import 'package:imin_printer/enums.dart';
// import 'package:imin_printer/imin_style.dart';
// import 'package:imin_printer/column_maker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
  //   /// Android状态栏透明
  // if (Platform.isAndroid) {
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryColor: Colors.green,
          //  primarySwatch: Colors.yellow,
          ),
      home: const VerticalHome(),
    );
  }
}
