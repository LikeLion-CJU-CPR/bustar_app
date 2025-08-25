import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryFilters extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilters({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // 카테고리 데이터 (아이콘 포함)
    final categories = [
      {'id': 'all', 'name': '전체', 'icon': CupertinoIcons.gift_fill},
      {'id': 'transport', 'name': '교통', 'icon': CupertinoIcons.car_detailed},
      {'id': 'food', 'name': '음식', 'icon': CupertinoIcons.shopping_cart},
      {'id': 'shopping', 'name': '쇼핑', 'icon': CupertinoIcons.bag_fill},
    ];

    return SizedBox(
      height: 36,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++) ...[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () =>
                    onCategorySelected(categories[i]['id'] as String),
                icon: Icon(categories[i]['icon'] as IconData, size: 16),
                label: Text(categories[i]['name'] as String),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: selectedCategory == categories[i]['id']
                      ? const Color(0xFF6CB77E)
                      : Colors.white,
                  foregroundColor: selectedCategory == categories[i]['id']
                      ? Colors.white
                      : Colors.black,
                  side: selectedCategory == categories[i]['id']
                      ? BorderSide.none
                      : BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            if (i < categories.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
