import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/commute_routes_panel.dart';
import 'widgets/favorite_routes_card.dart';

class RouteSearchScreen extends StatelessWidget {
  const RouteSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/bustar_icon.png', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text(
              'BUSTAR',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // 검색창
              GestureDetector(
                onTap: () {},
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.search),
                      hintText: '정류장을 입력해 주세요.',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 출근/퇴근 경로 패널
              const CommuteCardsPanel(),
              const SizedBox(height: 32),
              // 자주 가는 경로 섹션
              const FavoriteRoutesSection(),
              const SizedBox(height: 32),
              // 자주 가는 도착역
            ],
          ),
        ],
      ),
    );
  }
}
