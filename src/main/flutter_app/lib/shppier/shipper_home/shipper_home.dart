import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'shipper_home_ui.dart';

class ShipperHomePage extends StatefulWidget {
  const ShipperHomePage({super.key});

  @override
  State<ShipperHomePage> createState() => _ShipperHomePageState();
}

class _ShipperHomePageState extends State<ShipperHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Fastruck'),
      body: ShipperHomeUI(
        focusedDay: _focusedDay,
        selectedDay: _selectedDay,
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onMonthChanged: (newDate) {
          setState(() {
            _focusedDay = newDate;
          });
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          // TODO: 페이지 전환 로직
        },
      ),
    );
  }
}
