// RecommendationCard.dart
import 'package:flutter/material.dart';
import 'package:bustar_app/widgets/custom_card.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String distance;
  final String hours;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.distance,
    required this.hours,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(distance, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    const SizedBox(width: 8),
                    Text(hours, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
