import 'package:flutter/material.dart';

class CouponFilterButtons extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final Map<String, int> counts;

  const CouponFilterButtons({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.counts,
  });

  @override
  Widget build(BuildContext context) {
    final filterOptions = [
      {'id': 'all', 'name': '전체'},
      {'id': 'active', 'name': '사용 가능'},
      {'id': 'used', 'name': '사용 완료'},
      {'id': 'expired', 'name': '만료'},
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filterOptions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filterOptions[index];
          final bool isSelected = selectedFilter == filter['id'];
          final count = counts[filter['id']] ?? 0;

          return ElevatedButton(
            onPressed: () => onFilterSelected(filter['id']!),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: isSelected
                  ? const Color(0xFF6CB77E)
                  : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black,
              side: isSelected
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('${filter['name']} ($count)'),
          );
        },
      ),
    );
  }
}
