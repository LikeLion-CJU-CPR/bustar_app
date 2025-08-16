import 'package:flutter/material.dart';

// ✨ 위젯 import 경로가 새로운 구조에 맞게 변경됩니다.
import 'widgets/achievements_card.dart';
import 'widgets/points_overview_card.dart';
import 'widgets/recent_history_card.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 임시 데이터 ---
    final List<Map<String, dynamic>> achievements = [
      {
        'name': '대중교통 마스터',
        'description': '100회 이용 달성',
        'icon': '🚇',
        'completed': true,
      },
      {
        'name': 'AI 경로 전문가',
        'description': 'AI 추천 경로 50회 이용',
        'icon': '🤖',
        'completed': true,
      },
      {
        'name': '친환경 영웅',
        'description': '자가용 대신 대중교통 30일',
        'icon': '🌱',
        'completed': false,
      },
      {
        'name': '시간 절약왕',
        'description': '빠른 경로로 10시간 절약',
        'icon': '⏰',
        'completed': true,
      },
    ];

    final List<Map<String, dynamic>> recentPointHistory = [
      {
        'date': '2025-08-03',
        'activity': 'AI 추천 경로 이용',
        'points': 50,
        'type': 'earn',
      },
      {
        'date': '2025-08-02',
        'activity': '연속 7일 이용 보너스',
        'points': 100,
        'type': 'bonus',
      },
      {
        'date': '2025-08-01',
        'activity': '커피 쿠폰 사용',
        'points': -300,
        'type': 'use',
      },
    ];
    // --- 임시 데이터 끝 ---

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ✨ 이제 메서드 호출이 아닌, 위젯 클래스를 생성합니다.
                const PointsOverviewCard(),
                const SizedBox(height: 24),
                RecentHistoryCard(recentPointHistory: recentPointHistory),
                const SizedBox(height: 24),
                AchievementsCard(achievements: achievements),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
