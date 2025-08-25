// RecommendationCard.dart
import 'package:flutter/material.dart';
import 'package:bustar_app/widgets/custom_card.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final String distance;
  final String hours;
  final bool isTag;
  final String chip1;
  final String chip2;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.distance,
    required this.hours,
    required this.isTag,
    required this.chip1,
    required this.chip2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          distance,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          hours,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      label: Text(
                        chip1,
                        style: TextStyle(
                          color: isTag ? const Color(0xFF6CB77E) : Colors.white,
                        ),
                      ),
                      side: const BorderSide(
                        color: Color(0xFF6CB77E),
                        width: 1,
                      ),
                      backgroundColor: isTag
                          ? Colors.white
                          : const Color(0xFF6CB77E),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(
                        chip2,
                        style: const TextStyle(color: Colors.white),
                      ),
                      side: const BorderSide(
                        color: Color(0xFF6CB77E),
                        width: 1,
                      ),
                      backgroundColor: const Color(0xFF6CB77E),
                    ),
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
