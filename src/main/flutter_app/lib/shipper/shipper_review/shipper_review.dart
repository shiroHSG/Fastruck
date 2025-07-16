import 'package:flutter/material.dart';
import 'package:flutter_app/shipper/shipper_review/review_detail.dart';
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
  }
  void _onReviewTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ReviewDetailPage(
          name: '홍길동',
          phone: '010-1234-5678',
          requestTime: '2025.07.02 12:40',
          price: '500,000원',
          note: '친절하고 빠른 배송 부탁드립니다.',
          estimatedArrival: '2025.07.03',
          actualArrival: '2025.07.02',
          rating: 5,
          reviewContent: '정확한 시간에 도착해주셔서 감사합니다!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ShipperReviewUI(
        reviewList: reviewList,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onReviewTap: _onReviewTap,
      ),
    );
  }
}
