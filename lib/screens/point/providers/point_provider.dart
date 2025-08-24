import 'dart:convert';

import 'package:bustar_app/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PointProvider with ChangeNotifier {
  int _currentPoints = 0; // 초기값은 0으로 설정하고, API를 통해 업데이트합니다.

  int get currentPoints => _currentPoints;

  /// API를 통해 사용자의 초기 포인트 정보를 가져옵니다.
  /// 앱 시작 시 호출되어야 합니다.
  Future<void> fetchInitialPoints(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/point/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        _currentPoints = data['point'];
        notifyListeners(); // 상태 변경을 알려 UI를 업데이트합니다.
      } else {
        // 서버에서 오류 응답을 보냈을 경우
        debugPrint('포인트 정보를 불러오는 데 실패했습니다: ${response.statusCode}');
      }
    } catch (e) {
      // 네트워크 오류 등 예외 발생 시
      debugPrint('포인트 정보 로딩 중 오류 발생: $e');
    }
  }

  /// 포인트를 차감합니다.
  void deductPoints(int amount) {
    _currentPoints -= amount;
    notifyListeners(); // 상태 변경을 알림
  }

  /// 포인트를 특정 값으로 설정합니다. (서버와 동기화 시 사용)
  void setPoints(int newPoints) {
    _currentPoints = newPoints;
    notifyListeners();
  }
}