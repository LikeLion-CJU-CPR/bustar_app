import 'package:flutter/material.dart';
import 'package:bustar_app/screens/route/widgets/route_overview_card.dart';
import 'package:bustar_app/screens/route/widgets/stop_progress_card.dart';
import 'package:bustar_app/screens/route/widgets/recommendation_card.dart';

class RouteStatusScreen extends StatelessWidget {
  const RouteStatusScreen({super.key, required index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          '운행노선 711번',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 노선 개요 카드
            RouteOverviewCard(),
            SizedBox(height: 16),

            // 2. 정류장 진행 상태 카드
            StopProgressCard(),
            SizedBox(height: 24),

            // 3. 추천 플레이스 섹션
            Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 16.0),
              child: Text(
                '도착지 주변 추천 플레이스',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            RecommendationCard(
              title: '화이트리에 청주 지웰시티점',
              distance: '0.5 km',
              hours: '영업시간 9:00 ~ 19:00',
            ),
            SizedBox(height: 12),
            RecommendationCard(
              title: '화이트리에 청주 지웰시티점',
              distance: '0.5 km',
              hours: '영업시간 9:00 ~ 19:00',
            ),
            SizedBox(height: 12),
            RecommendationCard(
              title: '화이트리에 청주 지웰시티점',
              distance: '0.5 km',
              hours: '영업시간 9:00 ~ 19:00',
            ),
          ],
        ),
      ),
    );
  }
}
