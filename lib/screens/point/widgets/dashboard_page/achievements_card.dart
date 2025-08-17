import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_card.dart';
import '../../models/achievement_model.dart';

class AchievementsCard extends StatelessWidget {
  final List<Achievement> achievements;
  const AchievementsCard({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardHeader(icon: CupertinoIcons.rosette, title: '성취도'),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: CardContent(
              child: Column(
                children: achievements.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(item.icon, style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  if (item.isCompleted)
                                    Icon(
                                      CupertinoIcons.star_fill,
                                      size: 14,
                                      color: Colors.yellow.shade700,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: item.isCompleted
                                ? Colors.blue.shade600
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            item.isCompleted ? "완료" : "진행중",
                            style: TextStyle(
                              color: item.isCompleted
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
