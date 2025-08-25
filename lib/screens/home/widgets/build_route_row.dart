import 'package:flutter/material.dart';

class BuildRouteRow extends StatelessWidget {
  final String text;
  final Color color;

  const BuildRouteRow({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    String type;
    if (color == Colors.blue) {
      type = "간선";
    } else if (color == Colors.red) {
      type = "급행";
    } else {
      type = "순환";
    }
    double defaultSize = 10;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: color, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              type,
              style: TextStyle(
                color: color,
                fontSize: defaultSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
