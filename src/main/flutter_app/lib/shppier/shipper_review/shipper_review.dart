import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_bottom_bar.dart';

class ShipperReviewPage extends StatefulWidget {
  const ShipperReviewPage({super.key});

  @override
  State<ShipperReviewPage> createState() => _ShipperReviewPageState();
}

class _ShipperReviewPageState extends State<ShipperReviewPage> {
  int _selectedIndex = 2; // 리뷰 탭 인덱스

  final List<Map<String, String>> reviewList = [
    {
      'route': '서울 → 부산',
      'driver': '홍길동, 별점 5',
    },
    {
      'route': '대구 → 인천',
      'driver': '김철수, 별점 4',
    },
    {
      'route': '광주 → 울산',
      'driver': '이영희, 별점 5',
    },
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // 현재 탭이면 아무 동작 X

    setState(() {
      _selectedIndex = index;
    });

    // 탭에 따라 라우팅 처리
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/shipper_home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/shipper_request');
        break;
      case 2:
      // 현재 페이지 (리뷰) - 이동 X
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/shipper_notice');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/shipper_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: '리뷰 목록'),
      body: ListView.separated(
        itemCount: reviewList.length,
        padding: const EdgeInsets.symmetric(vertical: 12),
        separatorBuilder: (_, __) => const Divider(
          color: AppColors.point,
          thickness: 1,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final item = reviewList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['route'] ?? '',
                  style: const TextStyle(
                    color: AppColors.point,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['driver'] ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
