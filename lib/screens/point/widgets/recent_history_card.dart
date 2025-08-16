import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_card.dart'; // 전역 위젯 import

class RecentHistoryCard extends StatelessWidget {
  final List<Map<String, dynamic>> recentPointHistory;
  const RecentHistoryCard({super.key, required this.recentPointHistory});

  // 포인트 타입에 따라 색상을 결정하는 헬퍼 함수
  Color _getPointColor(String type) {
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

  // 포인트 타입에 따라 텍스트를 결정하는 헬퍼 함수
  String _getTypeText(String type) {
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
    return CustomCard(
      header: Padding(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '전체 보기',
                style: TextStyle(color: Colors.blue.shade600),
              ),
            ),
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
    );
  }
}
