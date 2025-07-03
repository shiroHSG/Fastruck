import 'package:flutter/material.dart';
import 'package:flutter_app/shppier/shipper_review/shipper_review.dart';

import 'app_theme.dart';
import 'package:flutter_app/shppier/shipper_home/shipper_home.dart';
import 'carrier/carrier_home/carrier_home.dart';
import 'login/login.dart';

const String baseUrl = 'http://10.0.2.2:8080';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const StartPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/shipper_home': (context) => const ShipperHomePage(),
        '/shipper_review': (context) => const ShipperReviewPage(),
        '/carrier-home': (context) => const CarrierHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    // 1초 후 자동 이동
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/logo2.png',
              width: 350,
            ),
          ],
        ),
      ),
    );
  }
}

