import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'models/coupon_model.dart';
import 'utils/coupon_helpers.dart';
import 'widgets/my_coupons_page/coupon_filter_buttons.dart';
import 'widgets/my_coupons_page/coupon_list_item.dart';
import 'package:bustar_app/config/api_config.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  String _selectedFilter = 'all';
  late Future<List<Coupon>> _myCouponsFuture;

  @override
  void initState() {
    super.initState();
    _myCouponsFuture = _fetchMyCoupons(1); // 사용자 ID 1로 가정
  }

  Future<List<Coupon>> _fetchMyCoupons(int userId) async {
    // 1. 모든 쿠폰의 기본 정보 가져오기
    final couponResponse = await http.get(Uri.parse('$baseUrl/coupon/'));
    if (couponResponse.statusCode != 200) {
      throw Exception('쿠폰 정보를 불러오는 데 실패했습니다.');
    }
    final List<dynamic> couponData = json.decode(
      utf8.decode(couponResponse.bodyBytes),
    );
    final Map<int, dynamic> allCouponsMap = {
      for (var coupon in couponData) coupon['coupon_id']: coupon,
    };

    // 2. 사용자가 보유한 쿠폰 목록 가져오기
    final userCouponResponse = await http.get(
      Uri.parse('$baseUrl/user_coupon/'),
    );
    if (userCouponResponse.statusCode != 200) {
      throw Exception('보유 쿠폰 목록을 불러오는 데 실패했습니다.');
    }
    final List<dynamic> userCouponData = json.decode(
      utf8.decode(userCouponResponse.bodyBytes),
    );

    // 3. 두 데이터를 조합하여 최종 쿠폰 목록 생성
    final List<Coupon> coupons = [];
    for (var userCoupon in userCouponData) {
      if (userCoupon['id'] != userId) continue; // 현재 사용자의 쿠폰만 필터링

      final fullCoupon = allCouponsMap[userCoupon['coupon_id']];
      if (fullCoupon == null) continue;

      // 상태 결정
      String status;
      if (userCoupon['use_finish'] == 1) {
        status = 'used';
      } else if (userCoupon['finish_period'] == 1) {
        status = 'expired';
      } else {
        status = 'active';
      }

      // 아이콘 및 카테고리 결정
      String icon;
      String category;
      String affiliate = fullCoupon['coupon_affiliate'] ?? '기타';
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

      coupons.add(
        Coupon(
          id: userCoupon['coupon_id'],
          name: fullCoupon['coupon_name'],
          description:
              '${fullCoupon['coupon_affiliate']} ${fullCoupon['coupon_discount']}원 할인',
          discount: '${fullCoupon['coupon_discount']}원',
          code: 'BUSTAR-${userCoupon['id']}-${userCoupon['coupon_id']}',
          purchaseDate: userCoupon['start_period'],
          expiryDate: userCoupon['end_period'],
          status: status,
          icon: icon,
          category: category,
          usage: '매장에서 쿠폰 제시',
          usedDate: null, // API에서 제공하지 않음
        ),
      );
    }
    return coupons;
  }

  // ✨ 쿠폰 상세 정보 다이얼로그 표시 함수
  Future<void> _showCouponDetailDialog(Coupon coupon) async {
    final statusInfo = getStatusInfo(coupon.status);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Center(child: Text('쿠폰 상세')),
          contentPadding: const EdgeInsets.all(24),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(coupon.icon, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(
                  coupon.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  coupon.description,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                _buildDetailRow('할인 금액', coupon.discount),
                _buildDetailRow('구매일', formatDate(coupon.purchaseDate)),
                _buildDetailRow('유효기간', formatDate(coupon.expiryDate)),
                _buildDetailRow(
                  '상태',
                  statusInfo.text,
                  valueColor: statusInfo.color,
                ),
                const SizedBox(height: 16),
                _buildStatusSpecificContent(coupon), // 상태별 UI 표시
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('닫기'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // ✨ QR 코드 다이얼로그 표시 함수
  Future<void> _showQrCodeDialog(Coupon coupon) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Center(child: Text('QR 코드')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.qrcode, size: 180, color: Colors.black),
              const SizedBox(height: 16),
              Text(
                coupon.usage,
                style: TextStyle(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              child: const Text('확인'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // 다이얼로그 내의 상세 정보 행을 만드는 헬퍼 위젯
  Widget _buildDetailRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade700)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }

  // 다이얼로그 내에서 쿠폰 상태에 따라 다른 UI를 보여주는 헬퍼 위젯
  Widget _buildStatusSpecificContent(Coupon coupon) {
    if (coupon.status == 'active') {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '쿠폰 코드',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        coupon.code,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.doc_on_doc, size: 16),
                      onPressed: () {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        Clipboard.setData(ClipboardData(text: coupon.code));
                        Navigator.of(context).pop();
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(content: Text('쿠폰 코드가 복사되었습니다.')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(CupertinoIcons.qrcode, size: 20),
            label: const Text('QR 코드로 사용'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // 상세 다이얼로그 닫기
              _showQrCodeDialog(coupon); // QR 코드 다이얼로그 열기
            },
          ),
        ],
      );
    } else if (coupon.status == 'used') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '사용 완료',
          style: TextStyle(color: Colors.green.shade700),
          textAlign: TextAlign.center,
        ),
      );
    } else if (coupon.status == 'expired') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '쿠폰이 만료되었습니다',
          style: TextStyle(color: Colors.red.shade700),
          textAlign: TextAlign.center,
        ),
      );
    }
    return const SizedBox.shrink(); // 아무것도 표시하지 않음
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('내 쿠폰함', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<List<Coupon>>(
        future: _myCouponsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final myCoupons = snapshot.data!;
            final filteredCoupons = (_selectedFilter == 'all')
                ? myCoupons
                : myCoupons.where((c) => c.status == _selectedFilter).toList();

            final counts = {
              'all': myCoupons.length,
              'active': myCoupons.where((c) => c.status == 'active').length,
              'used': myCoupons.where((c) => c.status == 'used').length,
              'expired': myCoupons.where((c) => c.status == 'expired').length,
            };

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                CouponFilterButtons(
                  selectedFilter: _selectedFilter,
                  counts: counts,
                  onFilterSelected: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ...filteredCoupons.map(
                  (coupon) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CouponListItem(
                      coupon: coupon,
                      onTap: () => _showCouponDetailDialog(coupon),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('보유한 쿠폰이 없습니다.'));
          }
        },
      ),
    );
  }
}
