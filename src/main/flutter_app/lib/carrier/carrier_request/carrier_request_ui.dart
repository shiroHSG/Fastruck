import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class CarrierRequestUI extends StatelessWidget {
  final List<Map<String, dynamic>> requestList;
  final String selectedFilter;
  final ValueChanged<String?> onFilterChanged;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const CarrierRequestUI({
    super.key,
    required this.requestList,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 드롭다운 + 검색창
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              // 드롭다운
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.base,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedFilter,
                  underline: const SizedBox(),
                  dropdownColor: AppColors.base,
                  items: ['전체', '입찰중', '입찰완료'].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(
                        status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.point),
                      ),
                    );
                  }).toList(),
                  onChanged: onFilterChanged,
                ),
              ),
              const SizedBox(width: 12),
              // 검색창
              Expanded(
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: '검색',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.point,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    filled: true,
                    fillColor: AppColors.base,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // 요청 리스트
        Expanded(
          child: ListView.separated(
            itemCount: requestList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = requestList[index];
              return InkWell(
                onTap: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RequestDetailPage()),
                  );*/
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.base),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['from']} → ${item['to']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.point,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['info'],
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
