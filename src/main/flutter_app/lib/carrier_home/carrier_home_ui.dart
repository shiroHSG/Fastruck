import 'package:flutter/material.dart';
import '../app_theme.dart';

class CarrierHomeUI extends StatelessWidget {
  final bool hasOngoingBid;

  const CarrierHomeUI({super.key, required this.hasOngoingBid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 20),

        Expanded(
          child: hasOngoingBid ? _buildOngoingBidView() : _buildEmptyView(),
        ),
      ],
    );
  }

  Widget _buildOngoingBidView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('출발지 → 도착지'),
          const SizedBox(height: 8),
          const Text('금액, 출발날짜, 운송품목', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
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
          const SizedBox(height: 40),
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

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('현재 진행중인 입찰건이 없습니다.', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('입찰 목록을 확인하시겠습니까?', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatusButton(String label, IconData icon) {
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
