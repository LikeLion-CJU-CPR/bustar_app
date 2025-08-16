import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_card.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key, required this.stats});

  final List<Map<String, String>> stats;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: const CardHeader(
        icon: CupertinoIcons.rosette,
        title: '나의 통계',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.map((stat) {
            return Column(
              children: [
                Text(stat['icon']!, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text(
                  stat['value']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stat['label']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
