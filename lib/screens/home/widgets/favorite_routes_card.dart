import 'package:flutter/material.dart';

import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/screens/route/route_status_screen.dart';
import 'package:bustar_app/screens/home/widgets/build_route_row.dart';

class FavoriteRoutesSection extends StatefulWidget {
  const FavoriteRoutesSection({super.key});

  @override
  State<FavoriteRoutesSection> createState() => _FavoriteRoutesSectionState();
}

class _FavoriteRoutesSectionState extends State<FavoriteRoutesSection> {
  final bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '자주 가는 경로',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _buildFavoriteRouteCard(
                        '청주대학교.뉴시스',
                        '오송역종점 정류장',
                        idx: 1,
                        fromColor: Colors.red,
                        toColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFavoriteRouteCard(
                        '+',
                        '',
                        isAddButton: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildFavoriteRouteCard(
    String from,
    String to, {
    int idx = -1,
    Color fromColor = Colors.black,
    Color toColor = Colors.black,
    bool isAddButton = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RouteStatusScreen(index: idx),
          ),
        );
      },
      child: CustomCard(
        padding: const EdgeInsets.all(16),
        child: isAddButton
            ? const Center(child: Icon(Icons.add, color: Colors.grey, size: 32))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildRouteRow(text: from, color: fromColor),
                  const SizedBox(height: 8),
                  BuildRouteRow(text: to, color: toColor),
                ],
              ),
      ),
    );
  }
}
