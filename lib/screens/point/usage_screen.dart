import 'dart:convert';

import 'package:bustar_app/screens/point/providers/point_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bustar_app/config/api_config.dart';
import 'package:provider/provider.dart';

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
  late Future<List<RewardItem>> _rewardsFuture;

  @override
  void initState() {
    super.initState();
    _rewardsFuture = _fetchRewards();
  }

  Future<List<RewardItem>> _fetchRewards() async {
    final response = await http.get(Uri.parse('$baseUrl/coupon/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) {
        String icon;
        String category;
        String affiliate = item['coupon_affiliate'] ?? '기타';

        switch (affiliate) {
          case 'gs편의점':
            icon = '🏪';
            category = 'shopping';
            break;
          case '멋사커피':
            icon = '☕';
            category = 'food';
            break;
          default:
            icon = '🎁';
            category = 'etc';
        }

        return RewardItem(
          id: item['coupon_id'],
          name: item['coupon_name'],
          description: '$affiliate ${item['coupon_discount']}원 할인',
          points: item['coupon_price'],
          icon: icon,
          category: category,
          discount: '${item['coupon_discount']}원',
          expiry: '${item['coupon_period']}일',
          popular: false, // API는 이 필드를 제공하지 않습니다.
        );
      }).toList();
    } else {
      throw Exception('API에서 보상 목록을 불러오는 데 실패했습니다.');
    }
  }

  // 구매 확인 다이얼로그 표시 함수
  Future<void> _showPurchaseConfirmationDialog(RewardItem item) async {
    final pointProvider = context.read<PointProvider>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
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
                '구매 후 보유 포인트: ${(pointProvider.currentPoints - item.points)}P',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          actions: <Widget>[
            Expanded(
              child: TextButton(
                child: const Text('취소'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  try {
                    final response = await http.post(
                      Uri.parse('$baseUrl/purchase/product/'),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        'user_id': 1, // 사용자 ID 1로 가정
                        'product_amount': item.points,
                        'granted_coupon_id': item.id,
                      }),
                    );

                    if (!context.mounted) return;

                    Navigator.of(dialogContext).pop();

                    if (response.statusCode == 200) {
                      final responseData = json.decode(
                        utf8.decode(response.bodyBytes),
                      );
                      pointProvider.setPoints(
                        responseData['new_point_balance'],
                      );
                      setState(() {
                        _purchasedIds.add(item.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('상품을 성공적으로 구매했습니다!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      final errorData = json.decode(
                        utf8.decode(response.bodyBytes),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('구매 실패: ${errorData['detail']}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('오류가 발생했습니다: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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
    final pointProvider = context.watch<PointProvider>();
    final currentPoints = pointProvider.currentPoints;

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
              '별사탕 사용',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              '보유 별사탕: $currentPoints ✦',
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
        child: FutureBuilder<List<RewardItem>>(
          future: _rewardsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('오류: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final rewards = snapshot.data!;
              final filteredRewards = rewards
                  .where(
                    (reward) =>
                        _selectedCategory == 'all' ||
                        reward.category == _selectedCategory,
                  )
                  .toList();

              return SingleChildScrollView(
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredRewards.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final reward = filteredRewards[index];
                        return RewardListItem(
                          reward: reward,
                          currentPoints: currentPoints,
                          isPurchased: _purchasedIds.contains(reward.id),
                          onPurchase: (item) {
                            // ✨ 여기서 context를 전달하지 않습니다.
                            _showPurchaseConfirmationDialog(item);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('데이터가 없습니다.'));
            }
          },
        ),
      ),
    );
  }
}
