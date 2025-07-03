import 'package:flutter/material.dart';
import '../app_theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return; // 현재 탭이면 이동하지 않음

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/shipper_home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/shipper_request');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/shipper_review');
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
    return BottomNavigationBar(
      backgroundColor: AppColors.primary,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF3A4D8F),
      unselectedItemColor: AppColors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: '요청목록'),
        BottomNavigationBarItem(icon: Icon(Icons.reviews), label: '리뷰'),
        BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '공지'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
      ],
    );
  }
}
