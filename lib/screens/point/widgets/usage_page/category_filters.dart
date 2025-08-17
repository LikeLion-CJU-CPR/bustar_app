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
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = selectedCategory == category['id'];
          return ElevatedButton.icon(
            onPressed: () => onCategorySelected(category['id'] as String),
            icon: Icon(category['icon'] as IconData, size: 16),
            label: Text(category['name'] as String),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: isSelected ? Colors.blue.shade600 : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black,
              side: isSelected
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}
