import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/coupon_model.dart';
import 'utils/coupon_helpers.dart';
import 'widgets/my_coupons_page/coupon_filter_buttons.dart';
import 'widgets/my_coupons_page/coupon_list_item.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  String _selectedFilter = 'all';

  // --- 임시 데이터 ---
  final List<Coupon> myCoupons = [
    Coupon(
      id: 1,
      name: '커피 할인 쿠폰',
      description: '스타벅스 아메리카노 1,000원 할인',
      discount: '1,000원',
      code: 'COFFEE2024001',
      purchaseDate: '2025-08-15',
      expiryDate: '2025-09-15',
      status: 'active',
      icon: '☕',
      category: 'food',
      usage: '매장에서 쿠폰 코드 제시',
    ),
    Coupon(
      id: 2,
      name: '지하철 무료 승차권',
      description: '1회 무료 이용 가능',
      discount: '1회 무료',
      code: 'SUBWAY2024002',
      purchaseDate: '2025-07-20',
      expiryDate: '2025-09-20',
      status: 'active',
      icon: '🚇',
      category: 'transport',
      usage: 'QR코드를 개찰구에 스캔',
    ),
    Coupon(
      id: 3,
      name: '편의점 할인 쿠폰',
      description: 'CU, GS25 500원 할인',
      discount: '500원',
      code: 'STORE2024003',
      purchaseDate: '2025-07-10',
      expiryDate: '2025-07-25',
      status: 'used',
      icon: '🏪',
      category: 'shopping',
      usage: '결제 시 쿠폰 코드 입력',
      usedDate: '2025-07-22',
    ),
    Coupon(
      id: 4,
      name: '버스 무료 승차권',
      description: '시내버스 1회 무료 이용',
      discount: '1회 무료',
      code: 'BUS2024004',
      purchaseDate: '2025-06-15',
      expiryDate: '2025-07-15',
      status: 'expired',
      icon: '🚌',
      category: 'transport',
      usage: 'QR코드를 버스 단말기에 스캔',
    ),
  ];
  // --- 임시 데이터 끝 ---

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
    } else if (coupon.status == 'used' && coupon.usedDate != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '${formatDate(coupon.usedDate!)}에 사용 완료',
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
    final filteredCoupons = (_selectedFilter == 'all')
        ? myCoupons
        : myCoupons.where((c) => c.status == _selectedFilter).toList();

    final counts = {
      'all': myCoupons.length,
      'active': myCoupons.where((c) => c.status == 'active').length,
      'used': myCoupons.where((c) => c.status == 'used').length,
      'expired': myCoupons.where((c) => c.status == 'expired').length,
    };

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
      body: ListView(
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
      ),
    );
  }
}
