import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_card.dart';
import '../../models/point_history_model.dart';
import '../../utils/point_helpers.dart';

class HistoryListCard extends StatelessWidget {
  final List<PointHistory> filteredHistory;
  final String selectedFilter;

  const HistoryListCard({
    super.key,
    required this.filteredHistory,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardHeader(
            icon: CupertinoIcons.line_horizontal_3_decrease,
            title:
                '${selectedFilter == 'all' ? '전체' : getTypeLabel(selectedFilter)} 내역',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: filteredHistory.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Text(
                        '해당하는 내역이 없습니다.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : CardContent(
                    child: Column(
                      children: filteredHistory
                          .map((item) => _buildListItem(item))
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(PointHistory item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.activity, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    formatDate(item.date),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: getBadgeBackgroundColor(item.type),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      getTypeLabel(item.type),
                      style: TextStyle(
                        color: getBadgeTextColor(item.type),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${item.points > 0 ? '+' : ''}${item.points}P',
            style: TextStyle(
              color: getPointColor(item.type),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
