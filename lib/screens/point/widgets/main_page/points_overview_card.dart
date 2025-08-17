import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bustar_app/widgets/action_button.dart';

class PointsOverviewCard extends StatelessWidget {
  const PointsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    const currentPoints = 2450;
    const nextLevelPoints = 3000;
    final progress = (currentPoints / nextLevelPoints); // Flutter는 0.0 ~ 1.0 사용

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.indigo.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          // 보유 포인트 섹션
          Text(
            currentPoints.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            ),
            style: TextStyle(
              fontSize: 36,
              color: Colors.blue.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '보유 포인트',
            style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 24),

          // 프로그레스 바 섹션
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('다음 레벨까지', style: TextStyle(fontSize: 14)),
              Text(
                '${nextLevelPoints - currentPoints}P',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 8, // h-2
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.blue.shade200.withAlpha(128),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
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

          // 버튼 섹션
          Row(
            children: [
              ActionButton(
                icon: CupertinoIcons.gift_fill,
                label: '혜택 사용하기',
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
              ),
              const SizedBox(width: 12),
              ActionButton(
                icon: CupertinoIcons.ticket_fill,
                label: '내 쿠폰함',
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade600,
                side: BorderSide(color: Colors.blue.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
