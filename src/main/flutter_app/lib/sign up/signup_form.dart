// 입력 필드 + 가입유형 + 버튼
import 'package:flutter/material.dart';
import 'package:flutter_app/sign%20up/signup_input_field.dart';
import 'package:flutter_app/sign%20up/signup_label.dart';
import '../app_theme.dart';
import 'join_type_selector.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? selectedJoinType;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            const SignUpLabel(text: '이메일'),
            const SignUpInputField(hint: '이메일을 입력하세요'),
            const SignUpLabel(text: '비밀번호'),
            const SignUpInputField(hint: '비밀번호를 입력하세요', obscure: true),
            const SignUpLabel(text: '비밀번호 확인'),
            const SignUpInputField(hint: '비밀번호를 다시 입력하세요', obscure: true),
            const SignUpLabel(text: '이름'),
            const SignUpInputField(hint: '이름을 입력하세요'),
            const SignUpLabel(text: '전화번호'),
            const SignUpInputField(hint: '전화번호를 입력하세요'),
            const SignUpLabel(text: '가입 유형을 선택해주세요'),
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
                },
                child: const Text('회원가입'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
