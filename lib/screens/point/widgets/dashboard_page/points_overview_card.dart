import 'package:bustar_app/screens/point/providers/point_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/action_button.dart';
import '../../my_coupons_screen.dart';
import '../../usage_screen.dart';

class PointsOverviewCard extends StatelessWidget {
  const PointsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pointProvider = context.watch<PointProvider>();
    final currentPoints = pointProvider.currentPoints;
    const nextLevelPoints = 3000;
    final progress = (currentPoints / nextLevelPoints);

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightGreen.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.lightGreen.shade200),
      ),
      child: Column(
        children: [
          Text(
            currentPoints.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            ),
            style: const TextStyle(
              fontSize: 36,
              color: Color(0xFF6CB77E),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '보유 별사탕',
            style: TextStyle(fontSize: 14, color: Color(0xFF6CB77E)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('다음 레벨까지', style: TextStyle(fontSize: 14)),
              Text(
                '${nextLevelPoints - currentPoints}P',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.lightGreen.shade200.withValues(
                  alpha: .5,
                ),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6CB77E),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '실버 회원',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              Text(
                '골드 회원',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ActionButton(
                icon: CupertinoIcons.gift_fill,
                label: '혜택 사용하기',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UsageScreen(),
                    ),
                  );
                },
                backgroundColor: const Color(0xFF6CB77E),
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 12),
              ActionButton(
                icon: CupertinoIcons.ticket_fill,
                label: '내 쿠폰함',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyCouponsScreen(),
                    ),
                  );
                },
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6CB77E),
                side: const BorderSide(color: Color(0xFF6CB77E)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
