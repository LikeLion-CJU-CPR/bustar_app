import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bustar_app/screens/route/widgets/route_overview_card.dart';
import 'package:bustar_app/screens/route/widgets/stop_progress_card.dart';
import 'package:bustar_app/screens/route/widgets/recommendation_card.dart';
import 'package:http/http.dart' as http;
import 'package:bustar_app/config/api_config.dart';

class BusSchedule {
  final String departureTime;
  final String arrivalTime;
  BusSchedule({required this.departureTime, required this.arrivalTime});
}

// Dummy Data
final List<Map<String, dynamic>> dummyData = [
  {
    'routeNumber': '711번',
    'routeOverview': {
      'start': '충북대학교입구',
      'startETA': '5분 뒤 도착',
      'current': '우암초등학교',
      'currentETA': '현재 위치',
      'end': '청주대학교.뉴시스',
      'endETA': '8분 뒤 도착',
    },
    'recommendations': [
      {
        'title': '청대식당',
        'distance': '0.2 km',
        'hours': '영업시간 11:00 ~ 22:00',
        'isTag': true,
        'chip1': '2000￦',
        'chip2': '식당',
      },
      {
        'title': '청대정문카페',
        'distance': '0.3 km',
        'hours': '영업시간 09:00 ~ 21:00',
        'isTag': false,
        'chip1': '빵',
        'chip2': '카페',
      },
    ],
  },
  {
    'routeNumber': '747번',
    'routeOverview': {
      'start': '청주대학교.뉴시스',
      'startETA': '7분 뒤 도착',
      'current': '충북대학교입구',
      'currentETA': '현재 위치',
      'end': '오송역종점',
      'endETA': '15분 뒤 도착',
    },
    'recommendations': [
      {
        'title': '오송역멋대빙수',
        'distance': '0.3 km',
        'hours': '영업시간 08:00 ~ 21:00',
        'isTag': false,
        'chip1': '빙수',
        'chip2': '카페',
      },
      {
        'title': '오송역 식당',
        'distance': '0.4 km',
        'hours': '영업시간 10:00 ~ 22:00',
        'isTag': true,
        'chip1': '5%',
        'chip2': '식당',
      },
    ],
  },
];

class RouteStatusScreen extends StatefulWidget {
  final int index;
  const RouteStatusScreen({super.key, required this.index});

  @override
  State<RouteStatusScreen> createState() => _RouteStatusScreenState();
}

class _RouteStatusScreenState extends State<RouteStatusScreen> {
  List<Map<String, dynamic>>? _stopProgress;
  List<BusSchedule>? _schedules;
  String? _routeType;
  bool _isLoading = true;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadRouteData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getLatestBusStopName(Map<String, dynamic> routeOverviewData) {
    // 1. 데이터가 준비되지 않았으면 기본값을 반환합니다.
    if (_stopProgress == null || _schedules == null || _stopProgress!.isEmpty) {
      return routeOverviewData['current']!;
    }

    // 2. 사용자의 목적지 정류장 인덱스를 찾습니다.
    final endStopName = routeOverviewData['end'] as String;
    final destinationIndex = _stopProgress!.indexWhere(
      (s) => s['stopName'] == endStopName,
    );

    // 목적지를 찾을 수 없으면 기본값을 반환합니다.
    if (destinationIndex == -1) {
      return routeOverviewData['current']!;
    }

    // 3. 목적지를 아직 지나치지 않은 버스 중, 목적지에 가장 가까운 버스를 찾습니다.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final stopCount = _stopProgress!.length;

    double maxProgressBeforeDestination = -1.0;
    int lastPassedStopIndexOfClosestBus = -1;

    for (var schedule in _schedules!) {
      final depParts = schedule.departureTime.split(':');
      final arrParts = schedule.arrivalTime.split(':');
      var depTime = DateTime(
        today.year,
        today.month,
        today.day,
        int.parse(depParts[0]),
        int.parse(depParts[1]),
      );
      var arrTime = DateTime(
        today.year,
        today.month,
        today.day,
        int.parse(arrParts[0]),
        int.parse(arrParts[1]),
      );

      if (arrTime.isBefore(depTime)) {
        arrTime = arrTime.add(const Duration(days: 1));
      }

      // 현재 운행 중인 버스인지 확인합니다.
      if (now.isAfter(depTime) && now.isBefore(arrTime)) {
        final totalDuration = arrTime.difference(depTime).inMilliseconds;
        final elapsedTime = now.difference(depTime).inMilliseconds;
        final progress = (elapsedTime / totalDuration).clamp(0.0, 1.0);

        final currentStopIndex = (progress * (stopCount - 1)).floor();

        // 버스가 목적지를 지나지 않았는지 확인합니다.
        if (currentStopIndex < destinationIndex) {
          // 목적지에 가장 가까운 버스(가장 많이 진행한 버스)를 선택합니다.
          if (progress > maxProgressBeforeDestination) {
            maxProgressBeforeDestination = progress;
            lastPassedStopIndexOfClosestBus = currentStopIndex;
          }
        }
      }
    }

    // 4. 조건에 맞는 버스가 없으면 기본값을 반환합니다.
    if (maxProgressBeforeDestination == -1.0) {
      return '-';
    }

    // 5. 가장 가까운 버스가 다음으로 지나갈 정류장 이름을 계산하여 반환합니다.
    final nextStopIndex = lastPassedStopIndexOfClosestBus + 1;
    final safeIndex = nextStopIndex.clamp(0, stopCount - 1);

    return _stopProgress![safeIndex]['stopName'];
  }

  String _parseDuration(String duration) {
    final match = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?').firstMatch(duration);
    if (match == null) return '00:00';

    final hours = match.group(1) ?? '0';
    final minutes = match.group(2) ?? '0';

    return '${hours.padLeft(2, '0')}:${minutes.padLeft(2, '0')}';
  }

  Future<void> _loadRouteData() async {
    try {
      final routeData = dummyData[widget.index];
      final routeOverviewData =
          routeData['routeOverview'] as Map<String, dynamic>;
      final routeNumberString = routeData['routeNumber'] as String;
      final busNumber = routeNumberString.replaceAll('번', '');

      final startStop = routeOverviewData['start'] as String;
      final endStop = routeOverviewData['end'] as String;

      // Fetch routes and times concurrently
      final responses = await Future.wait([
        http.get(Uri.parse('$baseUrl/bus_routes/$busNumber')),
        http.get(Uri.parse('$baseUrl/bus_times/$busNumber')),
        http.get(Uri.parse('$baseUrl/bus/$busNumber')),
      ]);

      final routeResponse = responses[0];
      final timeResponse = responses[1];
      final typeResponse = responses[2];

      if (routeResponse.statusCode != 200) {
        throw Exception('버스 노선 정보를 불러오는 데 실패했습니다.');
      }
      if (timeResponse.statusCode != 200) {
        throw Exception('버스 시간표 정보를 불러오는 데 실패했습니다.');
      }
      if (typeResponse.statusCode != 200) {
        throw Exception('버스 종류 정보를 불러오는 데 실패했습니다.');
      }

      // Process route data
      final List<dynamic> routeJson = json.decode(
        utf8.decode(routeResponse.bodyBytes),
      );
      final directionData = routeJson.firstWhere((d) {
        final stops = d['stops'] as List<dynamic>;
        final startIndex = stops.indexWhere(
          (s) => s['station_name'] == startStop,
        );
        final endIndex = stops.indexWhere((s) => s['station_name'] == endStop);
        return startIndex != -1 && endIndex != -1 && startIndex < endIndex;
      }, orElse: () => null);
      if (directionData == null) {
        throw Exception('해당 출발-도착지를 포함하는 노선을 찾을 수 없습니다.');
      }

      final targetStops = directionData['stops'] as List<dynamic>;
      final direction = directionData['direction'] as String;

      List<Map<String, dynamic>> processedStops = [];
      for (int i = 0; i < targetStops.length; i++) {
        final stop = targetStops[i];
        final stopName = stop['station_name'] as String;

        processedStops.add({
          'stopName': stopName,
          'isBoarding': stopName == startStop,
          'isDestination': stopName == endStop,
          'isCurrent': false, // 초기값은 false로, build 시점에 동적으로 결정됩니다.
        });
      }

      // Process time data
      final List<dynamic> timeJson = json.decode(
        utf8.decode(timeResponse.bodyBytes),
      );
      final List<BusSchedule> schedules = timeJson
          .where((time) => time['direction'] == direction)
          .map(
            (time) => BusSchedule(
              departureTime: _parseDuration(time['start_time']),
              arrivalTime: _parseDuration(time['arrive_time']),
            ),
          )
          .toList();

      // Process type data
      final Map<String, dynamic> typeJson = json.decode(
        utf8.decode(typeResponse.bodyBytes),
      );
      final String fetchedRouteType = typeJson['bus_type'];

      setState(() {
        _stopProgress = processedStops;
        _schedules = schedules;
        _routeType = fetchedRouteType;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeData = dummyData[widget.index];
    final routeOverviewData =
        routeData['routeOverview'] as Map<String, dynamic>;
    final recommendationsData =
        routeData['recommendations'] as List<Map<String, dynamic>>;

    final String currentBusStopName = _getLatestBusStopName(routeOverviewData);
    final String currentBusStopETA = (currentBusStopName == '-')
        ? ''
        : routeOverviewData['currentETA']!;

    // ✨ 2. 운행 중이거나 출발 예정인 모든 버스 스케줄을 찾습니다.
    final List<BusSchedule> activeSchedules = [];
    if (_schedules != null) {
      final now = DateTime.now();
      for (final schedule in _schedules!) {
        final depParts = schedule.departureTime.split(':');
        final arrParts = schedule.arrivalTime.split(':');
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
          activeSchedules.add(schedule);
        }
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
              current: currentBusStopName,
              currentETA: currentBusStopETA,
              end: routeOverviewData['end']!,
              endETA: routeOverviewData['endETA']!,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Center(child: Text('오류: $_error'))
            else if (_stopProgress != null &&
                _schedules != null &&
                _routeType != null)
              Builder(
                builder: (context) {
                  // 실시간으로 계산된 버스 위치에 따라 isCurrent 플래그를 업데이트합니다.
                  final updatedStops = _stopProgress!.map((stop) {
                    return {
                      ...stop,
                      'isCurrent': stop['stopName'] == currentBusStopName,
                    };
                  }).toList();
                  return StopProgressCard(
                    stops: updatedStops,
                    routeType: _routeType!,
                    schedules: activeSchedules,
                  );
                },
              )
            else
              const Center(child: Text('노선 진행 정보를 불러올 수 없습니다.')),
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
                  isTag: rec['isTag']!,
                  chip1: rec['chip1']!,
                  chip2: rec['chip2']!,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
