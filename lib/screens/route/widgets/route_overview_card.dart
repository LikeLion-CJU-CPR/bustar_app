// RouteOverviewCard.dart
import 'package:flutter/material.dart';
import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/extensions/string_extensions.dart';

class RouteOverviewCard extends StatelessWidget {
  final String start;
  final String startETA;
  final String current;
  final String currentETA;
  final String end;
  final String endETA;

  const RouteOverviewCard({
    super.key,
    required this.start,
    required this.startETA,
    required this.current,
    required this.currentETA,
    required this.end,
    required this.endETA,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStep(start, startETA, Colors.grey.shade600),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              _buildStep(current, currentETA, Colors.black, isCurrent: true),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              _buildStep(end, endETA, Colors.grey.shade600),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    String title,
    String subtitle,
    Color color, {
    bool isCurrent = false,
  }) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFF6CB77E) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(
              title.insertZwj(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isCurrent ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: isCurrent ? 14 : 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: isCurrent ? Colors.white70 : color,
                fontSize: isCurrent ? 12 : 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
