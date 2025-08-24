import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bustar_app/config/api_config.dart';
import 'widgets/achievements_card.dart';
import 'widgets/header_card.dart';
import 'widgets/stats_card.dart';

/// 사용자 정보 화면을 표시하는 스크린 위젯입니다.
///
/// 사용자 이름, 등급, 가입일, 주요 통계, 최근 성취도, 앱 정보 등을
/// 각각의 카드 형태로 보여줍니다.
class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    // API를 호출하여 사용자 정보를 가져옵니다. (사용자 ID: 1로 가정)
    _dataFuture = Future.wait([fetchUser(1), fetchUsageRecord(1)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // 화면 전체 배경색을 밝은 회색으로 설정
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("오류: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final user = snapshot.data![0] as User;
            final usageRecord = snapshot.data![1] as UsageRecord;

            // API에서 받아온 데이터로 통계 목록 생성
            final List<Map<String, String>> stats = [
              {
                "label": "총 이용 횟수",
                "value": "${usageRecord.totalUse}회",
                "icon": "🚇",
              },
              {
                "label": "이번 달 이용",
                "value": "${usageRecord.monthUse}회",
                "icon": "📅",
              },
              {
                "label": "절약한 시간",
                "value": "${usageRecord.saved}시간",
                "icon": "⏰",
              },
            ];

            // --- 임시 데이터 (성취도) ---
            // TODO: 이 데이터도 API를 통해 가져오도록 수정해야 합니다.
            final List<Map<String, String>> recentAchievements = [
              {"name": "대중교통 마스터", "icon": "🚇", "date": "2025-08-01"},
              {"name": "AI 경로 전문가", "icon": "🤖", "date": "2025-07-28"},
              {"name": "시간 절약왕", "icon": "⏰", "date": "2025-07-25"},
            ];
            // --- 임시 데이터 끝 ---

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      HeaderCard(
                        userName: user.name,
                        userLevel: "${user.grade} 회원",
                        memberSince: user.date
                            .substring(0, 7)
                            .replaceAll('-', '.'),
                      ),
                      const SizedBox(height: 24),
                      StatsCard(stats: stats),
                      const SizedBox(height: 24),
                      AchievementsCard(achievements: recentAchievements),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("사용자 정보를 불러올 수 없습니다."));
          }
        },
      ),
    );
  }
}

// --- Data Model & API Service ---

class User {
  final int id;
  final String name;
  final String date;
  final String grade;

  User({
    required this.id,
    required this.name,
    required this.date,
    required this.grade,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      grade: json['grade'],
    );
  }
}

Future<User> fetchUser(int userId) async {
  final response = await http.get(Uri.parse('$baseUrl/user/$userId'));

  if (response.statusCode == 200) {
    // UTF-8로 디코딩하여 한글 깨짐 방지
    final decodedBody = utf8.decode(response.bodyBytes);
    return User.fromJson(jsonDecode(decodedBody));
  } else {
    throw Exception('사용자 정보 로딩 실패');
  }
}

class UsageRecord {
  final int id;
  final int totalUse;
  final int monthUse;
  final int saved;

  UsageRecord({
    required this.id,
    required this.totalUse,
    required this.monthUse,
    required this.saved,
  });

  factory UsageRecord.fromJson(Map<String, dynamic> json) {
    return UsageRecord(
      id: json['id'],
      totalUse: json['total_use'],
      monthUse: json['month_use'],
      saved: json['saved'],
    );
  }
}

Future<UsageRecord> fetchUsageRecord(int userId) async {
  final response = await http.get(Uri.parse('$baseUrl/usage_record/$userId'));

  if (response.statusCode == 200) {
    final decodedBody = utf8.decode(response.bodyBytes);
    return UsageRecord.fromJson(jsonDecode(decodedBody));
  } else {
    throw Exception('통계 정보 로딩 실패');
  }
}
