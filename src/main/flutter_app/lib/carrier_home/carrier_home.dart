import 'package:flutter/material.dart';
import '../app_theme.dart';

class CarrierHomePage extends StatefulWidget {
  const CarrierHomePage({super.key});

  @override
  State<CarrierHomePage> createState() => _CarrierHomePageState();
}

class _CarrierHomePageState extends State<CarrierHomePage> {
  bool hasOngoingBid = true; // false로 바꾸면 입찰건 없을 때 화면 보여짐 (테스트용)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 헤더
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Image.asset('assets/image/logo1.png', width: 40),
                const SizedBox(width: 8),
                const Text(
                  'Fastruck',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '현재 입찰 진행건',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.point,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: hasOngoingBid ? _buildOngoingBidView() : _buildEmptyView(),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: '요청목록'),
          BottomNavigationBarItem(icon: Icon(Icons.reviews), label: '리뷰'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '공지'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
    );
  }

  // 🚛 입찰 진행 중 UI
  Widget _buildOngoingBidView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('출발지 → 도착지'),
          const SizedBox(height: 8),
          const Text('금액, 출발날짜, 운송품목', style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.location_on, size: 28),
              Icon(Icons.fire_truck, size: 28),
              Icon(Icons.local_shipping, size: 28),
              Icon(Icons.home_work_outlined, size: 28),
              Icon(Icons.check_circle_outline, size: 28),
            ],
          ),

          const SizedBox(height: 10),

          // 상태 버튼들
          Column(
            children: [
              _buildStatusButton('집하지로 이동중', Icons.fire_truck),
              _buildStatusButton('화물 적재중', Icons.archive),
              _buildStatusButton('배송 출발', Icons.local_shipping),
              _buildStatusButton('배송지 도착', Icons.location_on),
              _buildStatusButton('배송 완료', Icons.check_circle_outline),
            ],
          ),
        ],
      ),
    );
  }

  // 📭 입찰 없을 때 UI
  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '현재 진행중인 입찰건이 없습니다.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text('입찰 목록을 확인하시겠습니까?', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(icon),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.base,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
