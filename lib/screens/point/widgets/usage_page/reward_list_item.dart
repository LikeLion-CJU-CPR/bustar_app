import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/action_button.dart';
import '../../models/reward_item_model.dart';

class RewardListItem extends StatelessWidget {
  // ... (생성자는 이전과 동일)
  final RewardItem reward;
  final int currentPoints;
  final bool isPurchased;
  final Function(RewardItem) onPurchase;

  const RewardListItem({
    super.key,
    required this.reward,
    required this.currentPoints,
    required this.isPurchased,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    final bool canAfford = currentPoints >= reward.points;

    return Opacity(
      // ... (상단 UI 코드는 이전과 동일)
      opacity: canAfford ? 1.0 : 0.6,
      child: CustomCard(
        child: Container(
          decoration: reward.popular
              ? BoxDecoration(
                  border: Border.all(color: Colors.yellow.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.yellow.shade50.withValues(alpha: .3),
                )
              : null,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(reward.icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          reward.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (reward.popular)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade600,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '인기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reward.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '할인: ${reward.discount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '유효: ${reward.expiry}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${reward.points} ✦',
                    style: const TextStyle(
                      color: Color(0xFF6CB77E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  isPurchased
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.check_mark,
                                size: 14,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '구매완료',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ActionButton(
                          isExpanded: false,
                          icon: CupertinoIcons.plus,
                          iconSize: 14,
                          fontSize: 12,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          onPressed: canAfford
                              ? () => onPurchase(reward)
                              : null,
                          label: canAfford ? '구매' : '부족',
                          backgroundColor: canAfford
                              ? const Color(0xFF6CB77E)
                              : Colors.grey.shade300,
                          foregroundColor: canAfford
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
