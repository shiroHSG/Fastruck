import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'login_form.dart';
import 'login_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: const [
          SizedBox(height: 100),
          LoginLogo(),
          SizedBox(height: 20),
          Expanded(
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
