// 입력 필드 + 가입유형 + 버튼
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/sign%20up/signup_input_field.dart';
import 'package:flutter_app/sign%20up/signup_label.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';
import '../login/login.dart';
import '../main.dart';
import 'join_type_selector.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? selectedJoinType; // 화주 / 차주
  File? _selectedImageFile;

  Future<void> _register() async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('$baseUrl/api/member/register');

    final memberData = {
      'role': selectedJoinType == '화주' ? 'SHIPPER' : 'CARRIER',
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'phone': _phoneController.text.trim(),
    };

    final request = http.MultipartRequest('POST', url)
      ..fields['memberData'] = jsonEncode(memberData);

    if (_selectedImageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _selectedImageFile!.path));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print("회원가입 성공");
        _showDialog('회원가입이 완료되었습니다!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        print("실패: $responseBody");
        print(jsonEncode(memberData));
        _showDialog('회원가입 실패: 서버 응답 오류');
      }
    } catch (e) {
      print("오류: $e");
      _showDialog('회원가입 중 오류 발생');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('알림'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

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
            SignUpInputField(hint: '이메일을 입력하세요', controller: _emailController),

            const SignUpLabel(text: '비밀번호'),
            SignUpInputField(hint: '비밀번호를 입력하세요', obscure: true, controller: _passwordController),

            const SignUpLabel(text: '비밀번호 확인'),
            const SignUpInputField(hint: '비밀번호를 다시 입력하세요', obscure: true), // 확인용

            const SignUpLabel(text: '이름'),
            SignUpInputField(hint: '이름을 입력하세요', controller: _nameController),

            const SignUpLabel(text: '전화번호'),
            SignUpInputField(hint: '전화번호를 입력하세요', controller: _phoneController),

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
                onPressed: _register,
                child: const Text('회원가입'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
