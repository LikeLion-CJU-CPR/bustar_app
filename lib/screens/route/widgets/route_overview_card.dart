// RouteOverviewCard.dart
import 'package:flutter/material.dart';
import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/extensions/string_extensions.dart';

class RouteOverviewCard extends StatelessWidget {
  const RouteOverviewCard({super.key});

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
              _buildStep(
                '사직사거리.시립미술관(교육도서관) 정류장',
                '7분 뒤 도착',
                Colors.grey.shade600,
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              _buildStep('솔밭공원', '현재 위치', Colors.black, isCurrent: true),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              _buildStep('현대백화점', '3분 뒤 도착', Colors.grey.shade600),
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
                fontSize: isCurrent ? 16 : 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: isCurrent ? Colors.white70 : color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
