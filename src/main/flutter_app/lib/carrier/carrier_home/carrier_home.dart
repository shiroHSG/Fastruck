import 'package:flutter/material.dart';
import '../../app_theme.dart';
import '../../profile/profile.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../carrier_request/carrier_request.dart';
import 'carrier_home_ui.dart'; // 홈 UI

class CarrierHomePage extends StatefulWidget {
  const CarrierHomePage({super.key});

  @override
  State<CarrierHomePage> createState() => _CarrierHomePageState();
}

class _CarrierHomePageState extends State<CarrierHomePage> {
  int currentIndex = 0;
  bool hasOngoingBid = true; // 진행 중인 입찰 여부 (샘플용)

  @override
  Widget build(BuildContext context) {
    // 각 탭별로 body를 분기
    Widget body;
    if (currentIndex == 0) {
      body = CarrierHomeUI(hasOngoingBid: hasOngoingBid);
    } else if (currentIndex == 1) {
      body = const CarrierRequestPage(); // 화주 요청 목록 불러오기
    } else if (currentIndex == 2) {
      body = const Placeholder(); // 리뷰 페이지 구현 시 교체
    } else if (currentIndex == 3) {
      body = const Placeholder(); // 공지사항 등 필요 시 교체
    } else if (currentIndex == 4) {
      body = const ProfilePage(); // 프로필 페이지 구현 시 교체
    } else {
      body = const Center(child: Text('아직 구현되지 않은 탭입니다.'));
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Fastruck'),
      backgroundColor: AppColors.white,
      body: body,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
