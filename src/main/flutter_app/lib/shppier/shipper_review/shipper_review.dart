import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import 'shipper_review_ui.dart';

class ShipperReviewPage extends StatefulWidget {
  const ShipperReviewPage({super.key});

  @override
  State<ShipperReviewPage> createState() => _ShipperReviewPageState();
}

class _ShipperReviewPageState extends State<ShipperReviewPage> {
  int _selectedIndex = 2;

  final List<Map<String, String>> reviewList = [
    {
      'from': '서울',
      'to': '부산',
      'driver': '홍길동, 별점 5',
    },
    {
      'from': '인천',
      'to': '대구',
      'driver': '김철수, 별점 4',
    },
    {
      'from': '광주',
      'to': '울산',
      'driver': '이영희, 별점 5',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // 라우트 이동은 추후 필요시 추가
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ShipperReviewUI(
        reviewList: reviewList,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
