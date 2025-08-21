import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/screens/route/route_page.dart';

class CommuteCardsPanel extends StatelessWidget {
  const CommuteCardsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 출근 경로 카드
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoutePage(index: 0),
                  ),
                );
              },
              child: CustomCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '출근 경로',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "내일 아침 6:20분 출발",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    _buildRouteRow(
                      CupertinoIcons.circle_filled,
                      '개신현대아파트',
                      Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    _buildRouteRow(
                      CupertinoIcons.circle_filled,
                      '충북대학교입구',
                      Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    _buildRouteRow(
                      CupertinoIcons.circle_filled,
                      '청주대학교.뉴시스',
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 퇴근 경로 카드
          const Expanded(
            child: CustomCard(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  '퇴근 경로를\n등록해 주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
