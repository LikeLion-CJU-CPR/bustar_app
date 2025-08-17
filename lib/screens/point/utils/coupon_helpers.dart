import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 상태에 따른 뱃지 텍스트, 색상 등의 정보를 담는 클래스
class StatusInfo {
  final String text;
  final Color color;
  final Color backgroundColor;
  final IconData icon;

  StatusInfo({
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.icon,
  });
}

// 쿠폰 상태에 따라 스타일 정보를 반환하는 함수
StatusInfo getStatusInfo(String status) {
  switch (status) {
    case 'active':
      return StatusInfo(text: '사용 가능', color: Colors.green.shade700, backgroundColor: Colors.green.shade50, icon: Icons.check_circle);
    case 'used':
      return StatusInfo(text: '사용 완료', color: Colors.grey.shade700, backgroundColor: Colors.grey.shade200, icon: Icons.check_circle_outline);
    case 'expired':
      return StatusInfo(text: '기간 만료', color: Colors.red.shade700, backgroundColor: Colors.red.shade50, icon: Icons.cancel);
    default:
      return StatusInfo(text: '알 수 없음', color: Colors.grey.shade700, backgroundColor: Colors.grey.shade200, icon: Icons.help_outline);
  }
}

// 날짜 문자열을 'xxxx. xx. xx' 형태로 포맷하는 함수
String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  return DateFormat('yyyy. MM. dd').format(date);
}

// 만료일까지 남은 일수를 계산하는 함수
int getDaysLeft(String expiryDate) {
  final today = DateTime.now();
  final expiry = DateTime.parse(expiryDate);
  final diff = expiry.difference(today);
  return diff.inDays + 1;
}