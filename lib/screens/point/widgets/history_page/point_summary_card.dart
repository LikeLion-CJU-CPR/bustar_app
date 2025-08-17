import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_card.dart';

class PointSummaryCard extends StatelessWidget {
  final bool isEarn;
  final int amount;
  const PointSummaryCard({super.key, required this.isEarn, required this.amount});

  @override
  Widget build(BuildContext context) {
    // 리팩토링된 CustomCard와 CardContent를 사용
    return CustomCard(
      padding: const EdgeInsets.all(16.0),
      child: CardContent(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEarn
                      ? CupertinoIcons.arrow_up_right
                      : CupertinoIcons.arrow_down_right,
                  size: 20,
                  color: isEarn ? Colors.green.shade500 : Colors.red.shade500,
                ),
                const SizedBox(width: 8),
                Text(
                  isEarn ? '총 적립' : '총 사용',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${isEarn ? '+' : '-'}${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}P',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isEarn ? Colors.green.shade600 : Colors.red.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
