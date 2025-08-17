import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_card.dart';

class AchievementsCard extends StatelessWidget {
  const AchievementsCard({super.key, required this.achievements});

  final List<Map<String, String>> achievements;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(icon: CupertinoIcons.star_fill, title: '최근 성취도'),
          CardContent(
            child: Column(
              children: achievements.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Text(item['icon']!, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              item['date']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        CupertinoIcons.star_fill,
                        size: 16,
                        color: Colors.yellow.shade700,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16), // Add bottom padding to balance the card
        ],
      ),
    );
  }
}
