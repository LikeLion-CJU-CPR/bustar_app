import 'package:flutter/material.dart';
import 'package:bustar_app/screens/route/widgets/route_overview_card.dart';
import 'package:bustar_app/screens/route/widgets/stop_progress_card.dart';
import 'package:bustar_app/screens/route/widgets/recommendation_card.dart';

// Dummy Data
final List<Map<String, dynamic>> dummyData = [
  {
    'routeNumber': '711번',
    'routeType': '간선',
    'routeOverview': {
      'start': '우암초등학교',
      'startETA': '7분 뒤 도착',
      'current': '솔밭공원',
      'currentETA': '현재 위치',
      'end': '현대백화점',
      'endETA': '3분 뒤 도착',
    },
    'stopProgress': [
      {
        'stopName': '우암초등학교',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': true,
      },
      {
        'stopName': '청주시청',
        'isCurrent': false,
        'isPassed': true,
        'isDestination': false,
        'isBoarding': false,
      },
      {
        'stopName': '솔밭공원',
        'isCurrent': true,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': false,
      },
      {
        'stopName': '현대백화점',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': true,
        'isBoarding': false,
      },
      {
        'stopName': '지웰시티',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': false,
      },
    ],
    'recommendations': [
      {
        'title': '화이트리에 청주 지웰시티점',
        'distance': '0.5 km',
        'hours': '영업시간 9:00 ~ 19:00',
      },
      {
        'title': '스타벅스 청주지웰시티점',
        'distance': '0.6 km',
        'hours': '영업시간 7:00 ~ 22:00',
      },
    ],
  },
  {
    'routeNumber': '747번',
    'routeType': '급행',
    'routeOverview': {
      'start': '비하동',
      'startETA': '5분 뒤 도착',
      'current': '가경터미널',
      'currentETA': '현재 위치',
      'end': '충북대학교',
      'endETA': '10분 뒤 도착',
    },
    'stopProgress': [
      {
        'stopName': '비하동',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': true,
      },
      {
        'stopName': '가경터미널',
        'isCurrent': true,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': false,
      },
      {
        'stopName': '사창사거리',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': false,
        'isBoarding': false,
      },
      {
        'stopName': '충북대학교',
        'isCurrent': false,
        'isPassed': false,
        'isDestination': true,
        'isBoarding': false,
      },
    ],
    'recommendations': [
      {
        'title': '충북대 정문 맛집',
        'distance': '0.2 km',
        'hours': '영업시간 11:00 ~ 22:00',
      },
    ],
  },
];

class RouteStatusScreen extends StatelessWidget {
  final int index;
  const RouteStatusScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final routeData = dummyData[index];
    final routeOverviewData =
        routeData['routeOverview'] as Map<String, dynamic>;
    final stopProgressData =
        routeData['stopProgress'] as List<Map<String, dynamic>>;
    final recommendationsData =
        routeData['recommendations'] as List<Map<String, dynamic>>;
    final routeTypeData = routeData['routeType'] as String;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          '운행노선 ${routeData['routeNumber']}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 노선 개요 카드
            RouteOverviewCard(
              start: routeOverviewData['start']!,
              startETA: routeOverviewData['startETA']!,
              current: routeOverviewData['current']!,
              currentETA: routeOverviewData['currentETA']!,
              end: routeOverviewData['end']!,
              endETA: routeOverviewData['endETA']!,
            ),
            const SizedBox(height: 16),

            // 2. 정류장 진행 상태 카드
            StopProgressCard(stops: stopProgressData, routeType: routeTypeData),
            const SizedBox(height: 24),

            // 3. 추천 플레이스 섹션
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 16.0),
              child: Text(
                '도착지 주변 추천 플레이스',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...recommendationsData.map((rec) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: RecommendationCard(
                  title: rec['title']!,
                  distance: rec['distance']!,
                  hours: rec['hours']!,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
