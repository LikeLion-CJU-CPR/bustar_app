import 'package:flutter/material.dart';

import 'widgets/achievements_card.dart';
import 'widgets/header_card.dart';
import 'widgets/stats_card.dart';

/// 사용자 정보 화면을 표시하는 스크린 위젯입니다.
///
/// 사용자 이름, 등급, 가입일, 주요 통계, 최근 성취도, 앱 정보 등을
/// 각각의 카드 형태로 보여줍니다.
class MyInfoScreen extends StatelessWidget {
  /// 기본 사용자 이름을 '데모 사용자'로 설정합니다.
  const MyInfoScreen({super.key, this.userName = "데모 사용자"});

  /// 사용자 이름. 홈 스크린 등 다른 곳에서 전달받을 수 있습니다.
  final String userName;

  @override
  Widget build(BuildContext context) {
    // --- 임시 데이터 ---
    // 실제 앱에서는 이 데이터들을 API 호출 등을 통해 동적으로 가져와야 합니다.
    const String userLevel = "실버 회원";
    const String memberSince = "2024.01";

    // '나의 통계' 카드에 표시될 데이터 목록
    final List<Map<String, String>> stats = [
      {"label": "총 이용 횟수", "value": "124회", "icon": "🚇"},
      {"label": "이번 달 이용", "value": "24회", "icon": "📅"},
      {"label": "절약한 시간", "value": "45시간", "icon": "⏰"},
    ];

    // '최근 성취도' 카드에 표시될 데이터 목록
    final List<Map<String, String>> recentAchievements = [
      {"name": "대중교통 마스터", "icon": "🚇", "date": "2025-08-01"},
      {"name": "AI 경로 전문가", "icon": "🤖", "date": "2025-07-28"},
      {"name": "시간 절약왕", "icon": "⏰", "date": "2025-07-25"},
    ];
    // --- 임시 데이터 끝 ---

    return Scaffold(
      backgroundColor: Colors.grey[50], // 화면 전체 배경색을 밝은 회색으로 설정
      body: SafeArea(
        child: SingleChildScrollView(
          // 내용이 길어지면 스크롤이 가능하도록 합니다.
          child: Padding(
            padding: const EdgeInsets.all(16.0), // 화면 전체에 여백을 줍니다.
            child: Column(
              children: [
                // 각 정보 섹션을 카드 위젯으로 만듭니다.
                HeaderCard(
                  userName: userName,
                  userLevel: userLevel,
                  memberSince: memberSince,
                ),
                const SizedBox(height: 24), // 카드 사이의 간격
                StatsCard(stats: stats),
                const SizedBox(height: 24),
                AchievementsCard(achievements: recentAchievements),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
