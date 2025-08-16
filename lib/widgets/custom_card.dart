import 'package:flutter/material.dart';

/// 앱 전체에서 일관된 스타일을 제공하는 재사용 가능한 카드 위젯입니다.
///
/// `header`와 `content` 영역으로 구성되며, 흰색 배경, 둥근 모서리, 그림자 효과가
/// 기본으로 적용됩니다. (웹 프론트엔드의 Card 컴포넌트와 유사한 역할)
class CustomCard extends StatelessWidget {
  /// 카드의 제목 영역에 표시될 위젯입니다. (옵션)
  /// 보통 `CardHeader` 위젯이 사용됩니다.
  final Widget? header;

  /// 카드의 본문 영역에 표시될 위젯입니다. (필수)
  final Widget content;

  const CustomCard({super.key, this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // 카드 배경색
        borderRadius: BorderRadius.circular(
          12.0,
        ), // 모서리를 둥글게 (tailwind의 rounded-xl 정도)
        border: Border.all(color: Colors.grey.shade300, width: 1.0), // 회색 테두리
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 자식 위젯들을 가로로 꽉 채웁니다.
        children: [
          // header가 null이 아닐 경우에만 표시합니다.
          if (header != null) header!,
          Padding(
            padding: EdgeInsets.only(
              top: header == null ? 24.0 : 0,
              bottom: 24.0,
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}

/// `CustomCard`의 헤더 영역을 꾸미기 위한 위젯입니다.
///
/// 아이콘과 제목을 가로로 나란히 표시합니다.
class CardHeader extends StatelessWidget {
  /// 헤더 왼쪽에 표시될 아이콘입니다.
  final IconData icon;

  /// 헤더에 표시될 텍스트입니다.
  final String title;

  const CardHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 헤더 내부 여백 설정
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
