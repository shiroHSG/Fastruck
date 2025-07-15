// 필드 제목 (_InputLabel 분리)
import 'package:flutter/material.dart';

class SignUpLabel extends StatelessWidget {
  final String text;
  const SignUpLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
