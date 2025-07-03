import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import '../../../widgets/custom_dialog.dart';

class RequestDetailUI extends StatelessWidget {
  const RequestDetailUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 하단 하나의 헤더
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  '상세 정보',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 수정 / 삭제 버튼
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('작성자 : test'),
                const Text('연락처 : 010-1111-2222'),
                const Text('작성 시간 : 2025.07.02 11:43'),
                const SizedBox(height: 16),
                const Text('출발지 :'),
                const Text('도착지 :'),
                const Text('출발 희망 날짜 :'),
                const Text('운송물품 :'),
                const Text('특이사항 :'),
                const Text('기타 요청사항 :'),

                const SizedBox(height: 30),
                const Divider(color: AppColors.base),
                const SizedBox(height: 8),
                const Text(
                  '입착 신청 현황',
                  style: TextStyle(
                    color: AppColors.point,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),

                Column(
                  children: List.generate(2, (index) => _bidCard(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bidCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.base,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              debugPrint('프로필 이미지 클릭됨');
            },
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('이름 : 홍길동'),
                    Text('금액 : 500,000원'),
                    Text('예상 소요 시간 : 3시간'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const BidDetailDialog(
                        name: '홍길동',
                        phone: '010-2222-3333',
                        requestTime: '2025.07.02 12:40',
                        price: '500,000원',
                        note: '빠른 배송 부탁드립니다.',
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('보기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
