import 'package:flutter/material.dart';
import 'package:bustar_app/screens/route/widgets/route_overview_card.dart';
import 'package:bustar_app/screens/route/widgets/stop_progress_card.dart';
import 'package:bustar_app/screens/route/widgets/recommendation_card.dart';

class BusSchedule {
  final String departureTime;
  final String arrivalTime;
  BusSchedule({required this.departureTime, required this.arrivalTime});
}

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
    'departure_times': [
      "02:04",
      "02:05",
      "05:50",
      "06:30",
      "07:25",
      "07:55",
      "08:25",
      "09:00",
      "09:40",
      "10:10",
      "10:45",
      "11:20",
      "11:55",
      "12:30",
      "13:10",
      "13:45",
      "14:20",
      "14:55",
      "15:30",
      "16:05",
      "16:40",
      "17:15",
      "17:50",
      "18:25",
      "19:00",
      "19:35",
      "20:10",
      "20:45",
      "21:20",
      "21:55",
      "23:20",
    ],
    'arrival_times': [
      "02:06",
      "02:07",
      "06:10",
      "07:45",
      "08:40",
      "09:10",
      "09:40",
      "10:15",
      "10:55",
      "11:25",
      "12:00",
      "12:35",
      "13:10",
      "13:45",
      "14:25",
      "15:00",
      "15:35",
      "16:10",
      "16:45",
      "17:20",
      "17:55",
      "18:30",
      "19:05",
      "19:40",
      "20:15",
      "20:50",
      "21:25",
      "22:00",
      "22:35",
      "23:10",
      "00:30",
    ],
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
    'departure_times': [
      "02:35",
      "02:37",
      "02:40",
      // ---
      "05:50",
      "06:30",
      "07:25",
      "07:55",
      "08:25",
      "09:00",
      "09:40",
      "10:10",
      "10:45",
      "11:20",
      "11:55",
      "12:30",
      "13:10",
      "13:45",
      "14:20",
      "14:55",
      "15:30",
      "16:05",
      "16:40",
      "17:15",
      "17:50",
      "18:25",
      "19:00",
      "19:35",
      "20:10",
      "20:45",
      "21:20",
      "21:55",
      "23:20",
    ],
    'arrival_times': [
      "02:40",
      "02:42",
      "02:45",
      // ---
      "06:10",
      "07:45",
      "08:40",
      "09:10",
      "09:40",
      "10:15",
      "10:55",
      "11:25",
      "12:00",
      "12:35",
      "13:10",
      "13:45",
      "14:25",
      "15:00",
      "15:35",
      "16:10",
      "16:45",
      "17:20",
      "17:55",
      "18:30",
      "19:05",
      "19:40",
      "20:15",
      "20:50",
      "21:25",
      "22:00",
      "22:35",
      "23:10",
      "00:30",
    ],
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
    final recommendationsData =
        routeData['recommendations'] as List<Map<String, dynamic>>;
    final departureTimes = routeData['departure_times'] as List<String>;
    final arrivalTimes = routeData['arrival_times'] as List<String>;

    // ✨ 2. 운행 중이거나 출발 예정인 모든 버스 스케줄을 찾습니다.
    final List<BusSchedule> activeSchedules = [];
    final now = DateTime.now();

    for (int i = 0; i < departureTimes.length; i++) {
      final depParts = departureTimes[i].split(':');
      final arrParts = arrivalTimes[i].split(':');
      var depTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(depParts[0]),
        int.parse(depParts[1]),
      );
      var arrTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(arrParts[0]),
        int.parse(arrParts[1]),
      );

      if (arrTime.isBefore(depTime)) {
        arrTime = arrTime.add(const Duration(days: 1));
      }

      // 현재 시간이 도착 시간보다 이전인 모든 버스를 리스트에 추가 (break 제거)
      if (now.isBefore(arrTime)) {
        activeSchedules.add(
          BusSchedule(
            departureTime: departureTimes[i],
            arrivalTime: arrivalTimes[i],
          ),
        );
      }
    }

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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RouteOverviewCard(
              start: routeOverviewData['start']!,
              startETA: routeOverviewData['startETA']!,
              current: routeOverviewData['current']!,
              currentETA: routeOverviewData['currentETA']!,
              end: routeOverviewData['end']!,
              endETA: routeOverviewData['endETA']!,
            ),
            const SizedBox(height: 16),
            StopProgressCard(
              stops: routeData['stopProgress'] as List<Map<String, dynamic>>,
              routeType: routeData['routeType'] as String,
              schedules: activeSchedules,
            ),
            const SizedBox(height: 24),
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
