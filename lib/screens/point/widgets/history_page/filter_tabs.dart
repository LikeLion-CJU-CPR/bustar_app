import 'package:flutter/material.dart';
import '../../models/point_history_model.dart';

class FilterTabs extends StatelessWidget {
  final String selectedFilter;
  final List<PointHistory> pointHistory;
  final Function(String) onFilterSelected;

  const FilterTabs({
    super.key,
    required this.selectedFilter,
    required this.pointHistory,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'all', 'label': '전체', 'count': pointHistory.length},
      {
        'key': 'earn',
        'label': '적립',
        'count': pointHistory.where((i) => i.type == 'earn').length,
      },
      {
        'key': 'use',
        'label': '사용',
        'count': pointHistory.where((i) => i.type == 'use').length,
      },
      {
        'key': 'bonus',
        'label': '보너스',
        'count': pointHistory.where((i) => i.type == 'bonus').length,
      },
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final bool isSelected = selectedFilter == filter['key'];

          return ElevatedButton(
            onPressed: () => onFilterSelected(filter['key'] as String),
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Row(
              children: [
                Text(
                  filter['label'] as String,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: .2)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    filter['count'].toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
