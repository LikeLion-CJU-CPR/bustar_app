import 'package:flutter/material.dart';

import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/screens/route/route_status_screen.dart';
import 'package:bustar_app/screens/home/widgets/build_route_row.dart';

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
                    builder: (context) => const RouteStatusScreen(index: 0),
                  ),
                );
              },
              child: const CustomCard(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '출근 경로',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "내일 아침 6:20분 출발",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    BuildRouteRow(text: '충북대학교입구', color: Colors.blue),
                    SizedBox(height: 8),
                    BuildRouteRow(text: '청주대학교.뉴시스', color: Colors.blue),
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
}
