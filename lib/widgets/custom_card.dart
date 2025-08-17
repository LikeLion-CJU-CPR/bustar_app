import 'package:flutter/material.dart';

/// ## CustomCard Widget
/// 테두리와 그림자 스타일을 제공하는 기본 컨테이너입니다.
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0), // rounded-xl
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: child,
    );
  }
}

/// ## CardHeader Widget
/// 카드 상단에 아이콘과 제목을 표시하는 위젯입니다.
class CardHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const CardHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ✨ 카드의 다른 콘텐츠와 겹치지 않도록 아래쪽에만 패딩을 줍니다.
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// ## CardContent Widget
/// 카드 내부에 들어가는 콘텐츠에 일관된 좌우 패딩을 적용합니다.
class CardContent extends StatelessWidget {
  final Widget child;
  const CardContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // React의 px-6 스타일에 해당
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: child,
    );
  }
}
