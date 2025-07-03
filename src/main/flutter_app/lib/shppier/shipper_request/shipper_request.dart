import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import 'shipper_request_ui.dart';

class ShipperRequestPage extends StatefulWidget {
  const ShipperRequestPage({super.key});

  @override
  State<ShipperRequestPage> createState() => _ShipperRequestPageState();
}

class _ShipperRequestPageState extends State<ShipperRequestPage> {
  int selectedMonth = DateTime.now().month;

  final List<Map<String, dynamic>> requestList = [
    {
      'from': '서울',
      'to': '부산',
      'info': '2025.07.10 출발 / 2025.07.11 도착예정 / 철강 운송',
      'status': '배정',
    },
    {
      'from': '인천',
      'to': '대구',
      'info': '2025.07.12 출발 / 2025.07.13 도착예정 / 가전제품 운송',
      'status': '미배정',
    },
    {
      'from': '광주',
      'to': '울산',
      'info': '2025.07.15 출발 / 2025.07.16 도착예정 / 식자재 운송',
      'status': '배송완료',
    },
  ];

  void onMonthChanged(int month) {
    setState(() {
      selectedMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ShipperRequestUI(
        selectedMonth: selectedMonth,
        requestList: requestList,
        onMonthChanged: onMonthChanged,
      ),
    );
  }
}
