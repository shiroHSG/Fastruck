import 'package:flutter/material.dart';
import 'package:flutter_app/shppier/shipper_request/request_detail.dart';

import '../../../app_theme.dart';

class ShipperRequestUI extends StatelessWidget {
  final int selectedMonth;
  final Function(int) onMonthChanged;
  final List<Map<String, dynamic>> requestList;

  const ShipperRequestUI({
    super.key,
    required this.selectedMonth,
    required this.onMonthChanged,
    required this.requestList,
  });

  Color _statusColor(String status) {
    switch (status) {
      case '배정':
        return Colors.green;
      case '미배정':
        return Colors.red;
      case '배송완료':
        return AppColors.primary;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 페이지 제목 및 월 선택 드롭다운
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '화물 요청 목록',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.point,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: 80,
                  child: DropdownButton<String>(
                    value: "$selectedMonth월",
                    dropdownColor: AppColors.base,
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: '${index + 1}월',
                        child: Center( // 가운데 정렬
                          child: Text(
                            '${index + 1}월',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        int month = int.parse(value.replaceAll('월', ''));
                        onMonthChanged(month);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: ListView.separated(
            itemCount: requestList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = requestList[index];
              return InkWell(
                onTap: () {
                  debugPrint('리스트 ${index + 1}번 클릭됨: ${item['from']} → ${item['to']}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RequestDetailPage()),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.base),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            item['status'],
                            style: TextStyle(
                              color: _statusColor(item['status']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        (item['info'] as String?) ?? '',
                        style: const TextStyle(color: Colors.grey),
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
