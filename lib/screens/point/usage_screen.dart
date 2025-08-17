import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/reward_item_model.dart';
import 'my_coupons_screen.dart';
import 'widgets/usage_page/category_filters.dart';
import 'widgets/usage_page/reward_list_item.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
  String _selectedCategory = 'all';
  final Set<int> _purchasedIds = {};
  int _currentPoints = 2450;

  // --- 임시 데이터 ---
  final List<RewardItem> rewards = [
    RewardItem(
      id: 1,
      name: '커피 할인 쿠폰',
      description: '스타벅스 아메리카노 1,000원 할인',
      points: 300,
      icon: '☕',
      category: 'food',
      discount: '1,000원',
      expiry: '30일',
      popular: true,
    ),
    RewardItem(
      id: 2,
      name: '지하철 무료 승차권',
      description: '1회 무료 이용 가능',
      points: 500,
      icon: '🚇',
      category: 'transport',
      discount: '1회 무료',
      expiry: '60일',
      popular: true,
    ),
    RewardItem(
      id: 3,
      name: '편의점 할인 쿠폰',
      description: 'CU, GS25 500원 할인',
      points: 200,
      icon: '🏪',
      category: 'shopping',
      discount: '500원',
      expiry: '14일',
      popular: false,
    ),
    RewardItem(
      id: 4,
      name: '버스 무료 승차권',
      description: '시내버스 1회 무료 이용',
      points: 400,
      icon: '🚌',
      category: 'transport',
      discount: '1회 무료',
      expiry: '60일',
      popular: false,
    ),
    RewardItem(
      id: 5,
      name: '배달 할인 쿠폰',
      description: '배달의민족 3,000원 할인',
      points: 800,
      icon: '🚚',
      category: 'food',
      discount: '3,000원',
      expiry: '30일',
      popular: false,
    ),
  ];
  // --- 임시 데이터 끝 ---

  // 구매 확인 다이얼로그 표시 함수
  Future<void> _showPurchaseConfirmationDialog(RewardItem item) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Center(child: Text('구매 확인')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '정말로 이 상품을 구매하시겠습니까?',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(item.icon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${item.points}P',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '구매 후 보유 포인트: ${(_currentPoints - item.points)}P',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          actions: <Widget>[
            Expanded(
              child: TextButton(
                child: const Text('취소'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _purchasedIds.add(item.id);
                    _currentPoints -= item.points;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('구매 확정'),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(
            bottom: 24,
            left: 24,
            right: 24,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRewards = rewards
        .where(
          (reward) =>
              _selectedCategory == 'all' ||
              reward.category == _selectedCategory,
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '포인트 사용',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              '보유 포인트: ${_currentPoints}P',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyCouponsScreen(),
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.ticket_fill, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CategoryFilters(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 24),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(), // 중첩 스크롤 방지
                shrinkWrap: true,
                itemCount: filteredRewards.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final reward = filteredRewards[index];
                  return RewardListItem(
                    reward: reward,
                    currentPoints: _currentPoints,
                    isPurchased: _purchasedIds.contains(reward.id),
                    onPurchase: (item) {
                      _showPurchaseConfirmationDialog(item);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
