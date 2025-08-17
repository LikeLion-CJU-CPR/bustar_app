import 'package:flutter/material.dart';
import '../../../../widgets/custom_card.dart';
import '../../models/coupon_model.dart';
import '../../utils/coupon_helpers.dart';

class CouponListItem extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback onTap;
  
  const CouponListItem({
    super.key,
    required this.coupon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusInfo = getStatusInfo(coupon.status);
    final daysLeft = getDaysLeft(coupon.expiryDate);

    return Opacity(
      opacity: (coupon.status == 'used' || coupon.status == 'expired') ? 0.6 : 1.0,
      child: CustomCard(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(coupon.icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(coupon.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(coupon.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                      const SizedBox(height: 8),
                      if (coupon.status == 'active' && daysLeft > 0)
                        Text(
                          '$daysLeft일 남음',
                          style: TextStyle(fontSize: 12, color: daysLeft <= 7 ? Colors.red.shade600 : Colors.grey.shade600),
                        ),
                      if (coupon.status == 'used' && coupon.usedDate != null)
                        Text(
                          '사용일: ${formatDate(coupon.usedDate!)}',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusInfo.backgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(statusInfo.text, style: TextStyle(fontSize: 12, color: statusInfo.color, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    Text('${formatDate(coupon.expiryDate)}까지', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}