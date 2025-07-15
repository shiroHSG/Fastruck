import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class ShipperReviewUI extends StatelessWidget {
  final List<Map<String, String>> reviewList;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Function(int index)? onReviewTap; // ✨ 탭 콜백 추가

  const ShipperReviewUI({
    super.key,
    required this.reviewList,
    required this.selectedIndex,
    required this.onItemTapped,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '리뷰 목록',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.point,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            itemCount: reviewList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = reviewList[index];
              return InkWell(
                onTap: () {
                  if (onReviewTap != null) {
                    onReviewTap!(index); // ✨ 눌렀을 때 외부로 전달
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.base),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['from']} → ${item['to']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.point,
                        ),
                      ),
                      Text(
                        item['driver'] ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
