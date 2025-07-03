import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'carrier_home_ui.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

class CarrierHomePage extends StatefulWidget {
  const CarrierHomePage({super.key});

  @override
  State<CarrierHomePage> createState() => _CarrierHomePageState();
}

class _CarrierHomePageState extends State<CarrierHomePage> {
  bool hasOngoingBid = true;
  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO: 탭 인덱스에 따라 페이지 이동 처리
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Fastruck'),
      backgroundColor: AppColors.white,
      body: CarrierHomeUI(hasOngoingBid: hasOngoingBid),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
