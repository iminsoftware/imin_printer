import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "设置",
            style: TextStyle(
              color: Color(0xFF1D1D1F),
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
          foregroundColor: const Color(0xFF1D1D1F),
          backgroundColor: Colors.white,
          centerTitle: true),
      body: const Center(
        child: Text("This is new route"),
      ),
    );
  }
}
