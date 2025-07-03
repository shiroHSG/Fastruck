import 'package:flutter/material.dart';
import 'package:flutter_app/shppier/shipper_home/shipper_request/shipper_request.dart';
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
    Widget body;

    if (currentIndex == 0) {
      body = ShipperHomeUI(
        focusedDay: _focusedDay,
        selectedDay: _selectedDay,
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onMonthChanged: (date) {
          setState(() {
            _focusedDay = date;
          });
        },
      );
    } else if (currentIndex == 1) {
      body = const ShipperRequestPage(); // 여기서 push 없이 body만 교체
    } else {
      body = const Center(child: Text('아직 구현되지 않은 탭입니다.'));
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: 'Fastruck'),
      body: body,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index; // 상태만 바꾸면 자동으로 바디 교체됨
          });
        },
      ),
    );
  }
}
