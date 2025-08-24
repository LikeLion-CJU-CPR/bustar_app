import 'package:flutter/material.dart';
import 'package:bustar_app/widgets/custom_card.dart';

class StopProgressCard extends StatefulWidget {
  final List<Map<String, dynamic>> stops;
  final String routeType;
  const StopProgressCard({
    super.key,
    required this.stops,
    required this.routeType,
  });

  @override
  State<StopProgressCard> createState() => _StopProgressCardState();
}

class _StopProgressCardState extends State<StopProgressCard> {
  final ScrollController _scrollController = ScrollController();
  final double _itemWidth = 80.0;
  int _busIconIndex = 0;

  @override
  void initState() {
    super.initState();
    _busIconIndex = widget.stops.indexWhere(
      (stop) => stop['isCurrent'] == true,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_busIconIndex != -1) {
        _scrollToCenter();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCenter() {
    final screenWidth = MediaQuery.of(context).size.width;
    final centerPosition = screenWidth / 2;
    final scrollOffset =
        ((_busIconIndex) * _itemWidth) + (_itemWidth / 2) - centerPosition;
    _scrollController.animateTo(
      scrollOffset,
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

  @override
  Widget build(BuildContext context) {
    final busColor = _getBusColor();
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 16.5,
              left: 20.0,
              right: 20.0,
              child: Container(height: 3, color: Colors.grey.shade300),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: widget.stops.map((stop) {
                  StopIconType iconType = StopIconType.dot;
                  if (stop['isCurrent'] == true) {
                    iconType = StopIconType.bus;
                  } else if (stop['isDestination'] == true) {
                    iconType = StopIconType.star;
                  }

                  return _StopItem(
                    label: stop['stopName'],
                    iconType: iconType,
                    itemWidth: _itemWidth,
                    busColor: busColor,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum StopIconType { dot, bus, star }

class _StopItem extends StatelessWidget {
  final String label;
  final StopIconType iconType;
  final double itemWidth;
  final Color busColor;

  const _StopItem({
    required this.label,
    required this.iconType,
    required this.itemWidth,
    required this.busColor,
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
      case StopIconType.bus:
        return Icon(Icons.directions_bus, color: busColor, size: 36);
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
