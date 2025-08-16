import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
    required this.userName,
    required this.userLevel,
    required this.memberSince,
  });

  final String userName;
  final String userLevel;
  final String memberSince;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.purple.shade100,
            child: Icon(
              CupertinoIcons.person_fill,
              size: 40,
              color: Colors.purple.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$userName님',
            style: TextStyle(
              fontSize: 20,
              color: Colors.purple.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  userLevel,
                  style: TextStyle(
                    color: Colors.purple.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '가입일: $memberSince',
                style: TextStyle(fontSize: 12, color: Colors.purple.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
