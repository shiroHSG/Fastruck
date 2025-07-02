// 전체 페이지 뼈대
import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // 뒤로가기 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 24),
              color: AppColors.primary,
              onPressed: () {
                Navigator.pop(context); // 로그인 페이지로 돌아가기
              },
            ),
          ),

          // 로고
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              'assets/image/logo1.png',
              width: 200,
            ),
          ),

          const Expanded(child: SignUpForm()),
        ],
      ),
    );
  }
}
