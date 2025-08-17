import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ✨ 수정된 CustomCard 위젯과 CardContent를 사용하기 위해 import
import 'package:bustar_app/widgets/custom_card.dart';

class RecentHistoryCard extends StatelessWidget {
  final List<Map<String, dynamic>> recentPointHistory;
  const RecentHistoryCard({super.key, required this.recentPointHistory});

  // (헬퍼 함수들은 이전과 동일)
  Color _getPointColor(String type) {
    // ...
    switch (type) {
      case 'use':
        return Colors.red.shade600;
      case 'bonus':
        return Colors.blue.shade600;
      case 'earn':
      default:
        return Colors.green.shade600;
    }
  }

  String _getTypeText(String type) {
    // ...
    switch (type) {
      case 'use':
        return '사용';
      case 'bonus':
        return '보너스';
      case 'earn':
      default:
        return '적립';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✨ CustomCard는 이제 header와 content 대신 하나의 child를 받습니다.
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. 헤더 부분: '전체 보기' 버튼이 있어 기존 CardHeader 대신 직접 구성합니다.
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(CupertinoIcons.time, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '최근 포인트 내역',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // TODO: 전체 보기 화면으로 이동하는 로직 추가
                  },
                  child: Text(
                    '전체 보기',
                    style: TextStyle(color: Colors.blue.shade600),
                  ),
                ),
              ],
            ),
          ),

          // 2. 콘텐츠 부분: 일관된 패딩을 위해 CardContent 위젯을 사용합니다.
          // ✨ 카드 하단에 일관된 여백(pb-6)을 주기 위해 Padding 추가
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: CardContent(
              child: Column(
                children: recentPointHistory.map((item) {
                  final int points = item['points'];
                  final String type = item['type'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['activity'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${points > 0 ? '+' : ''}$points'
                              'P',
                              style: TextStyle(
                                fontSize: 14,
                                color: _getPointColor(type),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getTypeText(type),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
