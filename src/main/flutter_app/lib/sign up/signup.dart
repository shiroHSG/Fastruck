import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'join_type_selector.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedJoinType; // 화주 또는 차주

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/image/logo1.png',
            width: 200,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _InputLabel(text: '이메일'),
                    const _InputField(hint: '이메일을 입력하세요'),
                    const _InputLabel(text: '비밀번호'),
                    const _InputField(hint: '비밀번호를 입력하세요', obscure: true),
                    const _InputLabel(text: '비밀번호 확인'),
                    const _InputField(hint: '비밀번호를 다시 입력하세요', obscure: true),
                    const _InputLabel(text: '이름'),
                    const _InputField(hint: '이름을 입력하세요'),
                    const _InputLabel(text: '전화번호'),
                    const _InputField(hint: '전화번호를 입력하세요'),

                    const _InputLabel(text: '가입 유형을 선택해주세요'),
                    JoinTypeSelector(
                      onChanged: (value) {
                        setState(() {
                          selectedJoinType = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          print('선택된 가입유형: $selectedJoinType');
                          // 회원가입 처리
                        },
                        child: const Text('회원가입'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 공통 위젯들
class _InputLabel extends StatelessWidget {
  final String text;
  const _InputLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  const _InputField({required this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
