import 'package:flutter/material.dart';

class PointProvider with ChangeNotifier {
  int _currentPoints = 2450; // 초기 포인트 값

  int get currentPoints => _currentPoints;

  void deductPoints(int amount) {
    _currentPoints -= amount;
    notifyListeners(); // 상태 변경을 알림
  }
}