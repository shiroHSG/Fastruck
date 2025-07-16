import 'package:flutter/material.dart';
import 'package:flutter_app/shipper/shipper_request/request_detail.dart';
import '../../../app_theme.dart';

class ShipperRequestUI extends StatelessWidget {
  final int selectedMonth;
  final List<Map<String, dynamic>> requestList;
  final void Function(int) onMonthChanged;

  const ShipperRequestUI({
    super.key,
    required this.selectedMonth,
    required this.requestList,
    required this.onMonthChanged,
  });

  // 상태별 색상 반환 (상태명이 한글로 넘어옴)
  Color _statusColor(String status) {
    switch (status) {
      case '배정':
        return Colors.green;
      case '미배정':
        return Colors.red;
      case '배송완료':
        return AppColors.primary;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 타이틀 및 월 선택
          Container(
            color: AppColors.primary.withOpacity(0.10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                const Icon(Icons.local_shipping, color: AppColors.primary, size: 32),
                const SizedBox(width: 10),
                const Text(
                  "화물 요청 목록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                const Spacer(),
                DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(
                    12,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}월'),
                    ),
                  ),
                  onChanged: (month) {
                    if (month != null) onMonthChanged(month);
                  },
                  underline: const SizedBox(),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: requestList.isEmpty
                ? const Center(child: Text('등록된 요청이 없습니다.', style: TextStyle(color: Colors.grey)))
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: requestList.length,
              separatorBuilder: (_, __) => const Divider(height: 12, color: AppColors.primary, thickness: 0.5),
              itemBuilder: (context, idx) {
                final req = requestList[idx];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  title: Row(
                    children: [
                      Text(
                        "${req['from']} → ${req['to']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        req['status'] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: _statusColor(req['status']),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      req['info'] ?? "",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onTap: () {
                    // 상세페이지로 id 전달 (id가 null 아닐 때만 이동)
                    if (req['id'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RequestDetailPage(id: req['id']),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
