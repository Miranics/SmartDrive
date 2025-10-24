import 'package:flutter/material.dart';

class UserStatCard extends StatelessWidget {
  final IconData icon;
  final String percentage;
  final String label;

  const UserStatCard({
    super.key,
    required this.icon,
    required this.percentage,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      height: 180,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFD9EDFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(3, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, fontWeight: FontWeight.w700),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFF006FFF),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
