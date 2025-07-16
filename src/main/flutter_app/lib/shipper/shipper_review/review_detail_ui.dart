import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class ReviewDetailUI extends StatelessWidget {
  final String name;
  final String phone;
  final String requestTime;
  final String price;
  final String note;
  final String estimatedArrival;
  final String actualArrival;
  final int rating;
  final String reviewContent;

  const ReviewDetailUI({
    super.key,
    required this.name,
    required this.phone,
    required this.requestTime,
    required this.price,
    required this.note,
    required this.estimatedArrival,
    required this.actualArrival,
    required this.rating,
    required this.reviewContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더 영역
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
                    '리뷰 상세',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 운송 정보
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이름 : $name'),
                  Text('연락처 : $phone'),
                  Text('요청 시간 : $requestTime'),
                  Text('금액 : $price'),
                  Text('기타 전달사항 : $note'),
                  Text('도착 예정일 : $estimatedArrival'),
                  Text('도착일 : $actualArrival'),
                ],
              ),
            ),

            const Divider(color: AppColors.primary, thickness: 1),
            const SizedBox(height: 16),

            // 내가 작성한 리뷰
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '내가 작성한 리뷰',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.point,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey,
                    size: 30,
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  reviewContent.isNotEmpty ? reviewContent : '작성된 리뷰가 없습니다.',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
