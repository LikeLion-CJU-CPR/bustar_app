import 'package:flutter/material.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('내 정보 화면입니다.', style: TextStyle(fontSize: 24))],
          ),
        ),
      ),
    );
  }
}
