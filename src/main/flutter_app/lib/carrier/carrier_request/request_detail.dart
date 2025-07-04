import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class CarrierRequestDetailPage extends StatelessWidget {
  const CarrierRequestDetailPage({super.key});

  // 샘플 입찰자 데이터
  final List<Map<String, String>> bids = const [
    {'name': '홍길동', 'price': '150,000원'},
    {'name': '김영희', 'price': '160,000원'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '입찰 상세',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 요청 정보
            const Text('작성자 : test'),
            const SizedBox(height: 4),
            const Text('연락처 : 010-1111-2222'),
            const SizedBox(height: 4),
            const Text('작성 시간 : 2025.07.02 11:43'),
            const SizedBox(height: 16),
            const Text('출발지 : 서울'),
            const Text('도착지 : 부산'),
            const Text('출발 날짜 : 2025.07.10'),
            const Text('운송 물품 : 철강 자재'),
            const Text('기타 요청사항 : 파손 주의'),
            const SizedBox(height: 20),

            // 구분선
            const Divider(
              thickness: 1,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),

            // 입찰 신청 현황 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '입찰 신청 현황',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.point,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 입찰 신청 로직 또는 페이지 이동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('신청하기'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 입찰자 리스트
            ...bids.map((bid) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('이름 : ${bid['name']}'),
                        Text('금액 : ${bid['price']}'),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
