import 'package:flutter/material.dart';

import 'models/achievement_model.dart';
import 'models/point_history_item_model.dart';
import 'widgets/dashboard_page/achievements_card.dart';
import 'widgets/dashboard_page/points_overview_card.dart';
import 'widgets/dashboard_page/recent_history_card.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 임시 데이터: 이제 데이터 모델 클래스를 사용합니다 ---
    final List<Achievement> achievements = [
      Achievement(
        name: '대중교통 마스터',
        description: '100회 이용 달성',
        icon: '🚇',
        isCompleted: true,
      ),
      Achievement(
        name: 'AI 경로 전문가',
        description: 'AI 추천 경로 50회 이용',
        icon: '🤖',
        isCompleted: true,
      ),
      Achievement(
        name: '친환경 영웅',
        description: '자가용 대신 대중교통 30일',
        icon: '🌱',
        isCompleted: false,
      ),
      Achievement(
        name: '시간 절약왕',
        description: '빠른 경로로 10시간 절약',
        icon: '⏰',
        isCompleted: true,
      ),
    ];

    final List<PointHistoryItem> recentPointHistory = [
      PointHistoryItem(
        date: '2025-08-17',
        activity: 'AI 추천 경로 이용',
        points: 50,
        type: 'earn',
      ),
      PointHistoryItem(
        date: '2025-08-16',
        activity: '연속 7일 이용 보너스',
        points: 100,
        type: 'bonus',
      ),
      PointHistoryItem(
        date: '2025-08-15',
        activity: '커피 쿠폰 사용',
        points: -300,
        type: 'use',
      ),
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
