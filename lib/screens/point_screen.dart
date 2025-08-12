import 'package:flutter/material.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('포인트 화면입니다.', style: TextStyle(fontSize: 24))],
          ),
        ),
      ),
    );
  }
}
