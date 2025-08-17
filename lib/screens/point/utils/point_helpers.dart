import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  if (date == today) {
    return '오늘';
  } else if (date == yesterday) {
    return '어제';
  } else {
    return DateFormat('M/d').format(date);
  }
}

String getTypeLabel(String type) {
  switch (type) {
    case 'use':
      return '사용';
    case 'bonus':
      return '보너스';
    default:
      return '적립';
  }
}

Color getPointColor(String type) {
  switch (type) {
    case 'use':
      return Colors.red.shade600;
    case 'bonus':
      return Colors.blue.shade600;
    default:
      return Colors.green.shade600;
  }
}

Color getBadgeBackgroundColor(String type) {
  switch (type) {
    case 'use':
      return Colors.red.shade50;
    case 'bonus':
      return Colors.blue.shade50;
    default:
      return Colors.green.shade50;
  }
}

Color getBadgeTextColor(String type) {
  switch (type) {
    case 'use':
      return Colors.red.shade700;
    case 'bonus':
      return Colors.blue.shade700;
    default:
      return Colors.green.shade700;
  }
}
