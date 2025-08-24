import 'package:flutter/material.dart';

import 'package:bustar_app/widgets/custom_card.dart';

class StopProgressCard extends StatefulWidget {
  const StopProgressCard({super.key});

  @override
  State<StopProgressCard> createState() => _StopProgressCardState();
}

class _StopProgressCardState extends State<StopProgressCard> {
  // ✨ 2. ScrollController 생성
  final ScrollController _scrollController = ScrollController();

  // 각 정류장 아이템의 너비
  final double _itemWidth = 80.0;

  // 버스 아이콘의 인덱스 (0부터 시작)
  final int _busIconIndex = 4;

  @override
  void initState() {
    super.initState();
    // ✨ 3. 첫 프레임이 렌더링된 후 스크롤 위치를 계산하고 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 버스 아이콘이 중앙에 오도록 스크롤하는 함수
  void _scrollToCenter() {
    // 화면의 중앙 위치 계산
    final screenWidth = MediaQuery.of(context).size.width;
    final centerPosition = screenWidth / 2;

    // 버스 아이콘의 중앙까지의 스크롤 위치 계산
    // (버스 아이콘의 인덱스 * 아이템 너비) + (아이템 너비의 절반) - (화면 너비의 절반)
    final scrollOffset =
        ((_busIconIndex + 1) * _itemWidth) + (_itemWidth / 2) - centerPosition;

    // 계산된 위치로 스크롤 이동
    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              // ✨ 4. 컨트롤러 연결
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  _StopItem(
                    label: '충북대 입구',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '산업단지 입구',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '상화 전기',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '금호 어울림 아파트',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '출발공원',
                    iconType: StopIconType.bus,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '현대백화점',
                    iconType: StopIconType.star,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '현대자동차 서비스',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '다음 정류장',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                  _StopItem(
                    label: '그 다음 정류장',
                    iconType: StopIconType.dot,
                    itemWidth: _itemWidth,
                  ),
                ],
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
      case StopIconType.bus:
        return const Icon(Icons.directions_bus, color: Colors.blue, size: 36);
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
