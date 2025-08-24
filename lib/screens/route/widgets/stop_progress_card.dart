import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bustar_app/widgets/custom_card.dart';
import 'package:bustar_app/screens/route/route_status_screen.dart';

class StopProgressCard extends StatefulWidget {
  final List<Map<String, dynamic>> stops;
  final String routeType;
  final List<BusSchedule> schedules;

  const StopProgressCard({
    super.key,
    required this.stops,
    required this.routeType,
    required this.schedules,
  });

  @override
  State<StopProgressCard> createState() => _StopProgressCardState();
}

class _StopProgressCardState extends State<StopProgressCard> {
  final ScrollController _scrollController = ScrollController();
  final double _itemWidth = 80.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // ✨ 2. 1초마다 화면을 갱신하는 타이머 설정
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // setState를 호출하여 build 메서드를 다시 실행시킴 -> 버스 위치가 갱신됨
      if (mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCenter());
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 사라질 때 타이머 정리
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCenter() {
    final currentStopIndex = widget.stops.indexWhere(
      (stop) => stop['isCurrent'] == true,
    );
    if (currentStopIndex == -1) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final centerPosition = screenWidth / 2;
    final scrollOffset =
        (currentStopIndex * _itemWidth) + (_itemWidth / 2) - centerPosition;

    _scrollController.animateTo(
      scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Color _getBusColor() {
    switch (widget.routeType) {
      case '급행':
        return Colors.red;
      case '간선':
        return Colors.blue;
      case '순환':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  List<double> _calculateBusPositions() {
    final List<double> positions = [];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final double startPosition = _itemWidth / 2;
    final double endPosition =
        (widget.stops.length * _itemWidth) - (_itemWidth / 2);

    for (var schedule in widget.schedules) {
      final depParts = schedule.departureTime.split(':');
      final arrParts = schedule.arrivalTime.split(':');
      var depTime = DateTime(
        today.year,
        today.month,
        today.day,
        int.parse(depParts[0]),
        int.parse(depParts[1]),
      );
      var arrTime = DateTime(
        today.year,
        today.month,
        today.day,
        int.parse(arrParts[0]),
        int.parse(arrParts[1]),
      );

      if (arrTime.isBefore(depTime)) {
        arrTime = arrTime.add(const Duration(days: 1));
      }

      // 현재 운행 중인 버스만 계산
      if (now.isAfter(depTime) && now.isBefore(arrTime)) {
        final totalDuration = arrTime.difference(depTime).inMilliseconds;
        final elapsedTime = now.difference(depTime).inMilliseconds;
        final progress = (elapsedTime / totalDuration).clamp(0.0, 1.0);

        // 시작점과 끝점 사이의 위치 계산
        final currentPosition =
            startPosition + (endPosition - startPosition) * progress;
        positions.add(currentPosition);
      }
    }
    return positions;
  }

  @override
  Widget build(BuildContext context) {
    final busColor = _getBusColor();
    final busPositions = _calculateBusPositions();

    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: widget.stops.length * _itemWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 28.5,
                  left: _itemWidth / 2,
                  right: _itemWidth / 2,
                  child: Container(height: 3, color: Colors.grey.shade300),
                ),
                Row(
                  children: widget.stops.map((stop) {
                    StopIconType iconType = StopIconType.dot;
                    if (stop['isDestination'] == true ||
                        stop['isBoarding'] == true) {
                      iconType = StopIconType.star;
                    }
                    return _StopItem(
                      label: stop['stopName'],
                      iconType: iconType,
                      itemWidth: _itemWidth,
                    );
                  }).toList(),
                ),
                ...busPositions.map(
                  (position) => AnimatedPositioned(
                    // 1초 간격의 업데이트 사이에 부드럽게 움직이도록 애니메이션 설정
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.linear, // 일정한 속도로 움직이도록 설정
                    top: 7,
                    left: position - 18, // 아이콘 크기의 절반만큼 빼서 중심 맞춤
                    child: Icon(
                      Icons.directions_bus,
                      color: busColor,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum StopIconType { dot, star }

class _StopItem extends StatelessWidget {
  final String label;
  final StopIconType iconType;
  final double itemWidth;

  const _StopItem({
    required this.label,
    required this.iconType,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 36, child: _buildIcon()),
          const SizedBox(height: 12),
          Container(
            height: 28,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    switch (iconType) {
      case StopIconType.star:
        return const Icon(Icons.star, color: Color(0xFF6CB77E), size: 16);
      case StopIconType.dot:
        return Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        );
    }
  }
}
