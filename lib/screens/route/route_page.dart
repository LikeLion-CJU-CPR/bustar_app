import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RoutePage extends StatefulWidget {
  final int index;

  const RoutePage({super.key, required this.index});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
      ),
    );
  }
}
