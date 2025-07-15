import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import 'carrier_request_ui.dart';

class CarrierRequestPage extends StatefulWidget {
  const CarrierRequestPage({super.key});

  @override
  State<CarrierRequestPage> createState() => _CarrierRequestPageState();
}

class _CarrierRequestPageState extends State<CarrierRequestPage> {
  String selectedFilter = '전체';
  String searchQuery = '';

  // 더미 데이터
  final List<Map<String, dynamic>> allRequests = [
    {
      'from': '서울',
      'to': '부산',
      'info': '2025.07.10 출발 / 2025.07.11 도착예정 / 철강 운송',
      'status': '입찰중',
    },
    {
      'from': '인천',
      'to': '대구',
      'info': '2025.07.12 출발 / 2025.07.13 도착예정 / 가전제품 운송',
      'status': '입찰완료',
    },
    {
      'from': '광주',
      'to': '울산',
      'info': '2025.07.15 출발 / 2025.07.16 도착예정 / 식자재 운송',
      'status': '입찰중',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 필터링 + 검색 적용된 리스트
    List<Map<String, dynamic>> filteredList = allRequests.where((item) {
      final matchFilter = selectedFilter == '전체' || item['status'] == selectedFilter;
      final matchSearch = item['from'].toString().contains(searchQuery) ||
          item['to'].toString().contains(searchQuery) ||
          item['info'].toString().contains(searchQuery);
      return matchFilter && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CarrierRequestUI(
        requestList: filteredList,
        selectedFilter: selectedFilter,
        onFilterChanged: (value) {
          if (value != null) {
            setState(() => selectedFilter = value);
          }
        },
        searchQuery: searchQuery,
        onSearchChanged: (value) {
          setState(() => searchQuery = value);
        },
      ),
    );
  }
}
