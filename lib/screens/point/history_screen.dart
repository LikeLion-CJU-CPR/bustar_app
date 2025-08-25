import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/point_history_model.dart';
import 'widgets/history_page/filter_tabs.dart';
import 'widgets/history_page/history_list_card.dart';
import 'widgets/history_page/point_summary_card.dart';

class PointHistoryScreen extends StatefulWidget {
  const PointHistoryScreen({super.key});

  @override
  State<PointHistoryScreen> createState() => _PointHistoryScreenState();
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  String _selectedFilter = 'all';

  // --- 임시 데이터 ---
  final List<PointHistory> pointHistory = [
    PointHistory(
      date: '2025-08-17',
      activity: 'AI 추천 경로 이용',
      points: 50,
      type: 'earn',
    ),
    PointHistory(
      date: '2025-08-16',
      activity: '연속 7일 이용 보너스',
      points: 100,
      type: 'bonus',
    ),
    PointHistory(
      date: '2025-08-15',
      activity: '커피 쿠폰 사용',
      points: -300,
      type: 'use',
    ),
    PointHistory(
      date: '2025-08-14',
      activity: '빠른 경로 이용',
      points: 30,
      type: 'earn',
    ),
    PointHistory(
      date: '2025-07-30',
      activity: '친구 추천 완료',
      points: 200,
      type: 'bonus',
    ),
    PointHistory(
      date: '2025-07-29',
      activity: 'AI 추천 경로 이용',
      points: 50,
      type: 'earn',
    ),
    PointHistory(
      date: '2025-07-26',
      activity: '도시락 쿠폰 사용',
      points: -500,
      type: 'use',
    ),
    PointHistory(
      date: '2025-07-25',
      activity: '첫 주간 목표 달성',
      points: 150,
      type: 'bonus',
    ),
  ];
  // --- 임시 데이터 끝 --

  @override
  Widget build(BuildContext context) {
    final filteredHistory = pointHistory.where((item) {
      if (_selectedFilter == 'all') return true;
      return item.type == _selectedFilter;
    }).toList();

    final totalEarned = pointHistory
        .where((item) => item.points > 0)
        .fold<int>(0, (sum, item) => sum + item.points);
    final totalUsed = pointHistory
        .where((item) => item.points < 0)
        .fold<int>(0, (sum, item) => sum + item.points)
        .abs();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.grey.shade200,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '포인트 내역',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. 통계 위젯
              Row(
                children: [
                  Expanded(
                    child: PointSummaryCard(isEarn: true, amount: totalEarned),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PointSummaryCard(isEarn: false, amount: totalUsed),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 2. 필터 탭 위젯
              FilterTabs(
                selectedFilter: _selectedFilter,
                pointHistory: pointHistory,
                onFilterSelected: (newFilter) {
                  setState(() {
                    _selectedFilter = newFilter;
                  });
                },
              ),
              const SizedBox(height: 24),
              // 3. 내역 리스트 위젯
              HistoryListCard(
                filteredHistory: filteredHistory,
                selectedFilter: _selectedFilter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
